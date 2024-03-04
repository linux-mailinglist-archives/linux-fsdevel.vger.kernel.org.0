Return-Path: <linux-fsdevel+bounces-13565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9026987115F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 00:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA8F1C2048A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 23:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68627D3F0;
	Mon,  4 Mar 2024 23:57:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039CC7CF18;
	Mon,  4 Mar 2024 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596666; cv=none; b=dtLM1RP6oh80urEdVpWnitSNmiWxZPlDGpxHIENBIBctsnEyu54FncSvQGmfsLhmZ1TM9yQSy7zO/kMadHQiRVsvq6HIcozrQec50/nwVULhAnvqdLFJzPe68VtH7gs7Q8mU61f5C+DyBV3O4dOtX3sJrUzqJsEBZVo0KGYiI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596666; c=relaxed/simple;
	bh=joY7OG7UIn3bqxbd1zB9uJBeqBt8fu89bKu/J05OF6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPvwfnhuFJBrNRhnIVHeZogvvAgW45yviUasU7q3QX1UPjAckJmDeL0aQhHdT5yW/ZZYUZcLW011BSu/h4/XGuYwRMN5PZp/PEAZyq6xlrQbZJpMMh5ayY5om3VuJTYEJlk8VDUUtEFbiMOkpgSHtc8QpaA3RFo90u8gPoWX7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29a378040daso3380517a91.1;
        Mon, 04 Mar 2024 15:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709596664; x=1710201464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNchAcLGNEoVQRiIQolT0ekrjSxf/xSsvda4T8WFAVg=;
        b=XEQEt84GUDOHbzyW8NpHABYnVFJ/KLqX/wuEzHq9jsfkbhqzb+c8V+G2eO6gFktr50
         thbwlo4HmS5HYc4Z90LKLwsYUiS3cQOTQ4+9AyY79YTo0qsfEYS/x2saO9YVy6wcnJvy
         lTT4nPAwITrxI/QZlTTHAr+6eFYJ6VogkFlfX457R+3VtrTgiGUUnjgeiiC5SO9lDxOk
         EfKaITfvmMxtYp2SuNq7zohWA1fQi6H2FAUR0Mdv4oVtpGQGktaZnirA3nqzVqFy+GDz
         j8ujYB0Bho1Ra4zd4j3o7azejDVM/8wkl6JwRk9EuaWB5sSBGEcA3IpZKmBOisbEPhwd
         6l/A==
X-Forwarded-Encrypted: i=1; AJvYcCXtIPW2a3I5GR1YYzx8sZwFAn3jrFVq14LnkdpG6WT7PNgHeifpDLe1WVsRU0DHqCvumaRAqYVTANLrIwWz7PuClt2KHRmw
X-Gm-Message-State: AOJu0YwksWasXXgXQ+WJOGLPDWUJzj5IpSZzer+gap/UbABb6Fwotfym
	G2YccKZNZq7y0OOZHE05CRp/0Wt/YMyP+rJH/hkFyDln2CsKM8qB
X-Google-Smtp-Source: AGHT+IFTcbyAlas9hiaR2yPLZelINquCk/T2EmyChkVZIasuRGL+rZe9Tyc7IYgYR+fNxQp6beAOHA==
X-Received: by 2002:a17:90b:4017:b0:29b:294c:831d with SMTP id ie23-20020a17090b401700b0029b294c831dmr8173282pjb.38.1709596664208;
        Mon, 04 Mar 2024 15:57:44 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:9ba8:35e8:4ec5:44d1])
        by smtp.gmail.com with ESMTPSA id gb2-20020a17090b060200b0029acce2420asm8286417pjb.10.2024.03.04.15.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 15:57:43 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Benjamin LaHaise <ben@communityfibre.ca>,
	Eric Biggers <ebiggers@google.com>,
	Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion
Date: Mon,  4 Mar 2024 15:57:15 -0800
Message-ID: <20240304235715.3790858-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first kiocb_set_cancel_fn() argument may point at a struct kiocb
that is not embedded inside struct aio_kiocb. With the current code,
depending on the compiler, the req->ki_ctx read happens either before
the IOCB_AIO_RW test or after that test. Move the req->ki_ctx read such
that it is guaranteed that the IOCB_AIO_RW test happens first.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Cc: Benjamin LaHaise <ben@communityfibre.ca>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org
Fixes: b820de741ae4 ("fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/aio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index da18dbcfcb22..9cdaa2faa536 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -589,8 +589,8 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 
 void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 {
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
-	struct kioctx *ctx = req->ki_ctx;
+	struct aio_kiocb *req;
+	struct kioctx *ctx;
 	unsigned long flags;
 
 	/*
@@ -600,9 +600,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	if (!(iocb->ki_flags & IOCB_AIO_RW))
 		return;
 
+	req = container_of(iocb, struct aio_kiocb, rw);
+
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
+	ctx = req->ki_ctx;
+
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 	list_add_tail(&req->ki_list, &ctx->active_reqs);
 	req->ki_cancel = cancel;

