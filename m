Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4228077E484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 17:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbjHPPBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343943AbjHPPBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:01:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66CA2736
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 08:01:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F9F81F459;
        Wed, 16 Aug 2023 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692198061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BrSv2YasJLchZkGbZonYQ8KF/dsWsdFjChVazw6Zr3M=;
        b=sIjG12xD/+Y4vTyFSE0xryAzDkHspXr4l/UlDTyvy135PammhBSq2zwk3dphrY1zjpxcH+
        6aAOuKnvHwVFV05PoBf+dVLPaZdMWp4+zDJrPnBrWPs5XhtZgh2E41FwlWvoIModBR/9ap
        ugMQeiL7rliaHzF3XmOsGJitUdiqq7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692198061;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BrSv2YasJLchZkGbZonYQ8KF/dsWsdFjChVazw6Zr3M=;
        b=rB/UhU8BDKXNXzLJCT2dqkCreIhlf57Ed1GRLzN0P3nBQRiXrMKZvqADbkE1TzqX/02u3A
        VkJJ7rd9xMxJIwCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48C311353E;
        Wed, 16 Aug 2023 15:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LQOlEa3k3GQHDAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Aug 2023 15:01:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AC012A0769; Wed, 16 Aug 2023 17:01:00 +0200 (CEST)
