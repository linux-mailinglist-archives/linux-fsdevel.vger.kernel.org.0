Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627D2342A8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 05:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCTEft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 00:35:49 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58356 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhCTEfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 00:35:19 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNTIO-007ZDS-CS; Sat, 20 Mar 2021 04:33:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/7] cifs: constify path argument of ->make_node()
Date:   Sat, 20 Mar 2021 04:33:00 +0000
Message-Id: <20210320043304.1803623-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320043304.1803623-1-viro@zeniv.linux.org.uk>
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
 <20210320043304.1803623-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/cifsglob.h | 2 +-
 fs/cifs/smb1ops.c  | 2 +-
 fs/cifs/smb2ops.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 3de3c5908a72..cc328cd7867c 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -495,7 +495,7 @@ struct smb_version_operations {
 			 struct inode *inode,
 			 struct dentry *dentry,
 			 struct cifs_tcon *tcon,
-			 char *full_path,
+			 const char *full_path,
 			 umode_t mode,
 			 dev_t device_number);
 	/* version specific fiemap implementation */
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index 85fa254c7a6b..3b83839fc2c2 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -1025,7 +1025,7 @@ cifs_can_echo(struct TCP_Server_Info *server)
 static int
 cifs_make_node(unsigned int xid, struct inode *inode,
 	       struct dentry *dentry, struct cifs_tcon *tcon,
-	       char *full_path, umode_t mode, dev_t dev)
+	       const char *full_path, umode_t mode, dev_t dev)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct inode *newinode = NULL;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index f5087295424c..372ed85472b1 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4955,7 +4955,7 @@ smb2_next_header(char *buf)
 static int
 smb2_make_node(unsigned int xid, struct inode *inode,
 	       struct dentry *dentry, struct cifs_tcon *tcon,
-	       char *full_path, umode_t mode, dev_t dev)
+	       const char *full_path, umode_t mode, dev_t dev)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	int rc = -EPERM;
-- 
2.11.0

