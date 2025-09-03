Return-Path: <linux-fsdevel+bounces-60063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5806DB413D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903786818B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30702D7D2F;
	Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Dc62GCYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C12D4B7A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875345; cv=none; b=OzjG+tCNLZxvyH806/sXFNUTDThlF+GePkv90oXk0687bLH8Q6bdDer2Hp9qAr+8W349OY5OUpKA9DW2XHqGqGgZrDRbAS9kGgohxZNCcEhtSmAix0u7ba/SFTAGynyARf71CkU78JDSlTtUD4XToDfLclgpkQEtjZBwcW4hntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875345; c=relaxed/simple;
	bh=2JGfG5Z4d8Vr50575XPQ4vBsSQIRKYdtWxDj1+A4K4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8VU1nbVs6aRBmLzDfyYLC2302D5ZtAtX39YrraA33jWVftmy422oePkfjSaoIenRtAqpIxX1qZu07nI3W0rN67UHztuHJTlHQ6F7LwNfVf56+vUqi113CX1jaol78D1ahRYk6WGBhv4aUiXvbdiRr7So0l2cJaDYzbW3kYnwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Dc62GCYn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lWXAXfvmIL1JOHGlYroHu5MyhfB4+ykhxEKFJUWvdVA=; b=Dc62GCYngp+41gn91zsv1uVL+R
	PygVUB58+rzbu3fr7gnzHEcwRfvpQ2ui/QbwNzJeguWEV6+63Nd3RI9Zr2TKPtF7XjMGPKYATsWNY
	/0lrO0+VtkuQ/YNvtrS5jnN3vottqT/UFTCzPTXT9Mu23swi+mSw9cahUuKg/LEB834FQOAXeTli8
	kF2VXV7OTnbCHBczuIzhkUy6DG1cPoxXo/5vBXc8Srj2WuOYgdhoJ3TaOIGzKk29gVlEkLng4Zj96
	JEujKQK7wyHKdJxbMmNzcg0LZotI8EPBoaXewuqzWXW2xZpYfzM6VXEoCeS5cIIUr+zS4G9CD2R4a
	xjLbCwqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX3-0000000Ap8t-26F7;
	Wed, 03 Sep 2025 04:55:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 22/65] finish_automount(): simplify the ELOOP check
Date: Wed,  3 Sep 2025 05:54:43 +0100
Message-ID: <20250903045537.2579614-22-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It's enough to check that dentries match; if path->dentry is equal to
m->mnt_root, superblocks will match as well.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 86c6dd432b13..bdb33270ac6e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3798,8 +3798,7 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 
 	mnt = real_mount(m);
 
-	if (m->mnt_sb == path->mnt->mnt_sb &&
-	    m->mnt_root == dentry) {
+	if (m->mnt_root == path->dentry) {
 		err = -ELOOP;
 		goto discard;
 	}
-- 
2.47.2


