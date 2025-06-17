Return-Path: <linux-fsdevel+bounces-51851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66EADC226
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 08:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DE4176033
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718AF28C5AF;
	Tue, 17 Jun 2025 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0SrVpkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54B28B7C8;
	Tue, 17 Jun 2025 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750140692; cv=none; b=g8MuOga/qDCIVivY+0IFH6vFmiSwEbKVpKE5iYg4waYt5G+aL8uSuyCn+Dc1vVhBHTbPh0l6DnNBJ6DHqTSbyXUbpN+VSnu18lQV6eZ6xZDS+0CKyU3cgd9phrAHGrC3GaKWlQenz2zx3XkIpKwUoIhJ2aUkyC+/ZVF/EHBo5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750140692; c=relaxed/simple;
	bh=WGXBCdIhrRQgnhx+v3v9M3OHAqARRicRAUBwy8RZfxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHOr8QeiMZP9S1POczrDrnBTZRdHuN76jhzOPczQHvd6xwjbdb+gGFj6iyeXzyRis5VMbanCGNnvzyKyv4JiigjkZJP8ZFlab+b4OUGFxUjpPLqDQZuwWwvIlI5+yk3FZani1V6wN1MDUKEp+5dayeZS+YOFJ7+z2/4m7V6rhyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0SrVpkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D03C4CEE3;
	Tue, 17 Jun 2025 06:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750140692;
	bh=WGXBCdIhrRQgnhx+v3v9M3OHAqARRicRAUBwy8RZfxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0SrVpkqKMUohXQBrausf95FECjL9Jm8y/Tv44i/VhBTMs+8S+NyWCGjgVBn+dzo9
	 GdcbMqrgp2ExOMvFXY1imnfLrYH0AAw1IJoUWP0fqVK+pckO/wnybMLEqdr6wftKzr
	 wkinVaQVhpDO9X+d2b+yT19RGYTIhyIVx6xygR/B7c+FyjUiNaX/HxxezbQZFO9Dw4
	 hiBPS+5JI6oNsfrymbp0P7C0FhRLhzZAxauiLPup7K5SkuzCg4J7wyGKBfldqcMaYA
	 J2ES88cZgXv7HIVgaay9BokCF6D1HesYuJqDS9Wp5S14DOjtxKz/bQJbplipojj4Ym
	 Ni0DFYUgF2lXg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	m@maowtm.org,
	neil@brown.name,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 2/5] landlock: Use path_walk_parent()
Date: Mon, 16 Jun 2025 23:11:13 -0700
Message-ID: <20250617061116.3681325-3-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617061116.3681325-1-song@kernel.org>
References: <20250617061116.3681325-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use path_walk_parent() to walk a path up to its parent.

No functional changes intended.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/landlock/fs.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..e26ab8c34dd4 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -837,8 +837,8 @@ static bool is_access_to_paths_allowed(
 	 * restriction.
 	 */
 	while (true) {
-		struct dentry *parent_dentry;
 		const struct landlock_rule *rule;
+		struct path root = {};
 
 		/*
 		 * If at least all accesses allowed on the destination are
@@ -895,34 +895,20 @@ static bool is_access_to_paths_allowed(
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
 			break;
-jump_up:
-		if (walker_path.dentry == walker_path.mnt->mnt_root) {
-			if (follow_up(&walker_path)) {
-				/* Ignores hidden mount points. */
-				goto jump_up;
-			} else {
-				/*
-				 * Stops at the real root.  Denies access
-				 * because not all layers have granted access.
-				 */
-				break;
-			}
-		}
-		if (unlikely(IS_ROOT(walker_path.dentry))) {
+
+		if (unlikely(IS_ROOT(walker_path.dentry)) &&
+		    (walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
 			/*
 			 * Stops at disconnected root directories.  Only allows
 			 * access to internal filesystems (e.g. nsfs, which is
 			 * reachable through /proc/<pid>/ns/<namespace>).
 			 */
-			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
-				allowed_parent1 = true;
-				allowed_parent2 = true;
-			}
+			allowed_parent1 = true;
+			allowed_parent2 = true;
 			break;
 		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
-		walker_path.dentry = parent_dentry;
+		if (path_walk_parent(&walker_path, &root))
+			break;
 	}
 	path_put(&walker_path);
 
-- 
2.47.1


