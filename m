Return-Path: <linux-fsdevel+bounces-11756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A29856EDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8605928362D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62A213EFE5;
	Thu, 15 Feb 2024 20:48:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17213B295;
	Thu, 15 Feb 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030096; cv=none; b=MZqberlHMWxklVq9KaVQ5SYtXjmoHCElFMHPDy6krGgkTT9d8FVZx8/ZE61bhMv2IDB0KUvJ7JDjbQiYZwzRbDoUvF9Vlyiu0tDMh2TNwOZyFw6h+qiPsukYn3Qwo0xGD83gJiJzzrhZ1St6DrdUvmzA5xZP7CfrlDMHaOH6+a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030096; c=relaxed/simple;
	bh=C9Le9uH79wJNuQ0B7IWoi0V9qKFedQvPFtt2PfJbyoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlyC89ruNFfpaX38ww9rLlrmP9joVACsTC9lNuqH2wOVpyXCbtZEcofB7VhPZjM7YjZkKP6E3HhnfG4urLKEJ82d+mWP1r4pFk9Cy5XaPFHCdnbYQj3Jzcb6QQ+mIC07OS0qz9ZHcY/NW97GOBrjig1EsbzXEc37RRIs9Hg/CbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1143605a12.1;
        Thu, 15 Feb 2024 12:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708030094; x=1708634894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7owj2dc+ZeaBUzwGLeqY8Tlacmkmv7ErqrIRGSf8hk=;
        b=XhdBKP3KlvMA2hfAeC37JS57YhYbGkkegGPjbdaYRG8G4xTKTlsP7Lb44QHvpN7cqD
         OnhnTYGbrWOl4yk5ohk9xPo1tb3NC3LvkUPv5GtMt8iXlbsBFATXp0mBCRJXAMk5pZ/9
         geP6a/8USzAYTrGbsxAkR5CdS3BZZ/RRp+o6tJkRX0ROQyM4pHz3DtMbkiArJ09/OXvj
         qoDXxlHzw+tYrk+oJ2j00DRcjvA1U8UA+C3NtRXRLlhz6ppi5IKKVDatON2I6r00xb4B
         tl8yrB3NWDcx7Iu/MpBIvpEAoyOdYaYJZFNiMGZAWp/+ZJykBzwwx2db7eICghuNxy01
         uhNA==
X-Forwarded-Encrypted: i=1; AJvYcCUfOEwldebUvgy2uIOQT79c1awgKCcn7p4Q1+rUz3fInonpNrhcGhN0CHVCrYWIMO/Lip3ay74vGTDTStGeYMVYAl6SJ8tF
X-Gm-Message-State: AOJu0YyV14yLevodPP0fxhf4o4gZIDAUb5SAHEzEGIjUeVh8vu5k8KdN
	Nt99ORic8em5iubZ5o78JTziQOmy9BvslsFW7p+onUEWxG40mPwM
X-Google-Smtp-Source: AGHT+IHHY6oQkfj7cS40/nMFy8dmn+cnev+QAfDEZvMivZegBDYLCJY/T4JefaOaFvFcw7ouQIw/PA==
X-Received: by 2002:a17:903:2284:b0:1d5:c0d9:31c1 with SMTP id b4-20020a170903228400b001d5c0d931c1mr2794103plh.7.1708030093995;
        Thu, 15 Feb 2024 12:48:13 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:3612:25f8:d146:bb56])
        by smtp.gmail.com with ESMTPSA id v22-20020a170902e8d600b001db5e807cd2sm1677703plg.82.2024.02.15.12.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:48:13 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] fs/aio: Make io_cancel() generate completions again
Date: Thu, 15 Feb 2024 12:47:39 -0800
Message-ID: <20240215204739.2677806-3-bvanassche@acm.org>
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

The following patch accidentally removed the code for delivering
completions for cancelled reads and writes to user space: "[PATCH 04/33]
aio: remove retry-based AIO"
(https://lore.kernel.org/all/1363883754-27966-5-git-send-email-koverstreet@google.com/)
From that patch:

-	if (kiocbIsCancelled(iocb)) {
-		ret = -EINTR;
-		aio_complete(iocb, ret, 0);
-		/* must not access the iocb after this */
-		goto out;
-	}

This leads to a leak in user space of a struct iocb. Hence this patch
that restores the code that reports to user space that a read or write
has been cancelled successfully.

Fixes: 41003a7bcfed ("aio: remove retry-based AIO")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/aio.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index da18dbcfcb22..28223f511931 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2165,14 +2165,11 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 #endif
 
 /* sys_io_cancel:
- *	Attempts to cancel an iocb previously passed to io_submit.  If
- *	the operation is successfully cancelled, the resulting event is
- *	copied into the memory pointed to by result without being placed
- *	into the completion queue and 0 is returned.  May fail with
- *	-EFAULT if any of the data structures pointed to are invalid.
- *	May fail with -EINVAL if aio_context specified by ctx_id is
- *	invalid.  May fail with -EAGAIN if the iocb specified was not
- *	cancelled.  Will fail with -ENOSYS if not implemented.
+ *	Attempts to cancel an iocb previously passed to io_submit(). If the
+ *	operation is successfully cancelled 0 is returned. May fail with
+ *	-EFAULT if any of the data structures pointed to are invalid. May
+ *	fail with -EINVAL if aio_context specified by ctx_id is invalid. Will
+ *	fail with -ENOSYS if not implemented.
  */
 SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		struct io_event __user *, result)
@@ -2203,14 +2200,12 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
-	if (!ret) {
-		/*
-		 * The result argument is no longer used - the io_event is
-		 * always delivered via the ring buffer. -EINPROGRESS indicates
-		 * cancellation is progress:
-		 */
-		ret = -EINPROGRESS;
-	}
+	/*
+	 * The result argument is no longer used - the io_event is always
+	 * delivered via the ring buffer.
+	 */
+	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
+		aio_complete_rw(&kiocb->rw, -EINTR);
 
 	percpu_ref_put(&ctx->users);
 

