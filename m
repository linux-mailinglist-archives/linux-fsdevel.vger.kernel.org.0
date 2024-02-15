Return-Path: <linux-fsdevel+bounces-11755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373AF856ED8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691441C227EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 20:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A669F13B78F;
	Thu, 15 Feb 2024 20:48:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2A13B2A9;
	Thu, 15 Feb 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030095; cv=none; b=jw351kxFmVf7eSvlAIgP/JsuSlVNwBk+SjXJrCBYh2Vp8NnnX0q6oxFEdq6lYXlRomqQlzm9XLwhBqs0vjish8ncdOhIMNtPWKSo5mmtYMOJUeGe+tuxQKrStwpmPS97KCcBlGBU+Z8h2XJcx0PcDmC0HvzNRzbAUUbRizo+Cxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030095; c=relaxed/simple;
	bh=SoHAHffZ4RCJ/GSPZH6Zk08SApNjYRlemmf8PUDMp+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tv8I2yIF9OyXbUKbMnnPkFFJIHV1p/oDVNqievgCQwTWdMFsG6i/wSETCrBXEz/+0hWhQxQyL6edHT79XglVe6KYZT30XOFP4CDnquveUBR+pyhAq0r9SktD54dslcTbVQruwYC/uJFGlVNYx5aYj5Rl8xkGdPCpIrdJGYKWz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso91181a12.0;
        Thu, 15 Feb 2024 12:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708030093; x=1708634893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpqvRb2dxir6jw5v/wwCFjc5/+hKohMo9RksbxvA9rc=;
        b=rQ08UWEIXI8XXkut5sIbC0iCRjxxi5Cai5PLkIQfEvEwB/Z5qu3Gc59Q5Wi+QDFHWJ
         +XlrdF6OMb0kl+j177nWqFoS+OULVHZEXuf7AE3yeKYZPfiJ0Asp2UATuXxJ1+g1q4G6
         /1aancAXdxFpDok74DicRGhuzO+d4b9u9lJ9BbWiPYJvDTEkh7tb5Ch9ctCYYiWP2Mng
         f1opUiRvUMhUtvp827wDs2hmwFJWJXB6/4WctxBpvgVNU4KNsn0UwD26NAMxHVANhani
         snYBGfnOYcwySjERJ8w+fCgORzHjzOhH0qVIN92AFBu5wQS8MtKpzxFot11pT/fb2lbl
         T+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWTfjZxUO4EMWAVnfYTH7gqw56/f61fZN6DOAiueYmhyINUaJ3ORmP3vB5LGeDw9pAjZPZGPrYNTJA8Fm7L5vdcmqOHQ25q
X-Gm-Message-State: AOJu0Yy+2PFVhLvUiFkvHzdz4hDz2eQpVlCPNpOUAfa+qAxn/w7zeqKl
	aI7Jxj7ek1iQ8vkAHAy4ffLn4QbUGJC2H3CAPQJnWaau35TIx2Ag
X-Google-Smtp-Source: AGHT+IEfaHjF66NyQ5adjTHxfKVvTo3cItTBAnIthr0YDuzrKl8pLBhvrAqrWW594JXdyaB4L2pa/g==
X-Received: by 2002:a17:903:11c8:b0:1da:2a50:cbf8 with SMTP id q8-20020a17090311c800b001da2a50cbf8mr3345049plh.43.1708030092973;
        Thu, 15 Feb 2024 12:48:12 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:3612:25f8:d146:bb56])
        by smtp.gmail.com with ESMTPSA id v22-20020a170902e8d600b001db5e807cd2sm1677703plg.82.2024.02.15.12.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:48:12 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
Date: Thu, 15 Feb 2024 12:47:38 -0800
Message-ID: <20240215204739.2677806-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240215204739.2677806-1-bvanassche@acm.org>
References: <20240215204739.2677806-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kiocb_set_cancel_fn() is called for I/O submitted via io_uring, the
following kernel warning appears:

WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
Call trace:
 kiocb_set_cancel_fn+0x9c/0xa8
 ffs_epfile_read_iter+0x144/0x1d0
 io_read+0x19c/0x498
 io_issue_sqe+0x118/0x27c
 io_submit_sqes+0x25c/0x5fc
 __arm64_sys_io_uring_enter+0x104/0xab0
 invoke_syscall+0x58/0x11c
 el0_svc_common+0xb4/0xf4
 do_el0_svc+0x2c/0xb0
 el0_svc+0x2c/0xa4
 el0t_64_sync_handler+0x68/0xb4
 el0t_64_sync+0x1a4/0x1a8

Fix this by setting the IOCB_AIO_RW flag for read and write I/O that is
submitted by libaio.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/aio.c           | 9 ++++++++-
 include/linux/fs.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index bb2ff48991f3..da18dbcfcb22 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -593,6 +593,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
+	/*
+	 * kiocb didn't come from aio or is neither a read nor a write, hence
+	 * ignore it.
+	 */
+	if (!(iocb->ki_flags & IOCB_AIO_RW))
+		return;
+
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
@@ -1509,7 +1516,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = req->ki_filp->f_iocb_flags;
+	req->ki_flags = req->ki_filp->f_iocb_flags | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c9deac59c29a..d47306fe1121 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -352,6 +352,8 @@ enum rw_hint {
  * unrelated IO (like cache flushing, new IO generation, etc).
  */
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \

