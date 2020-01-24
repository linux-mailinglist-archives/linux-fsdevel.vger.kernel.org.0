Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4314777F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 05:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgAXEQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 23:16:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbgAXEQ2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 23:16:28 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 920902070A;
        Fri, 24 Jan 2020 04:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579839387;
        bh=kj/UPIlxMTG1LNrRNQzAQibp9tj2WikH8O930HrmAmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a67IdEUAnRcrrHdsQK7Nbl5g7OMOKGhUa7H2t42Ofc5V4ViYMbnvhK/a34YlJ+krO
         vmTgWu/vfSimME2bI6MPvtXho8XRo0ExKGAxkWCy262Xx8CsCGhYC/qMYhcQmegp9w
         qkPDAlLSC701dz3K1kcrqiHoKDf0AfVYXDtnfgjk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH 2/2] f2fs: fix race conditions in ->d_compare() and ->d_hash()
Date:   Thu, 23 Jan 2020 20:15:49 -0800
Message-Id: <20200124041549.159983-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124041549.159983-1-ebiggers@kernel.org>
References: <20200124041549.159983-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since ->d_compare() and ->d_hash() can be called in RCU-walk mode,
->d_parent and ->d_inode can be concurrently modified, and in
particular, ->d_inode may be changed to NULL.  For f2fs_d_hash() this
resulted in a reproducible NULL dereference if a lookup is done in a
directory being deleted, e.g. with:

	int main()
	{
		if (fork()) {
			for (;;) {
				mkdir("subdir", 0700);
				rmdir("subdir");
			}
		} else {
			for (;;)
				access("subdir/file", 0);
		}
	}

... or by running the 't_encrypted_d_revalidate' program from xfstests.
Both repros work in any directory on a filesystem with the encoding
feature, even if the directory doesn't actually have the casefold flag.

I couldn't reproduce a crash in f2fs_d_compare(), but it appears that a
similar crash is possible there.

Fix these bugs by reading ->d_parent and ->d_inode using READ_ONCE() and
falling back to the case sensitive behavior if the inode is NULL.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
Cc: <stable@vger.kernel.org> # v5.4+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/dir.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index aea9e2806144d..d7c9a2cda4899 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1083,24 +1083,27 @@ static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
 			  const char *str, const struct qstr *name)
 {
 	struct qstr qstr = {.name = str, .len = len };
+	const struct dentry *parent = READ_ONCE(dentry->d_parent);
+	const struct inode *inode = READ_ONCE(parent->d_inode);
 
-	if (!IS_CASEFOLDED(dentry->d_parent->d_inode)) {
+	if (!inode || !IS_CASEFOLDED(inode)) {
 		if (len != name->len)
 			return -1;
 		return memcmp(str, name->name, len);
 	}
 
-	return f2fs_ci_compare(dentry->d_parent->d_inode, name, &qstr, false);
+	return f2fs_ci_compare(inode, name, &qstr, false);
 }
 
 static int f2fs_d_hash(const struct dentry *dentry, struct qstr *str)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
 	const struct unicode_map *um = sbi->s_encoding;
+	const struct inode *inode = READ_ONCE(dentry->d_inode);
 	unsigned char *norm;
 	int len, ret = 0;
 
-	if (!IS_CASEFOLDED(dentry->d_inode))
+	if (!inode || !IS_CASEFOLDED(inode))
 		return 0;
 
 	norm = f2fs_kmalloc(sbi, PATH_MAX, GFP_ATOMIC);
-- 
2.25.0

