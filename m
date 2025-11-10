Return-Path: <linux-fsdevel+bounces-67723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44919C480EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1CE1884C83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCEE328601;
	Mon, 10 Nov 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz7HLTG1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AEA30AACE
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792711; cv=none; b=QaBbdQaKzuO5G4oVHhxgRXn6Rdz9wQZWLU4IJc6NxZBXDVH1AJEK0MIpAU6bF00OfoMOoyG+rXVPu4/9G4AfjsqOcPaX92scZBNY83mjIXNczNLsvxAhdPUfuWNu0KYoxZiyOtQDf4ZzYCqk9jpeQjQjBJR6Ae9kJyjcbWm6ayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792711; c=relaxed/simple;
	bh=NtWnINBt3sM6GiXGdKHci0gX7e3BpDT+7lx59+8Zdus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXCMYtqDCzEqce95KNZYPiMBrAbMSeu9Eu5mEu9rLhkuIErNc1ruUZfoYPqZoi3sOP0Vi0ImkoLle6R+yUoupEfwZfuDRXHWwPsDczWkaoS9AdUE8maCqbgwpdeAoDZe0q6djorQyMlAHiNh6JjMLaHfPXt/Wy41xmMu1/JjwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz7HLTG1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso5960971a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 08:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792708; x=1763397508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=crySnOU0BCzQMPPEF+Im0cShC+HGRCGDJ0MSVHJMWYg=;
        b=Jz7HLTG1UVYjcpQz7csEmnd+Oa87xqpup0PgaUOZ9+/xnwBe/+4qtTX1zJNtEFb9RS
         /jt9YI722uZvxQo1W1Tz8Swb3/Hqaja9d/370e+s+WX5cVu2blOEruTNQyFuhIinue5v
         thQc0WIts1C2Ldm2FMRcjqFzHj5kHBEaObpmewjtbp3bIgOWLWiG+uramKWSclBWT01Y
         pChFA+y3z9yqR3CO7PLZOw+WsB2Rreu9u7HiadMlk/oh6QgRncUJm8l/q4l2IDYLrAui
         dphML3/i03GT50PjxlQG4fuJvsBDsgLRwvUs/2MQKB0Hr6eXYMQRvs1UDPw1beo/73CD
         H9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792708; x=1763397508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crySnOU0BCzQMPPEF+Im0cShC+HGRCGDJ0MSVHJMWYg=;
        b=pdzQG9siUqNWN/N4kl4n1Rbty2dar4+ihFnR2UWw61q7x8I0E9b6/zS4fuu5Neu5wC
         6sxzQiOiChYiV7jR+pIgXNyHAl2uQAF+i/PsfmdTwtXJWKhLlPXZEos/g54cYbSZhpI6
         x79gGtywHtSnbIZ9xX2/agixzSCAGqDZTfK0bU2lgxSRCfQdCGmjYqzGLq0F8QdcbG3s
         AaPtmODSmDUPacFxQ+yNeQ/j08Z8WvL2U3omTrjP5QQcd8v/kjlUViJ8i9jpsdU3hmfn
         g+qeIxZrP2ahuMEyHbtJzYApFANopkDsXoBBy0EK7zSTJDBqg9YHLBiJ9ETn9Mlapt10
         gkYA==
X-Forwarded-Encrypted: i=1; AJvYcCXKYDo3JKPp2t2f2Cb92mBZ//Vz2kr9oRqxNzrbwVZG1J84s+mG6J/mEmXRt6b6hTvpnjy0+xR7KcfpDcZA@vger.kernel.org
X-Gm-Message-State: AOJu0YzujCRVzRYaimtzA26oebXuihZ5/8VMaqinqdB1857vAP35sqlX
	NYCO2v0VGIuIV7Yfe14XzU+AoKA1Mv+S+EZDjz+hqY1gfoa67DkVqjdx
