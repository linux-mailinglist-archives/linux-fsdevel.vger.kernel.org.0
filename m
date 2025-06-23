Return-Path: <linux-fsdevel+bounces-52454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45CAE347A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFC016D3B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D21E8358;
	Mon, 23 Jun 2025 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NDWCXplO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0221D88D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654475; cv=none; b=okm4PUONLROxT79tv3TxP1OTudzvQUJsKrlLjvXVjdqc7XHEUl2V/uoNGVHs3DVaGRDhboE90JOD7BTH3yMzTONKRtI/hPX5zwOtfeHo9Ih8vDnhhxgOIXuN/7kzgebn0wBZl90lb+yDG+wqsisRGJKoYFxdTBgKhAFkLfHmwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654475; c=relaxed/simple;
	bh=YNYQVM/L51DWJY0OvsyXHoUNR+JuzDG3udJBdQaFSvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ytjzufm8U36U+tfP4iv1smgwg0C3d6knPHeL0k/jDR4roEkf8Jjgxv3kDFcTLoC7uIBAyjKZE6sIdp8uYrmh7v0+As9xOk/dfFGD4+3TQtntLbbIfhnpcrXjCHcHpDTcChgwOzMq24sodsdwRa5nC7Ho4QITH/tIrtBup8a/VhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NDWCXplO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oswHxpU6mltnB2zZ74eT2tPSM+mIKPwnHucMfdJPczc=; b=NDWCXplOV4i3GbwTqAJ4Z+AN2U
	i5+ZUTs9d6/V39QtrauBOiP+gKSrdzi7on3ryiD13N4Wg0/m7dmOtwVJ8O7kFvqFen7P9RQCuKeuB
	BHLICNoUI7tNh/Hj2+WSqYVrPTXBCmBpT+7uA53EZJWcyV7RubDY3+KeKJJdyzdbagwUwVHF7vd/c
	cetX3+JFEYoQAbBVUjogyUWjpPQY8HDmSklCG5v8BVmPhFN72xHx9/Qnc3UyoSm19KXJtCXOLPsNg
	FhOUB45E2cbGMNGHxTLIEZL9DdrA44Ga1310yAswiKVWgNUClbCPkwB1CX2a+ZE0eJIXRz6eXxbmQ
	BxotKYOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCR-00000005KsS-3Bs2;
	Mon, 23 Jun 2025 04:54:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 23/35] do_move_mount(): take dropping the old mountpoint into attach_recursive_mnt()
Date: Mon, 23 Jun 2025 05:54:16 +0100
Message-ID: <20250623045428.1271612-23-viro@zeniv.linux.org.uk>
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

... and fold it with unhash_mnt() there - there's no need to retain a reference
to old_mp beyond that point, since by then all mountpoints we were going to add
are either explicitly pinned by get_mountpoint() or have stuff already added
to them.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f9b320975cac..912c64d1dd79 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2682,7 +2682,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	}
 
 	if (moving) {
-		unhash_mnt(source_mnt);
+		umount_mnt(source_mnt);
 		mnt_notify_add(source_mnt);
 	} else {
 		if (source_mnt->mnt_ns) {
@@ -3598,7 +3598,7 @@ static int do_move_mount(struct path *old_path,
 	struct mount *p;
 	struct mount *old;
 	struct mount *parent;
-	struct mountpoint *mp, *old_mp;
+	struct mountpoint *mp;
 	int err;
 	bool attached, beneath = flags & MNT_TREE_BENEATH;
 
@@ -3610,7 +3610,6 @@ static int do_move_mount(struct path *old_path,
 	p = real_mount(new_path->mnt);
 	parent = old->mnt_parent;
 	attached = mnt_has_parent(old);
-	old_mp = old->mnt_mp;
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
@@ -3684,8 +3683,6 @@ static int do_move_mount(struct path *old_path,
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


