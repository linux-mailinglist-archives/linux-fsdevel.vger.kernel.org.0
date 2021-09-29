Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D353D41CA36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 18:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345791AbhI2Qh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 12:37:28 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:54750 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345687AbhI2Qh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:37:27 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 23B81439;
        Wed, 29 Sep 2021 19:35:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632933344;
        bh=y6nA3GWCbrV+AJ5phsLcgeh14RzUjW20Sad0AwORUTc=;
        h=Date:To:CC:From:Subject;
        b=AhpB6B8J+eGE7340jiIeikVoLgAhUZHszkpgntE5jvth6TstCAoV49vo/JF6Us/IT
         XHmxgFNEk2Ax83dJUYKbieev6CZfa+PRsNLYLihWMdgJjwFcgrA2fWZ/bWTPEiSfNd
         uqv7RQZHWB8zs5yc4U9gYa7rpn912PhpBktrqzAA=
Received: from [192.168.211.131] (192.168.211.131) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 29 Sep 2021 19:35:43 +0300
Message-ID: <227c13e3-5a22-0cba-41eb-fcaf41940711@paragon-software.com>
Date:   Wed, 29 Sep 2021 19:35:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Check for NULL if ATTR_EA_INFO is incorrect
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.131]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This can be reason for reported panic.
Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 9a53f809576d..007602badd90 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3080,7 +3080,9 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
                        const struct EA_INFO *info;
 
                        info = resident_data_ex(attr, sizeof(struct EA_INFO));
-                       dup->ea_size = info->size_pack;
+                       /* If ATTR_EA_INFO exists 'info' can't be NULL. */
+                       if (info)
+                               dup->ea_size = info->size_pack;
                }
        }
 
-- 
2.33.0

