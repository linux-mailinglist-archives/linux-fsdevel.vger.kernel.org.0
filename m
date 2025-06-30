Return-Path: <linux-fsdevel+bounces-53263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C99AED2A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0F18953AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4E01F8EFF;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YI3Fg//5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5119F13F
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251981; cv=none; b=gbi77/lUW0AYBxTy0gchkR+pFe0ducKsv+UBzn7mFom5x4T2ezmqoNm6qK5BOOhJkRZuf4+8qXFkwdW83oxZ2mSSlyYxKK2r/R833AJg5srYWsMcbZf7DhTglTQEAdn1bzSumoE/d4RZZorMRyEkb6mQE5nZCyUnlkZvtLCKpjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251981; c=relaxed/simple;
	bh=agwhK5Cw2ZUwL8R7WdG5sylPVNmfe/X6VH3WEJ38z9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWgsbO+cA4zT9JgtFrFAAXf0HVphCJ4gvV4PLNsdY8xZ6s+AkNcAm9Zlvm+YJj0f2XQ3cOC6COtf4293KrooWjIhV4aI2b+HURCcre5YWe+GwA4ViJ+AzrNtG4PcT+mn5eMcPTWRSIwSn0Kyz/omGAn8SYPJahS/tXTFDZx1UrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YI3Fg//5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y4GrPacibVaDFJLqhXZRH7ZqnD7139qAT0w1AxWgB0w=; b=YI3Fg//5TI2O0nN5qHoN6Hobpq
	Z8I9jBYd7IhlvUMZMkAl5C63CpUA5uAhrJPLnY3chGLlB/ytZSK85pFjYteRBL7dENHZLwOpCCHNF
	kbYsPSG13Mo8p5YCnkB2uOV9TxYhtZNCH4WOce3ehhPKzFPk6jAx2CyP4BT5kS89U+LOnTNihNL41
	x7/poQH1Wy7tQRLTmG6gwZWW5bGz86s4EMlQjtFAmJWV1j7Z0n3Vqysk0QBDeScIfITi3d57kdVO2
	2IHREzt2h0TRdRJQpyabmtKB1ocYgHvpBW2af6GQ85eGzpw1utIrQZE0vAPxMJTqETQq0mfbdE7KD
	v+DnilBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dd-00000005p07-2nZh;
	Mon, 30 Jun 2025 02:52:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 22/48] do_move_mount(): get rid of 'attached' flag
Date: Mon, 30 Jun 2025 03:52:29 +0100
Message-ID: <20250630025255.1387419-22-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

'attached' serves as a proxy for "source is a subtree of our namespace
and not the entirety of anon namespace"; finish massaging it away.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e5f8fde57c99..7c7cc14da1ee 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3600,7 +3600,7 @@ static int do_move_mount(struct path *old_path,
 	struct mount *parent;
 	struct mountpoint *mp;
 	int err;
-	bool attached, beneath = flags & MNT_TREE_BENEATH;
+	bool beneath = flags & MNT_TREE_BENEATH;
 
 	mp = do_lock_mount(new_path, beneath);
 	if (IS_ERR(mp))
@@ -3609,7 +3609,6 @@ static int do_move_mount(struct path *old_path,
 	old = real_mount(old_path->mnt);
 	p = real_mount(new_path->mnt);
 	parent = old->mnt_parent;
-	attached = mnt_has_parent(old);
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
@@ -3622,6 +3621,9 @@ static int do_move_mount(struct path *old_path,
 		/* ... and the target should be in our namespace */
 		if (!check_mnt(p))
 			goto out;
+		/* parent of the source should not be shared */
+		if (IS_MNT_SHARED(parent))
+			goto out;
 	} else {
 		/*
 		 * otherwise the source must be the root of some anon namespace.
@@ -3649,11 +3651,6 @@ static int do_move_mount(struct path *old_path,
 	if (d_is_dir(new_path->dentry) !=
 	    d_is_dir(old_path->dentry))
 		goto out;
-	/*
-	 * Don't move a mount residing in a shared parent.
-	 */
-	if (attached && IS_MNT_SHARED(parent))
-		goto out;
 
 	if (beneath) {
 		err = can_move_mount_beneath(old_path, new_path, mp);
@@ -3686,7 +3683,7 @@ static int do_move_mount(struct path *old_path,
 out:
 	unlock_mount(mp);
 	if (!err) {
-		if (attached) {
+		if (!is_anon_ns(ns)) {
 			mntput_no_expire(parent);
 		} else {
 			/* Make sure we notice when we leak mounts. */
-- 
2.39.5


