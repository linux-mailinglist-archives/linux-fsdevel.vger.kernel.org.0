Return-Path: <linux-fsdevel+bounces-59546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CBEB3AE0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24F81C27FA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9B2EDD61;
	Thu, 28 Aug 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EeuynpV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C522D1F6B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422492; cv=none; b=pykkBKPr6h5/aa3kJlypHlRuwF9r7x5WjMmBqFpgaIC1W4kfZ6lFeNtjRXXtBH8u3iezMtM5z6j6XyBjcd1Ui5cHWXx0sRJNMMWcjjRjV9bSsCAQkjXquyboo+0ZBPgc8joVX1PITPoliaklOck9aMwqAsFWkJTMLpnH3V5jd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422492; c=relaxed/simple;
	bh=ehJe1yP5mWXsWoekjJTQux8UmIhLQAfj83I4VFR4X+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsvBltBGY0QBwbvAlQNQzejPE9aV2Uj+B8FYKQqkz5HlX753QO6sWCftB2/H/vKCro9pBQhDpPmQsrJuJpzI01ilZgbTudDY7vMMH22n44eBGb8gXmJg3YIe2sQOnkhgDXaeCRo/fV0hgMWhs0c/h1mKAlACmACXJHzcxWlDhc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EeuynpV/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+Boazuucs05bS539r/q+eKSDykQQi0QIqxSir9gnhqA=; b=EeuynpV/BlKK/6S+cvIVl1pKjv
	fMzqjMacKvnsGLa6EbAa14vGTAfXN/2Ut2gSioH/OerD4Zr/nUtN+/8yqzZHDRMSVRviFPG75GewU
	VM+GRdDCV0j1pvX8N9zxYld05LYueKu62UP9VNCzcaEtsH3tzgpPAUepyt5Wb80MwzoGM1df5E317
	mdWQ4gSsm8DfqRyq68kzZrZE5wDe9mrU8M/Ux+itIGeIfXJ9M2I2IhjaWKSQZlkI7XwSG2o9nC5zv
	NJrDyvOdeF5nae2ohC7Tg1j/uwE9TNeV3FIcM+41MqdMcX3Egj7BRTwsLUdq/vhS9v37qVQkWBf9Z
	V5U8472A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliy-0000000F23O-3KgQ;
	Thu, 28 Aug 2025 23:08:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 19/63] do_move_mount(): trim local variables
Date: Fri, 29 Aug 2025 00:07:22 +0100
Message-ID: <20250828230806.3582485-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Both 'parent' and 'ns' are used at most once, no point precalculating those...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9b575c9eee0b..ad9b5687ff15 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3564,10 +3564,8 @@ static inline bool may_use_mount(struct mount *mnt)
 static int do_move_mount(struct path *old_path,
 			 struct path *new_path, enum mnt_tree_flags_t flags)
 {
-	struct mnt_namespace *ns;
 	struct mount *p;
 	struct mount *old;
-	struct mount *parent;
 	struct pinned_mountpoint mp;
 	int err;
 	bool beneath = flags & MNT_TREE_BENEATH;
@@ -3578,8 +3576,6 @@ static int do_move_mount(struct path *old_path,
 
 	old = real_mount(old_path->mnt);
 	p = real_mount(new_path->mnt);
-	parent = old->mnt_parent;
-	ns = old->mnt_ns;
 
 	err = -EINVAL;
 
@@ -3588,12 +3584,12 @@ static int do_move_mount(struct path *old_path,
 		/* ... it should be detachable from parent */
 		if (!mnt_has_parent(old) || IS_MNT_LOCKED(old))
 			goto out;
+		/* ... which should not be shared */
+		if (IS_MNT_SHARED(old->mnt_parent))
+			goto out;
 		/* ... and the target should be in our namespace */
 		if (!check_mnt(p))
 			goto out;
-		/* parent of the source should not be shared */
-		if (IS_MNT_SHARED(parent))
-			goto out;
 	} else {
 		/*
 		 * otherwise the source must be the root of some anon namespace.
@@ -3605,7 +3601,7 @@ static int do_move_mount(struct path *old_path,
 		 * subsequent checks would've rejected that, but they lose
 		 * some corner cases if we check it early.
 		 */
-		if (ns == p->mnt_ns)
+		if (old->mnt_ns == p->mnt_ns)
 			goto out;
 		/*
 		 * Target should be either in our namespace or in an acceptable
-- 
2.47.2


