Return-Path: <linux-fsdevel+bounces-15684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D4892085
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 16:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E47B319E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE9816D4C7;
	Fri, 29 Mar 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OulgjE3S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0157713BC18;
	Fri, 29 Mar 2024 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716556; cv=none; b=RDDox4kyPYLJEbDhIDsb9+mbiLUCFjJWxO0wdAwffydVlqJzPFUC28v7WarBJ7L1SGBiCv6o3jwHu1SOCUIgEc8LA5pt4PorgoHN9tazAw/NuP0mRikQFkRnppC8AELQg8EO3qs4IEK7q0h5yC6yVkWXmAYybfxvYl8Rs1v9OcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716556; c=relaxed/simple;
	bh=wzk59FqyF6t2KvA8CfmMh5ViAbUa2Q0T9D7Zmx1Jx0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToegHuPZaCHyR14OuLoHnqseCnbybcfGNRTa50/kU8TVo2xu5rrL6QgC9shJehuXAJXrYvGwsbRmJe2bh16iYIZFScVDrBnnBCA78r923AQkUCozP9ygNPGpvaJAgFzbcwf0QXmwtT+Q71vY3H0oUEXITZpP0K93DJ1GGIJMTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OulgjE3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC818C433F1;
	Fri, 29 Mar 2024 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716555;
	bh=wzk59FqyF6t2KvA8CfmMh5ViAbUa2Q0T9D7Zmx1Jx0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OulgjE3SjDKPAX8pIFwZVzpBsI5hWbPssvt7dGokCaj5FvuHdXKGp1qOgrjgHoD9W
	 EjZ+4dxcovFgErT79DzbqE0sjruOFyU6NTAQ9PwbUZtdB1L9YcaTTRyxd6dPBEnWty
	 b5/tGb1tf+PQdBUCkxrRlFXrj+b7JBDLXB4arHlybwed1jO11aHEQkauuy1b1AT+PJ
	 0V2PyLm/9Y+tNTS6qLCxu0DVusaoJa8lsgXkeErVArHSMVMe8S0+tiZlYTI0TweTiN
	 6BWByVUOf2IUL6eIX0FIYAw+zhhp56uLs/MA0/avJRllyj2DzRm96Xq/3JZbQkx6NW
	 fGiQupIe6+9Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/31] isofs: handle CDs with bad root inode but good Joliet root directory
Date: Fri, 29 Mar 2024 08:48:25 -0400
Message-ID: <20240329124903.3093161-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index f62b5a5015668..4c763f573faf3 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -907,8 +907,22 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
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


