Return-Path: <linux-fsdevel+bounces-25606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C70F994E2FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 22:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672D4B214DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 20:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F6514C5AE;
	Sun, 11 Aug 2024 20:32:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [188.121.53.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FAE273F9
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2024 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723408366; cv=none; b=nkKZAMsMKLvuSglJGNq4tJgr8erm1jbYd2WObrkyrors9wk4EnTVTtzSLXecgX9qiVpXm0xkYhcUwOGcYCuX2BCpxUL/Mv6fWGHWL3+0Y5MCUyI0ooqtQ16MVs3wPsMetdHnstrq2XBg9jYR13noUlViEvz17PydPvOcv7RQMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723408366; c=relaxed/simple;
	bh=pKCnh7GHvmWQ33Np4n9VMUFEvgaWl5uOyP095/wAG0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IxiIRlxkNVIgFVtsfWpeZdzulV6Qtf1yL78IT+syHZ7/cF4Qaos40ia7Nc+CVBAtmj9NFWUm1NvuGfzU21YXpuKf1t3ZCI2CKQ9y7Dn3W7e0ZYxjwzYJ2jHyTS1XBhr3CuFgpKR4FD3AgS3IaWazhadELf6HdfR1Gwt2V2N1UyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id dEwOsxzsHeSaBdEwdsz0rz; Sun, 11 Aug 2024 13:13:40 -0700
X-CMAE-Analysis: v=2.4 cv=GJnDEfNK c=1 sm=1 tr=0 ts=66b91b75
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=t7CeM3EgAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=aXxt9TpeGBesqlHbmUgA:9 a=UObqyxdv-6Yh2QiB9mM_:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Subject: [PATCH] Squashfs: sanity check symbolic link size
Date: Sun, 11 Aug 2024 21:13:01 +0100
Message-Id: <20240811201301.13076-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMe3ExLrd/5tQ3ORwglA4RyjvgH85sDDHMPGC0AHVUBI5YGPACZxJCYUJ8JhPjcy0FNzv0ARflDa0NgBfoc4ck5eVoFiCy2Cc2drAyaK875muPzPZ+NH
 Fl0Fzh5DfDboOnAFmAyMCdtHI1FfhKC4BSagv1ZfpkHx3OubStAY5kmTZofNbRlm/mZy8guO7dkGDmDmjuLZVR/hQukY1RexRlIAz2ZSxqizbQUnJO1Fkxvs
 LfNX/3dxxPykFbKSMaGSaTFNwH20S7W2hNEskqkhFZBvtm9tPwGDwvrk92ESu/ilHR8xJhG1Tok7CS7yXoQgz9ESOiKr/WivyRN0315G9VQrUd7QoQf94bNU
 9HrftJQlgl0pP2zevy7mt3//wO1T8EqBwEKDghcJ6yBfl9i1+2eRPdrngJRgsMAXsKa0g16w6zQ5nnXaMd/tHHmfze1Yk2AuldRBOztqd80Fow/4v9ozSgM4
 q0HaJLRD0JXGugAusx4L02Ntl5RUt81Yqx1Ri1VLT+RDEZZrKMdgrsx0XfY=

Syzkiller reports a "KMSAN: uninit-value in pick_link" bug.

This is caused by an uninitialised page, which is ultimately caused
by a corrupted symbolic link size read from disk.

The reason why the corrupted symlink size causes an uninitialised
page is due to the following sequence of events:

1. squashfs_read_inode() is called to read the symbolic
   link from disk.  This assigns the corrupted value
   3875536935 to inode->i_size.

2. Later squashfs_symlink_read_folio() is called, which assigns
   this corrupted value to the length variable, which being a
   signed int, overflows producing a negative number.

3. The following loop that fills in the page contents checks that
   the copied bytes is less than length, which being negative means
   the loop is skipped, producing an unitialised page.

This patch adds a sanity check which checks that the symbolic
link size is not larger than expected.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: Lizhi Xu <lizhi.xu@windriver.com>
Reported-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000a90e8c061e86a76b@google.com/
---
 fs/squashfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 16bd693d0b3a..d5918eba27e3 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -279,8 +279,13 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
-		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_size = le32_to_cpu(sqsh_ino->symlink_size);
+		if (inode->i_size > PAGE_SIZE) {
+			ERROR("Corrupted symlink\n");
+			return -EINVAL;
+		}
+
+		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_op = &squashfs_symlink_inode_ops;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &squashfs_symlink_aops;
-- 
2.39.2


