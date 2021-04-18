Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA49B363339
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Apr 2021 05:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhDRDKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 23:10:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40878 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229870AbhDRDKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 23:10:24 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13I39pSd005538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Apr 2021 23:09:51 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D4F8A15C3B0D; Sat, 17 Apr 2021 23:09:50 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH] fs: fix reporting supported extra file attributes for statx()
Date:   Sat, 17 Apr 2021 23:09:35 -0400
Message-Id: <20210418030935.41892-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

statx(2) notes that any attribute that is not indicated as supported
by stx_attributes_mask has no usable value.  Commits 801e523796004
("fs: move generic stat response attr handling to vfs_getattr_nosec")
and 712b2698e4c02 ("fs/stat: Define DAX statx attribute") sets
STATX_ATTR_AUTOMOUNT and STATX_ATTR_DAX, respectively, without setting
stx_attributes_mask, which can cause xfstests generic/532 to fail.

Fix this in the same way as commit 1b9598c8fb99 ("xfs: fix reporting
supported extra file attributes for statx()")

Fixes: 801e523796004 ("fs: move generic stat response attr handling to vfs_getattr_nosec")
Fixes: 712b2698e4c02 ("fs/stat: Define DAX statx attribute")
Cc: stable@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index fbc171d038aa..1fa38bdec1a6 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -86,12 +86,20 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	/* SB_NOATIME means filesystem supplies dummy atime value */
 	if (inode->i_sb->s_flags & SB_NOATIME)
 		stat->result_mask &= ~STATX_ATIME;
+
+	/*
+	 * Note: If you add another clause to set an attribute flag, please
+	 * update attributes_mask below.
+	 */
 	if (IS_AUTOMOUNT(inode))
 		stat->attributes |= STATX_ATTR_AUTOMOUNT;
 
 	if (IS_DAX(inode))
 		stat->attributes |= STATX_ATTR_DAX;
 
+	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
+				  STATX_ATTR_DAX);
+
 	mnt_userns = mnt_user_ns(path->mnt);
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(mnt_userns, path, stat,
-- 
2.31.0

