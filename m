Return-Path: <linux-fsdevel+bounces-10627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189984CE6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 16:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77731F26CED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAAE80052;
	Wed,  7 Feb 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eRyBD1Sz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14118003C
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321200; cv=none; b=dNlPmV1ylxTkBumRVGEKiDY8wc2mBTn9jlwwcxnm4AJt8i7OS+UNmgMBTNgPH8WibvI3VE7UAcGSOfb6L65OsOo7/o1Wv78pe3m7SV3lBLgMhoyyJ9VjfQwu3rF6rOKpdYNpe6+q0YUKUhZGXMGkZ1OzBJ7zROY/hcLZWzOj5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321200; c=relaxed/simple;
	bh=pkM8gHDvxo/uMV/UUxjAEwzzvLPiZxbsP3gloJ9jxQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtpwY/DcgbPuc9kSBJ1tuhHrm3F//YT75NtHMw9FjSaozZ4tlqvFI0vuuqgjRHX6drfcYmFhsyhQAd7HVKG75kCOin6KqIfx9BVpZTM39tNoIutwbuuDgNSARhXrqrPdoMYN/2MX8RydpYJCZFBTbvTnML5YrURrqYZA9/Skb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eRyBD1Sz; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so7756339f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 07:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707321198; x=1707925998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rge2H5Ckc723L53bMFTprCxX27IsgJoZxMqw+BOrqxk=;
        b=eRyBD1Szdd1V6ObDYn5NTssxOZHVP+bq7E+GfKCnmI2uneSNFNKUOwRprlBvmEbeVx
         8C3UPN9MqCL/Y16reKh6ydX5uOGc0MYHNvYHkyEsgkl5yXNFSb0+KOPBieX3YN523cL+
         EVSvcS+/e8jmXjhfze1U0bo0tnzOOkn+10lXb+6zltIYIuC0qAVfHdyWJQoltNBVHjS1
         Cnv8KjbOC9JVa6MQaQwtqj20bYVUK165hGG0Y+S3w8bnMMi3tscJYgpwrYDFE3DojNaj
         bvZzVXEa5f7XDTZoBlY1jU00Ww6sm1rjvcZh+0PsxaJhs1OGPAkd4MMMxcaFG5XYsfTP
         PDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707321198; x=1707925998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rge2H5Ckc723L53bMFTprCxX27IsgJoZxMqw+BOrqxk=;
        b=bOML9DihiahRZIeobxo+WM1FNY7HNdo1OWFi1T7mL8gL5T1QaDeYwj+pXMiAhunntU
         IYnobTPoGh2zhqic9DKFStqBVQRQOgpLEneInzk3GVE7ZkPqZmUx2Saay3geJl9it61L
         mQEIYnKyB3YzWNqBzpYY9X3+mn2ctnp8JsuAlBp9AZ8NKyR5/3htKa6PUUrk3intex5V
         2vth9qbWlTIu970Vo51kue/i73/18+ZgROkxj+FmGFa+YBlmNJABZZThYnfFAtUApmAX
         aA1YXPYlDbfQWzt6VLdUgJBFv/S6mNZO8ozzjpCopNlvpMZAWDZVNn9TOX522YnJ1gxg
         bLow==
X-Forwarded-Encrypted: i=1; AJvYcCUDs0VpnexP/FbNrYJx6B3UX4qcOuNpWGk9emYHrVvnidxl5ZuCIGYnkwmcN9uAHR/uTTBcWZ5qhEiAx1LoKf7zRLJ6g7XvFS7Y8+qvnA==
X-Gm-Message-State: AOJu0Yxk/xlRuLlKXRRgoCFyGwz1/Z2/n+IEry94y/Kj9mX+BAtmYjab
	oOYMGjPfEUunJ1RpmdD1xt05zC9jF+aoV8Y1orlXV4TcGcgP9tPqrWfJJKArvKM=
