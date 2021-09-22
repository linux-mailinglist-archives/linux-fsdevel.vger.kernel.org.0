Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97567414DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 18:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhIVQU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 12:20:57 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:40893 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236558AbhIVQUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:20:54 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id BC25782301;
        Wed, 22 Sep 2021 19:19:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632327560;
        bh=ha5KScEEr/4qiK0D82pDFvi0KlfCBt3k5qZ32Ma0pI4=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=eWnwG8/LYteUmYBDXEPA4JgEEErk+znXQLcq0vZtU+swgyx9Fs0zjmn2C64IT9hjI
         6DbIsH/rX7GXzRabn8T0UttC/5wH+M119Ppz7VPMQOv1yPvftH9nqHTABdqORnDf/7
         /3M/nhjpyYbrhqpJ5JHwBH9/36gXXKS6LaB7T1qw=
Received: from [192.168.211.195] (192.168.211.195) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 22 Sep 2021 19:19:20 +0300
Message-ID: <fd75b417-f5a0-d0f2-c2d3-35d465e41334@paragon-software.com>
Date:   Wed, 22 Sep 2021 19:19:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH 3/5] fs/ntfs3: Pass flags to ntfs_set_ea in ntfs_set_acl_ex
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

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 3795943efc8e..70f2f9eb6b1e 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -549,6 +549,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 	size_t size, name_len;
 	void *value = NULL;
 	int err = 0;
+	int flags;
 
 	if (S_ISLNK(inode->i_mode))
 		return -EOPNOTSUPP;
@@ -591,20 +592,24 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 	}
 
 	if (!acl) {
+		/* Remove xattr if it can be presented via mode. */
 		size = 0;
 		value = NULL;
+		flags = XATTR_REPLACE;
 	} else {
 		size = posix_acl_xattr_size(acl->a_count);
 		value = kmalloc(size, GFP_NOFS);
 		if (!value)
 			return -ENOMEM;
-
 		err = posix_acl_to_xattr(mnt_userns, acl, value, size);
 		if (err < 0)
 			goto out;
+		flags = 0;
 	}
 
-	err = ntfs_set_ea(inode, name, name_len, value, size, 0, locked);
+	err = ntfs_set_ea(inode, name, name_len, value, size, flags, locked);
+	if (err == -ENODATA && !size)
+		err = 0; /* Removing non existed xattr. */
 	if (!err)
 		set_cached_acl(inode, type, acl);
 
-- 
2.33.0