Date:   Wed, 16 Aug 2023 17:01:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: create kiocb_{start,end}_write() helpers
Message-ID: <20230816150100.e57mr4pr3u52u64b@quack3>
References: <20230816085439.894112-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816085439.894112-1-amir73il@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-08-23 11:54:39, Amir Goldstein wrote:
> aio, io_uring, cachefiles and overlayfs, all open code an ugly variant
> of file_{start,end}_write() to silence lockdep warnings.
> 
> Create helpers for this lockdep dance and use the helpers in all the
> callers.
> 
> Use a new iocb flag IOCB_WRITE_STARTED to indicate if sb_start_write()
> was called.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Yeah, looks like a good cleanup to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
> 
> Christian,
> 
> This is an attempt to consolidate the open coded lockdep fooling in
> all those async io submitters into a single helper.
> The idea to do that consolidation was suggested by Jan.
> The (questionable) idea to use an IOCB_ flag was mine.
> 
> This re-factoring is part of a larger vfs cleanup I am doing for
> fanotify permission events.  The complete series is not ready for
> prime time yet, but this one patch is independent and I would love
> to get it reviewed/merged a head of the rest.
> 
> Thanks,
> Amir.
> 
> Changes since v1:
> - Leave ISREG checks in callers (Jens)
> - Leave setting IOCB_WRITE flag in callers
> 
>  fs/aio.c            | 26 +++----------------
>  fs/cachefiles/io.c  | 16 +++---------
>  fs/overlayfs/file.c | 15 +++++------
>  include/linux/fs.h  | 62 +++++++++++++++++++++++++++++++++++++++++++--
>  io_uring/rw.c       | 36 +++++---------------------
>  5 files changed, 79 insertions(+), 76 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 77e33619de40..16fb3ac2093b 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1444,17 +1444,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
>  	if (!list_empty_careful(&iocb->ki_list))
>  		aio_remove_iocb(iocb);
>  
> -	if (kiocb->ki_flags & IOCB_WRITE) {
> -		struct inode *inode = file_inode(kiocb->ki_filp);
> -
> -		/*
> -		 * Tell lockdep we inherited freeze protection from submission
> -		 * thread.
> -		 */
> -		if (S_ISREG(inode->i_mode))
> -			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> -		file_end_write(kiocb->ki_filp);
> -	}
> +	if (kiocb->ki_flags & IOCB_WRITE)
> +		kiocb_end_write(kiocb);
>  
>  	iocb->ki_res.res = res;
>  	iocb->ki_res.res2 = 0;
> @@ -1581,17 +1572,8 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
>  		return ret;
>  	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
>  	if (!ret) {
> -		/*
> -		 * Open-code file_start_write here to grab freeze protection,
> -		 * which will be released by another thread in
> -		 * aio_complete_rw().  Fool lockdep by telling it the lock got
> -		 * released so that it doesn't complain about the held lock when
> -		 * we return to userspace.
> -		 */
> -		if (S_ISREG(file_inode(file)->i_mode)) {
> -			sb_start_write(file_inode(file)->i_sb);
> -			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> -		}
> +		if (S_ISREG(file_inode(file)->i_mode))
> +			kiocb_start_write(req);
>  		req->ki_flags |= IOCB_WRITE;
>  		aio_rw_done(req, call_write_iter(file, req, &iter));
>  	}
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 175a25fcade8..6e16f7c116da 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -259,9 +259,7 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
>  
>  	_enter("%ld", ret);
>  
> -	/* Tell lockdep we inherited freeze protection from submission thread */
> -	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> -	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
> +	kiocb_end_write(iocb);
>  
>  	if (ret < 0)
>  		trace_cachefiles_io_error(object, inode, ret,
> @@ -286,7 +284,6 @@ int __cachefiles_write(struct cachefiles_object *object,
>  {
>  	struct cachefiles_cache *cache;
>  	struct cachefiles_kiocb *ki;
> -	struct inode *inode;
>  	unsigned int old_nofs;
>  	ssize_t ret;
>  	size_t len = iov_iter_count(iter);
> @@ -322,19 +319,12 @@ int __cachefiles_write(struct cachefiles_object *object,
>  		ki->iocb.ki_complete = cachefiles_write_complete;
>  	atomic_long_add(ki->b_writing, &cache->b_writing);
>  
> -	/* Open-code file_start_write here to grab freeze protection, which
> -	 * will be released by another thread in aio_complete_rw().  Fool
> -	 * lockdep by telling it the lock got released so that it doesn't
> -	 * complain about the held lock when we return to userspace.
> -	 */
> -	inode = file_inode(file);
> -	__sb_start_write(inode->i_sb, SB_FREEZE_WRITE);
> -	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
> +	kiocb_start_write(ki);
>  
>  	get_file(ki->iocb.ki_filp);
>  	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
>  
> -	trace_cachefiles_write(object, inode, ki->iocb.ki_pos, len);
> +	trace_cachefiles_write(object, file_inode(file), ki->iocb.ki_pos, len);
>  	old_nofs = memalloc_nofs_save();
>  	ret = cachefiles_inject_write_error();
>  	if (ret == 0)
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 21245b00722a..c756edb9bd4c 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -290,10 +290,7 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
>  	if (iocb->ki_flags & IOCB_WRITE) {
>  		struct inode *inode = file_inode(orig_iocb->ki_filp);
>  
> -		/* Actually acquired in ovl_write_iter() */
> -		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
> -				      SB_FREEZE_WRITE);
> -		file_end_write(iocb->ki_filp);
> +		kiocb_end_write(iocb);
>  		ovl_copyattr(inode);
>  	}
>  
> @@ -362,6 +359,9 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	return ret;
>  }
>  
> +/* IOCB flags that may be propagated to real file io */
> +#define OVL_IOCB_MASK ~(IOCB_WRITE_STARTED)
> +
>  static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct file *file = iocb->ki_filp;
> @@ -369,7 +369,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	struct fd real;
>  	const struct cred *old_cred;
>  	ssize_t ret;
> -	int ifl = iocb->ki_flags;
> +	int ifl = iocb->ki_flags & OVL_IOCB_MASK;
>  
>  	if (!iov_iter_count(iter))
>  		return 0;
> @@ -409,10 +409,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		if (!aio_req)
>  			goto out;
>  
> -		file_start_write(real.file);
> -		/* Pacify lockdep, same trick as done in aio_write() */
> -		__sb_writers_release(file_inode(real.file)->i_sb,
> -				     SB_FREEZE_WRITE);
>  		aio_req->fd = real;
>  		real.flags = 0;
>  		aio_req->orig_iocb = iocb;
> @@ -420,6 +416,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		aio_req->iocb.ki_flags = ifl;
>  		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
>  		refcount_set(&aio_req->ref, 2);
> +		kiocb_start_write(&aio_req->iocb);
>  		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
>  		ovl_aio_put(aio_req);
>  		if (ret != -EIOCBQUEUED)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b2adee67f9b2..8e5d410a1be5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -338,6 +338,8 @@ enum rw_hint {
>  #define IOCB_NOIO		(1 << 20)
>  /* can use bio alloc cache */
>  #define IOCB_ALLOC_CACHE	(1 << 21)
> +/* file_start_write() was called */
> +#define IOCB_WRITE_STARTED	(1 << 22)
>  
>  /* for use in trace events */
>  #define TRACE_IOCB_STRINGS \
> @@ -351,7 +353,8 @@ enum rw_hint {
>  	{ IOCB_WRITE,		"WRITE" }, \
>  	{ IOCB_WAITQ,		"WAITQ" }, \
>  	{ IOCB_NOIO,		"NOIO" }, \
> -	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }
> +	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
> +	{ IOCB_WRITE_STARTED,	"WRITE_STARTED" }
>  
>  struct kiocb {
>  	struct file		*ki_filp;
> @@ -2545,6 +2548,13 @@ static inline bool inode_wrong_type(const struct inode *inode, umode_t mode)
>  	return (inode->i_mode ^ mode) & S_IFMT;
>  }
>  
> +/**
> + * file_start_write - get write access to a superblock for regular file io
> + * @file: the file we want to write to
> + *
> + * This is a variant of sb_start_write() which is a noop on non-regualr file.
> + * Should be matched with a call to file_end_write().
> + */
>  static inline void file_start_write(struct file *file)
>  {
>  	if (!S_ISREG(file_inode(file)->i_mode))
> @@ -2559,11 +2569,59 @@ static inline bool file_start_write_trylock(struct file *file)
>  	return sb_start_write_trylock(file_inode(file)->i_sb);
>  }
>  
> +/**
> + * file_end_write - drop write access to a superblock of a regular file
> + * @file: the file we wrote to
> + *
> + * Should be matched with a call to file_start_write().
> + */
>  static inline void file_end_write(struct file *file)
>  {
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return;
> -	__sb_end_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> +	sb_end_write(file_inode(file)->i_sb);
> +}
> +
> +/**
> + * kiocb_start_write - get write access to a superblock for async file io
> + * @iocb: the io context we want to submit the write with
> + *
> + * This is a variant of file_start_write() for async io submission.
> + * Should be matched with a call to kiocb_end_write().
> + */
> +static inline void kiocb_start_write(struct kiocb *iocb)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_WRITE_STARTED))
> +		return;
> +	sb_start_write(inode->i_sb);
> +	/*
> +	 * Fool lockdep by telling it the lock got released so that it
> +	 * doesn't complain about the held lock when we return to userspace.
> +	 */
> +	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
> +	iocb->ki_flags |= IOCB_WRITE_STARTED;
> +}
> +
> +/**
> + * kiocb_end_write - drop write access to a superblock after async file io
> + * @iocb: the io context we sumbitted the write with
> + *
> + * Should be matched with a call to kiocb_start_write().
> + */
> +static inline void kiocb_end_write(struct kiocb *iocb)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (!(iocb->ki_flags & IOCB_WRITE_STARTED))
> +		return;
> +	/*
> +	 * Tell lockdep we inherited freeze protection from submission thread.
> +	 */
> +	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> +	sb_end_write(inode->i_sb);
> +	iocb->ki_flags &= ~IOCB_WRITE_STARTED;
>  }
>  
>  /*
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 1bce2208b65c..362d48493096 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -220,20 +220,6 @@ static bool io_rw_should_reissue(struct io_kiocb *req)
>  }
>  #endif
>  
> -static void kiocb_end_write(struct io_kiocb *req)
> -{
> -	/*
> -	 * Tell lockdep we inherited freeze protection from submission
> -	 * thread.
> -	 */
> -	if (req->flags & REQ_F_ISREG) {
> -		struct super_block *sb = file_inode(req->file)->i_sb;
> -
> -		__sb_writers_acquired(sb, SB_FREEZE_WRITE);
> -		sb_end_write(sb);
> -	}
> -}
> -
>  /*
>   * Trigger the notifications after having done some IO, and finish the write
>   * accounting, if any.
> @@ -243,7 +229,7 @@ static void io_req_io_end(struct io_kiocb *req)
>  	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
>  
>  	if (rw->kiocb.ki_flags & IOCB_WRITE) {
> -		kiocb_end_write(req);
> +		kiocb_end_write(&rw->kiocb);
>  		fsnotify_modify(req->file);
>  	} else {
>  		fsnotify_access(req->file);
> @@ -313,7 +299,7 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
>  	struct io_kiocb *req = cmd_to_io_kiocb(rw);
>  
>  	if (kiocb->ki_flags & IOCB_WRITE)
> -		kiocb_end_write(req);
> +		kiocb_end_write(kiocb);
>  	if (unlikely(res != req->cqe.res)) {
>  		if (res == -EAGAIN && io_rw_should_reissue(req)) {
>  			req->flags |= REQ_F_REISSUE | REQ_F_PARTIAL_IO;
> @@ -902,18 +888,8 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  		return ret;
>  	}
>  
> -	/*
> -	 * Open-code file_start_write here to grab freeze protection,
> -	 * which will be released by another thread in
> -	 * io_complete_rw().  Fool lockdep by telling it the lock got
> -	 * released so that it doesn't complain about the held lock when
> -	 * we return to userspace.
> -	 */
> -	if (req->flags & REQ_F_ISREG) {
> -		sb_start_write(file_inode(req->file)->i_sb);
> -		__sb_writers_release(file_inode(req->file)->i_sb,
> -					SB_FREEZE_WRITE);
> -	}
> +	if (req->flags & REQ_F_ISREG)
> +		kiocb_start_write(kiocb);
>  	kiocb->ki_flags |= IOCB_WRITE;
>  
>  	if (likely(req->file->f_op->write_iter))
> @@ -961,7 +937,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  				io->bytes_done += ret2;
>  
>  			if (kiocb->ki_flags & IOCB_WRITE)
> -				kiocb_end_write(req);
> +				kiocb_end_write(kiocb);
>  			return ret ? ret : -EAGAIN;
>  		}
>  done:
> @@ -972,7 +948,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  		ret = io_setup_async_rw(req, iovec, s, false);
>  		if (!ret) {
>  			if (kiocb->ki_flags & IOCB_WRITE)
> -				kiocb_end_write(req);
> +				kiocb_end_write(kiocb);
>  			return -EAGAIN;
>  		}
>  		return ret;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
