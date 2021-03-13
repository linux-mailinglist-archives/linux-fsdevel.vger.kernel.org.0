Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFEA339BBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhCMEk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:40:58 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33584 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhCMEkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:36 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2j-005O03-F1; Sat, 13 Mar 2021 04:38:25 +0000
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
Subject: [PATCH v2 10/15] cifs: have ->mkdir() handle race with another client sanely
Date:   Sat, 13 Mar 2021 04:38:19 +0000
Message-Id: <20210313043824.1283821-10-viro@zeniv.linux.org.uk>
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

if we have mkdir request reported successful *and* simulating lookup
gets us a non-directory (which is possible if another client has
managed to get rmdir and create in between), the sane action is not
to mangle ->i_mode of non-directory inode to S_IFDIR | mode, it's
"report success and return with dentry negative unhashed" - that
way the next lookup will do the right thing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index d46b36d52211..80c487fcf10e 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1739,6 +1739,16 @@ cifs_mkdir_qinfo(struct inode *parent, struct dentry *dentry, umode_t mode,
 	if (rc)
 		return rc;
 
+	if (!S_ISDIR(inode->i_mode)) {
+		/*
+		 * mkdir succeeded, but another client has managed to remove the
+		 * sucker and replace it with non-directory.  Return success,
+		 * but don't leave the child in dcache.
+		 */
+		 iput(inode);
+		 d_drop(dentry);
+		 return 0;
+	}
 	/*
 	 * setting nlink not necessary except in cases where we failed to get it
 	 * from the server or was set bogus. Also, since this is a brand new
@@ -1790,7 +1800,7 @@ cifs_mkdir_qinfo(struct inode *parent, struct dentry *dentry, umode_t mode,
 		}
 	}
 	d_instantiate(dentry, inode);
-	return rc;
+	return 0;
 }
 
 static int
-- 
2.11.0

