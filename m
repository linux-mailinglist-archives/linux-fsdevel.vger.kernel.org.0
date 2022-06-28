Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018FD55E622
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347488AbiF1O4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347485AbiF1Oz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:55:59 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED327FD9;
        Tue, 28 Jun 2022 07:55:57 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 71AFF2130;
        Tue, 28 Jun 2022 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656428100;
        bh=WWbQIsY9Zyf5oRCDPoz7LQM8meE/H7Rdhd/uZEi8WEE=;
        h=Date:To:CC:From:Subject;
        b=QWRyxX03VqcDbsyM5s1zYabodgU9rF58tDBqBAbjV4UtizmWHf6ucjXJEs/TeCpvx
         WxXneDCwFFqYGaYYmVp1JgNb6KzYBJ5NbazE9Ci+skCyRND+xwwdioyGKRVS0p9eEH
         CsqAwD0XJ2JbyXIffLoBwR6MQak7rOaq4fbbUOsA=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 413842D0;
        Tue, 28 Jun 2022 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656428155;
        bh=WWbQIsY9Zyf5oRCDPoz7LQM8meE/H7Rdhd/uZEi8WEE=;
        h=Date:To:CC:From:Subject;
        b=hm6VSXGv57SKkrMd98x7SOIghCi0tySWmTNCh8+kx+dWnoGEobpxhuaS9ihzkslI6
         nRtKCrxVdP/IrIML9cynoia4w1ehTQQq0H+LHBSi11gS6u+8O+RLsFjWdfi/SvKS8x
         wVcLwMVPFPsd8nFZYI6QVYMnUmINVFJ+EpEW0hRY=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 28 Jun 2022 17:55:54 +0300
Message-ID: <a110b84a-b513-8c86-8420-d2029b86aafd@paragon-software.com>
Date:   Tue, 28 Jun 2022 17:55:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Make ntfs_fallocate return -ENOSPC instead of
 -EFBIG
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In some cases we need to return ENOSPC
Fixes xfstest generic/213
Fixes: 114346978cf6 ("fs/ntfs3: Check new size for limits")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/file.c | 13 +++++++++++++
  1 file changed, 13 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index de37d5c1d60b..8fb67bdc81e5 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -670,6 +670,19 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
  		ni_unlock(ni);
  	} else {
  		/* Check new size. */
+
+		/* generic/213: expected -ENOSPC instead of -EFBIG. */
+		if (!is_supported_holes) {
+			loff_t to_alloc = new_size - inode_get_bytes(inode);
+
+			if (to_alloc > 0 &&
+			    (to_alloc >> sbi->cluster_bits) >
+				    wnd_zeroes(&sbi->used.bitmap)) {
+				err = -ENOSPC;
+				goto out;
+			}
+		}
+
  		err = inode_newsize_ok(inode, new_size);
  		if (err)
  			goto out;
-- 
2.36.1

