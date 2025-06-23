Return-Path: <linux-fsdevel+bounces-52462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577ACAE3484
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769E33B08A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FB61DB366;
	Mon, 23 Jun 2025 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="E5FoFkIy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692F1DE4E6
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654476; cv=none; b=bMRFbwRgNGW/cqmpkWmX6gqfcqBHUPyTkiVtZCwLldjgtrJlCTCym1p3Eb4rhT08fcOURfntCrB0lIQv6Z+ztz4QwA5+OG7jAadR4Wiriw6lQI543/QOi4UmlLo3biBSGKLSfCyoHSG7yjqKvEEUffL3g3RaU3WHyF8CwE6iiZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654476; c=relaxed/simple;
	bh=fEp8OrsOEbnAMIvhOf+ndln48Z6/xtIvt+a0hSVyqr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLQTpRjXqXNFOdfv0Fn01AscodtDiBDOBpX8AKn/XUyTxfIp0DqWws/yH/Hwf9Oe3aYPgQv3e0kr15mrHVeYPgDxkYbLf3o0guKdsjq1Ve6R4mJbLDLVvpedZuoLTFTV/nSn81TclkwXK4Dhh8YmO1SxI9QuGdyNW2D8A/fZ4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=E5FoFkIy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1kB8++SX98X7IWyFcFXww4rAVSQk/ijwetOlT3Laaxw=; b=E5FoFkIygWgW3Y+sOGwZ7ZlTIN
	gKv2rQM+K7geUY/ALGc9a/2FEvEfeEDuAUNSKxVpunkOZiyTAYeEUju+69mi+mqdYPOV1MCq5VFCP
	Im9XCWYfev0GF2kJB8ts/WDmAwP6jvLiPfM9RiQO9s2MYOn71OuFWnDlmUXADsCeCzaItfgN4i9DO
	PlaGAoBSx1imhm2Ms/WviUxpmMp/gGG2T4TfMQhx9mW6ZU7ZL78tSCHsSgjUJGWw8xpMLoUxtKq2L
	aTPsrsXQ4ueC/PRW3T1XlLW8bP/2xlexiOaVOkg7hJ092GFHWnDkLjCxDcX8Jiewx6Xl3wPIjoFW1
	g8uS4/iQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCS-00000005KtD-1k5J;
	Mon, 23 Jun 2025 04:54:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 27/35] pivot_root(): reorder tree surgeries, collapse unhash_mnt() and put_mountpoint()
Date: Mon, 23 Jun 2025 05:54:20 +0100
Message-ID: <20250623045428.1271612-27-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

attach new_mnt *before* detaching root_mnt; that way we don't need to keep hold
on the mountpoint and one more pair of unhash_mnt()/put_mountpoint() gets
folded together into umount_mnt().

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 164b80108cc4..834eed9d4493 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4685,7 +4685,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 {
 	struct path new, old, root;
 	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
-	struct mountpoint *old_mp, *root_mp;
+	struct mountpoint *old_mp;
 	int error;
 
 	if (!may_mount())
@@ -4748,20 +4748,19 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		goto out4;
 	lock_mount_hash();
 	umount_mnt(new_mnt);
-	root_mp = unhash_mnt(root_mnt);  /* we'll need its mountpoint */
 	if (root_mnt->mnt.mnt_flags & MNT_LOCKED) {
 		new_mnt->mnt.mnt_flags |= MNT_LOCKED;
 		root_mnt->mnt.mnt_flags &= ~MNT_LOCKED;
 	}
-	/* mount old root on put_old */
-	attach_mnt(root_mnt, old_mnt, old_mp);
 	/* mount new_root on / */
-	attach_mnt(new_mnt, root_parent, root_mp);
+	attach_mnt(new_mnt, root_parent, root_mnt->mnt_mp);
+	umount_mnt(root_mnt);
 	mnt_add_count(root_parent, -1);
+	/* mount old root on put_old */
+	attach_mnt(root_mnt, old_mnt, old_mp);
 	touch_mnt_namespace(current->nsproxy->mnt_ns);
 	/* A moved mount should not expire automatically */
 	list_del_init(&new_mnt->mnt_expire);
-	put_mountpoint(root_mp);
 	unlock_mount_hash();
 	mnt_notify_add(root_mnt);
 	mnt_notify_add(new_mnt);
-- 
2.39.5


