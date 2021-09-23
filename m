Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA58416286
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbhIWP4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 11:56:03 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:35826 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242260AbhIWP4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:56:03 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 803F11D99;
        Thu, 23 Sep 2021 18:44:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632411896;
        bh=SuD8zN6xNAKrdgxn219w20we7FQ4HvQ5FkLa7M0DkHU=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=G+mHblGnK8rNSp7ONON6k/QvKelb3TjsmJnOmb18XWa1n6tuqMqynrc4i0D5KovGE
         zet35q7FlpGnH0JfaQLHem3oDnv+7jQF7u5i2Y4vfbxGQyJKHVE3c2hoSh80uDxNbH
         P3Dtt9xZOXxyZ63uje/ZdIPZJhZP50h45MQ5Go2I=
Received: from [192.168.211.73] (192.168.211.73) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 23 Sep 2021 18:44:56 +0300
Message-ID: <22b8b701-e0c0-9b3f-dd58-0e8ab7c54754@paragon-software.com>
Date:   Thu, 23 Sep 2021 18:44:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH v2 5/6] fs/ntfs3: Change posix_acl_equiv_mode to
 posix_acl_update_mode
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
References: <a740b507-40d5-0712-af7c-9706d0b11706@paragon-software.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <a740b507-40d5-0712-af7c-9706d0b11706@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.73]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now ntfs3 uses posix_acl_equiv_mode instead of
posix_acl_update_mode like all other fs.

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 70f2f9eb6b1e..59ec5e61a239 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -559,22 +559,15 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 		if (acl) {
 			umode_t mode = inode->i_mode;
 
-			err = posix_acl_equiv_mode(acl, &mode);
-			if (err < 0)
-				return err;
+			err = posix_acl_update_mode(mnt_userns, inode, &mode,
+						    &acl);
+			if (err)
+				goto out;
 
 			if (inode->i_mode != mode) {
 				inode->i_mode = mode;
 				mark_inode_dirty(inode);
 			}
-
-			if (!err) {
-				/*
-				 * ACL can be exactly represented in the
-				 * traditional file mode permission bits.
-				 */
-				acl = NULL;
-			}
 		}
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		name_len = sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1;
-- 
2.33.0


