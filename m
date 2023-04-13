Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87CF6E15B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 22:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDMUTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDMUTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:19:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61077683;
        Thu, 13 Apr 2023 13:19:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so5418280pjk.4;
        Thu, 13 Apr 2023 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681417146; x=1684009146;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tauEvGRN9De7HDRz2444BtviyGem01A62jN60gEUUd0=;
        b=N3eA9JTy2cMA4T+ukjirB/KTWVPbV4zjjQGwp1LeZuoO5io9EQm5KisL3EBEruFxBw
         4o8dk+mZvGk+u8YqIl1YH+5X+YWk8Tldjr709wPFk3iTvUqh2mToL7pZWqRvFJrMhTih
         Fr7NkzaK5oEgE7ZTeQmTOAghUuRDeDTytKiberbm10wVscSufirK0qmbFMMvdDDhoK4r
         b626LC3wCZkKfjXUCIOnaOKS0spSFHlzGRG0Z6vO2oaHzhzG7D0DHovVACnrU5g+Ul1n
         wCf3onrIBeET1vDCT0dZhId1VbYVZI738lPk4O8xezgaAaRQr9IjQkuLhbjG4hppf9Ge
         VsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681417146; x=1684009146;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tauEvGRN9De7HDRz2444BtviyGem01A62jN60gEUUd0=;
        b=D4o722jWlfmBqkh6oFUB31NDvqPRhv//qrpJhGyGyepbHT0j33Tvmcb+7xTAmi+ouG
         3Vz+Z+Xim+VXOyIK+7Z1pOD+REX+6UnyfMfjqPkeHgY4FwBfrPhxnh07dhO+AfcjBWFF
         lJu5HysfKhI5FBJL+DPDXA8k6Tvsz2/ZY4hQ0Ai5yKEnF3+2d+zytiV6y/hrzFWDeffP
         QJYCuw5H/uJSbv+EdGtSZtX7TyQHFUpWAtmDHxsv8cqp2oFDGtRVvq74QeIn3AFBcxuJ
         ctdlWTulFm76sQhm58WwfI0pecH/b76+m2weOb2OScUdwfjxB3ZP+vMLq09e8w6q+nVC
         kZgg==
X-Gm-Message-State: AAQBX9fg+bEygibPywrssfGew0GN1mI4RxHV4yuOZO/yGNQ7ysV2GL1n
        AcYRVub2ZL2nHcAw8Gmsh4U=
X-Google-Smtp-Source: AKy350YTxPtR4VDt/sGg9rrWj7QdDXaudTKpCydQZAs2kHCbRpAcSStZnJIu6cw4pnk23cRFYCfB2g==
X-Received: by 2002:a17:903:41c3:b0:1a6:3799:ec36 with SMTP id u3-20020a17090341c300b001a63799ec36mr111037ple.33.1681417145812;
        Thu, 13 Apr 2023 13:19:05 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d70600b001a63a2efdf6sm1827298ply.273.2023.04.13.13.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 13:19:05 -0700 (PDT)
