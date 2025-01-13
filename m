Return-Path: <linux-fsdevel+bounces-39068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F95A0BFE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2287A3149
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FFD1C4A20;
	Mon, 13 Jan 2025 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH9yUoni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C11C5F29;
	Mon, 13 Jan 2025 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793275; cv=none; b=hGcQnrPDNaTZaZVFIjC9vIeg4HKy61mkgvhtOmlP9qHaeavx6LjufqM3M4RzSPpL4qbSLOg3tpeDbSZ9MLsqmY43jC4xzsiyMOFlFlsPbjWGOIo9/7TGqRXD2zO7j4QriYP/4DY/vzJth9sfHpbD1FusrIIf3ZuKLul4dkXY4ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793275; c=relaxed/simple;
	bh=qb+GHSzOcUnoklWqtNwI2Qq0jFqo0buyQ4cIym+CPuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MlO/olpM+H+TBcKHFedn3ebJQ3/Mp1mGIEGLavSANA8I9K2a1I1OvJS1wgSmhdht8gGy4iJ29dbb3Funko1tgzEGSsWSs5CjFK+5B+dDlGtuWvpqwyLZXq6X4veqd6XMto0+/5zzaojOn8yoAzUNOQjv0oXEHA9FzANw9rjfPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH9yUoni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772B3C4CEE1;
	Mon, 13 Jan 2025 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793274;
	bh=qb+GHSzOcUnoklWqtNwI2Qq0jFqo0buyQ4cIym+CPuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lH9yUoniF9h+qecsTTPSt8PKvdfN8Z5m06i0BuW4yQAc7jZa3h9ZMW5lbRJmiWxbL
	 /Z8T3MOXyKrmrP9uXtg1RtM3HYqZQ8/Bi/c/k80yhgiZcOj2A6T+W+SfH4TA8RdcYp
	 my380ecqKCkUl9l2bnk5Txvv942aTwKAtJyRJVJi0EFHuoxj85e4b8Oo5l6UhzO8t2
	 9yuh26IWnkolHvArcXqxPuwDPlDVBpgdHJBEm4pjgtxPlPhvdwcG9trN/sHvQQAAjy
	 gtCrghfqwa9g06NpFXyewLbUKunx9S6JFxO40UCeLbx/Z21Pn05ncgHJfJ0tQLOvAG
	 iNv/SEB/wpnsQ==
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
Subject: [PATCH AUTOSEL 6.12 02/20] hfs: Sanity check the root record
Date: Mon, 13 Jan 2025 13:34:07 -0500
Message-Id: <20250113183425.1783715-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
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
index eeac99765f0d..cf13b5cc1084 100644
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


