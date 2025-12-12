Return-Path: <linux-fsdevel+bounces-71195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 760C2CB8C4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 13:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48C5306C2EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809B322533;
	Fri, 12 Dec 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap8CaL7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18A299947
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765541507; cv=none; b=DA/Ir2v45LJc9TRgNteDI+tatpzXBdvfFTPm6330/piHNBJxHgPTGrgCKIyq9iLQKqJNiq8CA259pi2aw8/PBnTzch8yu4UhIilNtXGkAFw/wVRO13rQjthCqFvRb7TbXlf/y6cqxF8qO9KCy1smIqqt+oSicLnhLOOCE2eMkXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765541507; c=relaxed/simple;
	bh=2b2+OvJ6KKMed/C5RLpRc/P6FDnmtGu5C563yfFTdko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBemAf6nmhoQT5NnpMc49KmN34GGQu22mb+HTNQoLtl8EoaKzMxeMFECYDEN3sIgyF7nvUAiUnacVoz6yrZPAr4LHN/0901bIC3yG0DpGSoLDFlo+/uvdjDTnbZY5nu/XN4cpRc2xkBUEDhypnonTTRvCSXUNYTlTm7yyduyzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ap8CaL7z; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so2069116a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 04:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765541504; x=1766146304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=koBQsfPOu5asWBoZ6zB8+3jGGJJhQLlpQdEqu3VmDp0=;
        b=Ap8CaL7zY6viDZPXYZbe7nq6Myw974WPLuvFU6+voGuM6ErlHIce3G8xzoOCoHxsDr
         vY+1NQHVOoclTmGJQk+Lll5clz9ctA+tUC9qRaaqEvvVew5XjZfiNHg9yW8Vhr6OjonW
         34H5LRIThV7f31RmKWwEZ35B1dwL5imG/m/25+2gt9cvUjM+737YJcJFxrpK1A/Q5LdT
         8PG3KxAm3VKRXPgvNuPTJhUJ31WlJzi9wtVK4JeVmS/Uw9evWC7vPdyYEHI+FI5ngDK3
         gRBsCB+a5wQQvgdD8w7pLB+6KHg0bRdcq+CHxB8IAJ97bAkmV/huS0iCxHJlh2A+sYVh
         Yd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765541504; x=1766146304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koBQsfPOu5asWBoZ6zB8+3jGGJJhQLlpQdEqu3VmDp0=;
        b=c5aUuY8l7zvkc30xfxF9Vn3kNsLeJF1QaLnPIZx6GIDakK9B+csrkdrNM5wJQnYmEP
         uZ3MAS+sCercMgXD53ERoYlIoIFVFlXgbvBJ9rDvfzWbI9WEYKeYBn/sFdD5oBuuanAy
         CX7bHeVEIK67l/4R1tRdK1AjX/1tD3H6bXcvdigMNwrFE91r/rVPVE5knOBCib4RV4K2
         +TkE3+sO7Rqws4kuPN6a2BEeMsIw7jeBz3xdNttZsNOqMog7WgYwc971L030n4HVAPc3
         wpepzX7gXxvKGkHrSJUwDLzO5Bhaqr2HIfQ3tdIzSfAuAPAIgLvXEx6fjHQDFI7H18nl
         S5/A==
X-Forwarded-Encrypted: i=1; AJvYcCU7HelSxnXwJ9ghacPMAaIdCNljnDDawHrr0aYq9+bL2ZXIsWiwPqHNpxnIggc9mbHlip+yHZAVHP3weUXJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcp3TR3WO+bmxAwESlLGnDBXbfl5l4ZLl2VIbLUCDOW8AUVd0J
	N2x5aqmqofCQSEw5FuFIZyOfEeJwIExT88i5P+k+XscklGNA0uxColeD
