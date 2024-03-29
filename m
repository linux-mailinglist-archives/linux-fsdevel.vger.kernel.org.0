Return-Path: <linux-fsdevel+bounces-15680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BADF891BED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 14:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C47B1C222D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D51474AD;
	Fri, 29 Mar 2024 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAMiVAmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06021146D7B;
	Fri, 29 Mar 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716043; cv=none; b=U5looWXBDOuviVybgb4mp7wbgC7jQm8/2ewdpQMVFAk2t5abK+dwjeogtXXUpLSWJavBXBGoC39pLLBDan087qtStQsAhytpq1ZWQ6gDI8dN03lODjg6W4P0Kar8WUkoopR3mVHU5FUQSrJM6Gs9tTEx4LCAmDYBjEBceqvZJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716043; c=relaxed/simple;
	bh=dI+n5cg8esWd0k+bureAZYabQ7kxSKrIKWns4EovvvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUhjD0WcGFzjInylrWAdT5CjParVB7yj0bmVPAlZfLyoSSUa+NlU2eVFH2xnhsHvxzRTrRNwHRPIhUW7MKPrNGIpZlC9V2hIEvx7c1PTmbTszbsXQrqR2u+hp8AR8GlqYZJ2FCsQlC2PbLRndxB9riIR/9aia/ZiKANzRKNQjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAMiVAmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4859C43394;
	Fri, 29 Mar 2024 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716042;
	bh=dI+n5cg8esWd0k+bureAZYabQ7kxSKrIKWns4EovvvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAMiVAmZLBVJasiB9va0DUzgAuSX3fyzPte8gK9wMm1t0cr/V3raQ78dVF2eKfQG7
	 YwVrJLIES6EKra+vu1YpOmimnyY1ztfXksChHLp0DCrTxCKqUZjrielXGuVlgy/MwD
	 y4irppGkuOtAGb+t7XZ4GPsIbDhlAVY37iVo8fxeHJl8lbJCLOqVokvoixemwUlcT4
	 tMhd1ef9tpPFXNN0UMOEs7Yfzqi6xNf15WBJqsj78DYYjq32cw13OEnkLAXwDUIhWW
	 wo0UUetMEl7bVWdoIyY6DHMnn+QpCJobsM7fOiwF4pYbZo0tyASfzvifc0SMcKqb58
	 Q8O75Zz9y4jOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 25/98] isofs: handle CDs with bad root inode but good Joliet root directory
Date: Fri, 29 Mar 2024 08:36:56 -0400
Message-ID: <20240329123919.3087149-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 3e4d53e26f947..379c9edc907cf 100644
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


