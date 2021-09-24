Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8E441784D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 18:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbhIXQQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 12:16:34 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:37063 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347306AbhIXQQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:16:30 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 8BAF482359;
        Fri, 24 Sep 2021 19:14:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632500094;
        bh=8+bhTt5T0IhlM9asCO6uLJk9m4HR7Kuysrl7ri2mQvM=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=foWBnYazmlnsDAdIpqIkbe9o1LbpTCiDYiZKBh7PF1s/rjYXwzIoxkYPmiIVdoJnH
         EXBTV0AnGj/ZR8olFtC9njpb3iouEFJdXWOe56/bQ2SFRNdjZG4bhPkeKoJy7EcNpf
         sA0f9AFeh4pN4Ze71+hBM59jHgWbh3gwYAqTR/8I=
Received: from [192.168.211.101] (192.168.211.101) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 24 Sep 2021 19:14:54 +0300
Message-ID: <bd40adc5-67c7-0f47-ed6f-da2540202de0@paragon-software.com>
Date:   Fri, 24 Sep 2021 19:14:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH 1/3] fs/ntfs3: Use available posix_acl_release instead of
 ntfs_posix_acl_release
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
References: <eb131ee0-3e89-da58-650c-5b84dd792a49@paragon-software.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <eb131ee0-3e89-da58-650c-5b84dd792a49@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.101]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need to maintain ntfs_posix_acl_release.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 83bbee277e12..253a07d9aa7b 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -475,12 +475,6 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 }
 
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
-static inline void ntfs_posix_acl_release(struct posix_acl *acl)
-{
-	if (acl && refcount_dec_and_test(&acl->a_refcount))
-		kfree(acl);
-}
-
 static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
 					 struct inode *inode, int type,
 					 int locked)
@@ -641,7 +635,7 @@ static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
 		return -ENODATA;
 
 	err = posix_acl_to_xattr(mnt_userns, acl, buffer, size);
-	ntfs_posix_acl_release(acl);
+	posix_acl_release(acl);
 
 	return err;
 }
@@ -678,7 +672,7 @@ static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
 	err = ntfs_set_acl(mnt_userns, inode, acl, type);
 
 release_and_out:
-	ntfs_posix_acl_release(acl);
+	posix_acl_release(acl);
 	return err;
 }
 
-- 
2.33.0


