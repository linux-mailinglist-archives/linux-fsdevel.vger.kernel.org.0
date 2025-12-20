Return-Path: <linux-fsdevel+bounces-71792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3075CD2829
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 06:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C67BE301B2EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 05:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAEA2F39BE;
	Sat, 20 Dec 2025 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2/DcTnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DB926A1CF
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Dec 2025 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766209234; cv=none; b=SmL+iVhBzHHVVogF4wWPIie4ay3O2DJ5xWgHt0NhTBBZ5zrSXUK2Vs38eIH6p/xHAS+zvX1TjFSJL2Bh5cdsBbU6IJatTbcrtR6S4UeS0QsiBQz2jWyDbJGlQzBHrjN2MmLA05EpDeHVWyjWe2CRniD6dgmB3We3dttPKPuQwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766209234; c=relaxed/simple;
	bh=p42BJNupHuIS+VpYjjVjkRpU78a/l7ZJSRdNnBbDs8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHKuCjOV0ccNyjhOzQ0Yqj0CmzaqIdenVWy2eChfMcl/cVvQ12AnEUPEAqFdCQ0LTAaNZT9rrht/Q0k0Py1gN8wR4covQAFb/g77+LilCwRoqqh71eGTyjbaDzWJ9SQp5b4naab4toAYQIKRqCiS2bPpu6a4uGCyTpx6JZyYxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2/DcTnc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b81ec3701so2991530a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 21:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766209231; x=1766814031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8prGX8mCG0hlpIUxCwCqtaCOrf4LfFVDrIHbCsEcuY=;
        b=G2/DcTncR/tdE9SGjPTShYB4J939dQydgy6mvg7nFKjSFzybbppdxY+Sr7WeEyY2wV
         sMXNwjMdXM4nBG+TS9M6Jo2y/KuNXYBN6mTv0O/DEp5qJkcD2yGPTVS+BquRUVe85NkF
         DJHHjtRP/0e1oLena1krlBhfZti2+rZHGxKluR98QhIzcRvSgTH/ayWiZW4AjHe6nWQ4
         e0Iib/DmqhxGjGgVeulq+9QjIj5N/3HaI29tnPcQv2ueTi9sd4bi0vRdRjMHylFjkMWN
         rCIyJmy13u/6C176eYo1ciwJw+aQy3Hf1dq/KzAKMOAYJ1vptiGuSml0Au3rPaTEwfow
         OQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766209231; x=1766814031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8prGX8mCG0hlpIUxCwCqtaCOrf4LfFVDrIHbCsEcuY=;
        b=O/79ZMrZXnhz9FMU18OwkFlw/F0RBUczL4GahqLEqMLtmFngHQrKiYD6y7y3009/of
         R8w6KH+orZPV8iEE5y/rrWh4doJlerDEyqd9sXCszSYyddHR6P2eLjHKN3D0SliC/S7N
         ln4d+b/HY1QsYiPT+AlbV+jG5zd2pRKBo34jch4cnvctzQFEkjrXCujxoTjHg9MTMTZz
         A1TD9IS+acOMr6vPkniFevqE+cNJ5oVQUzNl+u/lLL1DGa4u2BK7SyXKoWxmgJw4bUsp
         +QB6NicAL8XJWBPUGblU+SdWpjw/Bn3jrPs+K9HMVFs1Nb3fHMm775kMI5SV9+B1cG08
         2D5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1LPVIFdZxu1YszA8gi9/0YPhOtCFHlIjLSKWNB5RusNsTns7fpK+7eLqL3/SHiWOjFid+THiOflYNuRS+@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkOSvsiTfGoFSIsShMhoBKEy2sIOnQEj4IE6Z/HUXAcNHfZ8J
	KVlKh5iG1cKvtDyhsuQviJVc9vp2jxEk7qJDHrovdXch/bbzGYgah9VK
X-Gm-Gg: AY/fxX5mrjnQSuguwyzCoSBl1lqXDFQP3VD51gABid5HbH8EyiyEV+U3gef3fPSUaSN
	eREavbJ9f3pjve4U8wxVI84hAYLsgEne80XZxXcgM+dojQtfnc75h/qmhdezw7snuIXZxJztNEv
	THtAZ2J9Q4PRZ7NlnOEzCQ39BTu7h1WwsUjKLQSM1ZpcSTNSLMUXq8AvusURurrYCbXJjFG3Jk6
	ZZlJKT1m6FnbFxQ1S7O2LrATPh4/MYr2AHM6m+vduwRcf4fUr/ODui8GaxH8KecPpqYekoudw2O
	uqeTA1ljt8e1Rr3OCCfwWT46D8dthxo9f0t/BjG/uHutmQT7E7yT/8Ro7FkzxAaUdU6pxkj+VKJ
	R5q53YmB8qJxExM5yaAcrGPBIdWwyZHg8jze5V7/5i2DgwZF8YaJvq+WoC+TL3v/lrYoE2Th5vj
	PZxxCJf8SSJhGghgNxBDl50S9kvJNqz6DCi2ZNa6kscKHPxReoOCmxReEP4eyeJVP7Ptuf9w==
X-Google-Smtp-Source: AGHT+IEq/HNbwlXVDbvScjeQpoQYsBu8b0ZfA8ZLBC5usoKuom4CFt9Fhy6b6qXz23H6iI2r4T8l8A==
X-Received: by 2002:a17:907:8690:b0:b76:63b8:7394 with SMTP id a640c23a62f3a-b80371d9dcbmr515084466b.51.1766209230538;
        Fri, 19 Dec 2025 21:40:30 -0800 (PST)
Received: from f.. (cst-prg-91-72.cust.vodafone.cz. [46.135.91.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f3e271sm412429566b.60.2025.12.19.21.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 21:40:29 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	clm@meta.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] fs: make sure to fail try_to_unlazy() and try_to_unlazy() for LOOKUP_CACHED
Date: Sat, 20 Dec 2025 06:40:22 +0100
Message-ID: <20251220054023.142134-1-mjguzik@gmail.com>
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

Fixes: 7c179096e77eca21 ("fs: add predicts based on nd->depth")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v3:
- keep nd->depth = 0 out of drop_links to further simplify the patch

The thread for v2 got derailed with a discussion unrelated to the fix
itself.

Whatever future cleanups or lack thereof can be discussed after the
regression is fixed so I'm keep anything of the sort out of this patch.

The easiest way out I can think of would merely remove the ->depth
checks before calling legitimize_mnt, but it would be a bummer to
reintroduce the func call.

The second easiest way out literally copy-pastes the current body into
the 2 callers, which I implemented in this patch.

 fs/namei.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b9..f7a8b5b000c2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -830,11 +830,9 @@ static inline bool legitimize_path(struct nameidata *nd,
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
@@ -883,6 +881,11 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
+	if (unlikely(nd->flags & LOOKUP_CACHED)) {
+		drop_links(nd);
+		nd->depth = 0;
+		goto out1;
+	}
 	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
@@ -918,6 +921,11 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	int res;
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
+	if (unlikely(nd->flags & LOOKUP_CACHED)) {
+		drop_links(nd);
+		nd->depth = 0;
+		goto out2;
+	}
 	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out2;
 	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
-- 
2.48.1


