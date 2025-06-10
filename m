Return-Path: <linux-fsdevel+bounces-51141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE61AD3010
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A7F1887556
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347B5284680;
	Tue, 10 Jun 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KgeLhStN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C528033F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543716; cv=none; b=Lsjw7LhSICX/mH9glA7uru5nIIsJmgW8jejr7mW8Y433wK/g4QACYhnJ138TWka1UE6ssLE3gdZzsq6sWGiRNE1JXQEnWt75KykBHmfSAWYPhubNl99VeSkuQL3wO1wXh8lvMfPlam3sydXrer2a1bYKar5CmgH529ULDd/tZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543716; c=relaxed/simple;
	bh=ybeXb419IZBQ0n+TbWy5qmtTCz4B3SoYCa84HZMr4eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSBUorSA2qKYZL85Zw+pu70pVz2ZzwVn85IGBVS2WUfm8DfFphfaWmqngYdArlyIJ8dq4fPrCY3AX2VE2lZDUF752c+2nGM1WDhbm4zcLZBT+DivNMDQ57xxjytMRz8gbnztbTxwB428L07OtkaZCOEWawxcRFwnE4pji1q10oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KgeLhStN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qQbbQ49jtcjgzp6DqNnnk5+0xm5oxhk+vRHqVANJiL0=; b=KgeLhStNNhvnj8vlNNDxo+qJDM
	PAHPAf24e0vh9FV7Mx9P9Zdoz6BaEl2v3sPyJNVrpl/cJ+w0wYjUDJI8vMg8Xzlb34E5mahcQcFcp
	R/2Io2b6XOV7FxzhPmoghYWo+YuDE6oW9dBvS1OZk80HM7vh2bW4VS8zj6Ca1FlWUjcdyfvZajT26
	RB4wlqiG3jxwTr2S5g6M3pa8ptj10sixM/iF34hYUnI0/HsAzqEk6p/Ykh1h/bTUwsOE9DsRADBLu
	1WUG02Mt6qOkQ1LpGiOdwCY27SMk43oqSANr/3g40lSUwPlCfdaN8+NxS+vGgssiyjLI0DSmZwaOU
	UXG6B8lQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEx-00000004jNJ-0k0Q;
	Tue, 10 Jun 2025 08:21:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 14/26] do_move_mount(): take dropping the old mountpoint into attach_recursive_mnt()
Date: Tue, 10 Jun 2025 09:21:36 +0100
Message-ID: <20250610082148.1127550-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and fold it with unhash_mnt() there - there's no need to retain a reference
to old_mp beyond that point, since by then all mountpoints we were going to add
are either explicitly pinned by get_mountpoint() or have stuff already added
to them.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 409ffbf35d7d..b176075ad833 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2686,7 +2686,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	}
 
 	if (moving) {
-		unhash_mnt(source_mnt);
+		umount_mnt(source_mnt);
 		if (beneath)
 			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
 		else
@@ -3596,7 +3596,7 @@ static int do_move_mount(struct path *old_path,
 	struct mount *p;
 	struct mount *old;
 	struct mount *parent;
-	struct mountpoint *mp, *old_mp;
+	struct mountpoint *mp;
 	int err;
 	bool attached, beneath = flags & MNT_TREE_BENEATH;
 
@@ -3610,7 +3610,6 @@ static int do_move_mount(struct path *old_path,
 	attached = mnt_has_parent(old);
 	if (attached)
 		flags |= MNT_TREE_MOVE;
-	old_mp = old->mnt_mp;
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
@@ -3685,8 +3684,6 @@ static int do_move_mount(struct path *old_path,
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old->mnt_expire);
-	if (attached)
-		put_mountpoint(old_mp);
 out:
 	unlock_mount(mp);
 	if (!err) {
-- 
2.39.5


