Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A66441C587
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344200AbhI2N2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 09:28:21 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:45546 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344147AbhI2N2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:28:16 -0400
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Sep 2021 09:28:16 EDT
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 7E4CB1008CBC1;
        Wed, 29 Sep 2021 21:17:34 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 683C3200B5753;
        Wed, 29 Sep 2021 21:17:34 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VQDhVj2_m4GK; Wed, 29 Sep 2021 21:17:34 +0800 (CST)
Received: from guozhi-ipads.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 0C34E200B574E;
        Wed, 29 Sep 2021 21:17:28 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Guo Zhi <qtxuning1999@sjtu.edu.cn>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/elf: Fix kernel pointer leak
Date:   Wed, 29 Sep 2021 21:17:02 +0800
Message-Id: <20210929131703.1163417-1-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pointers should be printed with %p rather than %px
which printed kernel pointer directly.
Change %px to %p to print the secured pointer.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f3523807dbca..440a483656ed 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -393,7 +393,7 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 
 	if ((type & MAP_FIXED_NOREPLACE) &&
 	    PTR_ERR((void *)map_addr) == -EEXIST)
-		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
+		pr_info("%d (%s): Uhuuh, elf segment at %p requested but the memory is mapped already\n",
 			task_pid_nr(current), current->comm, (void *)addr);
 
 	return(map_addr);
-- 
2.33.0

