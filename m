Return-Path: <linux-fsdevel+bounces-39081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBDA0C07E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828521691D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA54F223324;
	Mon, 13 Jan 2025 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDg1gj5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87F1D1724;
	Mon, 13 Jan 2025 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793387; cv=none; b=MxeBOrwX2V0UxVU4obr3rkNPk7j0BtvLcGZYDCCC61oG8YG9JDV6YMIs1rqWQqiSxpy7kHC/oECS2I3LpqCdpeWtdHuX6wuaq1UAQ6ujHn210d1clMvvCgYrA3p1Lm3Ly8SeeSpk8JftG495aMKeK3G0FDClAHqYtKDTVJ2M0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793387; c=relaxed/simple;
	bh=y1o2LMikgplcjwXIPq9Z/CuaTfAcD4na1HivCa8NOLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1aJr5pWymiZRD1kA1nzbWjgKAa4P4JNxpo5v7Am+rjWgUPZcctNH4roamzGF8H+wzRd3fgA3zv4oPyxabsN2T5EJPjp1IyEjBAdD1IFtTDq7uDPd1/GZxVdGiPAMuLC0spBkpjn7dHwoO+aqfG5bAv8jor34Iscy/I4LEwPG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDg1gj5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9D7C4CEE1;
	Mon, 13 Jan 2025 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793387;
	bh=y1o2LMikgplcjwXIPq9Z/CuaTfAcD4na1HivCa8NOLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDg1gj5NVkZ0SshLZFWgZQkWIJc/hY5DZNbi/q/pEFX0WPtmGSKnBGGci2UK+kqy3
	 RN139C2kL5UBoPf54VAuUjIwoyb3KsIR+N398/Rk8kEpAP/im4ltZ04gfrsGpKh0t/
	 qRBbzYDh12TnWQK/8kx/9ZNeYivotsAX1b2983OK8EnsnejLtTEUihAAxqhjnht15m
	 Is9IaaOiNyZe22D2S77Ah7SHkkCosD7T+TZ7V3cdih9I0Pf6VGf3a4iWc+67NsAJ63
	 sCaE0tfQP3EwfKsbgjHL4f/vzjityihc6xN26KzUCInJL/GlwdfAmIx3WL9AVHyaVq
	 hZp96WnYHiZzQ==
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
Subject: [PATCH AUTOSEL 5.10 2/5] hfs: Sanity check the root record
Date: Mon, 13 Jan 2025 13:36:16 -0500
Message-Id: <20250113183619.1784510-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183619.1784510-1-sashal@kernel.org>
References: <20250113183619.1784510-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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


