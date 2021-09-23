Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F337841623D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbhIWPmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 11:42:37 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:39386 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241995AbhIWPme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:42:34 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 7B18082328;
        Thu, 23 Sep 2021 18:41:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632411660;
        bh=GoAZ0/CRy27WnTWJaxXB1eOiw+SfG4rWLmsGg9C3DZ8=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=ruF27QuU0NH2Xs6prrDvO3iHpgeOH2BEKOh2il5sPT9sK6Pt9tM5ln4hXxKcTdsGV
         NgSqoF3xc1096WRzUWcM4+iirYSHoEBC2RbMP5enVOUw19KP0pwX/O31gr4K3b+m0Z
         4JUXrIABtEsM0HX0MSaF4o+k9N4VxFf0UZnXMY1w=
Received: from [192.168.211.73] (192.168.211.73) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 23 Sep 2021 18:41:00 +0300
Message-ID: <93b2af74-22c2-4f36-8ad7-c1cb035e00f4@paragon-software.com>
Date:   Thu, 23 Sep 2021 18:40:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH v2 1/6] fs/ntfs3: Fix logical error in ntfs_create_inode
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

We need to always call indx_delete_entry after indx_insert_entry
if error occurred.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index d583b71bec50..d51bf4018835 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1575,7 +1575,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 	if (!S_ISLNK(mode) && (sb->s_flags & SB_POSIXACL)) {
 		err = ntfs_init_acl(mnt_userns, inode, dir);
 		if (err)
-			goto out6;
+			goto out7;
 	} else
 #endif
 	{
-- 
2.33.0


