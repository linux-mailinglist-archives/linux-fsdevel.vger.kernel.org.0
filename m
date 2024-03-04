Return-Path: <linux-fsdevel+bounces-13509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064BC8709A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D55B29F6B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13E626D6;
	Mon,  4 Mar 2024 18:30:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DB4C62E;
	Mon,  4 Mar 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577012; cv=none; b=BCba9YdtBDtRMPgNhXVNyJjj+7QNIaiEpjOBCGln2ApcfF2Y61BqxYtLmMqLdLUkiLC3PdwKQsh6/cxHL8VRdv3Hv2jCFMsYQ9frPc0GZB5ZrBKoT389ZOif5A2gugm6iGRMBn6TiXSudPqQnrEM3CjomW0x7UK93NWiWRGa4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577012; c=relaxed/simple;
	bh=X/MGLe5h6l3DNtO6errxCkK0EeaAfLTak8qw38yQRQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nM//q9Tnm7DsxVAqfcm88HuHLVpM9QJYE3DlyJlLfGJNG1d8HyHd6ZQ/lnSupSfV5bqJmAu7+e99pcw8lEmYRNZ7QieCFimW52zRdWFG+WNpFOE6nfGRCaBntObazQlIQpzSBL1oFjF8+cFmMNmK5tDNXCmVP+yjGNf9hIjWt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc5d0162bcso40993915ad.0;
        Mon, 04 Mar 2024 10:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577010; x=1710181810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPhxviojLOo7bBw1srG77XjwgTU6YRGtCNTQjTnUSqk=;
        b=lFa7NR36bqmSGP1UZn5+uMg5zs3xpppAOPJJwfz2elOm6xlGak2cZ8czrS7x79nwpG
         0ujq6uZkCpzn4cUB3k0h3nYqXgXQ80+lx1tTfQRhIt4gyTVj3vL23IzTYPOIuY9JtdMk
         oy1DLMUsDc0PZxUhqQvJqMlpOQjLZ1HBJyE8ejb3Zjbryhgvnlqf9JT7TQza19/EUBZq
         aTkanYhhN9tJv7Bu7as3tJ8/Z/V0QMRCMNR5mQ1CB0Vtt1GWl+H8N0TZozyrf3Pj0QWZ
         5bO1T8TLjqZgFCB45ijbjhvBhPgv2E9F+/LxZObMTleVIb5nqwglf5S7zaGo4JYbOc87
         /XAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAzuwo5/G5NwMjGs2iE253pePIwPE4Ku78B97Cjj5yuk60F/aD4GyxdyHYnjMqvdBIg0VAl9WPgTpO/gVwG0nKvDzyyZ7h
X-Gm-Message-State: AOJu0YyvsMuPaKzg+8j1a+vp/JKXymYIxa1yBXU+lQtrm+gIW22XpDQQ
	P3uo5BvGvoOX1aXWV7NfsNSprWd7JBrOTVyzZZwGowjptqOYigdp
X-Google-Smtp-Source: AGHT+IGe4p8GgeQfUCvs/RHa5w28WSioYarmrnQosUZu7GMD1KFcH7zs8KcQCR+J6ZgqacdkMRqH2A==
X-Received: by 2002:a17:902:b688:b0:1d9:7095:7e3c with SMTP id c8-20020a170902b68800b001d970957e3cmr8254937pls.57.1709577009750;
        Mon, 04 Mar 2024 10:30:09 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:9ba8:35e8:4ec5:44d1])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b001dc391cc28fsm8791507plh.121.2024.03.04.10.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:30:09 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Benjamin LaHaise <ben@communityfibre.ca>,
	Eric Biggers <ebiggers@google.com>,
	Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	stable@vger.kernel.org,
	syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Subject: [PATCH] Revert "fs/aio: Make io_cancel() generate completions again"
Date: Mon,  4 Mar 2024 10:29:44 -0800
Message-ID: <20240304182945.3646109-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch "fs/aio: Make io_cancel() generate completions again" is based on the
assumption that calling kiocb->ki_cancel() does not complete R/W requests.
This is incorrect: the two drivers that call kiocb_set_cancel_fn() callers
set a cancellation function that calls usb_ep_dequeue(). According to its
documentation, usb_ep_dequeue() calls the completion routine with status
-ECONNRESET. Hence this revert.

Cc: Benjamin LaHaise <ben@communityfibre.ca>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org
Reported-by: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Fixes: 54cbc058d86b ("fs/aio: Make io_cancel() generate completions again")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/aio.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 28223f511931..da18dbcfcb22 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2165,11 +2165,14 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 #endif
 
 /* sys_io_cancel:
- *	Attempts to cancel an iocb previously passed to io_submit(). If the
- *	operation is successfully cancelled 0 is returned. May fail with
- *	-EFAULT if any of the data structures pointed to are invalid. May
- *	fail with -EINVAL if aio_context specified by ctx_id is invalid. Will
- *	fail with -ENOSYS if not implemented.
+ *	Attempts to cancel an iocb previously passed to io_submit.  If
+ *	the operation is successfully cancelled, the resulting event is
+ *	copied into the memory pointed to by result without being placed
+ *	into the completion queue and 0 is returned.  May fail with
+ *	-EFAULT if any of the data structures pointed to are invalid.
+ *	May fail with -EINVAL if aio_context specified by ctx_id is
+ *	invalid.  May fail with -EAGAIN if the iocb specified was not
+ *	cancelled.  Will fail with -ENOSYS if not implemented.
  */
 SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		struct io_event __user *, result)
@@ -2200,12 +2203,14 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
-	/*
-	 * The result argument is no longer used - the io_event is always
-	 * delivered via the ring buffer.
-	 */
-	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
-		aio_complete_rw(&kiocb->rw, -EINTR);
+	if (!ret) {
+		/*
+		 * The result argument is no longer used - the io_event is
+		 * always delivered via the ring buffer. -EINPROGRESS indicates
+		 * cancellation is progress:
+		 */
+		ret = -EINPROGRESS;
+	}
 
 	percpu_ref_put(&ctx->users);
 

