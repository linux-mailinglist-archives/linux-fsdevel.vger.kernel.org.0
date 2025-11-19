Return-Path: <linux-fsdevel+bounces-69110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 643BCC6F67A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE92C4FEA01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1D9369222;
	Wed, 19 Nov 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exg3Aib4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDA35C1BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562604; cv=none; b=IJtL6ECGNSW5jd+GvQ3NVPJfqJSYZ74nPJIFjoCrXZ9f9NQBmmOHOWMlj5Ra3SjRrM/Tz8xAbFzIVX2VyU5rtdHtGetGqE2/WscgmlWqoQRLaUTXjVHcFNvPyKr+LTUaqzDY5JvLKQofn4jLkXa4uU18Vow2E9ZRWkS2B4ObhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562604; c=relaxed/simple;
	bh=lcjr10cevC/wlOidXMnjjJxq6BqTEweLwuEWS26Ef4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOCOasS06/0RPdZiwfLkvb59Q/B7Mxco9fUuXWZXREsx8bKY8WdvXgmG04SDrRcl1kEfWy0LxRPTyuAhz7GCWgESJtAElwfMXFNHuR30gr4D0x9gmrviWUrwDv17cn3J4oV3D6kA2Fb02e7+PDovEZSPbFb4dLiJ4Ql6PlTUyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Exg3Aib4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477632d9326so46268365e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 06:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763562600; x=1764167400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4YCOv2WplfV/3rMOIyhYeErJ5mK15tvKllwtsGjP3s=;
        b=Exg3Aib4ZUvF1V4M7Qj3z8cygA//xVVOAoC7Uxffu4glFALdzIAy9wD/DSgxLQbtyh
         /Vo8gMoXq1Lf916Wmpj4MG8T7WBLvc7I3KyqujdHzIGgcxynj9LnLT0R1QymGVlgB6nu
         N1iKARa5z0Q+tZgOPZWnVrd/9fB+csyDdrsPqXslowbWAZKAP3uAXxWpG88gpStjartp
         tW4nna6qrVjydupK+bGUL8xmiJ54NoS5/+gfqjuAiR2OhKfZig2XLIFWPvw2+Cyclk7x
         gU+Us6xIOaqKsf+kEvlznxDKw58tRK8BZZunIPy/HilzskLDS//1G+kpcprPOlH5f2yM
         awoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562600; x=1764167400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4YCOv2WplfV/3rMOIyhYeErJ5mK15tvKllwtsGjP3s=;
        b=XRy0fjhSb6hygLw3n6ucZHoF4bLkgKKBrzAdkCCk6MlNBwBhnionZcqRhBPBU+W4IM
         ScA0Xg8lucjXFTUVvTPNv6IMc47uqAOVQz+UasYiQgkPUlk1WHWMAx6mCHJVuHGG3Tyj
         WshvqgPVsn7iUbu3va5/4M3npLD6S4tAkd1zEgeUhkXaFGgfkVDF9Kq3UX2uIRnI2PTx
         wIc42z63JvSPs7KDtROYOtw94wh586zIHDAoXf8PDdQOu6tAXkHJqcaobecGVAOJEzke
         ByMWM2YzwLrhmzWiM2T2VwiFjGX3M9EKcQ6tKLtkmlxd7Kq9WNZ4Hg+skFOPwcP/H2rM
         zMhA==
X-Forwarded-Encrypted: i=1; AJvYcCXYX7FImRohXOSv2MZWG7B9wwAWNZK7qQce3MWoSL0t/Ie6SQ5YNuLDlwdvCT+F6rc/cuZvSkdlEDvEgp5k@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1EnEDBK3U1f/kXMLeFzFBDAR/7nLC/WpH3kyj+BcownERK/1h
	125KZdYri32llSujE19kA/MI5csBMZT1VeVumh95OiSkXSgf8Tg7UbMaamfpuw==
X-Gm-Gg: ASbGncv35tTn2mCLsBVj9/f7REzj15wjfs40b/cRTJlPdro3ZW3v/QTtPh3DB4g5YVF
	1pi7iMPGnmCvJeLlQnKzyrnTnDZ6EPykJwKRakTFTFN/lFj/f+cQssb8sSeRS/hbwKmwob2BtF+
	8tc4lcPoHI0xPGx9METp36OVHSaV0Ihpo15JJf6tbedDeqBqS0T7uFY4laZgFLxda52WmZV8yTF
	/CeEDZ5NnPtwklTX8nZIR2eXZacn4my+2emIRWsgn1qOndqcgFD0vB030mA4sEJNBwOFExEYfUA
	VxDHrHNaonyHdeJho23cdJL+pQcWPZU7+g7R09htbYgFC9zVy4NS22o3XZ6FrkBRC8s1zdsVAqs
	W9y2BAFDOO2QBH0JUmquAlMr1gi9YHK11lMD3omHhBDD55qAOyYuoiIdQP3W6C6KDdTYvJEZSnJ
	IwF437a+aj/kQURJuszhfg1gGDGN1wYe3F3E/Z7GmBTRR6H60shjUr1iGf7V6jOkYCuPhUBg==
X-Google-Smtp-Source: AGHT+IG9f9oJHqipvunqw5h0QfH78OEGhSCMNSVGzC7u18CGVC61h+PcHcWih8kPaYXJtyzXwJwV1Q==
X-Received: by 2002:a05:600c:4fcf:b0:471:1717:411 with SMTP id 5b1f17b1804b1-4778fe9b299mr208879825e9.24.1763562599680;
        Wed, 19 Nov 2025 06:29:59 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm39449846f8f.19.2025.11.19.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:29:58 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5] fs: add predicts based on nd->depth
Date: Wed, 19 Nov 2025 15:29:54 +0100
Message-ID: <20251119142954.2909394-1-mjguzik@gmail.com>
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

Additionally a custom probe was added for depth within link_path_walk():
bpftrace -e 'kprobe:link_path_walk_probe { @[probe] = lhist(arg0, 0, 8, 1); }'
@[kprobe:link_path_walk_probe]:
[0, 1)           7528231 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, 2)            407905 |@@                                                  |

Given these results:
1. terminate_walk() is called towards the end of the lookup and in this
   test it never had any links to clean up.
2. legitimize_links() is also called towards the end of lookup and most
   of the time there s 0 depth. Patch consumers to avoid calling into it
   in that case.
3. walk_component() is typically called with WALK_MORE and zero depth,
   checked in that order. Check depth first and predict it is 0.
4. link_path_walk() also does not deal with a symlink most of the time
   when !*name

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v5:
- tweak the commit message + add link_path_walk probe stats, no code
  changes

 fs/namei.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2a112b2c0951..11295fcf877c 100644
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
+			if (likely(!depth)) {
 				nd->dir_vfsuid = i_uid_into_vfsuid(idmap, nd->inode);
 				nd->dir_mode = nd->inode->i_mode;
 				nd->flags &= ~LOOKUP_PARENT;
-- 
2.48.1


