Return-Path: <linux-fsdevel+bounces-71540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F5BCC6AB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 915BA306452F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32DF340281;
	Wed, 17 Dec 2025 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abvMj5nQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF033D6E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961236; cv=none; b=lh5BR2l85nVVGUc3qQKIxBGc9loPUacB3VU4rqZxjnaYP5BjUuku6HezYyiZnNs6oFDKSt8nu+nrOicGtsIHww+VZum4gvhKrQHec2/EgWwBnnV0M9gCkb/9mOhEq3Lr5FaesX0bzDwHfe/6C27WmVj93U98zq4dXhigABKEJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961236; c=relaxed/simple;
	bh=rHdM58pAnaDSEgykUXG1fdDukK9XmZ8ee1wCtCQnfhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcNeebfjew5/eAYZcnjkye0I3t99UFgDsQuMqdimVFEO7ob0la8m7gmL9H0EguPvTRbQ/XrMKrNX5KSFsn04pmU/BWrfH1WRSb1wmNJHgzFfAL8ZhAmwsCeLiYXYPm9O3KaxL1Jo1Ual8hfdZUTsOKtGUV2oZdPJwS9+LMj9WMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abvMj5nQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6495c4577adso7654462a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 00:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765961233; x=1766566033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aszomBLBoQUByCbC/oqX0FySIrenkQuSb6pWTR+FVTw=;
        b=abvMj5nQ9cCMIOdMJLQz69RPePLGhsjpjlJGkIODmZdtfThrj9ViwS7X/K4pLY7eMY
         hFFTuVlrWlYwMgmAPHxdkHPMITfOoUfzJpncyQQxncOePkLFS0aHAPbwdEQQ+SSpdcRa
         lYqrq7ze1ld6da23tfU6dObPd4J8kJKG04shU3FiqJB5avFp+35Gurzs21O7cejZj7EK
         AqsvU6ZY0CsPbNCyfCqCsCTx6leNfYMOh37M3w4nqvKtt7i9h2aTofXi32jkr93++Ura
         8pahIN9yXQkWeA5Sks6YIS5XMsefYKkHX0e7MGIYDQD5CJ5ILsEZUstktg1e7QE8Cedk
         RMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765961233; x=1766566033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aszomBLBoQUByCbC/oqX0FySIrenkQuSb6pWTR+FVTw=;
        b=j0YozxrEPCc0n1IpEWEI8D3Y5yCOddAEHA74CToD1Jm+64SnS/BsNp2uN/FOeB9GvI
         GU5lMiA3/AbuiQ+UX9J9+dn5kALBWmlVNFIssuJgL8czDJUIuvefKD8KPQQi6fSoFtjU
         lkekH7OzCdZGawndaxPlMwKu/O9HrSJT02RBQDv8FW/k5qEj/U2oTjh27L1w0vduQD1F
         g6TVhobAO0e33gs+B9EFfzEjtVXACnqAnz3UQKmGtMm/KD6m57mjAJkdQSMnEY60ml1n
         aZLf7rCpaJPxuKZRN9mSp8OSii0W2vntPl5/AcxjLvwel5dD/Jyh4toyoGyIFFJ0XeoP
         Iy9w==
X-Forwarded-Encrypted: i=1; AJvYcCWak1IPeTNvvHCUqaUxmN0WXH7O4n0Uut9d1E4S1WQOsJP2SjakrTtKRDMBDh5g61AyI3NMZ4NqeB3JRDTM@vger.kernel.org
X-Gm-Message-State: AOJu0YxxUMPl5FXz7JVVKjptyJICaeanLT+ipRLv51nEyEzzmsndSQ6I
	wwydAPgt4Ia9xOFWbchtWUJs8AkeN4m8cLQVbMIxd5kphs+v7TPXfFRs
