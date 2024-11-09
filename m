Return-Path: <linux-fsdevel+bounces-34130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843869C2924
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 02:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C251F22F13
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD418C36;
	Sat,  9 Nov 2024 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="SJM1fV2i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9645025
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115740; cv=none; b=S5f45OIKyZXhgK4qBZYgdtD44guCfvgBDQ/WuUGPbAXGndrmWgQ0GrMVqLMdlwdEKz68MFBP4Xuol2L7k1490MCX/6EC8knXSk4FyhwLFbezh9bkkwlGp5wzy2AzVsTUGhEZvIqIZCqAS5JJvkvhtZDvHjp1L6y3AjrVoPwSUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115740; c=relaxed/simple;
	bh=2V+LMyhP7QCx7vipIrK/PNDo/NUYimbVbH9Zga/QRnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGNnLONdqzDyQKZszGSJjfHz7Z2PEUtI5M1S0bsCvfSqpQNVHpfSlE5wh+mqTP/LA8IyzMyRu02MRhB6SxLFfX5Zpvxr8QMV9pB/hW9WtJ27LfQamQkyzzKXlUgFhmYNCBAkqOywqsQPPAsmt8oTThAikHmZlYwV63cqWrMb00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=SJM1fV2i; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2c2a17aa4so325302a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 17:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731115738; x=1731720538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOqgPPtziEx8SGLaOYb14oaOw/i0JcmNn0bH4qe21tg=;
        b=SJM1fV2i8umSzCb58koP7j7K+NELgsaCQQQH/MkptEuEx7pohw8Zvrn2gBl5q+9kTN
         740gtHf9rrk60l0atKcx41Hw9dEeaOoTz3lTLcdJEA8JCmrh9he0hQ5P62EvXd3IM0Lm
         U2oKGJFSbo6qHB6N3d1UZzZK+VgnjvOtpRTuqAdvwSoZvEyGaXzytFDCeh682XHxCNsq
         qgBWC3nPkRI6z6DkDwZyNDrUxyalAuw3qwC0xDRHlVt8F+LhnxPJ6g4G/gcolcMJeGTH
         /WB74lgTewunqEfl7neoRJTCejvuudZRffnm/JTSoLDOxdD8L6nLlKLaFD3INJOW0BaW
         rEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731115738; x=1731720538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOqgPPtziEx8SGLaOYb14oaOw/i0JcmNn0bH4qe21tg=;
        b=t3REvCfhmbYAgPmqouLnyC1XLb/AljZ3dU3nCTYGW6yPyLy9uZQ3Ym7+qLZAddA7Hu
         F8uv2stYAuJ9PjtVPyIGWYEJe1lFo02dBPDN49TdlBZMDvL7Q4C1U1iQgSs2P5GPhPtt
         uVnj5YWKZZgN9o22GuFKko2RgsrYKkfc29Kq8B0Z6IUVqqGqlanasrtxL2jHnXGg3LCt
         Unn3ZRb7uhP7eVWlea4ZDedtlfwPrBkIIdnmPCkJDR3IGG5wjw5qNaZdyAqFKeQoBU8R
         B8OSTKZPaOurT2vCqSnU2j0cvBDyM1rOnf9DDfBHgQDdqENDOed3YWzSrHrATnDseIL/
         aukQ==
X-Gm-Message-State: AOJu0YxOph6srr0d1T4eWcREZsv5lC8rdm9+6mIQ95JUSDmNxl12s12I
	pHPfZG7m+zgXZw+gHNBY36Z60aRrPL4svVpJnxPXFdSYuwAzTpwIJtCyQ7U0UICBgQJxJXrjBJC
	J
X-Google-Smtp-Source: AGHT+IFOd7MaBqO9qvnNSmqC8iCKDohmW0xsMff0WgR9ONvpPAG2Els+t+TmPhLbjIw8o7WypoTk7g==
X-Received: by 2002:a17:902:f68a:b0:20c:e169:eb6a with SMTP id d9443c01a7336-2118357e1b5mr27424505ad.10.1731115737917;
        Fri, 08 Nov 2024 17:28:57 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c96fsm37493355ad.255.2024.11.08.17.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:28:57 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel-team@fb.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] proc/kcore: use percpu_rw_semaphore for kclist_lock
Date: Fri,  8 Nov 2024 17:28:41 -0800
Message-ID: <83a3b235b4bcc3b8aef7c533e0657f4d7d5d35ae.1731115587.git.osandov@fb.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731115587.git.osandov@fb.com>
References: <cover.1731115587.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

The list of memory ranges for /proc/kcore is protected by a
rw_semaphore. We lock it for reading on every read from /proc/kcore.
This is very heavy, especially since it is rarely locked for writing.
Since we want to strongly favor read lock performance, convert it to a
percpu_rw_semaphore. I also experimented with percpu_ref and SRCU, but
this change was the simplest and the fastest.

In my benchmark, this reduces the time per read by yet another 20
nanoseconds on top of the previous two changes, from 195 nanoseconds per
read to 175.

Link: https://github.com/osandov/drgn/issues/106
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 082718f5c02f..f0d56d000816 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -69,7 +69,7 @@ static int kcore_nphdr;
 static size_t kcore_phdrs_len;
 static size_t kcore_notes_len;
 static size_t kcore_data_offset;
-static DECLARE_RWSEM(kclist_lock);
+DEFINE_STATIC_PERCPU_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
 
 /*
@@ -276,7 +276,7 @@ static int kcore_update_ram(void)
 	struct kcore_list *tmp, *pos;
 	int ret = 0;
 
-	down_write(&kclist_lock);
+	percpu_down_write(&kclist_lock);
 	if (!xchg(&kcore_need_update, 0))
 		goto out;
 
@@ -297,7 +297,7 @@ static int kcore_update_ram(void)
 	update_kcore_size();
 
 out:
-	up_write(&kclist_lock);
+	percpu_up_write(&kclist_lock);
 	list_for_each_entry_safe(pos, tmp, &garbage, list) {
 		list_del(&pos->list);
 		kfree(pos);
@@ -335,7 +335,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 	size_t orig_buflen = buflen;
 	int ret = 0;
 
-	down_read(&kclist_lock);
+	percpu_down_read(&kclist_lock);
 	/*
 	 * Don't race against drivers that set PageOffline() and expect no
 	 * further page access.
@@ -625,7 +625,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 out:
 	page_offline_thaw();
-	up_read(&kclist_lock);
+	percpu_up_read(&kclist_lock);
 	if (ret)
 		return ret;
 	return orig_buflen - buflen;
-- 
2.47.0


