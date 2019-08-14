Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED7D8D5BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHNOPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 10:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfHNOPK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:15:10 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F11AF2133F;
        Wed, 14 Aug 2019 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565792109;
        bh=kburXRh82xHoH2ULBf4qbUaBruG20vqIvfvEbFcltJY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YmMNPxPAWp25eQhuqgZ4ltWhMxF28BvGB5vskr14XqYVCQZZ96TVxfUdULrpt9Fg0
         60trd+Jkb520pjcYaqrosDqW5ftToo6hZAXtZVmiRfDVvso+e6i9CkZS/dVjFp3R2p
         sxNd0hLUe0BkrhCT6Rwkhd2HlJfkAotXSoeuAaW0=
Message-ID: <fde2959db776616008fc5d31df700f5d7d899433.camel@kernel.org>
Subject: Re: [RFC PATCH v2 02/19] fs/locks: Add Exclusive flag to user
 Layout lease
From:   Jeff Layton <jlayton@kernel.org>
To:     ira.weiny@intel.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 14 Aug 2019 10:15:06 -0400
In-Reply-To: <20190809225833.6657-3-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
         <20190809225833.6657-3-ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-08-09 at 15:58 -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add an exclusive lease flag which indicates that the layout mechanism
> can not be broken.
> 
> Exclusive layout leases allow the file system to know that pages may be
> GUP pined and that attempts to change the layout, ie truncate, should be
> failed.
> 
> A process which attempts to break it's own exclusive lease gets an
> EDEADLOCK return to help determine that this is likely a programming bug
> vs someone else holding a resource.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/locks.c                       | 23 +++++++++++++++++++++--
>  include/linux/fs.h               |  1 +
>  include/uapi/asm-generic/fcntl.h |  2 ++
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index ad17c6ffca06..0c7359cdab92 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -626,6 +626,8 @@ static int lease_init(struct file *filp, long type, unsigned int flags,
>  	fl->fl_flags = FL_LEASE;
>  	if (flags & FL_LAYOUT)
>  		fl->fl_flags |= FL_LAYOUT;
> +	if (flags & FL_EXCLUSIVE)
> +		fl->fl_flags |= FL_EXCLUSIVE;
>  	fl->fl_start = 0;
>  	fl->fl_end = OFFSET_MAX;
>  	fl->fl_ops = NULL;
> @@ -1619,6 +1621,14 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list) {
>  		if (!leases_conflict(fl, new_fl))
>  			continue;
> +		if (fl->fl_flags & FL_EXCLUSIVE) {
> +			error = -ETXTBSY;
> +			if (new_fl->fl_pid == fl->fl_pid) {
> +				error = -EDEADLOCK;
> +				goto out;
> +			}
> +			continue;
> +		}
>  		if (want_write) {
>  			if (fl->fl_flags & FL_UNLOCK_PENDING)
>  				continue;
> @@ -1634,6 +1644,13 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  			locks_delete_lock_ctx(fl, &dispose);
>  	}
>  
> +	/* We differentiate between -EDEADLOCK and -ETXTBSY so the above loop
> +	 * continues with -ETXTBSY looking for a potential deadlock instead.
> +	 * If deadlock is not found go ahead and return -ETXTBSY.
> +	 */
> +	if (error == -ETXTBSY)
> +		goto out;
> +
>  	if (list_empty(&ctx->flc_lease))
>  		goto out;
>  
> @@ -2044,9 +2061,11 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg)
>  	 * to revoke the lease in break_layout()  And this is done by using
>  	 * F_WRLCK in the break code.
>  	 */
> -	if (arg == F_LAYOUT) {
> +	if ((arg & F_LAYOUT) == F_LAYOUT) {
> +		if ((arg & F_EXCLUSIVE) == F_EXCLUSIVE)
> +			flags |= FL_EXCLUSIVE;
>  		arg = F_RDLCK;
> -		flags = FL_LAYOUT;
> +		flags |= FL_LAYOUT;
>  	}
>  
>  	fl = lease_alloc(filp, arg, flags);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dd60d5be9886..2e41ce547913 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1005,6 +1005,7 @@ static inline struct file *get_file(struct file *f)
>  #define FL_UNLOCK_PENDING	512 /* Lease is being broken */
>  #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>  #define FL_LAYOUT	2048	/* outstanding pNFS layout or user held pin */
> +#define FL_EXCLUSIVE	4096	/* Layout lease is exclusive */
>  
>  #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>  
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index baddd54f3031..88b175ceccbc 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -176,6 +176,8 @@ struct f_owner_ex {
>  
>  #define F_LAYOUT	16      /* layout lease to allow longterm pins such as
>  				   RDMA */
> +#define F_EXCLUSIVE	32      /* layout lease is exclusive */
> +				/* FIXME or shoudl this be F_EXLCK??? */
>  
>  /* operations for bsd flock(), also used by the kernel implementation */
>  #define LOCK_SH		1	/* shared lock */

This interface just seems weird to me. The existing F_*LCK values aren't
really set up to be flags, but are enumerated values (even if there are
some gaps on some arches). For instance, on parisc and sparc:

/* for posix fcntl() and lockf() */
#define F_RDLCK         01
#define F_WRLCK         02
#define F_UNLCK         03

While your new flag values are well above these values, it's still a bit
sketchy to do what you're proposing from a cross-platform interface
standpoint.

I think this would be a lot cleaner if you weren't overloading the
F_SETLEASE command with new flags, and instead added new
F_SETLAYOUT/F_GETLAYOUT cmd values.

You'd then be free to define a new set of "arg" values for use with
layouts, and there's be a clear distinction interface-wise between
setting a layout and a lease.

-- 
Jeff Layton <jlayton@kernel.org>

