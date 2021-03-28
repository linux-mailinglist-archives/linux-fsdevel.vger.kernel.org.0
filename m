Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA7D34BCB0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhC1Oo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhC1Ooe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 10:44:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBFBC061756;
        Sun, 28 Mar 2021 07:44:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id CED981F46335
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     krisman@collabora.com, kernel@collabora.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Chao Yu <yuchao0@huawei.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 3/3] f2fs: Prevent dangling dentries on casefold directories
Date:   Sun, 28 Mar 2021 11:43:56 -0300
Message-Id: <20210328144356.12866-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210328144356.12866-1-andrealmeid@collabora.com>
References: <20210328144356.12866-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before making a folder a case-insensitive one, this folder could have
been used before and created some negative dentries (given that the
folder needs to be empty before making it case-insensitive, all detries
there are negative ones). During a new file creation, if a d_hash()
collision happens and the name matches a negative dentry, the new file
might have a name different than the specified by user.

To prevent this from happening, remove all negative dentries in a
directory before making it a case-folded one.

Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d26ff2ae3f5e..616b7eb43795 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1826,6 +1826,10 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			return -EOPNOTSUPP;
 		if (!f2fs_empty_dir(inode))
 			return -ENOTEMPTY;
+
+		if (!(masked_flags & F2FS_CASEFOLD_FL) &&
+		    (iflags & F2FS_CASEFOLD_FL))
+			d_clear_dir_neg_dentries(inode);
 	}
 
 	if (iflags & (F2FS_COMPR_FL | F2FS_NOCOMP_FL)) {
-- 
2.31.0

