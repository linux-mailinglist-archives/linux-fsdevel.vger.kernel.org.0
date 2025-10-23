Return-Path: <linux-fsdevel+bounces-65277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B14BFFE23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6381354838
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA822F83BC;
	Thu, 23 Oct 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HXPa/5G4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62572F4A12
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207711; cv=none; b=tw2WYjsQq4zVfPUnvqHzP2mK7hgAvpvldcgrXyGQCCCZ35IU5wkYrq2qLCvm+boOdmowr2ltEMeJIuwlKvF4RcGIxGZ8B2BNxbKCBG+zEyYGCuw+tmae9DGnsXK0Zughn3OYtXMaoWFZFwz51asOdV3AyVslSna7H9vE0o/Zt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207711; c=relaxed/simple;
	bh=pgRaKIs6od0eFwYqqrJU6RY3VmvIaH4v1rOFEhr8j0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tphwuAka47TcoUherGJLK2lhAWJSaVnyUxjt+Gl33RVUZ7in4Leq1citnU8GpC25hsZpwTI4b9zKHq2h7SYrIH/zMefTTjGFBV5hyGbDkLY/eibFJ/+JYIchwTlzznenMDaK/1gGlrDWjoK445miRLnSzWFKYjxgTyhfBtw7kPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=HXPa/5G4; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-378d54f657fso6951391fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1761207707; x=1761812507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TByexTGBy5Gp/RFWC94cXxG9Os7YYgZ+RwohhIq2r5M=;
        b=HXPa/5G45sACGko3ijOusMNI2kznEwecri4PKOyPqiaTL0ftCfrVcPzDI5N3jfQB3h
         r6YzGSDui88JzjVV/9k8kJOUsGXvl6E/eF3UGrcxlz9+3rjuRLkTiIj5duii4QYV8aL+
         4iuvKeQGU2v3Q+8dlj14TeuoSyWktW8cN/3Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207707; x=1761812507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TByexTGBy5Gp/RFWC94cXxG9Os7YYgZ+RwohhIq2r5M=;
        b=lO4xiFruC8Sm9yjlN2d3ozZ5R6DKNoGnGvqhdPtpYh2AVAboG+uSENezCCX81eySf0
         +E8tVKKP8e0vGGkDnukq1VtOCMCeMkigFQXCaGPv7RT4h5vHflF5LopPKQxJYL/1FHxP
         4dEawaVRGXSssaLWhP0U1/FdQgmIThBUAbzWRQHJ+0C7AN/RGUiYzeVy28fK/MKTX3EQ
         Aku7x8vAC3R19TvwVBPf4Hrtgi4gUbFWleRexkPb32ltA5TXNAFM6EUc+l+3dfRVmRcv
         /1hmBkkE4DTemnLwvuk+WN9pKbkOxkvJrPMQHtDb96c+zOPMh7O/QdnyIfuFG6z3ZF5U
         UlXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb1od8d9L60PS+kBLpfYhpkQM/3MgyRYpJ+MOBcy8jclum4byUNqtDupyq115wngJy62L+c+LjVHmQKqBN@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIhgrv7ncBJAjBJFr1PKetYy/zRTl+3+EPZbUExrSA4R2nmxG
	83m1qTkDmTFvhbtyR/LaYB0Pp0qEx1ntBpErSBgKPgcoXenlfH1eoBgQ1XX27vD2Fug=
X-Gm-Gg: ASbGnctZQlHYnMIEfMaZyLCjKvK0xZqgkSd8EFBOOBY2Tj76td/hhoIddem0z03KQEG
	KBTdvVrXendbMyZkGulM7u7hpk3vEhJS0MOInzsquqkW3kFiZEZbyZWIn0sUrSI/6FaNjWlS8Ih
	FzlzzXCKtRIxPiM5F3T6MsBkBgSkeJMl7yi32+4RlaP4/ZzPKWHPnHZPL9QevYbyJ5JIT+Poaa0
	ARRjZlgS7Wt4HUGaHtNoltTls/Y5IIo7szgp+F7FtYX76ONQipWYwLk7dW/alLaK7nMGxH/b4zu
	XX60NMqW5WCjZqi9OCRi/F/jPitQz9o8BkPT1kRn0llZkzafMxRqzJuQk4tWGYhRt+fW/zohpv2
	QiFD1RZzgNFr5gpI+i73huFbBZUvoiN4u9YBrculhHYzShp9T3gWbSJAOFisc4elaldf51V5H5G
	9iT+h0VXNJYc4i4Q==
X-Google-Smtp-Source: AGHT+IF5PkyzpJwpjSOJHc7K9JLi3coycHYDHHhCZspJ09bDYqz9X5m4UzYaiIOgYvkJOFHvN40npQ==
X-Received: by 2002:a2e:bd83:0:b0:36d:4996:1c4d with SMTP id 38308e7fff4ca-37797831b7cmr67162081fa.9.1761207706694;
        Thu, 23 Oct 2025 01:21:46 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d168d4sm534702e87.56.2025.10.23.01.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:21:46 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
Date: Thu, 23 Oct 2025 10:21:42 +0200
Message-ID: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we build with -fms-extensions, union pipe_index can be
included as an anonymous member in struct pipe_inode_info, avoiding
the duplication.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Do we want to do this as well? At the very least it would give some
more test coverage if this could be in -next for most of a cycle.

Context for new people:

https://lore.kernel.org/lkml/CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com/
https://lore.kernel.org/linux-kbuild/20251020142228.1819871-1-linux@rasmusvillemoes.dk/

 include/linux/pipe_fs_i.h | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 9d42d473d201..80539972e569 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -44,12 +44,6 @@ typedef unsigned int pipe_index_t;
 typedef unsigned short pipe_index_t;
 #endif
 
-/*
- * We have to declare this outside 'struct pipe_inode_info',
- * but then we can't use 'union pipe_index' for an anonymous
- * union, so we end up having to duplicate this declaration
- * below. Annoying.
- */
 union pipe_index {
 	unsigned long head_tail;
 	struct {
@@ -87,14 +81,7 @@ struct pipe_inode_info {
 	struct mutex mutex;
 	wait_queue_head_t rd_wait, wr_wait;
 
-	/* This has to match the 'union pipe_index' above */
-	union {
-		unsigned long head_tail;
-		struct {
-			pipe_index_t head;
-			pipe_index_t tail;
-		};
-	};
+	union pipe_index;
 
 	unsigned int max_usage;
 	unsigned int ring_size;

base-commit: 778740ee2d00e5c04d0c8ffd9c3beea89b1ec554
-- 
2.51.0


