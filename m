Return-Path: <linux-fsdevel+bounces-39073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1CDA0C028
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7231D1886881
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53661FBBFC;
	Mon, 13 Jan 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCEqvBMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE71FAC51;
	Mon, 13 Jan 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793320; cv=none; b=o+8mpbX45fwCedXmJbRoM6q8TicRplCnPwBO6jRkHqX3ooDYRrTzae9bpisV0nlcuu4Qi5FJzxIhXkt0wVfuHhy1qvCalvlGD2br31g2YRTyhyAJdcY8q9thnapKjfQvh2wc7gs3jcZfOaX+EjpuwdQMsaEqVYHVRj2h/qqKVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793320; c=relaxed/simple;
	bh=u2zFzAaBRMPWTRzDckQPH3srUU5ZsguO5KNP5zWr598=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgxbKKlUUyfWQFKkpmjsWTL61DMoWZmqia/+IJs4Wi7ofid5TVNTCBaQrQqNaU9O4C82BbRwIFUfCYwXqcJUJAyPv459xXDKxIwY/oxfw7A0YNBxv/Hq8ZsM1XBQCaPM5d71vm6CpmV92Wfwr1HtndrQjal80Qb7r01toREfLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCEqvBMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADD0C4CEE2;
	Mon, 13 Jan 2025 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793320;
	bh=u2zFzAaBRMPWTRzDckQPH3srUU5ZsguO5KNP5zWr598=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCEqvBMNlbpoIOCXJDxiAluSATxZlay/JCFd5HM8l1bXAxjEDqdx3Xw07mFgj54Px
	 rfW2xkG/fEiaXtr2WUOwFI4g46z8R3q8ky9dJS1wj8UpubLQJpbM9YHxUVzMiEDUqM
	 zO2+mQE1GXIYDTOwFT/94N/DzMYbf32UpbWQo/3HXSXqkbiry4tsw6aqoAwzAYLb4h
	 VetXO9q/AO2pUyH6C023Bbxp9fVI30+zBY+MPBtdK4uEUCMy+qnUc2igjI5Q/MHeCW
	 DwmfciOMGrIWymG7AeH9aXpS+tV6c4281e3Sakk1T6kVnKqQGjtBg+zybP0n929C1M
	 RSQxHUFRpMjLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Stone <leocstone@gmail.com>,
	syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	quic_jjohnson@quicinc.com,
	sandeen@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/10] hfs: Sanity check the root record
Date: Mon, 13 Jan 2025 13:35:03 -0500
Message-Id: <20250113183511.1783990-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183511.1783990-1-sashal@kernel.org>
References: <20250113183511.1783990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.71
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
index 6764afa98a6f..431bdc65f723 100644
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


