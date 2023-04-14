Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514B16E1A14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 04:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDNCQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 22:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDNCQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D071026BA;
        Thu, 13 Apr 2023 19:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4206430D;
        Fri, 14 Apr 2023 02:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862A9C433D2;
        Fri, 14 Apr 2023 02:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681438562;
        bh=8+ozliOWL6qMJMQshYTA8fFVIE0YPzCFLSd41fysEaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FisVG1SHWJrVQIYF/9Uqi1rPoHS+0La1n8c/D6Y3FMdQmT5AIt4EknXZtftGYLecP
         uZpPdjxAlFp50hYgjBAkYrcTUbD1tgDsMwf46LlkMFp1DUQo9nQt7x9XK5JYJ1+kFs
         FhQDUteW4xfWn5ggXOShTCFJ3jwFhdp8H19RpupYY7lIn2KJbTHxkkilvmKs0QdcuY
         2oYpPoSkLFFNWtrZSlbHOBQzo6k+p9SQQ72oTpgvX5MVs1n9jcIewIJhYL9K+eW7GE
         3pZ5921fEZ6+RoAfl7E+JlCKdlWnxlQWxxVxK2wTbTjfRsqTHAr7QeKrDHTsuobQSs
         W+BHFLCgqTGew==
Date:   Thu, 13 Apr 2023 19:16:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 10/10] iomap: Add trace points for DIO path
Message-ID: <20230414021601.GE360877@frogsfrogsfrogs>
References: <20230413144232.GD360877@frogsfrogsfrogs>
 <87fs93zgba.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs93zgba.fsf@doe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 01:48:49AM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Thu, Apr 13, 2023 at 02:10:32PM +0530, Ritesh Harjani (IBM) wrote:
