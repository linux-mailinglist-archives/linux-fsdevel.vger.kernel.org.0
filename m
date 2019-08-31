Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6AA41EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 05:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfHaDLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 23:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbfHaDLi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 23:11:38 -0400
Received: from zzz.tds (h184-61-154-48.mdsnwi.dsl.dynamic.tds.net [184.61.154.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8315423697;
        Sat, 31 Aug 2019 03:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567221097;
        bh=GJ3U4px7b3ANezBJVEhyma8S78tvLyrPWzysEmmy8a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Abk8lRoXiqwTnfyyX/UusjkVXFbidWi8kHdGOtAfHi3Xd4gW9wMLQV9Y2nA1LhsC3
         K+27ju15Hl2PVbaUVOM9zrR6+p1AO0C83A+pSeFXOXUpBJl3yT/D4m1gQRRtK9F8mK
         KIZwPE+U5Ojvw0H8KUgaRICLEa7MECts6Z2peNYw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com,
        David Howells <dhowells@redhat.com>
Subject: [PATCH vfs/for-next] vfs: fix vfs_get_single_reconf_super error handling
Date:   Fri, 30 Aug 2019 22:10:24 -0500
Message-Id: <20190831031024.26008-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <0000000000003675ae05915a9fd3@google.com>
References: <0000000000003675ae05915a9fd3@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

syzbot reported an invalid free in debugfs_release_dentry().  The
reproducer tries to mount debugfs with the 'dirsync' option, which is
not allowed.  The bug is that if reconfigure_super() fails in
vfs_get_super(), deactivate_locked_super() is called, but also
fs_context::root is left non-NULL which causes deactivate_super() to be
called again later.

Fix it by releasing fs_context::root in the error path.

Reported-by: syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com
Fixes: e478b48498a7 ("vfs: Add a single-or-reconfig keying to vfs_get_super()")
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 0f913376fc4c..99195e15be05 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1194,8 +1194,11 @@ int vfs_get_super(struct fs_context *fc,
 		fc->root = dget(sb->s_root);
 		if (keying == vfs_get_single_reconf_super) {
 			err = reconfigure_super(fc);
-			if (err < 0)
+			if (err < 0) {
+				dput(fc->root);
+				fc->root = NULL;
 				goto error;
+			}
 		}
 	}
 
-- 
2.23.0

