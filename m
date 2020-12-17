Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DE22DD274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 14:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgLQNve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 08:51:34 -0500
Received: from smtp.h3c.com ([60.191.123.56]:58084 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQNve (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:51:34 -0500
X-Greylist: delayed 7900 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Dec 2020 08:51:33 EST
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 0BHBdokK096789
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 19:39:50 +0800 (GMT-8)
        (envelope-from zhang.yanjunA@h3c.com)
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([10.8.0.70])
        by h3cspam01-ex.h3c.com with ESMTP id 0BHBcPdV095977;
        Thu, 17 Dec 2020 19:38:26 +0800 (GMT-8)
        (envelope-from zhang.yanjunA@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 17 Dec 2020 19:38:29 +0800
From:   Yanjun Zhang <zhang.yanjuna@h3c.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yanjun Zhang <zhang.yanjuna@h3c.com>
Subject: [PATCH] writeback: add warning messages for not registered bdi
Date:   Thu, 17 Dec 2020 19:28:01 +0800
Message-ID: <20201217112801.22421-1-zhang.yanjuna@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0BHBcPdV095977
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The device name is only printed for the warning case, that bdi is not
registered detected by the function __mark_inode_dirty. Besides, the
device name returned by bdi_dev_name may be "(unknown)" in some cases.

This patch add printed messages about the inode and super block. Once
trigging this warning, we could make more direct analysis.

Signed-off-by: Yanjun Zhang <zhang.yanjuna@h3c.com>
---
 fs/fs-writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e6005c78b..825160cf4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2323,7 +2323,8 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 
 			WARN((wb->bdi->capabilities & BDI_CAP_WRITEBACK) &&
 			     !test_bit(WB_registered, &wb->state),
-			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
+			     "bdi-%s not registered, dirtied inode %lu on %s\n",
+			     bdi_dev_name(wb->bdi), inode->i_ino, sb->s_id);
 
 			inode->dirtied_when = jiffies;
 			if (dirtytime)
-- 
2.17.1

