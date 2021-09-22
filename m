Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22F7414DFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 18:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhIVQVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 12:21:39 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:44224 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236565AbhIVQVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:21:38 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 2E1601D1D;
        Wed, 22 Sep 2021 19:20:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632327607;
        bh=e749/JBSqvPfXTMtu2F9EBHwqQD373LQ39GI5x0Pox4=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=mcq2IUhHofJ7p/Mr4tmzgGVTTxJn7W99nN4rhDY3Uqek73I5/V2LhMf4Cp8nyWNAH
         HC2Zd9FGqcGAiKdA+lsQz9TDDUH7oCzMCW9Gq5XbAzTYM6s1bxK+6eD0fWF6rEaSFE
         Hi0/AI8TUvk7WrdEB2RsrKxb+xPqk1o7Cvnlc5C0=
Received: from [192.168.211.195] (192.168.211.195) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 22 Sep 2021 19:20:06 +0300
Message-ID: <18250134-b9a0-c2af-ce7f-9ec01ddfdb9a@paragon-software.com>
Date:   Wed, 22 Sep 2021 19:20:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH 4/5] fs/ntfs3: Change posix_acl_equiv_mode to
 posix_acl_update_mode
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
References: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.195]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now ntfs3 uses posix_acl_equiv_mode instead of
posix_acl_update_mode like all other fs.

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