Date:   Fri, 14 Apr 2023 01:48:49 +0530
Message-Id: <87fs93zgba.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 10/10] iomap: Add trace points for DIO path
In-Reply-To: <20230413144232.GD360877@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Thu, Apr 13, 2023 at 02:10:32PM +0530, Ritesh Harjani (IBM) wrote:
>> This patch adds trace point events for iomap DIO path.
>>
>> <e.g. iomap dio trace>
>>      xfs_io-8815  [000]   526.790418: iomap_dio_rw_begin:   dev 7:7 ino 0xc isize 0x0 pos 0x0 count 4096 flags DIRECT dio_flags DIO_FORCE_WAIT done_before 0 aio 0 ret 0
>>      xfs_io-8815  [000]   526.790978: iomap_dio_complete:   dev 7:7 ino 0xc isize 0x1000 pos 0x1000 flags DIRECT aio 0 error 0 ret 4096
>>      xfs_io-8815  [000]   526.790988: iomap_dio_rw_end:     dev 7:7 ino 0xc isize 0x1000 pos 0x1000 count 0 flags DIRECT dio_flags DIO_FORCE_WAIT done_before 0 aio 0 ret 4096
>>         fsx-8827  [005]   526.939345: iomap_dio_rw_begin:   dev 7:7 ino 0xc isize 0x922f8 pos 0x4f000 count 61440 flags NOWAIT|DIRECT|ALLOC_CACHE dio_flags  done_before 0 aio 1 ret 0
>>         fsx-8827  [005]   526.939459: iomap_dio_rw_end:     dev 7:7 ino 0xc isize 0x922f8 pos 0x4f000 count 0 flags NOWAIT|DIRECT|ALLOC_CACHE dio_flags  done_before 0 aio 1 ret -529
>> ksoftirqd/5-41    [005]   526.939564: iomap_dio_complete:   dev 7:7 ino 0xc isize 0x922f8 pos 0x5e000 flags NOWAIT|DIRECT|ALLOC_CACHE aio 1 error 0 ret 61440
>>
>> Tested-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/iomap/direct-io.c |  3 ++
>>  fs/iomap/trace.c     |  1 +
>>  fs/iomap/trace.h     | 90 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 94 insertions(+)
>>
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index 5871956ee880..bb7a6dfbc8b3 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -130,6 +130,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>>  	if (ret > 0)
>>  		ret += dio->done_before;
>>
>> +	trace_iomap_dio_complete(iocb, dio->error, ret);
>>  	kfree(dio);
>>
>>  	return ret;
>> @@ -681,6 +682,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>  	struct iomap_dio *dio;
>>  	ssize_t ret = 0;
>>
>> +	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before, ret);
>>  	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
>>  			     done_before);
>>  	if (IS_ERR_OR_NULL(dio)) {
>> @@ -689,6 +691,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>  	}
>>  	ret = iomap_dio_complete(dio);
>>  out:
>> +	trace_iomap_dio_rw_end(iocb, iter, dio_flags, done_before, ret);
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
>> diff --git a/fs/iomap/trace.c b/fs/iomap/trace.c
>> index da217246b1a9..728d5443daf5 100644
>> --- a/fs/iomap/trace.c
>> +++ b/fs/iomap/trace.c
>> @@ -3,6 +3,7 @@
>>   * Copyright (c) 2019 Christoph Hellwig
>>   */
>>  #include <linux/iomap.h>
>> +#include <linux/uio.h>
>>
>>  /*
>>   * We include this last to have the helpers above available for the trace
>> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
>> index f6ea9540d082..dcb4dd4db5fb 100644
>> --- a/fs/iomap/trace.h
>> +++ b/fs/iomap/trace.h
>> @@ -183,6 +183,96 @@ TRACE_EVENT(iomap_iter,
>>  		   (void *)__entry->caller)
>>  );
>>
>> +#define TRACE_IOMAP_DIO_STRINGS \
>> +	{IOMAP_DIO_FORCE_WAIT, "DIO_FORCE_WAIT" }, \
>> +	{IOMAP_DIO_OVERWRITE_ONLY, "DIO_OVERWRITE_ONLY" }, \
>> +	{IOMAP_DIO_PARTIAL, "DIO_PARTIAL" }
>
> Can you make the strings line up too, please?
>

Ok near other _STRINGS macro. Sure, will do that.


>> +
>> +DECLARE_EVENT_CLASS(iomap_dio_class,
>> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter,
>> +		 unsigned int dio_flags, u64 done_before, int ret),
>
> We're passing in ssize_t values for @ret, shouldn't the types match?
>

Yes, I missed to correct that. Will make it loff_t.
This should be fixed in ext2 trace point macro too.

(ssize_t can vary based on 32 bit v/s 64 bit, so while printing it as
%llx it gives warning on 32bit. Hence will use loff_t for ret)


>> +	TP_ARGS(iocb, iter, dio_flags, done_before, ret),
>> +	TP_STRUCT__entry(
>> +		__field(dev_t,	dev)
>> +		__field(ino_t,	ino)
>> +		__field(loff_t, isize)
>> +		__field(loff_t, pos)
>> +		__field(u64,	count)
>
> What's the difference between "length" as used in the other tracepoints
> and "count" here?
>

Yup let me make it length which will be a more consistent naming.
I chose count just because of (iov_iter_count(iter)).

>> +		__field(u64,	done_before)
>> +		__field(int,	ki_flags)
>> +		__field(unsigned int,	dio_flags)
>> +		__field(bool,	aio)
>> +		__field(int, ret)
>> +	),
>> +	TP_fast_assign(
>> +		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
>> +		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
>> +		__entry->isize = file_inode(iocb->ki_filp)->i_size;
>> +		__entry->pos = iocb->ki_pos;
>> +		__entry->count = iov_iter_count(iter);
>> +		__entry->done_before = done_before;
>> +		__entry->dio_flags = dio_flags;
>> +		__entry->ki_flags = iocb->ki_flags;
>> +		__entry->aio = !is_sync_kiocb(iocb);
>> +		__entry->ret = ret;
>> +	),
>> +	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx count %llu "
>
> count and done_before are lengths of file operations, in bytes, right?

Yes, that's right.

>
> Everywhere else we use 0x%llx for that.
>

Yup I had noticed that, but I guess I missed it.
Thanks for catching it. I will fix it.

>> +		  "flags %s dio_flags %s done_before %llu aio %d ret %d",
>> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
>> +		  __entry->ino,
>> +		  __entry->isize,
>> +		  __entry->pos,
>> +		  __entry->count,
>> +		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
>> +		  __print_flags(__entry->dio_flags, "|", TRACE_IOMAP_DIO_STRINGS),
>> +		  __entry->done_before,
>> +		  __entry->aio,
>> +		  __entry->ret)
>> +)
>> +
>> +#define DEFINE_DIO_RW_EVENT(name)					\
>> +DEFINE_EVENT(iomap_dio_class, name,					\
>> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter,		\
>> +		 unsigned int dio_flags, u64 done_before,		\
>> +		 int ret),						\
>> +	TP_ARGS(iocb, iter, dio_flags, done_before, ret))
>> +DEFINE_DIO_RW_EVENT(iomap_dio_rw_begin);
>> +DEFINE_DIO_RW_EVENT(iomap_dio_rw_end);
>> +
>> +TRACE_EVENT(iomap_dio_complete,
>> +	TP_PROTO(struct kiocb *iocb, int error, int ret),
>> +	TP_ARGS(iocb, error, ret),
>> +	TP_STRUCT__entry(
>> +		__field(dev_t,	dev)
>> +		__field(ino_t,	ino)
>> +		__field(loff_t, isize)
>> +		__field(loff_t, pos)
>> +		__field(int,	ki_flags)
>> +		__field(bool,	aio)
>> +		__field(int,	error)
>> +		__field(int,	ret)
>
> Same comment about @ret and ssize_t here.

Got it.

Thanks for the review!
-ritesh


>
> --D
>
>> +	),
>> +	TP_fast_assign(
>> +		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
>> +		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
>> +		__entry->isize = file_inode(iocb->ki_filp)->i_size;
>> +		__entry->pos = iocb->ki_pos;
>> +		__entry->ki_flags = iocb->ki_flags;
>> +		__entry->aio = !is_sync_kiocb(iocb);
>> +		__entry->error = error;
>> +		__entry->ret = ret;
>> +	),
>> +	TP_printk("dev %d:%d ino 0x%lx isize 0x%llx pos 0x%llx flags %s aio %d error %d ret %d",
>> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
>> +		  __entry->ino,
>> +		  __entry->isize,
>> +		  __entry->pos,
>> +		  __print_flags(__entry->ki_flags, "|", TRACE_IOCB_STRINGS),
>> +		  __entry->aio,
>> +		  __entry->error,
>> +		  __entry->ret)
>> +);
>> +
>>  #endif /* _IOMAP_TRACE_H */
>>
>>  #undef TRACE_INCLUDE_PATH
>> --
>> 2.39.2
>>
