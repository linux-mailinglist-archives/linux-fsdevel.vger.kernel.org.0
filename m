Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6061AA43E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635933AbgDONUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 09:20:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2506326AbgDONUt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:20:49 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 21A454C74A24939194E6;
        Wed, 15 Apr 2020 21:20:45 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 21:20:35 +0800
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <npiggin@kernel.dk>, <zyan@redhat.com>,
        <hartleys@visionengravers.com>, Yanxiaodan <yanxiaodan@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] dcache: unlock inode->i_lock before goto restart tag in,
 d_prune_aliases
Message-ID: <c3a3d3d2-dad4-a4fe-014f-3f5eb3561524@huawei.com>
Date:   Wed, 15 Apr 2020 21:20:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

coccicheck reports:
  fs/dcache.c:1027:1-10: second lock on line 1027

In d_prune_aliases, before goto restart we should unlock
inode->i_lock.

Fixes: 29355c3904e ("d_prune_alias(): just lock the parent and call __dentry_kill()")
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Feilong Lin <linfeilong@huawei.com>
---
 fs/dcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index b280e07e162b..1532ebe9d9ca 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1030,6 +1030,7 @@ void d_prune_aliases(struct inode *inode)
 		if (!dentry->d_lockref.count) {
 			struct dentry *parent = lock_parent(dentry);
 			if (likely(!dentry->d_lockref.count)) {
+				spin_unlock(&inode->i_lock);
 				__dentry_kill(dentry);
 				dput(parent);
 				goto restart;
-- 
2.19.1

