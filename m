Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75820339BC3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhCMElA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:41:00 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33578 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhCMEkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:36 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2j-005O0B-Kv; Sat, 13 Mar 2021 04:38:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Richard Weinberger <richard@nod.at>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 12/15] hostfs_mknod(): don't bother with init_special_inode()
Date:   Sat, 13 Mar 2021 04:38:21 +0000
Message-Id: <20210313043824.1283821-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
References: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
 <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

read_name() in the end of hostfs_mknod() will DTRT

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hostfs/hostfs_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 29e407762626..aed8c4f28ad3 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -712,7 +712,6 @@ static int hostfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (name == NULL)
 		goto out_put;
 
-	init_special_inode(inode, mode, dev);
 	err = do_mknod(name, mode, MAJOR(dev), MINOR(dev));
 	if (err)
 		goto out_free;
-- 
2.11.0

