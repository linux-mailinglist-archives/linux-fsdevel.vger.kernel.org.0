Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95E3439C2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 18:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhJYRAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 13:00:51 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:56807 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234110AbhJYRAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:00:51 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id CDFA7808C5;
        Mon, 25 Oct 2021 19:58:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1635181106;
        bh=jXeqzlNUDb7Cz6wH59sPxI4xQQQ/EV06Awohr7HBZe0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=mCsObIQChpOOrhrxu6+r+wXspThHJw9pscmw4HwPLhhv9Y17cF6Ru1PBSN/+gtVte
         S6BmUA9wgbd4gI6ICDdU7JJdFbuzXaD++8x6RUmXQja+8ZGSrfxylbJPDer9VHn10V
         RrKKp9SS/oLJheRsWE9qAqneh6OgVg3rdmZOdbuI=
Received: from [192.168.211.155] (192.168.211.155) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 25 Oct 2021 19:58:26 +0300
Message-ID: <67d0c9ca-2531-8a8a-ea0b-270dc921e271@paragon-software.com>
Date:   Mon, 25 Oct 2021 19:58:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: [PATCH 1/4] fs/ntfs3: In function ntfs_set_acl_ex do not change
 inode->i_mode if called from function ntfs_init_acl
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
In-Reply-To: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.155]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ntfs_init_acl sets mode. ntfs_init_acl calls ntfs_set_acl_ex.
ntfs_set_acl_ex must not change this mode.
Fixes xfstest generic/444
Fixes: 83e8f5032e2d ("fs/ntfs3: Add attrib operations")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 2143099cffdf..97b5f8417d85 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -538,7 +538,7 @@ struct posix_acl *ntfs_get_acl(struct inode *inode, int type)
 
 static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 				    struct inode *inode, struct posix_acl *acl,
-				    int type)
+				    int type, int init_acl)
 {
 	const char *name;
 	size_t size, name_len;
@@ -551,8 +551,9 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 
 	switch (type) {
 	case ACL_TYPE_ACCESS:
-		if (acl) {
-			umode_t mode = inode->i_mode;
+		/* Do not change i_mode if we are in init_acl */
+		if (acl && !init_acl) {
+			umode_t mode;
 
 			err = posix_acl_update_mode(mnt_userns, inode, &mode,
 						    &acl);
@@ -613,7 +614,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		 struct posix_acl *acl, int type)
 {
-	return ntfs_set_acl_ex(mnt_userns, inode, acl, type);
+	return ntfs_set_acl_ex(mnt_userns, inode, acl, type, 0);
 }
 
 /*
@@ -633,7 +634,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 
 	if (default_acl) {
 		err = ntfs_set_acl_ex(mnt_userns, inode, default_acl,
-				      ACL_TYPE_DEFAULT);
+				      ACL_TYPE_DEFAULT, 1);
 		posix_acl_release(default_acl);
 	} else {
 		inode->i_default_acl = NULL;
@@ -644,7 +645,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	else {
 		if (!err)
 			err = ntfs_set_acl_ex(mnt_userns, inode, acl,
-					      ACL_TYPE_ACCESS);
+					      ACL_TYPE_ACCESS, 1);
 		posix_acl_release(acl);
 	}
 
-- 
2.33.0

