Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAA439EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbfFMPRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbfFMNWo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:22:44 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D5621473;
        Thu, 13 Jun 2019 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560432163;
        bh=JwfwFzoAqbbp1outlf75R3DQtkfxeJF9Er26IgGsSK8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jKHRgDobe0P6NKgK1Mpfvx8moCATLdwO4mCjgeY5ijni/cpHRAckOvnyucfGlNiHC
         a1BplI0n4QvnofEIaqntUYI3pJwHCmjjTAXZwVbcRWXIfRRxDZ5riPB+wPr1MAoNsf
         TMurIYQ01fH4QpZjegUL3HUBWLCaTh7CGg8M51K4=
Message-ID: <2851a6b983ed8b5b858b3b336e70296204349762.camel@kernel.org>
Subject: Re: [PATCH v2] locks: eliminate false positive conflicts for write
 lease
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J . Bruce Fields" <bfields@fieldses.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Date:   Thu, 13 Jun 2019 09:22:41 -0400
In-Reply-To: <20190612172408.22671-1-amir73il@gmail.com>
References: <20190612172408.22671-1-amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-06-12 at 20:24 +0300, Amir Goldstein wrote:
> check_conflicting_open() is checking for existing fd's open for read or
> for write before allowing to take a write lease.  The check that was
> implemented using i_count and d_count is an approximation that has
> several false positives.  For example, overlayfs since v4.19, takes an
> extra reference on the dentry; An open with O_PATH takes a reference on
> the dentry although the file cannot be read nor written.
> 
> Change the implementation to use i_readcount and i_writecount to
> eliminate the false positive conflicts and allow a write lease to be
> taken on an overlayfs file.
> 
> The change of behavior with existing fd's open with O_PATH is symmetric
> w.r.t. current behavior of lease breakers - an open with O_PATH currently
> does not break a write lease.
> 
> This increases the size of struct inode by 4 bytes on 32bit archs when
> CONFIG_FILE_LOCKING is defined and CONFIG_IMA was not already
> defined.
> 
> Cc: <stable@vger.kernel.org> # v4.19
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos, Jeff and Bruce,
> 
> This patch fixes a v4.19 overlayfs regression with taking write
> leases. It also provides correct semantics w.r.t RDONLY open counter
> that Bruce also needed for nfsd.
> 
> Since this is locks code that fixes an overlayfs regression which
> is also needed for nfsd, it could go via either of your trees.
> I didn't want to pick sides, so first one to grab the patch wins ;-)
> 
> I verified the changes using modified LTP F_SETLEASE tests [1],
> which I ran over xfs and overlayfs.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/ltp/commits/overlayfs-devel
> 
> Changes since v1:
> - Drop patch to fold i_readcount into i_count
> - Make i_readcount depend on CONFIG_FILE_LOCKING
> 
>  fs/locks.c         | 33 ++++++++++++++++++++++-----------
>  include/linux/fs.h |  4 ++--
>  2 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index ec1e4a5df629..28528b4fc53b 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1753,10 +1753,10 @@ int fcntl_getlease(struct file *filp)
>  }
>  
>  /**
> - * check_conflicting_open - see if the given dentry points to a file that has
> + * check_conflicting_open - see if the given file points to an inode that has
>   *			    an existing open that would conflict with the
>   *			    desired lease.
> - * @dentry:	dentry to check
> + * @filp:	file to check
>   * @arg:	type of lease that we're trying to acquire
>   * @flags:	current lock flags
>   *
> @@ -1764,19 +1764,31 @@ int fcntl_getlease(struct file *filp)
>   * conflict with the lease we're trying to set.
>   */
>  static int
> -check_conflicting_open(const struct dentry *dentry, const long arg, int flags)
> +check_conflicting_open(struct file *filp, const long arg, int flags)
>  {
>  	int ret = 0;
> -	struct inode *inode = dentry->d_inode;
> +	struct inode *inode = locks_inode(filp);
> +	int wcount = atomic_read(&inode->i_writecount);
> +	int self_wcount = 0, self_rcount = 0;
>  
>  	if (flags & FL_LAYOUT)
>  		return 0;
>  
> -	if ((arg == F_RDLCK) && inode_is_open_for_write(inode))
> +	if (arg == F_RDLCK && wcount > 0)
>  		return -EAGAIN;
>  
> -	if ((arg == F_WRLCK) && ((d_count(dentry) > 1) ||
> -	    (atomic_read(&inode->i_count) > 1)))
> +	/* Eliminate deny writes from actual writers count */
> +	if (wcount < 0)
> +		wcount = 0;
> +
> +	/* Make sure that only read/write count is from lease requestor */
> +	if (filp->f_mode & FMODE_WRITE)
> +		self_wcount = 1;
> +	else if ((filp->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)

nit: you already checked for FMODE_WRITE and you know that it's not set
here, so this is equivalent to:

    else if (filp->f_mode & FMODE_READ)

> +		self_rcount = 1;
> +
> +	if (arg == F_WRLCK && (wcount != self_wcount ||
> +	    atomic_read(&inode->i_readcount) != self_rcount))
>  		ret = -EAGAIN;
>  
>  	return ret;
> @@ -1786,8 +1798,7 @@ static int
>  generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **priv)
>  {
>  	struct file_lock *fl, *my_fl = NULL, *lease;
> -	struct dentry *dentry = filp->f_path.dentry;
> -	struct inode *inode = dentry->d_inode;
> +	struct inode *inode = locks_inode(filp);
>  	struct file_lock_context *ctx;
>  	bool is_deleg = (*flp)->fl_flags & FL_DELEG;
>  	int error;
> @@ -1822,7 +1833,7 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
>  	percpu_down_read(&file_rwsem);
>  	spin_lock(&ctx->flc_lock);
>  	time_out_leases(inode, &dispose);
> -	error = check_conflicting_open(dentry, arg, lease->fl_flags);
> +	error = check_conflicting_open(filp, arg, lease->fl_flags);
>  	if (error)
>  		goto out;
>  
> @@ -1879,7 +1890,7 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
>  	 * precedes these checks.
>  	 */
>  	smp_mb();
> -	error = check_conflicting_open(dentry, arg, lease->fl_flags);
> +	error = check_conflicting_open(filp, arg, lease->fl_flags);
>  	if (error) {
>  		locks_unlink_lock_ctx(lease);
>  		goto out;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 79ffa2958bd8..2d55f1b64014 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -694,7 +694,7 @@ struct inode {
>  	atomic_t		i_count;
>  	atomic_t		i_dio_count;
>  	atomic_t		i_writecount;
> -#ifdef CONFIG_IMA
> +#if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
>  	atomic_t		i_readcount; /* struct files open RO */
>  #endif
>  	union {
> @@ -2895,7 +2895,7 @@ static inline bool inode_is_open_for_write(const struct inode *inode)
>  	return atomic_read(&inode->i_writecount) > 0;
>  }
>  
> -#ifdef CONFIG_IMA
> +#if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
>  static inline void i_readcount_dec(struct inode *inode)
>  {
>  	BUG_ON(!atomic_read(&inode->i_readcount));


Looks good to me. Aside from the minor nit above:

    Reviewed-by: Jeff Layton <jlayton@kernel.org>

I have one file locking patch queued up for v5.3 so far, but nothing for
v5.2. Miklos or Bruce, if either of you have anything to send to Linus
for v5.2 would you mind taking this one too?

If not I can queue it up and get it to him after letting it soak in
linux-next for a bit.

