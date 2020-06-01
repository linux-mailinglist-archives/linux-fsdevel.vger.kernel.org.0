Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901CA1EA319
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 13:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgFALvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 07:51:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgFALvx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:51:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9DE07D15174F6FB97AB7;
        Mon,  1 Jun 2020 19:51:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 19:51:44 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] userfaultfd: eliminate meaningless check in userfaultfd_register()
Date:   Mon, 1 Jun 2020 19:55:21 +0800
Message-ID: <1591012521-517-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

When we reach here, !(cur->vm_flags & VM_MAYWRITE) is already checked and
equals to false. So the condition here always equals to false and should
be eliminated.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/userfaultfd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e39fdec8a0b0..e529e6bbb57b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1409,8 +1409,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 			if (end & (vma_hpagesize - 1))
 				goto out_unlock;
 		}
-		if ((vm_flags & VM_UFFD_WP) && !(cur->vm_flags & VM_MAYWRITE))
-			goto out_unlock;
 
 		/*
 		 * Check that this vma isn't already owned by a
-- 
2.19.1

