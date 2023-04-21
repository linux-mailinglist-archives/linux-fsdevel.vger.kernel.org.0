Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1E26EAE5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjDUP46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 11:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjDUP45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA14125BD;
        Fri, 21 Apr 2023 08:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A49564EEE;
        Fri, 21 Apr 2023 15:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AB8C433D2;
        Fri, 21 Apr 2023 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682092614;
        bh=vBPsMO1nsGTRrGpkMn/Fftt+rshboEXCADhHF/5eXAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XK/IxkJC0JDOyCyk854AHxmvHiMWFe+3qvnuzkttU/c6CvtiTsqeV6ecBcIvRcXoA
         rX/IXBN39A0DI4qncSt+Evp/2XHKlsEIMuLBNP2of8WXwS3XFHgJKntGAtGjcviMnw
         rhyiZ+vrhjWxXKp/1S/Ymt6fzXpcwehIipjjn263JvuucBHEyNO9+Vvc/JMWdsCEKf
         yI+13x/hCEEcVLsWmR/g5gG8Iq0+lPTmQEfrGxNDlNJaRWSVkomRWwH+VElW2HUqUs
         qfIZqKh/kqu2UwiESBcz9aLTQCe947tiaeMtKCAS8Gmh7PiNsEG9eS3Z/a1Lr2Ghyl
         Mk33Dn6mtzTXg==
Date:   Fri, 21 Apr 2023 08:56:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv6 9/9] iomap: Add DIO tracepoints
Message-ID: <20230421155653.GK360881@frogsfrogsfrogs>
References: <cover.1682069716.git.ritesh.list@gmail.com>
 <67daf0c2a4025b9c80023171bca5c9d1ec9b4341.1682069716.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67daf0c2a4025b9c80023171bca5c9d1ec9b4341.1682069716.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:16:19PM +0530, Ritesh Harjani (IBM) wrote:
