Return-Path: <linux-fsdevel+bounces-25610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773D594E3DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 01:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E2EB217F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 23:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC015853D;
	Sun, 11 Aug 2024 23:35:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-01.prod.sxb1.secureserver.net (sxb1plsmtpa01-01.prod.sxb1.secureserver.net [188.121.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD941757E
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2024 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723419344; cv=none; b=LNtT7CMXJmEj1Yvo4j+O3xRFw4QPj/TkbmdtsICVuZfGx4oL8qIWuG0C/Hio9SVIkiu0HbCd4EHnLwEZ2XGj5cY5AjTqLuzHlIJD35WIqhJ53unvmr86ZAS5r0TQwdDCyEiWXQzDhtEOblejNa7qdXZ96krPMXSGogkshqurZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723419344; c=relaxed/simple;
	bh=0LhUPbXTy9pdwvQ4YkiZMMkLq0j5DEixcApfQlOOrYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kpdKZx7SXl5JvNltd9t94Z/cOJoJ4+9I613k98qwjqhiONbwxnq9jiBK/1sRNspa3i4gcVo9vHW1iwamhi7jIftJsJxLazub1rukIA8YbStyunhAYawYfR+IUSvoINnEVV1WiA1QFt4Es4Uwo95AWeqkz7+soZ4USdAugao82EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id dHyXsXxYxPxTTdHyhs0hh7; Sun, 11 Aug 2024 16:28:00 -0700
X-CMAE-Analysis: v=2.4 cv=PMvE+uqC c=1 sm=1 tr=0 ts=66b94901
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
Subject: [PATCH V2] Squashfs: sanity check symbolic link size
Date: Mon, 12 Aug 2024 00:28:21 +0100
Message-Id: <20240811232821.13903-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBRiLdx9hdHg3BQlZZ42kFfI6TsgiSiR7+Ep0JLGXbm59LJvUmz/3N9DUVs3uCkUIs1evK0j85rvJEJkj5Oe5y8IEpK9zgBVsofh9TjQ0Tn5hTpSXhJH
 Pa8oF0wNuEy9LAE6u2MAvTwXuStoT7ZJxfLDKtb/S/mNvq5TKbnaes8w020fyh9xOnsPPA0KkbcJMHehpq4mhVCWNmENG659y8s661FpRDy3NNSnJ8fM1Df7
 NElWZ5Cziu8rc2gmzS08wprsR2gb/n1kSixpynMwC3bLxUgRntj79rZJeUJG1pGxBUaBape5bPW9xXJfNaWOCMa33Gwh0lzej0BIvOdOx2USP5Wl+gERiVsH
 0yxNKCyn8o2xJ/7LFeDmCdvq6KPxhiBHIF5XY8gJmIMxB8xXowfcnvEaNsUbofhmxUFfG5jTMYYUUw8cdVj1mSWIKiPucikwYd2m+cRMf8fw3URmT9DjYJDC
 SBeWOwUyT8LtYlVo8uggMEzSdw0b8p/oTK2+SG1gibQpbRHDm2gJZFkL4t4=

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
   the loop is skipped, producing an uninitialised page.

This patch adds a sanity check which checks that the symbolic
link size is not larger than expected.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: Lizhi Xu <lizhi.xu@windriver.com>
Reported-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000a90e8c061e86a76b@google.com/
--
V2: fix spelling mistake.
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


