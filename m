Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7896D416287
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbhIWP4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 11:56:04 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:35828 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242259AbhIWP4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:56:03 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5DF091D90;
        Thu, 23 Sep 2021 18:44:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632411840;
        bh=xo6NzBG5zTDvAw5Mm7uDCLaWbmcG9uTUtIcsabAqkkg=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=q14bBxSV0iNF8D2aN5Zg/iJhFJ4sOLzzr/SGZv6Y7+hYWdhvV/mqs2wxAAFUXfJbp
         ZpbWJkt7teA7llmoFWJDkik9YC/1j6ToJ3a28yz/6CHGaN5oVEfhDd0pbO47k56AVm
         FJnVvLXXDqDGgFUeAnK1N6z9kbiycWE8w9OimSxI=
Received: from [192.168.211.73] (192.168.211.73) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 23 Sep 2021 18:43:59 +0300
Message-ID: <7083d062-bee3-f343-4aec-61bcc5f96414@paragon-software.com>
Date:   Thu, 23 Sep 2021 18:43:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH v2 4/6] fs/ntfs3: Pass flags to ntfs_set_ea in ntfs_set_acl_ex
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

In case of removing of xattr there must be XATTR_REPLACE flag and
zero length. We already check XATTR_REPLACE in ntfs_set_ea, so
now we pass XATTR_REPLACE to ntfs_set_ea.

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


