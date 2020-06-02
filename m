Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3101EB2FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 03:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgFBBbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 21:31:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5835 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbgFBBbQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 21:31:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4E73E4485C0BB0CF2468;
        Tue,  2 Jun 2020 09:31:12 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 09:31:06 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-afs@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dhowells@redhat.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3] afs: Fix memory leak in afs_put_sysnames()
Date:   Tue, 2 Jun 2020 09:30:45 +0800
Message-ID: <20200602013045.321855-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_put_sysnames() to actually free the specified afs_sysnames
object after its reference count has been decreased to zero and
its contents have been released.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: <Stable@vger.kernel.org> # v4.17+
Fixes: 6f8880d8e681557 ("afs: Implement @sys substitution handling")
---
 fs/afs/proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 468e1713bce1..6f34c84a0fd0 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -563,6 +563,7 @@ void afs_put_sysnames(struct afs_sysnames *sysnames)
 			if (sysnames->subs[i] != afs_init_sysname &&
 			    sysnames->subs[i] != sysnames->blank)
 				kfree(sysnames->subs[i]);
+		kfree(sysnames);
 	}
 }
 
-- 
2.25.4

