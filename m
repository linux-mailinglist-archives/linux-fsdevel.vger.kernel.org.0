Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D459463C0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 17:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbhK3Qo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 11:44:59 -0500
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:39096 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232901AbhK3Qo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:44:56 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B95AA40D;
        Tue, 30 Nov 2021 19:41:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1638290490;
        bh=/gt5meQDcE4KHTZT7C03i/3WGT8X/p7mNPvhNZSWk2k=;
        h=Date:To:CC:From:Subject;
        b=mhupN5segY8sg3kmtxwKzBw3B/YaGurptL96TSoz/W6x3KwzD4GQDZRz0mARc3gFq
         onTMwULXEvLqHPCkVp0/KPYkbnXiQIYIAlfvW3LvIan6EZL3M62NfaLZpU8NDExxnn
         qtIZovJLSithA3MS79Lt1MBoTk4dWS2L2vPuVwq8=
Received: from [192.168.211.41] (192.168.211.41) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 30 Nov 2021 19:41:30 +0300
Message-ID: <8b4de37d-1073-ca87-1df8-ccd8d09444af@paragon-software.com>
Date:   Tue, 30 Nov 2021 19:41:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Fix NULL dereference in ntfs_update_mftmirr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.41]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can get NULL pointer to struct super_block.
This commit adds check for such situation.
Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Thread: https://lore.kernel.org/lkml/20211125140816.GC3109@xsang-OptiPlex-9020/

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fsntfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 4de9acb16968..38de8cb53183 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -831,14 +831,17 @@ int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 {
 	int err;
 	struct super_block *sb = sbi->sb;
-	u32 blocksize = sb->s_blocksize;
+	u32 blocksize, bytes;
 	sector_t block1, block2;
-	u32 bytes;
 
-	if (!(sbi->flags & NTFS_FLAGS_MFTMIRR))
+	/*
+	 * sb can be NULL here. In this case sbi->flags should be 0 too.
+	 */
+	if (!sb || !(sbi->flags & NTFS_FLAGS_MFTMIRR))
 		return 0;
 
 	err = 0;
+	blocksize = sb->s_blocksize;
 	bytes = sbi->mft.recs_mirr << sbi->record_bits;
 	block1 = sbi->mft.lbo >> sb->s_blocksize_bits;
 	block2 = sbi->mft.lbo2 >> sb->s_blocksize_bits;
-- 
2.33.1

