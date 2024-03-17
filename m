Return-Path: <linux-fsdevel+bounces-14636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05FA87DEE4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDFD1F21A39
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D21CAAE;
	Sun, 17 Mar 2024 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny/Swwi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DF1CA87;
	Sun, 17 Mar 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693527; cv=none; b=fRFmfpyweCr4blbpHBFJuss2LF9NNMw1iSmVkLSce01NA0BN1nL8jkzLsiIKcPYRHaeXiwKcAA+hDs9p75JoeJuV/ikb3Ebzaz4rcqn5iCrV9XhGG9ti/Z5krSdKwOq1qhtJSqAWuKuQogt55YXtVlrPMaezkrP5ss47Q3Xvi/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693527; c=relaxed/simple;
	bh=YonbOlo7kZSrSHU+riF5JjnXy5xT6SgrOFqAqO9Lx1A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5rrVtGxqjx0OKCm+1O3/r/dX848jd1n2Ypnep3NafoCohCV+hr1X1kCgtPZPLuVc3SNwv0FfbPoOVb30NRDvmPseI5KmnKg6FY3ySsuCKEXraa1jS5VjKVVHVnM08bcz/+p//FOImmcaS/rUAhdKvnTtzD/G4vvjhxqv5Iunuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny/Swwi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A9EC433C7;
	Sun, 17 Mar 2024 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693527;
	bh=YonbOlo7kZSrSHU+riF5JjnXy5xT6SgrOFqAqO9Lx1A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ny/Swwi0tvnl6I7rDvXBsh3Rfr7eEL7kxXVBjAg6MZEoK5oKTX0MbDXtY+QV977u/
	 MC6r2lyUiuHoRdKDliGyzuOfPQwfgM9G99P4v3ih0JEbo+D9RA/xXnrxY4xM1VvPIb
	 +sYYuXplXZoMqz/fYx+pnaonYaWYHYEtDsxhlhY/vbhENCEWmRz9T3OWyJXt2Ny975
	 zVJa+Kj1rwbPRr4hB4lSWh6qtczniWk3tC7ZViRH2DdMswfXCccNu51CKGnJl09FhB
	 0cIJQ/0KxijzR56tjwoWb6iPsISxPO9R/b1gu8ECsAGuEUAiKNxfBpZIuFBRkWpKPC
	 6LT2dkwb0i8SQ==
Date: Sun, 17 Mar 2024 09:38:46 -0700
Subject: [PATCH 19/20] xfs_repair: junk fsverity xattrs when unnecessary
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247937.2685643.15009445761715327565.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Remove any fs-verity extended attributes when the filesystem doesn't
support fs-verity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 repair/attr_repair.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)


diff --git a/repair/attr_repair.c b/repair/attr_repair.c
index 9c41cb21..5225950c 100644
--- a/repair/attr_repair.c
+++ b/repair/attr_repair.c
@@ -313,6 +313,13 @@ process_shortform_attr(
 					NULL, currententry->namelen,
 					currententry->valuelen);
 
+		if ((currententry->flags & XFS_ATTR_VERITY) &&
+		    !xfs_has_verity(mp)) {
+			do_warn(
+ _("verity metadata found on filesystem that doesn't support verity\n"));
+			junkit |= 1;
+		}
+
 		remainingspace = remainingspace -
 					xfs_attr_sf_entsize(currententry);
 
@@ -513,6 +520,15 @@ process_leaf_attr_local(
 			return -1;
 		}
 	}
+
+	if ((entry->flags & XFS_ATTR_VERITY) && !xfs_has_verity(mp)) {
+		do_warn(
+ _("verity metadata found in attribute entry %d in attr block %u, inode %"
+   PRIu64 " on filesystem that doesn't support verity\n"),
+				i, da_bno, ino);
+		return -1;
+	}
+
 	return xfs_attr_leaf_entsize_local(local->namelen,
 						be16_to_cpu(local->valuelen));
 }
@@ -549,6 +565,14 @@ process_leaf_attr_remote(
 		return -1;
 	}
 
+	if ((entry->flags & XFS_ATTR_VERITY) && !xfs_has_verity(mp)) {
+		do_warn(
+ _("verity metadata found in attribute entry %d in attr block %u, inode %"
+   PRIu64 " on filesystem that doesn't support verity\n"),
+				i, da_bno, ino);
+		return -1;
+	}
+
 	value = malloc(be32_to_cpu(remotep->valuelen));
 	if (value == NULL) {
 		do_warn(


