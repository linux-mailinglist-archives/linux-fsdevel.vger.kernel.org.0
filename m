Return-Path: <linux-fsdevel+bounces-67051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D75C33914
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D98464F50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5734323E35E;
	Wed,  5 Nov 2025 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYgmGkVm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7A22D7B9;
	Wed,  5 Nov 2025 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304143; cv=none; b=Wv8cpSgTaIqsTXw0BVfxtatle3FxYBJsYRhnZQefcL0whPA8fijiq2MlQLhBTbc+VmBo1cVmQJYW/K32BC0AVbq1pTr04/C6zQmF0SnD379v+dnUKfCXQCtF6CIWqRQOQiC+aIaYxG5pwgj6NfvamB7BvGPTzpNkXUBkcwSwIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304143; c=relaxed/simple;
	bh=i2xs8vhiIib4bZoXTBu0HnLxlrY8DfOSOTtqKk1oIY8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MML+/c49eYcI630utVI4kkNd5O0CtEfHmT1xa5yptkA23ZhKolcquFF6Er1e+bOuAdvkSTG1IBsYWD9hiNx0H0vyYhi9QLRj3K0ElcmjGFo47eBS5PskaksKUv86Bchoh/Di8JeX36yJ/2W425SSuyt8mqwmIFlU9IrQ/jmOow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYgmGkVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB36C116B1;
	Wed,  5 Nov 2025 00:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304143;
	bh=i2xs8vhiIib4bZoXTBu0HnLxlrY8DfOSOTtqKk1oIY8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RYgmGkVmUClYkdAjHYKxBcNvbaGyodjnnWp9rQ6dQ4WsBauNFUXxyxqlj3hwHtiR7
	 /QkETWPVPgYRDgbJ3B87KJE3QxA+jaBaHxNl4ukICecM+QhOeywbDdH9SYchs1wYxn
	 razXh3oQTGICAoRYEUZn+uiZxhybg3c9GbEzE3QhUESbbSW2PllBhDQaoMPZ1qTRy+
	 J0UkGbgOcI7FPPYnQxBFPDj9rqXW7uhzrAcvE0gg+sF/9AjVeX9Im7BcJCsgtj3Uot
	 13KM/XxF1rxz47f1ydq+7pafXlB6UMH93iAraO0DlAvR+y6VYLcCwLZNIxkHwUJYDY
	 NTtg0KJef+bDg==
Date: Tue, 04 Nov 2025 16:55:42 -0800
Subject: [PATCH 6/6] xfs: report fs metadata errors via fsnotify
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 amir73il@gmail.com, jack@suse.cz, gabriel@krisman.be
Message-ID: <176230366563.1647991.7643572351164139083.stgit@frogsfrogsfrogs>
In-Reply-To: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Report filesystem corruption problems to fsnotify.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_health.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index da827060853a8f..0da4ae216dc169 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -71,6 +71,9 @@ xfs_fs_health_update_hook(
 	unsigned int			old_mask,
 	unsigned int			new_mask)
 {
+	if (op != XFS_HEALTHUP_HEALTHY && new_mask)
+		sb_error(mp->m_super, -EFSCORRUPTED);
+
 	if (xfs_hooks_switched_on(&xfs_health_hooks_switch)) {
 		struct xfs_health_update_params	p = {
 			.domain		= XFS_HEALTHUP_FS,
@@ -91,13 +94,17 @@ xfs_group_health_update_hook(
 	unsigned int			old_mask,
 	unsigned int			new_mask)
 {
+	struct xfs_mount		*mp = xg->xg_mount;
+
+	if (op != XFS_HEALTHUP_HEALTHY && new_mask)
+		sb_error(mp->m_super, -EFSCORRUPTED);
+
 	if (xfs_hooks_switched_on(&xfs_health_hooks_switch)) {
 		struct xfs_health_update_params	p = {
 			.old_mask	= old_mask,
 			.new_mask	= new_mask,
 			.group		= xg->xg_gno,
 		};
-		struct xfs_mount	*mp = xg->xg_mount;
 
 		switch (xg->xg_type) {
 		case XG_TYPE_AG:
@@ -124,6 +131,9 @@ xfs_inode_health_update_hook(
 	unsigned int			old_mask,
 	unsigned int			new_mask)
 {
+	if (op != XFS_HEALTHUP_HEALTHY && new_mask)
+		inode_error(VFS_I(ip), FSERR_METADATA, 0, 0, -EFSCORRUPTED);
+
 	if (xfs_hooks_switched_on(&xfs_health_hooks_switch)) {
 		struct xfs_health_update_params	p = {
 			.domain		= XFS_HEALTHUP_INODE,


