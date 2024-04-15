Return-Path: <linux-fsdevel+bounces-16983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566418A5E88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B814DB2109E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4947A159210;
	Mon, 15 Apr 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig08t2Lf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD7156967;
	Mon, 15 Apr 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224433; cv=none; b=VMmcVoT7+7+Fef2oN8+o2HjlU05Ua/wQJRwYp+ODFP3ME+LrS+HTXYM5K7riq/aO7monNeo0By50qa2BTof7ET9fDfbNUOcHzKm1ppfro5Y9ZN1rLRcFEBVMXG1mmEwm9kdXM4VYf6ZLAuDxqmW+6H6s+N81d2Cg1fejOlGtHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224433; c=relaxed/simple;
	bh=s9Lrin2PDZHmLMJblPo0jKJyeb8hr7q2u4ke3Gax8cE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwSB6KkA89Kz8zLCopntKCyinZtuLrHjVjX9neLvg44k7nWMqLxhpALlDYag6ebdUUn5wIN2E1JYfpy6T/PLA/CQwrJJfUFayWr00dKbeWGqO3ThEubgPyIE6Jac4eCQONh91wbiWUOhTUHL7AsbaFjNr1anoA60tVYS8MOb5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig08t2Lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A77DC113CC;
	Mon, 15 Apr 2024 23:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224433;
	bh=s9Lrin2PDZHmLMJblPo0jKJyeb8hr7q2u4ke3Gax8cE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ig08t2LfgC5rprFLDBIu7wwuU7OM8JJHtqXviaKGbYfpYXU9qPLDuiPudTk+g+BHp
	 ywKXSMJ7pVzCy+TdI6Oh81RilP3Fq9Sf2ftOiDnSRyz2h28x+QgFT25YemZZ4STxyo
	 nWrEX/r24QTwS9v4TnddLJ/BQ/wBO5NH31P+Su00cHBLu9IBgk1MeI5JVMsgNGKURZ
	 emoU+/IbW6c3NL877vmZbtQFU76eEwFrecFFMqyLrJTOKouZLSDk4NArGW7E5b7wBR
	 XAP0J9XrYjze61G6Ty5t6BgvsJ2FCDdAOzTPNkfVweiptwxMKIlrLpL96UjwHKFOee
	 Dl/UtLQaw3pWg==
Date: Mon, 15 Apr 2024 16:40:32 -0700
Subject: [PATCH 6/7] xfs: refactor non-power-of-two alignment checks
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322380829.87068.17230248734549992834.stgit@frogsfrogsfrogs>
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

Create a helper function that can compute if a 64-bit number is an
integer multiple of a 32-bit number, where the 32-bit number is not
required to be an even power of two.  This is needed for some new code
for the realtime device, where we can set 37k allocation units and then
have to remap them.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  |   12 +++---------
 fs/xfs/xfs_linux.h |    5 +++++
 2 files changed, 8 insertions(+), 9 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 64278f8acaee..d1d4158441bd 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -47,15 +47,9 @@ xfs_is_falloc_aligned(
 {
 	unsigned int		alloc_unit = xfs_inode_alloc_unitsize(ip);
 
-	if (!is_power_of_2(alloc_unit)) {
-		u32	mod;
-
-		div_u64_rem(pos, alloc_unit, &mod);
-		if (mod)
-			return false;
-		div_u64_rem(len, alloc_unit, &mod);
-		return mod == 0;
-	}
+	if (!is_power_of_2(alloc_unit))
+		return isaligned_64(pos, alloc_unit) &&
+		       isaligned_64(len, alloc_unit);
 
 	return !((pos | len) & (alloc_unit - 1));
 }
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 8f07c9f6157f..ac355328121a 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -198,6 +198,11 @@ static inline uint64_t howmany_64(uint64_t x, uint32_t y)
 	return x;
 }
 
+static inline bool isaligned_64(uint64_t x, uint32_t y)
+{
+	return do_div(x, y) == 0;
+}
+
 /* If @b is a power of 2, return log2(b).  Else return -1. */
 static inline int8_t log2_if_power2(unsigned long b)
 {


