Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36241CA99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhI2Qvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 12:51:36 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:54932 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243893AbhI2Qvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:51:35 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E56DE439;
        Wed, 29 Sep 2021 19:49:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632934192;
        bh=AIg9rkQY3+i/Vv+sIzG4WbPk6OdyngEjF1gtfZjJ8+s=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=AR92/WPNAWP1pd/PCqBveW5ZF9FXMmrG88Tr3SVenqkZA9mG4IPtdyGH3YrSCkA7C
         HUMFr2B60/UO8AEx4lP4Nz461e9jqHG5iAVwfE7gTtnqL/Dm/00d+bdQaKdetbjOhy
         epF2rBlP1IjeMAauapSBOEf2tgPgbOF0KiKrhIPw=
Received: from [192.168.211.131] (192.168.211.131) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 29 Sep 2021 19:49:52 +0300
Message-ID: <e33d2976-96fa-0870-9ec7-119f81870867@paragon-software.com>
Date:   Wed, 29 Sep 2021 19:49:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH v3 1/3] fs/ntfs3: Use available posix_acl_release instead of
 ntfs_posix_acl_release
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kari.argillander@gmail.com>
References: <1514c7ce-9b2c-fc12-75c4-3b4cfd2639a5@paragon-software.com>
In-Reply-To: <1514c7ce-9b2c-fc12-75c4-3b4cfd2639a5@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.131]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need to maintain ntfs_posix_acl_release.

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>
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


