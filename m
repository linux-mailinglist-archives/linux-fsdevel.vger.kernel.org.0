Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5117C3A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 18:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCFRHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 12:07:51 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.97]:12034 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgCFRHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:07:50 -0500
X-Greylist: delayed 1422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2020 12:07:50 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id D0FD8565EF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2020 10:44:07 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id AG51jNZJCRP4zAG51jkegk; Fri, 06 Mar 2020 10:44:07 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4949jWfNFN1LuKCp4152G5zJnK9VURS26JWdKzebTl8=; b=pbJ8v8Rjw8Waa3sCJFWCCg/4Zr
        JLZcujPDZo6DGBnxpiVT8/sj5C4Q/S7lg/GlBtpJl47aH85EFViK6u6wWsIwD/I/qkCQWV2CWNEth
        h5FRlKuCamjf9igMkmOYgjmtI9eKWBxyrHYA2tnEUgZdYh6RN9bktPvCsEnBtl3M81jX994AAlm+7
        jEqaQp5hUmg9IkyjLHRmN/m7ddVsdgHDPeA9kXCpELGMAJHwX9m+lhidS6CE8tCAU0TJM7UD8K4lY
        FUmb+RIvvG58YhWt4tXMvB1haWRf+rj08yYyGoC7LM190hD5i+oGyRq6ptNyiJSyY+eNPQAIo0u48
        jsBM53+w==;
Received: from [201.166.190.127] (port=51762 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jAG50-001rRz-1d; Fri, 06 Mar 2020 10:44:06 -0600
Date:   Fri, 6 Mar 2020 10:47:12 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] fs/binfmt_elf.c: Replace zero-length array with
 flexible-array member
Message-ID: <20200306164712.GA21930@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.166.190.127
X-Source-L: No
X-Exim-ID: 1jAG50-001rRz-1d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.190.127]:51762
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13f25e241ac4..6a7f1fc26eb1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1664,7 +1664,7 @@ struct elf_thread_core_info {
 	struct elf_thread_core_info *next;
 	struct task_struct *task;
 	struct elf_prstatus prstatus;
-	struct memelfnote notes[0];
+	struct memelfnote notes[];
 };
 
 struct elf_note_info {
-- 
2.25.0

