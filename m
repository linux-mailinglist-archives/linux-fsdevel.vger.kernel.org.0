Return-Path: <linux-fsdevel+bounces-67146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3904C3637A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 16:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A18618924A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6818832E6B4;
	Wed,  5 Nov 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCx/ljgr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F095931329D
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355202; cv=none; b=NZZgHMnS8v+wL7OGrzz2YuS/XkKIXxWR9SquFeGeL9p7MkY46OSs9vHPCzSrv+f6Zw3FqSji3BQhCNR1+ekYeXgQpPT6QP4+Q50mC0cgg2cHwDUqDVv/FawVWZa2864tFM7gux46H3hoasgNAJ7PXNEv/7lotX6gO0WwOXlqQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355202; c=relaxed/simple;
	bh=hMflwBi1rbNrSzKhcf3HQbcg4uOMTpc+2wqfNATMZB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncoSaPgcda98vwFJK2Ju97XG6sqx9dL0DyttJC330rOyNRj4hdsybSa2Cvn0VnVg9idX8u2/ZxH7VHJJsjFpjPRO+tyCllP9L4C1GBD94aVlHvHn/DkECh3FMHAaqS40RxyTqzhWmO7q/sfjJVou/zoNdWztlbEQIxVVJKrVUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCx/ljgr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so3556181f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 07:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762355199; x=1762959999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MagQcWlTriY+Z8puqAxWVOt94EHVEjLFKqb7wFV2fUw=;
        b=YCx/ljgrBk5PS9pnV52beQfxekgl8yCTsthpcGg3fakNqfNB+xHAojinSa0kmX6pb4
         uZuy1Ref85GK213fNCOG4s2rZDtnlZycCtgkOGpTWqVH4ZaAnSzAIcxS1rQSMQpEmMFX
         q86oSZ57S61oHoalHqCbHBaXNHOjMZH1SYPo2pm43YhWeL7b36/QoyMApNCGhNuzF1K+
         IJSKBoy2JIE+GIByEPt9Mu9cXpZ7TzD21cHEzHivd3c97M3piS5zE7fwqI+OjITLOEu/
         G85Ek5TnZg0Ir99qzUhMfyOEg5mWQrpdA/v2cR/Dy+djTwks11Ck56anGUUmcbeq5/HK
         QBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355199; x=1762959999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MagQcWlTriY+Z8puqAxWVOt94EHVEjLFKqb7wFV2fUw=;
        b=ayC2cMnVqO7Fvr7feecr1xoQ9dQ7mYYP1QBvGhD6/NjNvWyCcv5kjd0McBXSGDtO4V
         Shsuuj0T6Vwh7LNhRjHtzCbUvAbiV8Tx1hlg61Io1R3/VmEznjXOCWyPV+VJOndLZ7CD
         WvFxDbG2Moqt+3X1s9ipTQMeiooOcTEZr/v8SyZIAILH0GPAoWh/+mcpG9cIVXUc4if6
         7aIgF7IqgynjoIGo7r2sEGOMWq++UYxIDiYyc/YirGTPe2Afxe4rzUcyf30bPdZh5MO0
         Gm4KOhdkxorrUti1EFDBxWWAMsg2tTiscyaeYDpkPtlqvWrVGFFbiBcKiRo1az0fLiJU
         6LGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqUxZgXViAtbnlFKRvwa4HzMBEm2yFYIJuXBlNmbD9Ess+puQ6jum3a4WlC9nysL6GrchlSOC8eUeCv59h@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYNe2riPa+kxCLf/0gaOpOr0XNER0wifJnW1EkogOKt3rONDM
	bT1eyl0ZoaLSwhZHpDBj60sYcKLokc9kdz0sociZRehwlCqu6zE/SV2v
X-Gm-Gg: ASbGnctJD/rSY/H2yY3v+51b5P4hSuvjs8mqhtv0ZhyzGpr26uxWpQKlJn7p2VkNpSb
	ZwvMVZVRFCSliyieivHhl/5NOcgUk6nEZfiLw73idmR/+nN/Hl9uhsrtC50T4FOvahwemMxbQkh
	eaj9JdhdlmXffdUYWpF9C9wL37qolaUYKOxP6gRUXKjZB7MqybO8XnFlzQYEvZaWV9/MtOB0qcK
	SCDtQklFNIKcqwoCuab8+1WjdVvXcLNGIrXi8ZFwYPBw9D4JQfzAiwjlPpM31Mk9EmJLm8dq0gs
	vc/zSvbE2zBtOLQT5Qo4BA5lh++vRJSd7tp+If2GQDm4rF6TVlHDNc3N+6bZEvUv9iOdsupCDpz
	V1Pp2Fu3Y0owxAlK5pQZF83xFQT8uEM4dEzniS5CFII0veZ3ZtiTaDhZHTImkftl/dEplaQEzaB
	iKmyv6Ii1W1wWHSLt1976uyovgz/pytfQ/iZXRmA87k87Y2ccb
