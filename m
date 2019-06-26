Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEC560FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 05:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfFZDwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 23:52:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44166 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfFZDwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:52:32 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfyyN-0008Mv-UN; Wed, 26 Jun 2019 03:51:52 +0000
Date:   Wed, 26 Jun 2019 04:51:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, hch@infradead.org,
        clm@fb.com, adilger.kernel@dilger.ca, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org,
        reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] vfs: don't allow writes to swap files
Message-ID: <20190626035151.GA10613@ZenIV.linux.org.uk>
References: <156151637248.2283603.8458727861336380714.stgit@magnolia>
 <156151641177.2283603.7806026378321236401.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156151641177.2283603.7806026378321236401.stgit@magnolia>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:33:31PM -0700, Darrick J. Wong wrote:
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -236,6 +236,9 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
>  	if (IS_IMMUTABLE(inode))
>  		return -EPERM;
>  
> +	if (IS_SWAPFILE(inode))
> +		return -ETXTBSY;
> +
>  	if ((ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_TIMES_SET)) &&
>  	    IS_APPEND(inode))
>  		return -EPERM;

Er...  So why exactly is e.g. chmod(2) forbidden for swapfiles?  Or touch(1),
for that matter...

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 596ac98051c5..1ca4ee8c2d60 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3165,6 +3165,19 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	if (error)
>  		goto bad_swap;
>  
> +	/*
> +	 * Flush any pending IO and dirty mappings before we start using this
> +	 * swap file.
> +	 */
> +	if (S_ISREG(inode->i_mode)) {
> +		inode->i_flags |= S_SWAPFILE;
> +		error = inode_drain_writes(inode);
> +		if (error) {
> +			inode->i_flags &= ~S_SWAPFILE;
> +			goto bad_swap;
> +		}
> +	}

Why are swap partitions any less worthy of protection?
