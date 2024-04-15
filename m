Return-Path: <linux-fsdevel+bounces-16984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B068A5E8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F80B1C20A33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89411159208;
	Mon, 15 Apr 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4ZphCCs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60FF156974;
	Mon, 15 Apr 2024 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224449; cv=none; b=R9r1QJWkUQ6wdA29CscwIMkFfdBXTErVZpBuXQ52jq+1IEHkqKPmTYGPzBbEfpPZLrYlY7IIXg4KvbBtiuCsSlVTJwkuW+XTtsv0r4P08jysNf4fjOJEEY6WGQhV38KlcvvOxh5Xm72sFOUmKdn5SSPw4T31g52iZejq86i1TH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224449; c=relaxed/simple;
	bh=HZkXKS0k4m9TwOFEmNgVrgvvVnPZFP1r1oDEwMc9+pk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrZlcZ/Wf6NDHIuSGUogc6j7NsJE+nAmA3J6JiGxMUns4Xge7j86GqjynvUb1WRYXSqwVjtU4h+kT///vQ6eRriANPjQFier9ppl3cdA7HK/xOqeJqyPQ0sRm1o1cfuRHVycP985ZrN20/iIl8ZcdTLzZ8gNdNKAVL+NK2CpFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4ZphCCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E96C113CC;
	Mon, 15 Apr 2024 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224448;
	bh=HZkXKS0k4m9TwOFEmNgVrgvvVnPZFP1r1oDEwMc9+pk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=f4ZphCCsY89UWLPJ6gBCEjq/3w1ZOQxo/KhTDd91R/wSru+ZShJLnJZgUL2i09ci+
	 7e2JFaFleLCfsG6J1DVMUzWKb9+V7XoRKz7sMckC2eiI2MjzkyITMFmIWCRtlMqjcm
	 5S3TMICyXPw51gM9fRF9QAWSUcxwPjDrM8UaueIBS+9kD4TqwaOvTCLL3f8B2q5MWS
	 K/y3zSZxMYKf7jl8Df6Qek1RkiOrMrYUScrgs5qUKf7dnCKwT3wM9xyIJybGGG5Cb9
	 3u7WbIekR65c5f/qF5mj15N0SKUmn5QYM/iI9JNVq++ejIwzRygAb491lkeSJHExhw
	 DQscIVbdz5Epw==
Date: Mon, 15 Apr 2024 16:40:48 -0700
Subject: [PATCH 7/7] xfs: constify xfs_bmap_is_written_extent
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322380846.87068.9673983859392153004.stgit@frogsfrogsfrogs>
In-Reply-To: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
References: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
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

This predicate doesn't modify the structure that's being passed in, so
we can mark it const.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_bmap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index f7662595309d..b8bdbf1560e6 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -158,7 +158,7 @@ static inline bool xfs_bmap_is_real_extent(const struct xfs_bmbt_irec *irec)
  * Return true if the extent is a real, allocated extent, or false if it is  a
  * delayed allocation, and unwritten extent or a hole.
  */
-static inline bool xfs_bmap_is_written_extent(struct xfs_bmbt_irec *irec)
+static inline bool xfs_bmap_is_written_extent(const struct xfs_bmbt_irec *irec)
 {
 	return xfs_bmap_is_real_extent(irec) &&
 	       irec->br_state != XFS_EXT_UNWRITTEN;