X-Gm-Gg: AY/fxX5A42ujY0q/6O9qatA015I7VB2HwcR7Yhj7FirANA+DUNpu8um7p3VVkDslGBT
	H3P6/syLn/MNlThXQcgQB1MhDx6V/gL2pD7k7wZm5L7yl7tjHA2twjoD+FcJDocBlAGThgpsejV
	6w8KDFep4C0MlaSy8U78jTtqa6BdG9t9qLVMMTRnF3RCmlV0IP4wEjcd8f/6RCV55rIPbyKNi1g
	TL3mYG2SEqP8pB4nBBz1RlR+OjRCvxcq3eu/e6tfPBHRQoLwfoAF+cZhslJkdA7bocX22Wd6Uwk
	Pmgj+PI7wL3NJZTSuKab5XHQJp9FjDVDUlOqoEPvpG5RG9YzFGLK7z+/pHZf1Uvl/2LK0kKligo
	bgLXiGcSKiScPCoDpNH8prtfGdaU28a8FE+yIdn8uMuBRcTyeR2NKe+tWr0Eiyzb+z1+/D7sNFK
	6HTAQEpw+q8J6QaxHjxs8SMka3Qh0a7OF4w2GWAewPEJQuabl04nOFBxjiumv40IVzZf6hDQU7
X-Google-Smtp-Source: AGHT+IFCpSEfd4LaFO6M+tPUkmFHhAEEOJ1sSHWWLhQek5ePCHqBviABc8XZoiiaey3UFyr0cUR24g==
X-Received: by 2002:a05:6402:2709:b0:649:593b:baf4 with SMTP id 4fb4d7f45d1cf-6499b1cd664mr1618177a12.27.1765541504152;
        Fri, 12 Dec 2025 04:11:44 -0800 (PST)
Received: from f.. (cst-prg-23-145.cust.vodafone.cz. [46.135.23.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-649820f785csm5154463a12.21.2025.12.12.04.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 04:11:43 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	clm@meta.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: make sure to fail try_to_unlazy() and try_to_unlazy() for LOOKUP_CACHED
Date: Fri, 12 Dec 2025 13:11:18 +0100
Message-ID: <20251212121119.1577170-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise the slowpath can be taken by the caller, defeating the flag.

This regressed after calls to legitimize_links() started being
conditionally elided and stems from the routine always failing
after seeing the flag, regardless if there were any links.

In order to address both the bug and the weird semantics make it illegal
to call legitimize_links() with LOOKUP_CACHED and handle the problem at
the two callsites.

While here another tiny tidyp: ->depth = 0 can be moved into
drop_links().

Fixes: 7c179096e77eca21 ("fs: add predicts based on nd->depth")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b9..648567c77716 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -774,6 +774,7 @@ static void drop_links(struct nameidata *nd)
 		do_delayed_call(&last->done);
 		clear_delayed_call(&last->done);
 	}
+	nd->depth = 0;
 }
 
 static void leave_rcu(struct nameidata *nd)
@@ -799,7 +800,7 @@ static void terminate_walk(struct nameidata *nd)
 	} else {
 		leave_rcu(nd);
 	}
-	nd->depth = 0;
+	VFS_BUG_ON(nd->depth);
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
 }
@@ -830,11 +831,9 @@ static inline bool legitimize_path(struct nameidata *nd,
 static bool legitimize_links(struct nameidata *nd)
 {
 	int i;
-	if (unlikely(nd->flags & LOOKUP_CACHED)) {
-		drop_links(nd);
-		nd->depth = 0;
-		return false;
-	}
+
+	VFS_BUG_ON(nd->flags & LOOKUP_CACHED);
+
 	for (i = 0; i < nd->depth; i++) {
 		struct saved *last = nd->stack + i;
 		if (unlikely(!legitimize_path(nd, &last->link, last->seq))) {
@@ -883,6 +882,10 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
+	if (unlikely(nd->flags & LOOKUP_CACHED)) {
+		drop_links(nd);
+		goto out1;
+	}
 	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
@@ -918,6 +921,10 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	int res;
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
+	if (unlikely(nd->flags & LOOKUP_CACHED)) {
+		drop_links(nd);
+		goto out2;
+	}
 	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out2;
 	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
-- 
2.48.1


