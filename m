Return-Path: <linux-fsdevel+bounces-47457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63642A9E482
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Apr 2025 21:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E77189A9BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Apr 2025 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85331DE88A;
	Sun, 27 Apr 2025 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iUJSRjSP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845002701C4
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Apr 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745783408; cv=none; b=ohEzMtyyq9LM3S4ueCVUIOxJQbgV0KELgAqVY0mX6IBX88lAttbZ6Ss6ge4k+pppf/wGRxtD2pWWNK4Hyh8mycOlMX7Gx0oXYM33862tP996y+MVsVDwT453MagTjZ3Ai+omUALmxuz7Ba51V++ydb993OZNgYQv2EmJxj3v2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745783408; c=relaxed/simple;
	bh=heJ3k6Q2MhlOTFcIrVq1ux/F3Y9L9PdVjV0rxHEwgz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kjkxW0rGrdJm7eNvlXHgYnC4WRjHD0kgr8Q78+ZQFao4mgi9XicrcmHOGcPPdS6DWaGdCwEkHQUkyZrwUrgGqRlL1gXKOnQXmhTr+L2sApZ0WJ39KnxN69G7W1z6WscSvS8dx+eLpHgcfBd6ik+8A7Hb0C6d4oxM6GeZw+3Gp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iUJSRjSP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3tB88Mhr+ZvAFbMB411pp8HCia10iCJNCdzMi5pCwQY=; b=iUJSRjSPtlr4mhCADpilg3f7Pz
	BbFsx+NRUFFn3vMTlMsfFC6XmpBDOIM/IjjOreU1hgEg+juyrQXSxg1r56lIAp14DBwfVOQDZAS9y
	NQwURDlmu2//Y2HZCXkZ2pIcKeJrWF8nlkbaObyUfgpFYMDOUxJv/2zA9OfgYATFchZPXceUYVA4X
	x9lbb7vNqm8slrdThG8U1llqCK+Z4ljfP2T3HBCtXlrcgK8t0cJYgsrZlR9dVN6s7TskR5TThdziL
	RrSCTVVyvZDxsihh2W0zJQOvmIHVOiBw6hxDkFmG1qu37aeVMEkqO3l5a9rq6Ez2B0Bvn+f8M8HOn
	D7YcucLw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u980o-00000003Dqr-3pzX;
	Sun, 27 Apr 2025 19:50:03 +0000
Date: Sun, 27 Apr 2025 20:50:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH][RFC] __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be
 under mount_lock
Message-ID: <20250427195002.GK2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[another catch from struct mount audit]
... or we risk stealing final mntput from sync umount - raising mnt_count
after umount(2) has verified that victim is not busy, but before it
has set MNT_SYNC_UMOUNT; in that case __legitimize_mnt() doesn't see
that it's safe to quietly undo mnt_count increment and leaves dropping
the reference to caller, where it'll be a full-blown mntput().

Check under mount_lock is needed; leaving the current one done before
taking that makes no sense - it's nowhere near common enough to bother
with.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 98a5cd756e9a..eba4748388b1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -790,12 +790,8 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	smp_mb();			// see mntput_no_expire()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
-	if (bastard->mnt_flags & MNT_SYNC_UMOUNT) {
-		mnt_add_count(mnt, -1);
-		return 1;
-	}
 	lock_mount_hash();
-	if (unlikely(bastard->mnt_flags & MNT_DOOMED)) {
+	if (unlikely(bastard->mnt_flags & (MNT_SYNC_UMOUNT | MNT_DOOMED))) {
 		mnt_add_count(mnt, -1);
 		unlock_mount_hash();
 		return 1;

