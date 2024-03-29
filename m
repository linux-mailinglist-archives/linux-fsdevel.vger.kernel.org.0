Return-Path: <linux-fsdevel+bounces-15686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D25891EF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 15:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA121C28738
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D571BC9E2;
	Fri, 29 Mar 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqS1TYMU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B01BC9C8;
	Fri, 29 Mar 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716668; cv=none; b=fXraRvLNF9q/3r1PfNWnODchGi5WVtq+p0fBL0+JQHvRp9Hr95lFtRb1h3ZanyEr9GgYOAD7mQj5okmdmo/FwuFlw1edeEumLbvHgV+aqlcAG6VnTBIMFHgzVY8PlFd13DIrIfp0l5EWVT0F1qH03sIabIVk1wLQIABXgToOf4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716668; c=relaxed/simple;
	bh=Ucz+XM0hbFsLrQFA6e6BdC5gIbS3eQZ09830I8HpeXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNPvrvaYZ1EsuJg6603VXl8J6G3q82h7Msoq9u2KiDChciz2X5pFdSEZwUAswjBuGAUtJTURBEttES7Gj/20q1TRacs8IZ3w0SersPBoZx2oIOwa/DSY+xZvjkcAn1YYlk/gs86qisgQsaTPZeJun2p9AYy3IRaRr4VVFFgqQjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqS1TYMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73D0C43394;
	Fri, 29 Mar 2024 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716668;
	bh=Ucz+XM0hbFsLrQFA6e6BdC5gIbS3eQZ09830I8HpeXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqS1TYMUXEvUMSy+AksB0wYh06UhlXBzALXjyzI3V/zk+vUzJa4jUrEkDuArRt7BJ
	 KNfMeNveyiOlclI2czdMfWBCi+vKx20vQbGFc3sZIxriyitvC0nXZEW+YdddDEtnBI
	 /GJ5ZpalNYtLuet+e+A1j8QYaVVohlo+jL9jjpoFakYfZsotZxmnfika4n6nFA/+ne
	 A8kBVYFDz19MxE+q7txWAoj3JABxBhmz38OC1rdLdn1wyvpZgY9nq6nmVF0RsZpYHz
	 O0pee6Byr1SKG8sGVnfY6M82I/SdMFfT9vLDy8CDlGD9pPSTR/QvNg4DVOgaMQKstj
	 bjRG7NpAGs9kQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/19] isofs: handle CDs with bad root inode but good Joliet root directory
Date: Fri, 29 Mar 2024 08:50:37 -0400
Message-ID: <20240329125100.3094358-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: Alex Henrie <alexhenrie24@gmail.com>

[ Upstream commit 4243bf80c79211a8ca2795401add9c4a3b1d37ca ]

I have a CD copy of the original Tom Clancy's Ghost Recon game from
2001. The disc mounts without error on Windows, but on Linux mounting
fails with the message "isofs_fill_super: get root inode failed". The
error originates in isofs_read_inode, which returns -EIO because de_len
is 0. The superblock on this disc appears to be intentionally corrupt as
a form of copy protection.

When the root inode is unusable, instead of giving up immediately, try
to continue with the Joliet file table. This fixes the Ghost Recon CD
and probably other copy-protected CDs too.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20240208022134.451490-1-alexhenrie24@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/isofs/inode.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6e4e2cfd40b9e..aec11a7676c9e 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -910,8 +910,22 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	 * we then decide whether to use the Joliet descriptor.
 	 */
 	inode = isofs_iget(s, sbi->s_firstdatazone, 0);
-	if (IS_ERR(inode))
-		goto out_no_root;
+
+	/*
+	 * Fix for broken CDs with a corrupt root inode but a correct Joliet
+	 * root directory.
+	 */
+	if (IS_ERR(inode)) {
+		if (joliet_level && sbi->s_firstdatazone != first_data_zone) {
+			printk(KERN_NOTICE
+			       "ISOFS: root inode is unusable. "
+			       "Disabling Rock Ridge and switching to Joliet.");
+			sbi->s_rock = 0;
+			inode = NULL;
+		} else {
+			goto out_no_root;
+		}
+	}
 
 	/*
 	 * Fix for broken CDs with Rock Ridge and empty ISO root directory but
-- 
2.43.0


