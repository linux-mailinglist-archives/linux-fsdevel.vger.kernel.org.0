Return-Path: <linux-fsdevel+bounces-48508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F59CAB044E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563F1983E73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2620B221DB9;
	Thu,  8 May 2025 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TJAI0aNG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E23E35976
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734534; cv=none; b=MoL5tmlMxf78gCV0u9Dp+hg7pnPS0E0ZnArOt2YtsZZda+m7UlZpnZsD5CiPPcv1nqmyr70/mSG1ZwL6wwHycvYHOc0m+CkhETBLWaaJhntMefsOxBXIBTUZO2H399+gr5uin3bf2blyXAIaZGD4rWMHOjoydEm+X4091Xxy04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734534; c=relaxed/simple;
	bh=2OVl8xjl03k1TbOrKffSzrGTVOF9sm7cU49HNNPFBj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMNfu8xSbfar8fhwMddUfQ4s8dq2d5TxM7pWAsYfQiyQBgK030ngemzD7PGepCUWLsxOonIUYvxMcC49dzzfbuajt1FxoE6CgPMBVgqTwsPQN1H2uF/VPfnCOyIyxLsbshn4vxLy3dZoddUDThkz7mh8rgMgY3jtJFpgPviIzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TJAI0aNG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YRJc589MYnpaqRN527fTMTXWDsjyRdZV08KBnxs6zko=; b=TJAI0aNGuDhVwi3cbv9GsGQLDP
	wdYCFXStXY9lcCy1tM84h6hxk1A2Sqezk9Ci2UwVtKLRW4MxM31/3auyeegvidr6D7JaeOs2M+UcC
	jm11ITx5oo3IK0by+XoUrgabgM0j40yhg5QGMFKmIBBsPi5WLh+HW8RgTwegtGE3GNbGDhSIQpL4B
	XT+7ttLBXWID9b1XMifqMwVhm7UDFSWxkx0DzoQSOuDidh1/oSorvOSzZWZfNQckSIZVGrdi+uNyt
	Ly+Wl0VuVLU8yywgtVcHXhIAdwFD14tYGQn/w93Esbr2JwZJd/60M1ngG47Gx1zjL9PnzTF3i36vM
	Ym5WS/vw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD7Rb-00000007qM6-2uer;
	Thu, 08 May 2025 20:02:11 +0000
Date: Thu, 8 May 2025 21:02:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/4] do_move_mount(): don't leak MNTNS_PROPAGATING on failures
Message-ID: <20250508200211.GF2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508195916.GC2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

as it is, a failed move_mount(2) from anon namespace breaks
all further propagation into that namespace, including normal
mounts in non-anon namespaces that would otherwise propagate
there.

Fixes: 064fe6e233e8 ("mount: handle mount propagation for detached mount trees")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d8a344d0a80a..04a9bb9f31fa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3715,15 +3715,14 @@ static int do_move_mount(struct path *old_path,
 	if (err)
 		goto out;
 
-	if (is_anon_ns(ns))
-		ns->mntns_flags &= ~MNTNS_PROPAGATING;
-
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old->mnt_expire);
 	if (attached)
 		put_mountpoint(old_mp);
 out:
+	if (is_anon_ns(ns))
+		ns->mntns_flags &= ~MNTNS_PROPAGATING;
 	unlock_mount(mp);
 	if (!err) {
 		if (attached) {
-- 
2.39.5


