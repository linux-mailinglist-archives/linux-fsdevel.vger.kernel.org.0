Return-Path: <linux-fsdevel+bounces-66942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CCAC30EE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF57E18C4954
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D2C2F691B;
	Tue,  4 Nov 2025 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBP4zSsG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211D2F0678;
	Tue,  4 Nov 2025 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258375; cv=none; b=Y1K2ZP9xpRhF6vYegX0V63yyRJOtnjjziyna60J+lcZxuVluoM8/I5vC63AAeKPe2cxThKpotFjks+O6FVG4bdE4O9RI5ns//cmho/W+QsmdeYPnYg9MAJY33vQd67RVGQ8auAchung8L2iV+sXOikLRGrvch7JHIjWeIbep/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258375; c=relaxed/simple;
	bh=kR8Z8OF/ahXDqF23C6zmufbL5GXpgAqkpWaYruiALN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UlgoozUTNtxZX3U+2cSMh3IE95BwyqaC2k5Mw2ialHDyj4a6FYj9e1iiLG26qHNwLACW02m0C8KFgkHgkiYwu+4v+q9d/QgiQ1QMJNcq1hZjXB1fVNoXq4+4YHWPePm9N0DPzfML2NIBz+XVTJVdxRr4D0dOnZtyqBT6mQ6x890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBP4zSsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9EEC116B1;
	Tue,  4 Nov 2025 12:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258375;
	bh=kR8Z8OF/ahXDqF23C6zmufbL5GXpgAqkpWaYruiALN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oBP4zSsGw8wowc4XqtFOYCnckBmr4cX5U/RYdTuO2TbvvSdSdU7PT7lcI0IXgkI53
	 ClksvAgQEI+Aa0+idRx8cfBB52FwIgnR2vorXUsJizGnIHq5/mUvDmkM49fhS7EMvN
	 JqiRN7O54Jx03eYcybYsqyCcvwCQIWG5RvTYSna8JSmPgI7bDkKVbFx4/Vi9CuRgws
	 Rur+/EhzNfM1WiyJS5tWV68thGBBYRJSa5T0+I63cgDsCl8rSvzjy8CEx9f07SkGJI
	 btQ+WYx8LYQilJAyYZpAZdwdNQ6f6pHkjCtVFNoaq5TQYTweMuztR0rhkt0MHW5vY2
	 iNJCWbjRtO6sA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 13:12:37 +0100
Subject: [PATCH RFC 8/8] xfs: use super write guard in xfs_file_ioctl()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-guards-v1-8-5108ac78a171@kernel.org>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=663; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kR8Z8OF/ahXDqF23C6zmufbL5GXpgAqkpWaYruiALN8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyvt1ya/8qxQsS/xbm5Ozmn/lGWHRL9+kXfRMSqo/Yn
 zZXW5oV1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARxeWMDCf/nTB4KBtxb/aR
 syF/TH9smHRVzivBj8/WJOXDzItn30gw/E/SnMboyDtj2fUPtRbXbipKnd/baPYyyLdN5MK1iQL
 /N/ABAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xfs/xfs_ioctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index a6bb7ee7a27a..f72e96f54cb5 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1408,10 +1408,8 @@ xfs_file_ioctl(
 
 		trace_xfs_ioc_free_eofblocks(mp, &icw, _RET_IP_);
 
-		sb_start_write(mp->m_super);
-		error = xfs_blockgc_free_space(mp, &icw);
-		sb_end_write(mp->m_super);
-		return error;
+		scoped_guard(super_write, mp->m_super)
+			return xfs_blockgc_free_space(mp, &icw);
 	}
 
 	case XFS_IOC_EXCHANGE_RANGE:

-- 
2.47.3


