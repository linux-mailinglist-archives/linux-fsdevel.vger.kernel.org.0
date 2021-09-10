Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33A4072C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 22:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhIJVAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 17:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhIJVAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:00:52 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA9C061574;
        Fri, 10 Sep 2021 13:59:41 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5FE08701D; Fri, 10 Sep 2021 16:59:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5FE08701D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1631307580;
        bh=2w98AgBV/4XZ3PqFsD8uKt2O2D7jwV6LoybQQ4T2g2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/F/e4v2X692UfLrVuUQUGIe716fCo5m0nrualYO9k81Qiof8M4bcjyBeauJ0Fip5
         G5lo3CZ24megqAYHYG1AhMLMphgCQMcSBrp/fTmFe8SEMCiG1lG2xpoSWG+L04eBi9
         hGlvBKXFDwDWZB5pRzB34bylbznD9MQ6cg9D9QFA=
Date:   Fri, 10 Sep 2021 16:59:40 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] locks: remove LOCK_MAND flock lock support
Message-ID: <20210910205940.GA789@fieldses.org>
References: <20210910201915.95170-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910201915.95170-1-jlayton@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:19:15PM -0400, Jeff Layton wrote:
> As best I can tell, the logic for these has been broken for a long time
> (at least before the move to git), such that they never conflict with
> anything.

I've wondered about that!

But a grep of the Samba code shows it actually uses LOCK_MAND, why?
Looking closer now, I see that it sets LOCK_MAND in some cases but never
checks for LOCK_MAND, so there's absolutely no point unless the kernel
is doing something useful, which it isn't.  Huh.

Looking back at the kernel...  LOCK_MAND was introduced in Linux
2.4.0-test9pre6, and it was only checked in nfsd read and write code,
and only only on exports that had an "msnfs" export option set.

So it was a mandatory lock that only worked against NFS readers and
writers, and only if the admin knew to set this export option.

And, oh, look, I'd forgotten about this, but apparently in 2011 I
noticed that the msnfs option was totally undocumented and ripped it
out, in 9ce137eee4fe "nfsd: don't support msnfs export option".

I've heard no complaints since, so I guess that was an OK decision.

But I should have noticed at the same time that this also made LOCK_MAND
a no-op.

OK, sorry for the novel, and thanks for cleaning this up!

(Are you sending Samba a patch too?)

--b.

