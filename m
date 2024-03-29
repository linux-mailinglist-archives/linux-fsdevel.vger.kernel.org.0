Return-Path: <linux-fsdevel+bounces-15681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70954891CE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 15:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B791F260AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BA11B24F5;
	Fri, 29 Mar 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtXFmGxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8941B04A7;
	Fri, 29 Mar 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716238; cv=none; b=ZzA01Gr5gaXmFC13vDoSovfmTrpFX+O4Ho0D9mrXtiNc0pJueldAAEsVsMo1wll+fshkq3IbTfd80PmWar61Fnmfo7IT6nZ2/dM7yNnWn57S/ffbmLYEXvhZoymk9twXTwKA6VV6h2sJdCerWONsL4KQBDQ3wUFeLk9YiuhboFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716238; c=relaxed/simple;
	bh=AM0AEfvCynPT9+ZkFSfLOsGspOEWmurTQ9haASLWJvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBR8QyHI4/6rMa7oGjNpZqmEHpk61ErN+PI9UIz4qlaBgrgLZxOZgjx34iZiNYAtuzHTtTaMXSsY/rjoEE54XU3yFY4hXBZUmORZGFSnspsf4XuoVouIf2KBOggGvI/YUU8kxt09HHCQxgCISKFqwm7Vbu37wy32L8tGy9R0IUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtXFmGxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E47DC43394;
	Fri, 29 Mar 2024 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716238;
	bh=AM0AEfvCynPT9+ZkFSfLOsGspOEWmurTQ9haASLWJvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtXFmGxjs1a1wOjt9sMId7VVHZyHObfn+XgcefWOaI5649mZziDyWJTsooQxb/tlH
	 ORSpJlW1Nj7Rrc/vqQSfXsG8wYNe6LwgAQaQC8toI+oxXAs8JTb8CdBfgm8YsnsdWF
	 xCSttOG2kzz25LhEK6wiDn0X+AI3QEShLB0bC/3CC2v3dORfdvwnqzAEjmjaFpLanc
	 ndJQtzxMFJH72t9yG69Wxk01rBkMBrwKS3zMGVyt6pHnjmAx1nH/otP8N0CkJy+tFj
	 uAG2BOLB580a2MIMQv/qc+CzweB8ADpa0V99EKIQsmBNlGtdxF7d69Dk1DXH1lVTUM
	 8T58frmANE8ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/75] isofs: handle CDs with bad root inode but good Joliet root directory
Date: Fri, 29 Mar 2024 08:41:57 -0400
Message-ID: <20240329124330.3089520-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 2ee21286ac8f0..54075fe3de9b1 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -908,8 +908,22 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
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