> Add trace_iomap_dio_rw_begin, trace_iomap_dio_rw_queued and
> trace_iomap_dio_complete tracepoint.
> trace_iomap_dio_rw_queued is mostly only to know that the request was
> queued and -EIOCBQUEUED was returned. It is mostly trace_iomap_dio_rw_begin
> & trace_iomap_dio_complete which has all the details.
> 
> <example output log>
>       a.out-2073  [006]   134.225717: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x0 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT|WRITE dio_flags DIO_FORCE_WAIT aio 1
>       a.out-2073  [006]   134.226234: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT|WRITE aio 1 error 0 ret 4096
>       a.out-2074  [006]   136.225975: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x1000 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT dio_flags  aio 1
>       a.out-2074  [006]   136.226173: iomap_dio_rw_queued:  dev 7:7 ino 0xe size 0x1000 offset 0x1000 length 0x0
> ksoftirqd/3-31    [003]   136.226389: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT aio 1 error 0 ret 4096
>       a.out-2075  [003]   141.674969: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x1000 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT|WRITE dio_flags  aio 1
>       a.out-2075  [003]   141.676085: iomap_dio_rw_queued:  dev 7:7 ino 0xe size 0x1000 offset 0x1000 length 0x0
> kworker/2:0-27    [002]   141.676432: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT|WRITE aio 1 error 0 ret 4096
>       a.out-2077  [006]   143.443746: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x1000 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT dio_flags  aio 1
>       a.out-2077  [006]   143.443866: iomap_dio_rw_queued:  dev 7:7 ino 0xe size 0x1000 offset 0x1000 length 0x0
> ksoftirqd/5-41    [005]   143.444134: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT aio 1 error 0 ret 4096
>       a.out-2078  [007]   146.716833: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x1000 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT dio_flags  aio 0
>       a.out-2078  [007]   146.717639: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT aio 0 error 0 ret 4096
>       a.out-2079  [006]   148.972605: iomap_dio_rw_begin:   dev 7:7 ino 0xe size 0x1000 offset 0x0 length 0x1000 done_before 0x0 flags DIRECT dio_flags  aio 0
>       a.out-2079  [006]   148.973099: iomap_dio_complete:   dev 7:7 ino 0xe size 0x1000 offset 0x1000 flags DIRECT aio 0 error 0 ret 4096
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/direct-io.c |  7 +++-
>  fs/iomap/trace.c     |  1 +
>  fs/iomap/trace.h     | 78 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 36ab1152dbea..019cc87d0fb3 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -130,6 +130,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  	if (ret > 0)
>  		ret += dio->done_before;
>  
> +	trace_iomap_dio_complete(iocb, dio->error, ret);
>  	kfree(dio);
>  
>  	return ret;
> @@ -493,6 +494,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
>  
> +	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
> +
>  	if (!iomi.len)
>  		return NULL;
>  
> @@ -650,8 +653,10 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	 */
>  	dio->wait_for_completion = wait_for_completion;
>  	if (!atomic_dec_and_test(&dio->ref)) {
> -		if (!wait_for_completion)
> +		if (!wait_for_completion) {
> +			trace_iomap_dio_rw_queued(inode, iomi.pos, iomi.len);
>  			return ERR_PTR(-EIOCBQUEUED);
> +		}
>  
>  		for (;;) {
>  			set_current_state(TASK_UNINTERRUPTIBLE);
> diff --git a/fs/iomap/trace.c b/fs/iomap/trace.c
> index da217246b1a9..728d5443daf5 100644
> --- a/fs/iomap/trace.c
> +++ b/fs/iomap/trace.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2019 Christoph Hellwig
>   */
>  #include <linux/iomap.h>
> +#include <linux/uio.h>
>  
>  /*
>   * We include this last to have the helpers above available for the trace
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index f6ea9540d082..448b82d16c0b 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -83,6 +83,7 @@ DEFINE_RANGE_EVENT(iomap_writepage);
>  DEFINE_RANGE_EVENT(iomap_release_folio);
>  DEFINE_RANGE_EVENT(iomap_invalidate_folio);
>  DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
> +DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  
>  #define IOMAP_TYPE_STRINGS \
>  	{ IOMAP_HOLE,		"HOLE" }, \
> @@ -107,6 +108,11 @@ DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
>  	{ IOMAP_F_BUFFER_HEAD,	"BH" }, \
>  	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }
>  
> +#define IOMAP_DIO_STRINGS \
> +	{IOMAP_DIO_FORCE_WAIT, "DIO_FORCE_WAIT" }, \
> +	{IOMAP_DIO_OVERWRITE_ONLY, "DIO_OVERWRITE_ONLY" }, \
> +	{IOMAP_DIO_PARTIAL, "DIO_PARTIAL" }

I'll fix these indentation ^ problems on commit.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
>  DECLARE_EVENT_CLASS(iomap_class,
>  	TP_PROTO(struct inode *inode, struct iomap *iomap),
>  	TP_ARGS(inode, iomap),
> @@ -183,6 +189,78 @@ TRACE_EVENT(iomap_iter,
>  		   (void *)__entry->caller)
>  );
>  
> +TRACE_EVENT(iomap_dio_rw_begin,
> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter,
> +		 unsigned int dio_flags, size_t done_before),
> +	TP_ARGS(iocb, iter, dio_flags, done_before),
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(ino_t,	ino)
> +		__field(loff_t, isize)
> +		__field(loff_t, pos)
> +		__field(size_t,	count)
> +		__field(size_t,	done_before)
> +		__field(int,	ki_flags)
> +		__field(unsigned int,	dio_flags)
> +		__field(bool,	aio)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
> +		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
> +		__entry->isize = file_inode(iocb->ki_filp)->i_size;
> +		__entry->pos = iocb->ki_pos;
> +		__entry->count = iov_iter_count(iter);
> +		__entry->done_before = done_before;
> +		__entry->ki_flags = iocb->ki_flags;
> +		__entry->dio_flags = dio_flags;
> +		__entry->aio = !is_sync_kiocb(iocb);
> +	),
> +	TP_printk("dev %d:%d ino 0x%lx size 0x%llx offset 0x%llx length 0x%zx done_before 0x%zx flags %s dio_flags %s aio %d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino,
> +		  __entry->isize,
> +		  __entry->pos,
> +		  __entry->count,
> +		  __entry->done_before,
> +		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
> +		  __print_flags(__entry->dio_flags, "|", IOMAP_DIO_STRINGS),
> +		  __entry->aio)
> +);
> +
> +TRACE_EVENT(iomap_dio_complete,
> +	TP_PROTO(struct kiocb *iocb, int error, ssize_t ret),
> +	TP_ARGS(iocb, error, ret),
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(ino_t,	ino)
> +		__field(loff_t, isize)
> +		__field(loff_t, pos)
> +		__field(int,	ki_flags)
> +		__field(bool,	aio)
> +		__field(int,	error)
> +		__field(ssize_t, ret)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
> +		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
> +		__entry->isize = file_inode(iocb->ki_filp)->i_size;
> +		__entry->pos = iocb->ki_pos;
> +		__entry->ki_flags = iocb->ki_flags;
> +		__entry->aio = !is_sync_kiocb(iocb);
> +		__entry->error = error;
> +		__entry->ret = ret;
> +	),
> +	TP_printk("dev %d:%d ino 0x%lx size 0x%llx offset 0x%llx flags %s aio %d error %d ret %zd",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino,
> +		  __entry->isize,
> +		  __entry->pos,
> +		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
> +		  __entry->aio,
> +		  __entry->error,
> +		  __entry->ret)
> +);
> +
>  #endif /* _IOMAP_TRACE_H */
>  
>  #undef TRACE_INCLUDE_PATH
> -- 
> 2.39.2
> 