> Also, nothing checks for these flags and prevented opens or
> read/write behavior on the files. They don't seem to do anything.
> 
> Given that, we can rip these symbols out of the kernel, and just make
> flock(2) return 0 when LOCK_MAND is set in order to preserve existing
> behavior.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/locks.c                  |  3 ---
>  fs/gfs2/file.c                   |  2 --
>  fs/locks.c                       | 46 +++++++++++++++-----------------
>  fs/nfs/file.c                    |  9 -------
>  include/uapi/asm-generic/fcntl.h |  4 +++
>  5 files changed, 25 insertions(+), 39 deletions(-)
> 
> Note that I do see some occurrences of LOCK_MAND in samba codebase, but
> I think it's probably best that those are removed.
> 
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index bdeb271f47d9..d8c31069fbf2 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -302,9 +302,6 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
>  
>  	if (!(fl->fl_flags & FL_FLOCK))
>  		return -ENOLCK;
> -	/* No mandatory locks */
> -	if (fl->fl_type & LOCK_MAND)
> -		return -EOPNOTSUPP;
>  
>  	dout("ceph_flock, fl_file: %p\n", fl->fl_file);
>  
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index c559827cb6f9..078ef29e31bc 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -1338,8 +1338,6 @@ static int gfs2_flock(struct file *file, int cmd, struct file_lock *fl)
>  {
>  	if (!(fl->fl_flags & FL_FLOCK))
>  		return -ENOLCK;
> -	if (fl->fl_type & LOCK_MAND)
> -		return -EOPNOTSUPP;
>  
>  	if (fl->fl_type == F_UNLCK) {
>  		do_unflock(file, fl);
> diff --git a/fs/locks.c b/fs/locks.c
> index 3d6fb4ae847b..0e1d8a637e9c 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -461,8 +461,6 @@ static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
>  }
>  
>  static inline int flock_translate_cmd(int cmd) {
> -	if (cmd & LOCK_MAND)
> -		return cmd & (LOCK_MAND | LOCK_RW);
>  	switch (cmd) {
>  	case LOCK_SH:
>  		return F_RDLCK;
> @@ -942,8 +940,6 @@ static bool flock_locks_conflict(struct file_lock *caller_fl,
>  	 */
>  	if (caller_fl->fl_file == sys_fl->fl_file)
>  		return false;
> -	if ((caller_fl->fl_type & LOCK_MAND) || (sys_fl->fl_type & LOCK_MAND))
> -		return false;
>  
>  	return locks_conflict(caller_fl, sys_fl);
>  }
> @@ -2116,11 +2112,9 @@ EXPORT_SYMBOL(locks_lock_inode_wait);
>   *	- %LOCK_SH -- a shared lock.
>   *	- %LOCK_EX -- an exclusive lock.
>   *	- %LOCK_UN -- remove an existing lock.
> - *	- %LOCK_MAND -- a 'mandatory' flock.
> - *	  This exists to emulate Windows Share Modes.
> + *	- %LOCK_MAND -- a 'mandatory' flock. (DEPRECATED)
>   *
> - *	%LOCK_MAND can be combined with %LOCK_READ or %LOCK_WRITE to allow other
> - *	processes read and write access respectively.
> + *	%LOCK_MAND support has been removed from the kernel.
>   */
>  SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
>  {
> @@ -2137,9 +2131,22 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
>  	cmd &= ~LOCK_NB;
>  	unlock = (cmd == LOCK_UN);
>  
> -	if (!unlock && !(cmd & LOCK_MAND) &&
> -	    !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
> +	if (!unlock && !(f.file->f_mode & (FMODE_READ|FMODE_WRITE)))
> +		goto out_putf;
> +
> +	/*
> +	 * LOCK_MAND locks were broken for a long time in that they never
> +	 * conflicted with one another and didn't prevent any sort of open,
> +	 * read or write activity.
> +	 *
> +	 * Just ignore these requests now, to preserve legacy behavior, but
> +	 * throw a warning to let people know that they don't actually work.
> +	 */
> +	if (cmd & LOCK_MAND) {
> +		pr_warn_once("Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.\n");
> +		error = 0;
>  		goto out_putf;
> +	}
>  
>  	lock = flock_make_lock(f.file, cmd, NULL);
>  	if (IS_ERR(lock)) {
> @@ -2745,11 +2752,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  		seq_printf(f, " %s ",
>  			     (inode == NULL) ? "*NOINODE*" : "ADVISORY ");
>  	} else if (IS_FLOCK(fl)) {
> -		if (fl->fl_type & LOCK_MAND) {
> -			seq_puts(f, "FLOCK  MSNFS     ");
> -		} else {
> -			seq_puts(f, "FLOCK  ADVISORY  ");
> -		}
> +		seq_puts(f, "FLOCK  ADVISORY  ");
>  	} else if (IS_LEASE(fl)) {
>  		if (fl->fl_flags & FL_DELEG)
>  			seq_puts(f, "DELEG  ");
> @@ -2765,17 +2768,10 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  	} else {
>  		seq_puts(f, "UNKNOWN UNKNOWN  ");
>  	}
> -	if (fl->fl_type & LOCK_MAND) {
> -		seq_printf(f, "%s ",
> -			       (fl->fl_type & LOCK_READ)
> -			       ? (fl->fl_type & LOCK_WRITE) ? "RW   " : "READ "
> -			       : (fl->fl_type & LOCK_WRITE) ? "WRITE" : "NONE ");
> -	} else {
> -		int type = IS_LEASE(fl) ? target_leasetype(fl) : fl->fl_type;
> +	int type = IS_LEASE(fl) ? target_leasetype(fl) : fl->fl_type;
>  
> -		seq_printf(f, "%s ", (type == F_WRLCK) ? "WRITE" :
> -				     (type == F_RDLCK) ? "READ" : "UNLCK");
> -	}
> +	seq_printf(f, "%s ", (type == F_WRLCK) ? "WRITE" :
> +			     (type == F_RDLCK) ? "READ" : "UNLCK");
>  	if (inode) {
>  		/* userspace relies on this representation of dev_t */
>  		seq_printf(f, "%d %02x:%02x:%lu ", fl_pid,
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index aa353fd58240..24e7dccce355 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -843,15 +843,6 @@ int nfs_flock(struct file *filp, int cmd, struct file_lock *fl)
>  	if (!(fl->fl_flags & FL_FLOCK))
>  		return -ENOLCK;
>  
> -	/*
> -	 * The NFSv4 protocol doesn't support LOCK_MAND, which is not part of
> -	 * any standard. In principle we might be able to support LOCK_MAND
> -	 * on NFSv2/3 since NLMv3/4 support DOS share modes, but for now the
> -	 * NFS code is not set up for it.
> -	 */
> -	if (fl->fl_type & LOCK_MAND)
> -		return -EINVAL;
> -
>  	if (NFS_SERVER(inode)->flags & NFS_MOUNT_LOCAL_FLOCK)
>  		is_local = 1;
>  
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index 9dc0bf0c5a6e..ecd0f5bdfc1d 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -181,6 +181,10 @@ struct f_owner_ex {
>  				   blocking */
>  #define LOCK_UN		8	/* remove lock */
>  
> +/*
> + * LOCK_MAND support has been removed from the kernel. We leave the symbols
> + * here to not break legacy builds, but these should not be used in new code.
> + */
>  #define LOCK_MAND	32	/* This is a mandatory flock ... */
>  #define LOCK_READ	64	/* which allows concurrent read operations */
>  #define LOCK_WRITE	128	/* which allows concurrent write operations */
> -- 
> 2.31.1
