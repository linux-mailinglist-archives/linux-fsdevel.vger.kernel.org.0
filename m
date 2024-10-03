Return-Path: <linux-fsdevel+bounces-30896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268DD98F22B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 17:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5871A1C21485
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84F1A0726;
	Thu,  3 Oct 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqP/QS71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1660D1E52C;
	Thu,  3 Oct 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968142; cv=none; b=gY+qq/TQ6GrX5M06hw6ljxKXByYakkJaaZ1dDjj3A3XjPS37l+le+hebgZpHFLdAJJUNRgKPVBAi97PXZTWb5BFzV0ILNrSDFMjHAUgcUh0VtYvPk5ElwOHUgdRDajXWw+6I579QYJG2rdnSlYZ9ijW97d+rXTzZq44jiqcoGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968142; c=relaxed/simple;
	bh=NCjc18fQlwrCcRl2m64OcTUP4xeLduMqkrR3YMLjeSQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8eA9ccggku3UDe4jBzSmzH1P0HpfFIWN/9/VzWCxfzq5qAI4y2IoaDebFH8dbbm+rRx4pWUK5e6Wk6MbUxlLtvXJQh1tJ39eRlUKolwdK+/ZrodCy4FIrxSTqrDoKZlWA1H7z9ZZXQ4WWiqAPvPxo4vq8+sTuv9bhBH1estxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqP/QS71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E44FC4CEC5;
	Thu,  3 Oct 2024 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727968141;
	bh=NCjc18fQlwrCcRl2m64OcTUP4xeLduMqkrR3YMLjeSQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OqP/QS71ze71nh3zmfa47RLHrWp0Hnx1nODSS07rfHE9pyTe8KkNbiqmt7oifktgh
	 OZcIn6QH5FEdYUtiMsUZEM4jFMl3rhcVjJSSWw0cMsp11S19fL69wfmpqsQtwVw5VR
	 S0aiQcDeCuHku/cuSpWtrb26b/GsUXWajcIWp2gKRMS74Tgvf26jaFsH+8J9Ys1qFZ
	 XgjyVyfFBr+5flK7qSEyRMfOMBvG/vZj6FJKBzBuJp5F3xx6h3eRggcLanY31kWmu7
	 BD8C476i8nThQKH/Yvsvu3WBDe6aUicMGbNAs7M04//gsGtU/BtZWFj1CfgELjolju
	 SKSY4s6i2XPCA==
Date: Thu, 03 Oct 2024 08:09:01 -0700
Subject: [PATCH 1/4] xfs: don't allocate COW extents when unsharing a hole
From: "Darrick J. Wong" <djwong@kernel.org>
To: willy@infradead.org, brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: ruansy.fnst@fujitsu.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <172796813277.1131942.5486112889531210260.stgit@frogsfrogsfrogs>
In-Reply-To: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
References: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
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

It doesn't make sense to allocate a COW extent when unsharing a hole
because holes cannot be shared.

Fixes: 1f1397b7218d7 ("xfs: don't allocate into the data fork for an unshare request")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 1e11f48814c0..dc0443848485 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -707,7 +707,7 @@ imap_needs_cow(
 		return false;
 
 	/* when zeroing we don't have to COW holes or unwritten extents */
-	if (flags & IOMAP_ZERO) {
+	if (flags & (IOMAP_UNSHARE | IOMAP_ZERO)) {
 		if (!nimaps ||
 		    imap->br_startblock == HOLESTARTBLOCK ||
 		    imap->br_state == XFS_EXT_UNWRITTEN)