X-Google-Smtp-Source: AGHT+IGmAJKS3ABDPNt3bXsLwRNtrc71OkTuv9yDkGdf6eg9rrNsBnDyAPCMsjowKqp6vVlA/ys4Ag==
X-Received: by 2002:a92:c248:0:b0:363:b624:6304 with SMTP id k8-20020a92c248000000b00363b6246304mr6982705ilo.0.1707321197986;
        Wed, 07 Feb 2024 07:53:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1Yf5x2x7DTbzLYuwYpFSJjTpDPh76reOycoYDWBclX6hgh6RBIX8eelSqI8dyC5eCsuRxJjL69UiJ0Z12iM+HANdkMQ43bThBAiz4XVXhaxlNK6BuWBoWAtMGiElnr34TpftZJ0ojINNbjqSlppHMvCyuBObHUU52J9CWEGRzwzrWNcerVVWGETJe/fPTj++VGRmVVs1lAXh8J1Xx3FqQIvHJDONtGoW5i2hbzNu1
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 2-20020a92c642000000b00363a665a88csm444339ill.58.2024.02.07.07.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:53:17 -0800 (PST)
Message-ID: <300c5431-bb61-4fc9-a3cd-28ebcd0cea68@kernel.dk>
Date: Wed, 7 Feb 2024 08:53:16 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs, USB gadget: Rework kiocb cancellation
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240206234718.1437772-1-bvanassche@acm.org>
 <20240207-geliebt-badeort-a81cde648cfc@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240207-geliebt-badeort-a81cde648cfc@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/24 1:56 AM, Christian Brauner wrote:
> On Tue, Feb 06, 2024 at 03:47:18PM -0800, Bart Van Assche wrote:
>> Calling kiocb_set_cancel_fn() without knowing whether the caller
>> submitted a struct kiocb or a struct aio_kiocb is unsafe. Fix this by
>> introducing the cancel_kiocb() method in struct file_operations. The
>> following call trace illustrates that without this patch an
>> out-of-bounds write happens if I/O is submitted by io_uring (from a
>> phone with an ARM CPU and kernel 6.1):
>>
>> WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
>> Call trace:
>>  kiocb_set_cancel_fn+0x9c/0xa8
>>  ffs_epfile_read_iter+0x144/0x1d0
>>  io_read+0x19c/0x498
>>  io_issue_sqe+0x118/0x27c
>>  io_submit_sqes+0x25c/0x5fc
>>  __arm64_sys_io_uring_enter+0x104/0xab0
>>  invoke_syscall+0x58/0x11c
>>  el0_svc_common+0xb4/0xf4
>>  do_el0_svc+0x2c/0xb0
>>  el0_svc+0x2c/0xa4
>>  el0t_64_sync_handler+0x68/0xb4
>>  el0t_64_sync+0x1a4/0x1a8
>>
>> The following patch has been used as the basis of this patch: Christoph
>> Hellwig, "[PATCH 08/32] aio: replace kiocb_set_cancel_fn with a
>> cancel_kiocb file operation", May 2018
>> (https://lore.kernel.org/all/20180515194833.6906-9-hch@lst.de/).
> 
> What's changed that voids Al's objections on that patch from 2018?
> Specifically
> https://lore.kernel.org/all/20180406021553.GS30522@ZenIV.linux.org.uk
> https://lore.kernel.org/all/20180520052720.GY30522@ZenIV.linux.org.uk

Nothing, it's definitely still broken in the same UAF way.

But so is the cancelation bits, the assumption of the kiocb being
contained within some aio specific struct is just awful.

Does the cancelation support even work, or is needed? It would seem a
lot more prudent to get rid of it. Barring that, we should probably do
something like the below upfront until the whole thing is sorted out.


diff --git a/fs/aio.c b/fs/aio.c
index bb2ff48991f3..159648f43238 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -593,6 +593,10 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
+	/* kiocb didn't come from aio, so just ignore it */
+	if (!(iocb->ki_flags & IOCB_FROM_AIO))
+		return;
+
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
@@ -1509,7 +1513,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = req->ki_filp->f_iocb_flags;
+	req->ki_flags = req->ki_filp->f_iocb_flags | IOCB_FROM_AIO;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..2870b3d61866 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -352,6 +352,10 @@ enum rw_hint {
  * unrelated IO (like cache flushing, new IO generation, etc).
  */
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
+ /*
+  * kiocb came from fs/aio.c
+  */
+#define IOCB_FROM_AIO		(1 << 23)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \

-- 
Jens Axboe


