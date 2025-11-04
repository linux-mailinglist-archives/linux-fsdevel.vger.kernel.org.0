Return-Path: <linux-fsdevel+bounces-66937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA5EC30EA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C8B18C269C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AFB2F49F0;
	Tue,  4 Nov 2025 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQcDwvG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CD2F2600;
	Tue,  4 Nov 2025 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258365; cv=none; b=TkvxpF9/N3uAlcvPXbeB1SIRoXXj7zIHBp4PV7o0e7pwA6rL/UQY4IQ93PjHcx+fXU7VEGpNmBSJdZgHANjisvpAwUzwQ+nKb7/2KCu467NYI7UyHaySgJhs7xsVHukp1ddLrIBQhhleOlXCwBEGSQwxz/kTLudRikiiroCpwOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258365; c=relaxed/simple;
	bh=uM9WNYPv+qz+o9aMxxxqoxpw66MMshPQdqYJ1k1NrtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBXHSjHpCagJHoTX9a/JciWm33bs8yN2ZVWqZwrtRr9olrauxDmKnVbNmSXAF06wQJNXqZkst0I394R20KYcQ7HFQAdqdFWh3uHzKeuC6tXlFeO6rY6A2qgHFGDJmVFvYpXwRWyqNyebhBzH69V6knCz0RBkduUBk4f5ICS63MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQcDwvG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633C5C4CEF7;
	Tue,  4 Nov 2025 12:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258365;
	bh=uM9WNYPv+qz+o9aMxxxqoxpw66MMshPQdqYJ1k1NrtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OQcDwvG0JObVxfkWJqKAi6U1sxL63ETLtfFxx7G5SZKTOejF6J2i9huIqASS3nuD/
	 KXwvV7S13PsAxoQy4FZgue4NrCtDmyWa0kUxeJSiEMwyA48+gV/8eO5TNYlEuVyz0d
	 Xd0rzjYHtomosk/lXQkmvjcUMsdMBtBNatBLVTTzXOInjm+eZAKGtIFojd3TWmOMBJ
	 CP+m4W6nTJGK7cOzH67QFEKUv75AuiOpTG9FyohM+0wa6Q/65ARRYM4IjMXP+feJ0r
	 cxKyi+CXgJgGO21ynGxtoX2FyG7KWXcprH84RsG6XziAt4RSBNqs/ZkW7PKayuszw4
	 CFCDSZ/5f3vpw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 13:12:32 +0100
Subject: [PATCH RFC 3/8] btrfs: use super write guard
 btrfs_run_defrag_inode()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-guards-v1-3-5108ac78a171@kernel.org>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=828; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uM9WNYPv+qz+o9aMxxxqoxpw66MMshPQdqYJ1k1NrtU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyvt0iP9l4W9jaU79rdKZb3Czvlpq19PcpTo2qW7O4b
 /DwbpNZ3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRVRIM/5SnnXAurZ3SW3z5
 UuyW68tvWVp0J5xwO3n88M/TRm5JebsZ/hlaC8z5MFVj6hRr4TmO65z0jvRVn7/zuivN89y+vSm
 iV5gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/defrag.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 7b277934f66f..35fb8ee164dc 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -254,10 +254,9 @@ static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	range.extent_thresh = defrag->extent_thresh;
 	file_ra_state_init(ra, inode->vfs_inode.i_mapping);
 
-	sb_start_write(fs_info->sb);
-	ret = btrfs_defrag_file(inode, ra, &range, defrag->transid,
-				BTRFS_DEFRAG_BATCH);
-	sb_end_write(fs_info->sb);
+	scoped_guard(super_write, fs_info->sb)
+		ret = btrfs_defrag_file(inode, ra, &range,
+					defrag->transid, BTRFS_DEFRAG_BATCH);
 	iput(&inode->vfs_inode);
 
 	if (ret < 0)

-- 
2.47.3


