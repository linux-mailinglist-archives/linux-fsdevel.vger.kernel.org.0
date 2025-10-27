Return-Path: <linux-fsdevel+bounces-65803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4970C11B42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 23:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE9954E73D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D0A32E129;
	Mon, 27 Oct 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvuTGIjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838E32C93B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604188; cv=none; b=TK3c+ASNQfSiYdXS3L6js3qmi1rvOqQanjuxoFfV4K3A9r5VamhLWKsMcVmrIiCxhoRHZTBSj3lUcvryNS20D9NNJaJotG4c4ZwKn2ZHaviWsMTN9OfrzPSFbZ3YPOhVph0iQ2qHkJ4ziHa+3riw+Ie4OxM6qyTk6IxXhdtXqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604188; c=relaxed/simple;
	bh=SrDZ+DLNBGOu3nimpXfUjnM4yJ1VEfalsKv638KNQyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaIXZTRJtxip7WVNXNDFBwveqQPMPb4dnKCPYlUROn/8SLeiIwq4DpDccHe6ch+jXXC3miOz25zt+nZ/HUGO4DnEIIgdf+T5KiMcmr1n/tamWB/3mAj6zmwlTMxfBZ6bQWw3BFP4MIvGcSM4OvPrxfVFeg3OkBVffm+V4nsTy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvuTGIjh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-273a0aeed57so68247635ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604186; x=1762208986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgRF61PFPbChj1vp/o1QNZYukk3nxmzm0YChQApjqKc=;
        b=dvuTGIjhlHCYjeKn38LgAgS3ieBOJzizc7GEroj7Wd4vI7TfdS4VIszioPjRujSx2x
         pR8uN6H7Q78TJuLGtHf0+h7c+0feGuUJf9qf2H1JpR0jEw5N7iOzlFLJd4RfxaB8Xrmp
         MOwfqCs5BiE1gknZYnbEAQWLOBrCtPENpnzlV9FlZfi3TE6R1i3MLb6zYaGT414hzG1b
         zniA1aBpZrYmirFd0Mdj8r3lbEPTKu/dY/1b+z6S5sxwlP5fsGSR4CIN19RTmkAy+ejR
         Pq3h5xBQxnXm3Nlad0gAQTMYZSO79kGHG8V84UPW9Zk/cSBOOjYIK9YUACLPZSqtQbZK
         sHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604186; x=1762208986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgRF61PFPbChj1vp/o1QNZYukk3nxmzm0YChQApjqKc=;
        b=T6gCCLu+Hu0GJoSzNGuhBMUEvDNyEfVQP7e5lMEEjEXWUkr2TfOoOZgnQ4wl+Y+uQP
         mugulZxgfMtsOxA1YWRB0MESVarjByDVoOKqTK04WfJWsjXPfwXiU9VbrZ/Fhn7T/Lz2
         Hnbd9sq0+zLxVkqRLntKsUMhLU3nb7Lf7PLsn8OvbAZWqjMddxXre+/CNRa5buASZxb8
         2qOtUrOoHOwLShXS+mh0IPzlLCkkyHjT3FdxWwVK2UgN4AsDcMk+ZGdf+ppNQTyWQMLg
         MJ4wjrJIOAZUu76rD+cNNorvsJYQnKxvuBxXIoZdMAO4cdrR0Nxph1jP9iDvzrII24XI
         Oaqg==
X-Gm-Message-State: AOJu0YzxRPcIjOiX+RrE2sBLQz7qMTC/9yGCnFvdB90zCj4lP7Vrel38
	C8xyHkDQ50fSxqz6D+/dHLLKzhavVcETporBRX1ml8NJO13HKza8IW+P
X-Gm-Gg: ASbGncsVrxL/XXIOj+ZbIPACZnuisr1JndvXXTdpJFPTpIo7y3tuxlgd+iFax9UGcBB
	tXLYofFe4Nv4GE9aZYW+DjCluE6oiVd3s7vx2xRUUv2/CteXcJxRWeP8jgB0HYDic6Y75SBbfmS
	BDFH43O5bbCllqtfRPSmCs9YYxHWqwmjA8hY1dxPAvMibWBMv/xfSBr8G9uIsUPcFJh1mj0copt
	Dxo6ZmP+YgQ3FOdJkNdWrqAjozC8sgUpILTlFX9pF5qt9W6Alvy7OhElNoQxt+9tCH9urOuzwJE
	S9z5hIy3LhWXwdGBlJJClof779TBfuNimcaBiTCSGV4uum3JD3qnTvSsb/oCbnwwAWBtPW/ReJ7
	5CwMTIdnFU1T1i6T/tQNYmanTc5o2GBQHMeehYI/OOpTyCGkIJU3fg3T5daZcKMY0R8Aw1O4Z5i
	vQDtfAGn1DO5bqT0yWpIJpvvZGk5y+nF18MA==
X-Google-Smtp-Source: AGHT+IFVeyUuVXwYqaVSQ8PyIlEt9z22Qp/hZ8ZdfQtCmyIhJN79YO7UOU6Zi1O1KfyCfbulX0B8IA==
X-Received: by 2002:a17:902:e788:b0:290:b10f:9aec with SMTP id d9443c01a7336-294cc77a4b7mr10498995ad.26.1761604186312;
        Mon, 27 Oct 2025 15:29:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3405sm95430175ad.2.2025.10.27.15.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:29:45 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	xiaobing.li@samsung.com,
	csander@purestorage.com,
	kernel-team@meta.com
Subject: [PATCH v2 4/8] fuse: refactor io-uring header copying from ring
Date: Mon, 27 Oct 2025 15:28:03 -0700
Message-ID: <20251027222808.2332692-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027222808.2332692-1-joannelkoong@gmail.com>
References: <20251027222808.2332692-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move header copying from ring logic into a new copy_header_from_ring()
function. This consolidates error handling.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e94af90d4d46..faa7217e85c4 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -585,6 +585,17 @@ static int copy_header_to_ring(void __user *ring, const void *header,
 	return 0;
 }
 
+static int copy_header_from_ring(void *header, const void __user *ring,
+				 size_t header_size)
+{
+	if (copy_from_user(header, ring, header_size)) {
+		pr_info_ratelimited("Copying header from ring failed.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -595,10 +606,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_from_user(&ring_in_out, &ent->headers->ring_ent_in_out,
-			     sizeof(ring_in_out));
+	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
+				    sizeof(ring_in_out));
 	if (err)
-		return -EFAULT;
+		return err;
 
 	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
 			  &iter);
@@ -789,10 +800,10 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
-	err = copy_from_user(&req->out.h, &ent->headers->in_out,
-			     sizeof(req->out.h));
+	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+				    sizeof(req->out.h));
 	if (err) {
-		req->out.h.error = -EFAULT;
+		req->out.h.error = err;
 		goto out;
 	}
 
-- 
2.47.3