X-Gm-Gg: AY/fxX7rYvlOSjiplRLOSflhUVGaEe4VW6d5mHWOkXhIUeOly33+ssCc93gOVPjpxAv
	9u2NBFSW4xX2kFNsR6KilN8FQkp01S+fuQmZJCGfyKC7rHToc5JntoDWkIQEWgatBFXUwx+i8qI
	oHbbbn/68s0+1ld4NSTxKNTENJ9wPi+d0URpuZxQdqrNxhNYGg41iE0YZM7lDQL+wxt+XZX0xVn
	ES02cbozUpsbGBhd7LXAhjTtpoYglGAOfIhRxtAdDqr6Q7epJo1TBgOtWKuw+SnmFaWvVzU/+oD
	LyKlbqzUwKCqIaKHSnszauTG532ZCImuaMIv5udSOHPp/0gESsKhA5+H5OLKqlIco7RFii0Bwc8
	WZtFVV5anhhpn5ijThpL0eM8rm5hIq/urAlb1ea3MGjiKLaDKXa1lXeRqklHrkAIfMkeS5hhOVT
	0DIULHbkffYOzIntZt8uOcxpAGQLAxCL2gdXii2LbYs5c5jYTi+bodLncuhErbIQ==
X-Google-Smtp-Source: AGHT+IHfAAQ6tKmCvJCWlqYQhYa+AoAdrLEXviSWzBqJ7K61hKB+2craAY1s/YGhWoAjGDY1F/bE4g==
X-Received: by 2002:a17:906:7954:b0:b73:4fbb:37a2 with SMTP id a640c23a62f3a-b7d238ee6b1mr1721436666b.5.1765961232414;
        Wed, 17 Dec 2025 00:47:12 -0800 (PST)
Received: from f.. (cst-prg-23-145.cust.vodafone.cz. [46.135.23.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f584ba0sm1897536a12.33.2025.12.17.00.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 00:47:11 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	clm@meta.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: make sure to fail try_to_unlazy() and try_to_unlazy() for LOOKUP_CACHED
Date: Wed, 17 Dec 2025 09:47:04 +0100
Message-ID: <20251217084704.2323682-1-mjguzik@gmail.com>
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

Pull up ->depth = 0 to drop_links() to avoid repeating it in the
callers.

One remaining weirdness is terminate_walk() walking the symlink stack
after drop_links().

Fixes: 7c179096e77eca21 ("fs: add predicts based on nd->depth")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- handle terminate_walk looking at nd->depth after drop_links

 fs/namei.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b9..69d0aa9ad2a8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -774,6 +774,7 @@ static void drop_links(struct nameidata *nd)
 		do_delayed_call(&last->done);
 		clear_delayed_call(&last->done);
 	}
+	nd->depth = 0;
 }
 
 static void leave_rcu(struct nameidata *nd)
@@ -785,12 +786,13 @@ static void leave_rcu(struct nameidata *nd)
 
 static void terminate_walk(struct nameidata *nd)
 {
-	if (unlikely(nd->depth))
+	int depth = nd->depth;
+	if (unlikely(depth))
 		drop_links(nd);
 	if (!(nd->flags & LOOKUP_RCU)) {
 		int i;
 		path_put(&nd->path);
-		for (i = 0; i < nd->depth; i++)
+		for (i = 0; i < depth; i++)
 			path_put(&nd->stack[i].link);
 		if (nd->state & ND_ROOT_GRABBED) {
 			path_put(&nd->root);
@@ -799,7 +801,7 @@ static void terminate_walk(struct nameidata *nd)
 	} else {
 		leave_rcu(nd);
 	}
-	nd->depth = 0;
+	VFS_BUG_ON(nd->depth);
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
 }
@@ -830,11 +832,9 @@ static inline bool legitimize_path(struct nameidata *nd,
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
@@ -883,6 +883,10 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
+	if (unlikely(nd->flags & LOOKUP_CACHED)) {
+		drop_links(nd);
+		goto out1;
+	}
 	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
@@ -918,6 +922,10 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
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


