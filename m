Return-Path: <linux-fsdevel+bounces-39083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634C2A0C08D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857FA1887E27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CB2224B12;
	Mon, 13 Jan 2025 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRG3TzZ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12F224AFE;
	Mon, 13 Jan 2025 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793401; cv=none; b=lnKRSCXYRCaV0hEGx0HFmjg4RNrD/T7jjDe7eexwQ+6SsNJFntjl9Vo+pP6+qHZ7TP+Edh2TxNffttjDFqnY+BxTCHmEVPn14rXVHzqD3Rg0gvibkCKmVvl1/nWv53FPpDnBQiWPj4NbR07P7Vn89U8HbaLCvEcvjNG4YZKWRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793401; c=relaxed/simple;
	bh=OSMd6m3CV9jUJ8WykRwJ1KDi0nH2xHT6tg95x+6TSTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OfIIXoHIQpabpGFWyHCYZlQ/LbkYK23d2HyCJ2nSWLb0xZuTHOuev6TjDgak7oVzXa4dEhttPUne1IGhVFyNeM/K/F1W9Qz7yHl/JguMVL4DL4qhk1a99ifOyp7ONnukdxUBqqWPCMSw2jFzjSfAwdA1s+8+F+J0fJDH/yi8ETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRG3TzZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638D9C4CED6;
	Mon, 13 Jan 2025 18:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793401;
	bh=OSMd6m3CV9jUJ8WykRwJ1KDi0nH2xHT6tg95x+6TSTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nRG3TzZ7riGviLHQv+8zZWc/liDi0FDgDzd5F+Taro6pfxyMP7luYTY63tsvXlepi
	 d1yN/e55pIvdGZKibkUPG+ZJNVCXl6g71PH1BRPtSLaEtsJgLG1cKp2EgdlmaVr2pD
	 bT8wYAF98LhdKZ9ib8GfO/6Tl4Iu/lKFjztI0HstVNQpcNI6FwZR3sCHpYRnyNjQ/b
	 BF9rs7FfoUPgc+Cz+3LFWwPquks+AmH5pdFqp0WgpUX/P1yw2GGrbQMQskxdizBOSy
	 xnqrSmuLzq9RwE+ELKxopuPa0v9XmxyW3EqGJ7zfiY47skBOevJZwta3ZtiYnRk01n
	 fNX9pMxyeBwFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Stone <leocstone@gmail.com>,
	syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	quic_jjohnson@quicinc.com,
	viro@zeniv.linux.org.uk,
	sandeen@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/4] hfs: Sanity check the root record
Date: Mon, 13 Jan 2025 13:36:31 -0500
Message-Id: <20250113183633.1784590-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183633.1784590-1-sashal@kernel.org>
References: <20250113183633.1784590-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
Content-Transfer-Encoding: 8bit

From: Leo Stone <leocstone@gmail.com>

[ Upstream commit b905bafdea21a75d75a96855edd9e0b6051eee30 ]

In the syzbot reproducer, the hfs_cat_rec for the root dir has type
HFS_CDR_FIL after being read with hfs_bnode_read() in hfs_super_fill().
This indicates it should be used as an hfs_cat_file, which is 102 bytes.
Only the first 70 bytes of that struct are initialized, however,
because the entrylength passed into hfs_bnode_read() is still the length of
a directory record. This causes uninitialized values to be used later on,
when the hfs_cat_rec union is treated as the larger hfs_cat_file struct.

Add a check to make sure the retrieved record has the correct type
for the root directory (HFS_CDR_DIR), and make sure we load the correct
number of bytes for a directory record.

Reported-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2db3c7526ba68f4ea776
Tested-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
Tested-by: Leo Stone <leocstone@gmail.com>
Signed-off-by: Leo Stone <leocstone@gmail.com>
Link: https://lore.kernel.org/r/20241201051420.77858-1-leocstone@gmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index bcf820ce0e02..f82444fbbedc 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -419,11 +419,13 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
 		goto bail_no_root;
 	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
 	if (!res) {
-		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) {
+		if (fd.entrylength != sizeof(rec.dir)) {
 			res =  -EIO;
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
+		if (rec.type != HFS_CDR_DIR)
+			res = -EIO;
 	}
 	if (res)
 		goto bail_hfs_find;
-- 
2.39.5


