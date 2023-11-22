Return-Path: <linux-fsdevel+bounces-3466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1707F50C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8A2B20E91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AF55D4AE;
	Wed, 22 Nov 2023 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pG8jo4TP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D47A1AE;
	Wed, 22 Nov 2023 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rNmpOBKWoYfvVrhEukRAAHBSo1Q96GuxaczyMAbV7AU=; b=pG8jo4TPLP4OImKO1wWH4A1imn
	jY0RlChB5b9gcRdaSNvfTTygnHegbVfpY3EmJWx5Z6c1WUqI/Io1RU5pcNeH22yLPk54ZUe2T4eCf
	o7jGAJSzH3FksmBNhRWpSPA56egeiD7tUjiBFz/FIk6xNOI0PDTRmIgwzQqwuGaNueXaYKsGdKZgX
	LTNxN7fbMbs0T4dweEgv9ND+T8geZzkwX3NNjV1vAmzeCHrfSl3wL38z8I5eEhr/8ri0PHe5NfpVf
	tZwIHghZnX3G1D5CBeRIaW52QlCUgo4GEXaw/XBli2BF+5eLGwQU6PjNGOGHOtOm66D50TaHNVpnG
	ukkxBUZw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5t1o-001l1i-2l;
	Wed, 22 Nov 2023 19:36:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] udf_rename(): only access the child content on cross-directory rename
Date: Wed, 22 Nov 2023 19:36:46 +0000
Message-Id: <20231122193652.419091-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231122193652.419091-1-viro@zeniv.linux.org.uk>
References: <20231122193028.GE38156@ZenIV>
 <20231122193652.419091-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

We can't really afford locking the source on same-directory rename;
currently vfs_rename() tries to do that, but it will have to be
changed.  The logics in udf_rename() is lazy and goes looking for
".." in source even in same-directory case.  It's not hard to get
rid of that, leaving that behaviour only for cross-directory case;
that VFS can get locks safely (and will keep doing that after the
coming changes).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/udf/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 3508ac484da3..fac806a7a8d4 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -766,7 +766,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct udf_fileident_iter oiter, niter, diriter;
-	bool has_diriter = false;
+	bool has_diriter = false, is_dir = false;
 	int retval;
 	struct kernel_lb_addr tloc;
 
@@ -789,6 +789,9 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (!empty_dir(new_inode))
 				goto out_oiter;
 		}
+		is_dir = true;
+	}
+	if (is_dir && old_dir != new_dir) {
 		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
 					       &diriter);
 		if (retval == -ENOENT) {
@@ -878,7 +881,9 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			       udf_dir_entry_len(&diriter.fi));
 		udf_fiiter_write_fi(&diriter, NULL);
 		udf_fiiter_release(&diriter);
+	}
 
+	if (is_dir) {
 		inode_dec_link_count(old_dir);
 		if (new_inode)
 			inode_dec_link_count(new_inode);
-- 
2.39.2