X-Google-Smtp-Source: AGHT+IH6VE9rvxlDzTCdDohrrzJOds8A7rfSL643h36YHCfh8XGC8GC923hwtKU3u5u4FsC8gTEryg==
X-Received: by 2002:a05:6000:4013:b0:429:d3c9:b889 with SMTP id ffacd0b85a97d-429e32c81d5mr2904464f8f.1.1762355196516;
        Wed, 05 Nov 2025 07:06:36 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18ef89sm11179556f8f.6.2025.11.05.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:06:35 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: touch up predicts in path lookup
Date: Wed,  5 Nov 2025 16:06:30 +0100
Message-ID: <20251105150630.756606-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rationale:
- ND_ROOT_PRESET is only set in a condition already marked unlikely
- LOOKUP_IS_SCOPED already has unlikely on it, but inconsistently
  applied
- set_root() only fails if there is a bug
- most names are not empty (see !*s)
- most of the time path_init() does not encounter LOOKUP_CACHED without
  LOOKUP_RCU
- LOOKUP_IN_ROOT is a rarely seen flag

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 39c4d52f5b54..a9f9d0453425 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -951,8 +951,8 @@ static int complete_walk(struct nameidata *nd)
 		 * We don't want to zero nd->root for scoped-lookups or
 		 * externally-managed nd->root.
 		 */
-		if (!(nd->state & ND_ROOT_PRESET))
-			if (!(nd->flags & LOOKUP_IS_SCOPED))
+		if (likely(!(nd->state & ND_ROOT_PRESET)))
+			if (likely(!(nd->flags & LOOKUP_IS_SCOPED)))
 				nd->root.mnt = NULL;
 		nd->flags &= ~LOOKUP_CACHED;
 		if (!try_to_unlazy(nd))
@@ -1034,7 +1034,7 @@ static int nd_jump_root(struct nameidata *nd)
 	}
 	if (!nd->root.mnt) {
 		int error = set_root(nd);
-		if (error)
+		if (unlikely(error))
 			return error;
 	}
 	if (nd->flags & LOOKUP_RCU) {
@@ -2101,7 +2101,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
 
 		if (!nd->root.mnt) {
 			error = ERR_PTR(set_root(nd));
-			if (error)
+			if (unlikely(error))
 				return error;
 		}
 		if (nd->flags & LOOKUP_RCU)
@@ -2543,10 +2543,10 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	const char *s = nd->pathname;
 
 	/* LOOKUP_CACHED requires RCU, ask caller to retry */
-	if ((flags & (LOOKUP_RCU | LOOKUP_CACHED)) == LOOKUP_CACHED)
+	if (unlikely((flags & (LOOKUP_RCU | LOOKUP_CACHED)) == LOOKUP_CACHED))
 		return ERR_PTR(-EAGAIN);
 
-	if (!*s)
+	if (unlikely(!*s))
 		flags &= ~LOOKUP_RCU;
 	if (flags & LOOKUP_RCU)
 		rcu_read_lock();
@@ -2560,7 +2560,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->r_seq = __read_seqcount_begin(&rename_lock.seqcount);
 	smp_rmb();
 
-	if (nd->state & ND_ROOT_PRESET) {
+	if (unlikely(nd->state & ND_ROOT_PRESET)) {
 		struct dentry *root = nd->root.dentry;
 		struct inode *inode = root->d_inode;
 		if (*s && unlikely(!d_can_lookup(root)))
@@ -2579,7 +2579,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->root.mnt = NULL;
 
 	/* Absolute pathname -- fetch the root (LOOKUP_IN_ROOT uses nd->dfd). */
-	if (*s == '/' && !(flags & LOOKUP_IN_ROOT)) {
+	if (*s == '/' && likely(!(flags & LOOKUP_IN_ROOT))) {
 		error = nd_jump_root(nd);
 		if (unlikely(error))
 			return ERR_PTR(error);
@@ -2632,7 +2632,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	}
 
 	/* For scoped-lookups we need to set the root to the dirfd as well. */
-	if (flags & LOOKUP_IS_SCOPED) {
+	if (unlikely(flags & LOOKUP_IS_SCOPED)) {
 		nd->root = nd->path;
 		if (flags & LOOKUP_RCU) {
 			nd->root_seq = nd->seq;
-- 
2.48.1


