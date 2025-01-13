Return-Path: <linux-fsdevel+bounces-39079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54986A0C06C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B313A2B76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0A2139DC;
	Mon, 13 Jan 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtfgMVP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D862135DD;
	Mon, 13 Jan 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793370; cv=none; b=cxc3AaNZAGXKoY4DXeVvXhtKTnBAGpHq5YDYjeeFKZ0Ub9fdkK90QHC4gbthyfxEJxD3Iiia3pwNWjK9nEYZSCzRDfY4K+6ddfp1qkoFKhAdfZaGlbap99T3OBYDiUivwgnwviQoagpfx2MN0G9lpqEg1jBNynz87ucz9OhWiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793370; c=relaxed/simple;
	bh=y1o2LMikgplcjwXIPq9Z/CuaTfAcD4na1HivCa8NOLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=quA2fmFsesLVYhpjncszT6EFS9zZGtHonCLIxQjLaJg3yeyZImQReg4qZ9f28iVfLSIf025ejzgV3f2q7bplBPWT7VQlBT7JHvt5YHwoPBVLg87+f+ns692RRx57zqMyA3wnEgq2CqedETvcZUHUje3gUCYFeqmPN2vAVK8HbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtfgMVP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D325C4CED6;
	Mon, 13 Jan 2025 18:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793370;
	bh=y1o2LMikgplcjwXIPq9Z/CuaTfAcD4na1HivCa8NOLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtfgMVP0/W+fX23lm4VmgLWqMPQfCcfIUe99RKqzlq2+eRAYl+EFkNbj7LYpuQUTW
	 3C8d982bbC5qxPN24wQb8n6EAT6UmUQgX6ZwbJG7DCmiPajWLcQj2qrPzx/qLM+BMD
	 WayJ3B5UCBsGedjFx3MxhKRhu0wj6yP4wXSwipgKEZZ3FOHQ2LkNEsyJuNL/eBuVdN
	 721MOw70X3K7f69Ojpi00hMh1xU5JQSDVWUeek9FgPuOh4YRWkNpnOAnG+x43UNbaI
	 KqRANSRVMwVzLrJsLk7kiz1LPMaOhbfxFU3DFQAIv3kKJF5oFsZdY3XWeTfWAIzqBT
	 ryYTpWtWBOdcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Stone <leocstone@gmail.com>,
	syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	sandeen@redhat.com,
	quic_jjohnson@quicinc.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/6] hfs: Sanity check the root record
Date: Mon, 13 Jan 2025 13:35:56 -0500
Message-Id: <20250113183601.1784402-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183601.1784402-1-sashal@kernel.org>
References: <20250113183601.1784402-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.176
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
index 12d9bae39363..699dd94b1a86 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -418,11 +418,13 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
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


