Return-Path: <linux-fsdevel+bounces-41642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A15A33EFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C48188E3AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DDB221579;
	Thu, 13 Feb 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbFegvyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9238221556;
	Thu, 13 Feb 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449306; cv=none; b=HxTFWBncGZTiBk9IZ7m94ba5Rb0gwR272Nn4FW2AY59YfjDtTrhdkIGyMXv/eb2NzisPYC7otqi8cph0NHEaeYh+i+/BfS4GpI1mFDGjL1csB344lBhyrRpr1jUu+3unfkuV0yPu9YOzvVJC8Utw5uvhWU4bpMMMevPkp+50GQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449306; c=relaxed/simple;
	bh=1oTIlIq3MEQ0LFVEW83otWTtjbaiBoeQB6YVTrazel8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hEEYKNc5y123mlhnHCd3aTyq1rV7oWv//gArAThXF4WGAHvEQ7FpI6unFWcwelFDUbeQ/kOdsNdo2a1UHU0FWNhz8Nkfz6iGRmJTxlYO39mX8RipqpkUmduMg+x8Si0JVrXptFUg3M5o1u7PUvi2wYmalufKl2FPFECgBN+xs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbFegvyt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f40deb941so18162635ad.2;
        Thu, 13 Feb 2025 04:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739449304; x=1740054104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0o5D5Q8iO/vYMKnQhyZXnnRR/RYxV00eJSWYKGy6aM=;
        b=NbFegvytr1GRpT5bYirlUNxmU4yCp54Cx3jW00RCCe+434671UmSIH4QpK40bDT/VY
         ZHRxVrsbF6efjmEhxnyrmU1NnVf8wjnXOCfzUuJVCK6T9ok0tNKi6CF+ACvC4ma2UQmw
         uRD1rz8OfgDZWJ0Ku1xcbjl92msxubmTNtXIT88sejc3HvtE4VgWRl/nu5T15y6DAVvP
         3YXPIhiWsyAZ+D9b8SXYoRPNDWXKrevdimM8H0WEn0D858JCkxUQfC8GobC92aFVg4Wg
         6qTd5Oc3lydJ+RCyuxEKKV3xPgMb0mtE4+1eq50koSC43rHgq1rXQPYfJFVhtFWDTbUq
         buuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739449304; x=1740054104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0o5D5Q8iO/vYMKnQhyZXnnRR/RYxV00eJSWYKGy6aM=;
        b=XBV8HTdDDr9UFbGWgdIU/Ee0PS+K6jqHDhcYGqxDbAlqJ4UROr0DRXooJML7owLkld
         baJvW9XxF9J8qLe/qJWsRBZMWn3AsKc9TZr8HxoexFrrzRBvSfNv8ct0mTsx9fo+gGkf
         05NsVJdu5tkkl/aZaVY2HhQ6xVpnMVAeSiPs7++WZmJ1wQAA7eJsChGc15Bg3sggzQzU
         gnMAsnVsaFUQCaCmo069dXnQAfXEYqDW09worTtGTPzdLxb9EplVTAO0qA0zwisb4Q2w
         S2uPXvF+Aud6ga9OfEQTSzvY++7WUAGVURRRLA22LVwqQmKQf5hItWk0xRpOPVVIh+gq
         yIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpSsSB/SnB3z3eORwrrfvik9KJqjNuYo0/bUQi1JVsC/DUM+bbawPRvhDsMBVkHuKR2o1cgdKC+Q2yEMDo@vger.kernel.org, AJvYcCWWYjiEG8QaGhmZRb918QAbmrVzMKj/0B2TyxSOMD4NMFk/nfUtuSShwDhjM1SoSXab47GX1V7x0Xq2dleu@vger.kernel.org
X-Gm-Message-State: AOJu0YwN7xCgFWN5GtKQ+EbVFvni3C9cCLtAb4pyi5kZpErP7pOHhKg6
	2mZNsUExTE5+1jalK5TGa3wTPcytRntRndxV4bFgftTLx/uyfSIv
X-Gm-Gg: ASbGnctBl6nGgoi6mwSWAaL/tkK979fU+nzcRvUfyI3w/u4LrNZFFqqUCNPGSTBkYgu
	O5iW/pX9OeWXVz5Mtk5YrjX0hWvcy0KR5Eom3V+a7pmzCSJhjzIH4CkeVgA5wDNWwv0U9BpapAG
	8dQNvdWfePy3x1esYeRnKNBT0/RR7oJL+TIqY2YKw0wLjHFa2WSQ8cFADOw11Li8PnQOwqhAzVz
	fgqYOM3hrNoRfbTE98rnmOEfrZ8VVy3kQopOEXKU7ZAHcU3z9DdwZYmw7a7mMroKz8s9lYjI79r
	M1ZWEqzvWr5Oqhl/gBy+jWDt+TZf
X-Google-Smtp-Source: AGHT+IEw7oIxz9K2xsXII5mzZpoJuaKsJV/4Xg1U5jXHmRcOVYcKlOzUO/mlDfoW7NJPtJiOmXxuXg==
X-Received: by 2002:a05:6a00:8c5:b0:730:9a55:d921 with SMTP id d2e1a72fcca58-7323c1444cemr4643260b3a.14.1739449303913;
        Thu, 13 Feb 2025 04:21:43 -0800 (PST)
Received: from VM-32-27-fedora.. ([129.226.128.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324276196dsm1174840b3a.147.2025.02.13.04.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:21:43 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: alexjlzheng@tencent.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: remove useless d_unhashed() retry in d_alloc_parallel()
Date: Thu, 13 Feb 2025 20:21:37 +0800
Message-ID: <20250213122137.11830-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 45f78b0a2743 ("fs/dcache: Move the wakeup from
__d_lookup_done() to the caller."), we will only wake up
d_wait_lookup() after adding dentry to dentry_hashtable.

Therefore, there is no need to keep retries about d_unhashed()
in d_alloc_parallel().

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/dcache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e3634916ffb9..543833eedd8c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2584,8 +2584,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 			goto mismatch;
 		if (unlikely(dentry->d_parent != parent))
 			goto mismatch;
-		if (unlikely(d_unhashed(dentry)))
-			goto mismatch;
 		if (unlikely(!d_same_name(dentry, parent, name)))
 			goto mismatch;
 		/* OK, it *is* a hashed match; return it */
-- 
2.48.1


