Return-Path: <linux-fsdevel+bounces-74251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A732D38A11
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B69F5305819E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73799326D4F;
	Fri, 16 Jan 2026 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbbSOCAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD137318ED7
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606268; cv=none; b=FbRl0lGCP+IxrTW8Mmt/KSvpG4yBkFWh6FQGsPa5Ot/sc0ESjRfG74J/Fw4ce+NJYFAJKX9kLqudVUzDcco2jaLrC4ohm6NroKGpM8VuOWRqKAYI4KqIfpK3bnGcE7yb1n4Tbqf+6N+fDAmIu58lfig3VTaFTpJqwGnjuSIgNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606268; c=relaxed/simple;
	bh=X0rVa/St9VjNlqG0rrH1NPxF9R+fvsHNxiG5pd1IqwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5SztF7Na/W34aCXc6SvtA9R6vMKrs76UCMCHogmnloeeBfo2Q5d4xQVAsftodt4PLdPDNMBVoKIhFMDv0VROY3eW6tlXCJ1ddfzmbz66DsFf4+SFtCIOfnolPOFeFfcKGwIMXdIFEJu7C6Va/bEqgH2aka1UtypLIzv1wO/6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbbSOCAZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso1644405a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606266; x=1769211066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NUFMsREpOirl/85nGnx+NyCTEVbGrT/oKEvSLBv7Wc=;
        b=UbbSOCAZIzm8vVjtiDR0tcVJqKU9D+N4NMiw2xSiE0FdvPC5Kdvbwqmg4GwPaLaclM
         ujPRH2AsE7jzWhX9Sp8TDN6IFutXtZhwXJCUgHvLuxi5UlgBdzJlufHcpZ8y1NA9tuDM
         lwyPtoYXn8JCygF7Kk1FZSmGqO0ganPVPXO7VJd6uCJqpY0/dzlaveBjjJMLtB/KvV+G
         Xx1tdHmSs/IvksVfEMyElGEb97TG3dfl9shLRk+ghOY0MHVeLp/RbYgJHY5M04759v8W
         nnYs5fzUL5035fUVu9B8ikgtOy5FP2t6rcvq9yNS9fXdUg+AFBJcKk2OnsqlSIkGEx38
         jzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606266; x=1769211066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5NUFMsREpOirl/85nGnx+NyCTEVbGrT/oKEvSLBv7Wc=;
        b=rFkZniPPgLFFoNA+0GbrZKbqlPo/rV/8kSaSAKXm7EThF9dc4EPkveFFS0yChRZCfF
         d3nhXX110gek64UQ/nVJXyP/M4WRwFm/S5NRqZCOwktMgGu25JPP00Liw+A8syTBdeP2
         1GKedO4NagtPJHJN3kZGdQSgqrl4sfMr6tWxhRx4405LRtwli/3hHA51Otkk5Q2pPXiU
         kngAkT6WQWLU+s3UiIeIs8o794o6DnWFR3nE0Onn4h7SSru7x+HG/BJlo1CI4mVuGSXL
         LCYlTX0WD1Cb2pLa0YqWF2MFLM1fW4r8zOEVrjJ8EX7dbKHWrB17op3/jmuD7xaik84O
         vFGg==
X-Forwarded-Encrypted: i=1; AJvYcCW2DH0KEZsHxM9xm0ZpJY76qD0LNuZmOWGBrPOQy/3ORw6lzd4QnYzU9W30rNFQDyABYhFZGM8Up6bR3OrQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnlgn0VIM0D8I9p5y+fWYgdwKlSz/u4wgxtSP5rbh4WU5IGG2
	YxIVy0k1IIUljab9Nu902Wgpcir0ab48lcp4MXsSQHjXv5rXMQHlLJ/edJDubA==
X-Gm-Gg: AY/fxX5sr1PesdZgonwTP1KQ0DNBt8aILsU8u769eVcjHEuFX8vQ7UDXkJbwNJvl9wS
	zEUm4WhPtL0E3RT8vOcKEy2uX4svLFTugaeH/ZXjONz6yDXNUZdX9fnS71p32jwIXv3fOj9RT5S
	h4c1/qqQ9r8mirNWw1EKMvPOFgmwx/O3di5j8j8AfWE+bnqXYlS78mLhdE/zCvCSk9/6qMqtfan
	9sVmX5kEUGJSZJm407uwpYIJQdUtcP0stXROmjJjzs9S6Ut+V9H0FhgCNz60y4o3JloD9h88tcQ
	pvJd0qnlu5n0GFMIlz7PM78nJcrvg9eShi4PgCVHyGz0bebhXc/WEK0Ks0y0LwCdBMZgoBBaNFf
	+xjoFwUu7hv9ibTXYmwl2ZjX1rFbg4zQShJBFPrMxQG5GzYUA9owUADUzBD05D7XlDflTByV3/F
	0emuaOMQ==
X-Received: by 2002:a17:902:ce11:b0:2a0:9ca7:7405 with SMTP id d9443c01a7336-2a7188f91acmr47460095ad.36.1768606265863;
        Fri, 16 Jan 2026 15:31:05 -0800 (PST)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291facsm2940870b3a.57.2026.01.16.15.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:05 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 02/25] io_uring/kbuf: rename io_unregister_pbuf_ring() to io_unregister_buf_ring()
Date: Fri, 16 Jan 2026 15:30:21 -0800
Message-ID: <20260116233044.1532965-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the more generic name io_unregister_buf_ring() as this function will
be used for unregistering both provided buffer rings and kernel-managed
buffer rings.

This is a preparatory change for upcoming kernel-managed buffer ring
support.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 io_uring/kbuf.c     | 2 +-
 io_uring/kbuf.h     | 2 +-
 io_uring/register.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 100367bb510b..cbe477db7b86 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -718,7 +718,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	return 0;
 }
 
-int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
+int io_unregister_buf_ring(struct io_ring_ctx *ctx, void __user *arg)
 {
 	struct io_uring_buf_reg reg;
 	struct io_buffer_list *bl;
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index bf15e26520d3..40b44f4fdb15 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -74,7 +74,7 @@ int io_provide_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 int io_manage_buffers_legacy(struct io_kiocb *req, unsigned int issue_flags);
 
 int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
-int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg);
+int io_unregister_buf_ring(struct io_ring_ctx *ctx, void __user *arg);
 int io_register_pbuf_status(struct io_ring_ctx *ctx, void __user *arg);
 
 bool io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags);
diff --git a/io_uring/register.c b/io_uring/register.c
index 3d3822ff3fd9..888c8172818f 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -752,7 +752,7 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 		ret = -EINVAL;
 		if (!arg || nr_args != 1)
 			break;
-		ret = io_unregister_pbuf_ring(ctx, arg);
+		ret = io_unregister_buf_ring(ctx, arg);
 		break;
 	case IORING_REGISTER_SYNC_CANCEL:
 		ret = -EINVAL;
-- 
2.47.3