> >> This patch adds trace point events for iomap DIO path.
> >>
> >> <e.g. iomap dio trace>
> >>      xfs_io-8815  [000]   526.790418: iomap_dio_rw_begin:   dev 7:7 ino 0xc isize 0x0 pos 0x0 count 4096 flags DIRECT dio_flags DIO_FORCE_WAIT done_before 0 aio 0 ret 0
> >>      xfs_io-8815  [000]   526.790978: iomap_dio_complete:   dev 7:7 ino 0xc isize 0x1000 pos 0x1000 flags DIRECT aio 0 error 0 ret 4096
> >>      xfs_io-8815  [000]   526.790988: iomap_dio_rw_end:     dev 7:7 ino 0xc isize 0x1000 pos 0x1000 count 0 flags DIRECT dio_flags DIO_FORCE_WAIT done_before 0 aio 0 ret 4096
> >>         fsx-8827  [005]   526.939345: iomap_dio_rw_begin:   dev 7:7 ino 0xc isize 0x922f8 pos 0x4f000 count 61440 flags NOWAIT|DIRECT|ALLOC_CACHE dio_flags  done_before 0 aio 1 ret 0
> >>         fsx-8827  [005]   526.939459: iomap_dio_rw_end:     dev 7:7 ino 0xc isize 0x922f8 pos 0x4f000 count 0 flags NOWAIT|DIRECT|ALLOC_CACHE dio_flags  done_before 0 aio 1 ret -529
> >> ksoftirqd/5-41    [005]   526.939564: iomap_dio_complete:   dev 7:7 ino 0xc isize 0x922f8 pos 0x5e000 flags NOWAIT|DIRECT|ALLOC_CACHE aio 1 error 0 ret 61440
> >>
> >> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  fs/iomap/direct-io.c |  3 ++
> >>  fs/iomap/trace.c     |  1 +
> >>  fs/iomap/trace.h     | 90 ++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 94 insertions(+)
> >>
> >> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> >> index 5871956ee880..bb7a6dfbc8b3 100644
> >> --- a/fs/iomap/direct-io.c
> >> +++ b/fs/iomap/direct-io.c
> >> @@ -130,6 +130,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
> >>  	if (ret > 0)
> >>  		ret += dio->done_before;
> >>
> >> +	trace_iomap_dio_complete(iocb, dio->error, ret);
> >>  	kfree(dio);
> >>
> >>  	return ret;
> >> @@ -681,6 +682,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >>  	struct iomap_dio *dio;
> >>  	ssize_t ret = 0;
> >>
> >> +	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before, ret);
> >>  	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
> >>  			     done_before);
> >>  	if (IS_ERR_OR_NULL(dio)) {
> >> @@ -689,6 +691,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >>  	}
> >>  	ret = iomap_dio_complete(dio);
> >>  out:
> >> +	trace_iomap_dio_rw_end(iocb, iter, dio_flags, done_before, ret);
> >>  	return ret;
> >>  }
> >>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
> >> diff --git a/fs/iomap/trace.c b/fs/iomap/trace.c
> >> index da217246b1a9..728d5443daf5 100644
> >> --- a/fs/iomap/trace.c
> >> +++ b/fs/iomap/trace.c
> >> @@ -3,6 +3,7 @@
> >>   * Copyright (c) 2019 Christoph Hellwig
> >>   */
> >>  #include <linux/iomap.h>
> >> +#include <linux/uio.h>
> >>
> >>  /*
> >>   * We include this last to have the helpers above available for the trace
> >> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> >> index f6ea9540d082..dcb4dd4db5fb 100644
> >> --- a/fs/iomap/trace.h
> >> +++ b/fs/iomap/trace.h
> >> @@ -183,6 +183,96 @@ TRACE_EVENT(iomap_iter,
> >>  		   (void *)__entry->caller)
> >>  );
> >>
> >> +#define TRACE_IOMAP_DIO_STRINGS \
> >> +	{IOMAP_DIO_FORCE_WAIT, "DIO_FORCE_WAIT" }, \
> >> +	{IOMAP_DIO_OVERWRITE_ONLY, "DIO_OVERWRITE_ONLY" }, \
> >> +	{IOMAP_DIO_PARTIAL, "DIO_PARTIAL" }
> >
> > Can you make the strings line up too, please?
> >
> 
> Ok near other _STRINGS macro. Sure, will do that.
> 
> 
> >> +
> >> +DECLARE_EVENT_CLASS(iomap_dio_class,
> >> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter,
> >> +		 unsigned int dio_flags, u64 done_before, int ret),
> >
> > We're passing in ssize_t values for @ret, shouldn't the types match?
> >
> 
> Yes, I missed to correct that. Will make it loff_t.
> This should be fixed in ext2 trace point macro too.
> 
> (ssize_t can vary based on 32 bit v/s 64 bit, so while printing it as
> %llx it gives warning on 32bit. Hence will use loff_t for ret)

How about %zd?

--D

> 
> >> +	TP_ARGS(iocb, iter, dio_flags, done_before, ret),
> >> +	TP_STRUCT__entry(
> >> +		__field(dev_t,	dev)
> >> +		__field(ino_t,	ino)
> >> +		__field(loff_t, isize)
> >> +		__field(loff_t, pos)
> >> +		__field(u64,	count)
> >
> > What's the difference between "length" as used in the other tracepoints
> > and "count" here?
> >
> 
> Yup let me make it length which will be a more consistent naming.
> I chose count just because of (iov_iter_count(iter)).
> 
> >> +		__field(u64,	done_before)
> >> +		__field(int,	ki_flags)
> >> +		__field(unsigned int,	dio_flags)
> >> +		__field(bool,	aio)
> >> +		__field(int, ret)
> >> +	),
> >> +	TP_fast_assign(
> >> +		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
> >> +		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
> >> +		__entry->isize = file_inode(iocb->ki_filp)->i_size;
> >> +		__entry->pos = iocb->ki_pos;
> >> +		__entry->count = iov_iter_count(iter);
> >> +		__entry->done_before = done_before;
> >> +		__entry->dio_flags = dio_flags;
> >> +		__entry->ki_flags = iocb->ki_flags;
> >> +		__entry->aio = !is_sync_kiocb(iocb);
> >> +		__entry->ret = ret;
> >> +	),
> >> +	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx count %llu "
> >
> > count and done_before are lengths of file operations, in bytes, right?
> 
> Yes, that's right.
> 
> >
> > Everywhere else we use 0x%llx for that.
> >
> 
> Yup I had noticed that, but I guess I missed it.
> Thanks for catching it. I will fix it.
> 
> >> +		  "flags %s dio_flags %s done_before %llu aio %d ret %d",
> >> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> >> +		  __entry->ino,
> >> +		  __entry->isize,
> >> +		  __entry->pos,
> >> +		  __entry->count,
> >> +		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
> >> +		  __print_flags(__entry->dio_flags, "|", TRACE_IOMAP_DIO_STRINGS),
> >> +		  __entry->done_before,
> >> +		  __entry->aio,
> >> +		  __entry->ret)
> >> +)
> >> +
> >> +#define DEFINE_DIO_RW_EVENT(name)					\
> >> +DEFINE_EVENT(iomap_dio_class, name,					\
> >> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter,		\
> >> +		 unsigned int dio_flags, u64 done_before,		\
> >> +		 int ret),						\
> >> +	TP_ARGS(iocb, iter, dio_flags, done_before, ret))
> >> +DEFINE_DIO_RW_EVENT(iomap_dio_rw_begin);
> >> +DEFINE_DIO_RW_EVENT(iomap_dio_rw_end);
> >> +
> >> +TRACE_EVENT(iomap_dio_complete,
> >> +	TP_PROTO(struct kiocb *iocb, int error, int ret),
> >> +	TP_ARGS(iocb, error, ret),
> >> +	TP_STRUCT__entry(
> >> +		__field(dev_t,	dev)
> >> +		__field(ino_t,	ino)
> >> +		__field(loff_t, isize)
> >> +		__field(loff_t, pos)
> >> +		__field(int,	ki_flags)
> >> +		__field(bool,	aio)
> >> +		__field(int,	error)
> >> +		__field(int,	ret)
> >
> > Same comment about @ret and ssize_t here.
> 
> Got it.
> 
> Thanks for the review!
> -ritesh
> 
> 
> >
> > --D
> >
> >> +	),
> >> +	TP_fast_assign(
> >> +		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
> >> +		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
> >> +		__entry->isize = file_inode(iocb->ki_filp)->i_size;
> >> +		__entry->pos = iocb->ki_pos;
> >> +		__entry->ki_flags = iocb->ki_flags;
> >> +		__entry->aio = !is_sync_kiocb(iocb);
> >> +		__entry->error = error;
> >> +		__entry->ret = ret;
> >> +	),
> >> +	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx flags %s aio %d error %d ret %d",
> >> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> >> +		  __entry->ino,
> >> +		  __entry->isize,
> >> +		  __entry->pos,
> >> +		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
> >> +		  __entry->aio,
> >> +		  __entry->error,
> >> +		  __entry->ret)
> >> +);
> >> +
> >>  #endif /* _IOMAP_TRACE_H */
> >>
> >>  #undef TRACE_INCLUDE_PATH
> >> --
> >> 2.39.2
> >>