X-Gm-Gg: ASbGncszuIiESEPzFwzclZJNKvsdkct2RnMK5+KWcoOF1GPkM8IG7y9QxPVPXJ5vp2D
	v8LIiDn01gdjZHFWHexCiixyzVBoLGn6LYRUTO+sh8ry7r7Zd1GA6jzzhhnCRDez46B5oTo0tJp
	XKb8+STaczdMZtfpQRsyTvGMJ/Za4e9rIKp6lg7A4wS4RdX9Z6/USJ3iC5YmQdGtWhG4VMDo68X
	LFrqGKedfHzRKI6KtBuo15/K+I8hVkhoLBvvGa02DTdfMUCFgWtzhSUZQ3qWwkAn9Z0RamlLS8f
	nGrA3HGWmQKcQp7xdDHKZRxq0ElgRPwYDv/jMFW9VNxK2enjoTUFDzjTzNt0WM3tADza7xOfaD0
	YzzlXMDusXe//I6iyCcaqWApwu42aJVKKEMHLcDyKTpUG8kcXF0xJRMKRkg8vrxuIq+aYqMVGrO
	bKm7qRqWUIC8CqYueseJgbBnEB7RaHukGhjKz8kIYyyKY+FiTv
X-Google-Smtp-Source: AGHT+IFRyFfuGUAUqh/iXGb40Q/6TuxBb/dJTSuyufllnYorj5TKU4oOweyogQ8JItcI/4Zi5gDSNA==
X-Received: by 2002:a17:906:dc8d:b0:b6d:c44a:b69b with SMTP id a640c23a62f3a-b72e04524d9mr835230466b.35.1762792707889;
        Mon, 10 Nov 2025 08:38:27 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa11367sm1112772166b.68.2025.11.10.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:27 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] fs: add predicts based on nd->depth
Date: Mon, 10 Nov 2025 17:38:21 +0100
Message-ID: <20251110163821.1487937-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stats from nd->depth usage during the venerable kernel build collected like so:
bpftrace -e 'kprobe:terminate_walk,kprobe:walk_component,kprobe:legitimize_links
{ @[probe] = lhist(((struct nameidata *)arg0)->depth, 0, 8, 1); }'

@[kprobe:legitimize_links]:
[0, 1)           6554906 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, 2)              3534 |                                                    |

@[kprobe:terminate_walk]:
[0, 1)          12153664 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[kprobe:walk_component]:
[0, 1)          53075749 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, 2)            971421 |                                                    |
[2, 3)             84946 |                                                    |

Given these results:
1. terminate_walk() is called towards the end of the lookup. I failed
   run into a case where it has any depth to clean up. For now predict
   it is not.
2. legitimize_links() is also called towards the end of lookup and most
   of the time there 0 depth. Patch consumers to avoid calling into it if
   so.
3. walk_component() is typically called *with* WALK_MORE and zero depth,
   but these conditions are checked in this order and not predicted.
   Check depth first and predict it is 0.
4. link_path_walk() predicts not dealing with a symlink, but the other
   part of symlink handling fails to make the same predict. add it.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v3:
- more predicts

This obsoletes the previous patch which only took care of
legitimize_links().

While this only massages the existing stuff a little bit, I'm looking at
eliding some work later. This is prep cleanup.

 fs/namei.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2a112b2c0951..a3d86bd62075 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -785,7 +785,8 @@ static void leave_rcu(struct nameidata *nd)
 
 static void terminate_walk(struct nameidata *nd)
 {
-	drop_links(nd);
+	if (unlikely(nd->depth))
+		drop_links(nd);
 	if (!(nd->flags & LOOKUP_RCU)) {
 		int i;
 		path_put(&nd->path);
@@ -882,7 +883,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
+	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
 		goto out;
@@ -917,7 +918,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	int res;
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
+	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out2;
 	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
 	if (unlikely(res)) {
@@ -2179,7 +2180,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	 * parent relationships.
 	 */
 	if (unlikely(nd->last_type != LAST_NORM)) {
-		if (!(flags & WALK_MORE) && nd->depth)
+		if (unlikely(nd->depth) && !(flags & WALK_MORE))
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
 	}
@@ -2191,7 +2192,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 	}
-	if (!(flags & WALK_MORE) && nd->depth)
+	if (unlikely(nd->depth) && !(flags & WALK_MORE))
 		put_link(nd);
 	return step_into(nd, flags, dentry);
 }
@@ -2544,7 +2545,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		if (unlikely(!*name)) {
 OK:
 			/* pathname or trailing symlink, done */
-			if (!depth) {
+			if (unlikely(!depth)) {
 				nd->dir_vfsuid = i_uid_into_vfsuid(idmap, nd->inode);
 				nd->dir_mode = nd->inode->i_mode;
 				nd->flags &= ~LOOKUP_PARENT;
-- 
2.48.1


