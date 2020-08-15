Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBEF24539A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Aug 2020 00:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgHOWDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Aug 2020 18:03:35 -0400
Received: from smtp.h3c.com ([60.191.123.56]:39079 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgHOWDf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:03:35 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Aug 2020 18:03:34 EDT
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 07FB3uNj034474;
        Sat, 15 Aug 2020 19:03:56 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 07FB3im8034424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Aug 2020 19:03:44 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 15 Aug 2020 19:03:47 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <namjae.jeon@samsung.com>, <sj1557.seo@samsung.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] exfat: use i_blocksize() to get blocksize
Date:   Sat, 15 Aug 2020 18:57:07 +0800
Message-ID: <20200815105707.19701-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 07FB3im8034424
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We alreday has the interface i_blocksize() to get blocksize,
so use it.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 fs/exfat/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index a6a063830..163b599db 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -226,7 +226,7 @@ void exfat_truncate(struct inode *inode, loff_t size)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	unsigned int blocksize = 1 << inode->i_blkbits;
+	unsigned int blocksize = i_blocksize(inode);
 	loff_t aligned_size;
 	int err;
 
-- 
2.17.1

