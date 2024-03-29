Return-Path: <linux-fsdevel+bounces-15685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A6891EBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 15:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E61F27C7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B561B6266;
	Fri, 29 Mar 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMPMTzS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3713A3F4;
	Fri, 29 Mar 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716621; cv=none; b=THenFaAZXTePn75Hv0SCrZzy2fp4SV224Pm3raWfvXo4Zwst+66Ao7C+wF1ZAEp2609uMa4uLKAEFrPmpCKHqONNpPSdplUS//2hPCh7RLuRskPiAJ99inDjGmHWpWT/Z0M8zXTA7wcdkUecUhaXv7ZkSP3SlwQzzRdmxW0ltMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716621; c=relaxed/simple;
	bh=D+ZXDrFMuuWbejT/nbfJPc0TsJqe2vEksn/ftcPCOEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebNM+326J/ouAOqbJ8oYq/sMKLwjf/4tnSz9TvsOUQrpZphnj68qg4zQKJREWxTxxusj38K4//EjD+RrbtGrxc0fgjbRhBeHy9gJKazEBxJXfSD3497pCJQeb7Cy17ocixjk4Lfw/3VK4PYGluC1BjkrzQlmJD8zrmDjJe8gZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMPMTzS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38259C43390;
	Fri, 29 Mar 2024 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716620;
	bh=D+ZXDrFMuuWbejT/nbfJPc0TsJqe2vEksn/ftcPCOEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMPMTzS9r9xJmMVQ++Y7p+etuiwNRX5gi/jjTrXFY3FLPU6+uOYyQOqk4y8IfMeGK
	 Py7Y2JuT+sxkhO5JIlpUMT0uzNaOxOat0jfXG9YihiXCJBXUmSeCFPrN8+n2+sR1yp
	 ktCf2FjWkZeQ6YxJduZskH/UPe9Nrj/VzIYeSJ9B8zn+oYdwWTAxIncPzSiLNBBUk3
	 eqWq5/85Zcc1lma7glXQugCQE/RVc5xYoB3y4zPF6mwMI2G5dS++QHjUn4HtBe/+yi
	 mNyIv5/x+RW34A6K3R2vQRVI3VgcIH8MsTY8zVbexfiMQr+wtdjiB2dGHzmr0p5qx4
	 13wiA0DHtmQ1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/23] isofs: handle CDs with bad root inode but good Joliet root directory
Date: Fri, 29 Mar 2024 08:49:40 -0400
Message-ID: <20240329125009.3093845-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 74e487d63c62c..95c08f3c4b35e 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -912,8 +912,22 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
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


