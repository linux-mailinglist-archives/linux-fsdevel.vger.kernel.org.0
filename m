Return-Path: <linux-fsdevel+bounces-18284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99008B6904
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FAC1F2184C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83810A3E;
	Tue, 30 Apr 2024 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyf5WJjc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722B101CE;
	Tue, 30 Apr 2024 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448292; cv=none; b=SsZ6dNQF4NiI9RcVkWAVDY1r4t2wOD/3nmnyM+C8k7NrzpS1Hv+rTwGNc526+LkfjGvHjWdhVgO7KTJFHXPGlbOUSqnP56B9srTTFWOt4GAv2BqajnRhBJLxuRbZHqHQyROhwYjwLa/F7AxWGJcg8dMfWW/1GXbZvu56aMQ3O8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448292; c=relaxed/simple;
	bh=Fx+iBR1INLeZPQ429XVKohGIqa4/fizPIT+AcDKitok=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bhs6JqVF6hBCfvTEpDtkrdier7rkYJb+8cgwluGZKjOXahm2CKrtyhCCdwQ6u5mQE3Tnt3EanQtVnSZ34InNP7hsMRwqfxL63QeLovWFhkVt0WRoykSJ4J0SG3kVzh1EN8qEbUwU5TpJCOHZtr5U1w2Z0+NLIzK3XCER4CHuuwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyf5WJjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9424C116B1;
	Tue, 30 Apr 2024 03:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448291;
	bh=Fx+iBR1INLeZPQ429XVKohGIqa4/fizPIT+AcDKitok=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Nyf5WJjcPe7aqrEvJCWoPf9pA3BK8ikVkdwhwKudfZsqVWXuXKMgF4ceq+gbI+ZNv
	 3lD2k8V3rT8SlXZJ423hnJN0ZiSBIpvmcSa7ba1C71CndAsrK87VUZOgsshCgMh94i
	 6d7JCdXfdgxOaB0aTK/kJm1a2iOz1NA6ALs7ZClqzL7P/UTxqMmFDFsroIanx1qlDf
	 Y42CHDVJ+cAGmSWx/eWo9Z/r/4flqoP4IHbM5gXEwJl5Ea8frNi3E+dtT0KCWbvVcA
	 0E9NMTQwUw58zQ0l5BS89LTl0x43WJ94iFjUDB+ofASXj4plThW4/lDNFcXLqorlLY
	 x7TA/vhlwBrTw==
Date: Mon, 29 Apr 2024 20:38:11 -0700
Subject: [PATCH 28/38] xfs_repair: junk fsverity xattrs when unnecessary
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683541.960383.2565362271938349523.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
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
 repair/attr_repair.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)


diff --git a/repair/attr_repair.c b/repair/attr_repair.c
index 227e5dbcd016..898eb3edfd12 100644
--- a/repair/attr_repair.c
+++ b/repair/attr_repair.c
@@ -334,6 +334,13 @@ process_shortform_attr(
 			junkit |= 1;
 		}
 
+		if ((currententry->flags & XFS_ATTR_VERITY) &&
+		    !xfs_has_verity(mp)) {
+			do_warn(
+ _("verity metadata found on filesystem that doesn't support verity\n"));
+			junkit |= 1;
+		}
+
 		remainingspace = remainingspace -
 					xfs_attr_sf_entsize(currententry);
 
@@ -543,6 +550,14 @@ process_leaf_attr_local(
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
 	return xfs_attr_leaf_entsize_local(local->namelen,
 						be16_to_cpu(local->valuelen));
 }
@@ -592,6 +607,14 @@ process_leaf_attr_remote(
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


