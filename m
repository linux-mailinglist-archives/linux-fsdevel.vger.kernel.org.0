Return-Path: <linux-fsdevel+bounces-14624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3336F87DEC6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34C11F21290
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E590763B3;
	Sun, 17 Mar 2024 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFg7iv+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0481B949;
	Sun, 17 Mar 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693340; cv=none; b=R1isCBiMKqO7PFeUC45IfMgjJEPul/I6CuiRNvkc8FpFeC5WKrjb2Mk57uZgtKADCkKBR9pwB+dc8tspAYqX2/9jUbNQOOdAwbUNJW7FP32bBcKr1ztIOVf0Nblv8FJ8hbLJfmbe6UUeBfUh67mgUS+dKa5xL0whv1atycggq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693340; c=relaxed/simple;
	bh=U2hq3956kXMhaD85lR2Oe+rbf3mpdLcXYo9vZrv7R0w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWC2bHiB5J5XS1etlNrlcpgtW5lwIGcWTNO1ampzQ1jUzRHpusjbVwG+5R5ICHTiJdglg1LhLWzg5XJuOGHi5kVuZAnRf5xfszBR5fj8UVDXmHca7YNgkgS9i5knaSXK8RjOH4j+m+kVZ0hgp0xX8rT8rychuSYiHmzBbzxHtRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFg7iv+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7358C433F1;
	Sun, 17 Mar 2024 16:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693339;
	bh=U2hq3956kXMhaD85lR2Oe+rbf3mpdLcXYo9vZrv7R0w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dFg7iv+WtFDChcz599w2LQQfbi+V9MF46O+k1I7kag3u3k6eUEP7mnc8rZm/lF57p
	 185hT6mJ2T/DnykAvquc/xnCKGE9U1MQ43uwwUsd8igJ9ySuZ1lFEOT0s0lTz3fXpn
	 etfWsWFJkia86VoSSgEUOHs8IeajWGtvAgF8vdq0bJlAgHDEhobdW/iOQpkSOuvTtc
	 /Sl4ZsFYd+3SgTAhbmi9XM+88pA3Uuinjul649mXJ2vhGrwciKdiWae8EyVZfaYYvW
	 j9NivLQGW0y7dAbhZ7P5Zvz1NKMWn8Dn8XqkVXYZ83nuiytTJakKDQfPrJSlpK03NM
	 Kmektm47EWE7Q==
Date: Sun, 17 Mar 2024 09:35:39 -0700
Subject: [PATCH 07/20] xfs: add inode on-disk VERITY flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247772.2685643.1544897659577123663.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

Source kernel commit: ff6c7e66f70cb7239fcc6a1011f47132091d679e

Add flag to mark inodes which have fs-verity enabled on them (i.e.
descriptor exist and tree is built).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 libxfs/xfs_format.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/libxfs/xfs_format.h b/libxfs/xfs_format.h
index 93d280eb..3ce29021 100644
--- a/libxfs/xfs_format.h
+++ b/libxfs/xfs_format.h
@@ -1085,16 +1085,18 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+#define XFS_DIFLAG2_VERITY_BIT	5	/* inode sealed by fsverity */
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_VERITY	(1 << XFS_DIFLAG2_VERITY_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_VERITY)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {


