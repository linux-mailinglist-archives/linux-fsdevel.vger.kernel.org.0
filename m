Return-Path: <linux-fsdevel+bounces-66936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED62C30E99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B0E18C1751
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F043E2F25E2;
	Tue,  4 Nov 2025 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCScDT/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399EA2F3602;
	Tue,  4 Nov 2025 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258363; cv=none; b=NICuHrfOo53fIyz0vP4Ol1au7nvY2NyS63jifJ/LMcwqXCWu6z/nhjYlMYxgKdS0M6vhiY378djomFhmO3kkSal0m+6+DJCKe9OPpm2GGws/dUBDO4JXyeI4IF7rjv8qU4h1L9ISLJe4hq3kfo9WiHeWjg87lh5+rcF833mZiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258363; c=relaxed/simple;
	bh=ODAaCXkHU96saMrMeqt2w1kbggvsUdeDZpfzfo/cED0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pc2mZ6IBd2Ruz6X/+6sTNTFKtiICs3CY1zSd6R7zP+uPObpibeHXUI3SYUc0DjOHo4SeLZQmP3pM5rker4dMj4cKQHdzpIoExNB47NkLPHhTcujiHQamuMFFNaEdeaJQWAldSwR347owpCxf7fwQ3fWVLGhEtUhXKvoD7uVXqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCScDT/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD27C16AAE;
	Tue,  4 Nov 2025 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258362;
	bh=ODAaCXkHU96saMrMeqt2w1kbggvsUdeDZpfzfo/cED0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NCScDT/skDBPqTG/KJujrRIGMNVi6vaXwks6DLj+tZ7PEwDO6lk5bXDlRiosUtuWq
	 GkU5HDdzMu24jR2JbvRgB09ORukJ4/42rXwdPKQh4FBIhXZWUvjanRNkK/vP6Ru2Hn
	 1FM+k8cvLKsGFIwRNHcX08yFvpiUPMS6yct9+JyCdpfkF++WW/Jd2dxNcN7D0F2Vc3
	 IcZuAI6pCzX/eiNQ/wAmxIiRECPnzFIpyhO1gOR1eED3+3MLgrnO/2PT4LE2LFRuKI
	 thgPS0v1hMBqGJa8iEsRJS3k/PLAF19ytc0et/OS4egQe5CRcsAZ4xsYLvkdgeFufj
	 spSfr0gsDoDXg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 13:12:31 +0100
Subject: [PATCH RFC 2/8] btrfs: use super write guard in
 btrfs_reclaim_bgs_work()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-guards-v1-2-5108ac78a171@kernel.org>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ODAaCXkHU96saMrMeqt2w1kbggvsUdeDZpfzfo/cED0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyvt3itK76UeyEr0V37N9Yv9ta/JnLelaO8I53ib2Hd
 njLGM272VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRFRyMDDN/Pdz8rtB5n1no
 drbyC5qrLI/4t36wa+1J/xkmaaobac/IsPRg4vlaT3WtWUuu1uRPi2SW/fi49PXsT91nbqfP0N2
 mxAgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/block-group.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5322ef2ae015..8284b9435758 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1850,7 +1850,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	if (!btrfs_should_reclaim(fs_info))
 		return;
 
-	sb_start_write(fs_info->sb);
+	guard(super_write)(fs_info->sb);
 
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
 		sb_end_write(fs_info->sb);
@@ -2030,7 +2030,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	list_splice_tail(&retry_list, &fs_info->reclaim_bgs);
 	spin_unlock(&fs_info->unused_bgs_lock);
 	btrfs_exclop_finish(fs_info);
-	sb_end_write(fs_info->sb);
 }
 
 void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)

-- 
2.47.3


