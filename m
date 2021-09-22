Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884B2414DF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 18:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhIVQTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 12:19:51 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:44158 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236478AbhIVQTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:19:51 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 81FB81D1D;
        Wed, 22 Sep 2021 19:18:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632327499;
        bh=P0QxpD6OvYLGv8lTPq3qwBSTDBJSkeBOFJ4WRSqNZgU=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=rhVCNHnmjznucc/VVrqdOfXiULPqrb/ZOmVoPnibCIdlswya729l4z9hR3EGhDw4s
         sNyBF2B9FbZTgA8Y+jWkVti8ybbPWAhBi9QZ9AK07ZO144B+lOlnMmBY6wI9oq14sM
         U4KjBnL47FTlYvVd+3och7ueaCJ5E0q+kWPNhOwo=
Received: from [192.168.211.195] (192.168.211.195) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 22 Sep 2021 19:18:19 +0300
Message-ID: <994cb658-d2f8-a797-e947-35ac0a203ea2@paragon-software.com>
Date:   Wed, 22 Sep 2021 19:18:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH 2/5] fs/ntfs3: Refactor ntfs_get_acl_ex for better readability
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
 fs/ntfs3/xattr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 5c7c5c7a5ec1..3795943efc8e 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -518,12 +518,15 @@ static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
 	/* Translate extended attribute to acl. */
 	if (err >= 0) {
 		acl = posix_acl_from_xattr(mnt_userns, buf, err);
-		if (!IS_ERR(acl))
-			set_cached_acl(inode, type, acl);
+	} else if (err == -ENODATA) {
+		acl = NULL;
 	} else {
-		acl = err == -ENODATA ? NULL : ERR_PTR(err);
+		acl = ERR_PTR(err);
 	}
 
+	if (!IS_ERR(acl))
+		set_cached_acl(inode, type, acl);
+
 	__putname(buf);
 
 	return acl;
-- 
2.33.0


