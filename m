Return-Path: <linux-fsdevel+bounces-50541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2CAACD033
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E0E3A7829
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC7824DCFB;
	Tue,  3 Jun 2025 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iQzBAypH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0E22A4EB
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992815; cv=none; b=nCh8aWUeJpqev1U1PbvpKyo3RTcCKATdgE+iB4jrpWyWYIx3z9xssMZJpnRjdbtDNCNtdsrxdTq2HQJL1gea2r+K5uJ7pkixO0K9Rvb21B35+xPxAONKt1eSTbod6BhImZxOHmUzQDqdMXXEn2T6GGCQs77FNtl1B3fvXYzJwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992815; c=relaxed/simple;
	bh=RyUPhQ3akfp8bc46br4PtCJq74lAxPAytpwuvAq6ZHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/UcOXloQ+ufZ61AK0b5GZPpnd0u7lH4K0Y8UPrewa56AWEMsCBY0F2AI3R3tVJhYJESxQmAp+aI4TIYOnR6O7BPRWbXHfGylYapoMBYd2y3UZTfDDCW/OeO/ZBDlqO2kgEQSz19ojSumeddZWdWGKgjMKsBJyZrOd/7DEI0PsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iQzBAypH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=39mZDOhwrVizuaRQCiolW2K0mYUA86LpPExzvFxeoPA=; b=iQzBAypHJAuziGCDuPjl5hh6ZN
	/tMlOX/Fq2nznvKsbHoZEfRz6UnVUtQCd/+8mudIP4TSULEvPI6xZN/e6tmeuMURO/8beGdd5FeIB
	djN68oEnwbdFauV4YAolmYYb1uitL2NKRa7AjLSAPU30F5i/ARYmula1DIAwzEymqnxsvKZYXknxC
	0wBGUI1fDrHyLE9cuxLVdhPlhrlymT0Ij7diCID4+4whp98qQ5q0bhErJP9sh0NC30JrkzQdvTfEg
	dxJgDLphylodMNsoJWmgyg2ZQOlCmSJewx01hG7psiof8RAzQ5JUVehfgGxMWgfU2eMECAQOO3rbX
	8PmXTORA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMavT-00000000dW9-0QGT;
	Tue, 03 Jun 2025 23:20:11 +0000
Date: Wed, 4 Jun 2025 00:20:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kazuma Kondo <kazuma-kondo@nec.com>
Subject: [PATCH 5/5] fs: allow clone_private_mount() for a path on real rootfs
Message-ID: <20250603232011.GE145532@ZenIV>
References: <20250603231500.GC299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603231500.GC299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

From: =?UTF-8?q?KONDO=20KAZUMA=28=E8=BF=91=E8=97=A4=E3=80=80=E5=92=8C?=
 =?UTF-8?q?=E7=9C=9F=29?= <kazuma-kondo@nec.com>

Mounting overlayfs with a directory on real rootfs (initramfs)
as upperdir has failed with following message since commit
db04662e2f4f ("fs: allow detached mounts in clone_private_mount()").

  [    4.080134] overlayfs: failed to clone upperpath

Overlayfs mount uses clone_private_mount() to create internal mount
for the underlying layers.

The commit made clone_private_mount() reject real rootfs because
it does not have a parent mount and is in the initial mount namespace,
that is not an anonymous mount namespace.

This issue can be fixed by modifying the permission check
of clone_private_mount() following [1].

Fixes: db04662e2f4f ("fs: allow detached mounts in clone_private_mount()")
Link: https://lore.kernel.org/all/20250514190252.GQ2023217@ZenIV/ [1]
Link: https://lore.kernel.org/all/20250506194849.GT2023217@ZenIV/
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Kazuma Kondo <kazuma-kondo@nec.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6c94ecbe2c2c..854099aafed5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2493,18 +2493,19 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	if (IS_MNT_UNBINDABLE(old_mnt))
 		return ERR_PTR(-EINVAL);
 
-	if (mnt_has_parent(old_mnt)) {
-		if (!check_mnt(old_mnt))
-			return ERR_PTR(-EINVAL);
-	} else {
-		if (!is_mounted(&old_mnt->mnt))
-			return ERR_PTR(-EINVAL);
-
-		/* Make sure this isn't something purely kernel internal. */
-		if (!is_anon_ns(old_mnt->mnt_ns))
+	/*
+	 * Make sure the source mount is acceptable.
+	 * Anything mounted in our mount namespace is allowed.
+	 * Otherwise, it must be the root of an anonymous mount
+	 * namespace, and we need to make sure no namespace
+	 * loops get created.
+	 */
+	if (!check_mnt(old_mnt)) {
+		if (!is_mounted(&old_mnt->mnt) ||
+			!is_anon_ns(old_mnt->mnt_ns) ||
+			mnt_has_parent(old_mnt))
 			return ERR_PTR(-EINVAL);
 
-		/* Make sure we don't create mount namespace loops. */
 		if (!check_for_nsfs_mounts(old_mnt))
 			return ERR_PTR(-EINVAL);
 	}
-- 
2.39.5


