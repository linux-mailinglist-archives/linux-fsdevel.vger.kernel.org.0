Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B2217EA62
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 21:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgCIUpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 16:45:52 -0400
Received: from gateway30.websitewelcome.com ([192.185.149.4]:49648 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgCIUpw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:45:52 -0400
X-Greylist: delayed 1452 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 16:45:51 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id BB96F2126F
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2020 15:21:38 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BOuAjAxNCXVkQBOuAjTtmV; Mon, 09 Mar 2020 15:21:38 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KLV5yJSsYHCCLskrtRv6u1HK/r2QKBRZk7ghDZkHXAU=; b=Pz7R/rVH3x7D6lgGJyt/IlsXFD
        euImYoH8hRNDBfV4BZ1XYhTVwl1dQ3eFEbQSbi/XvbNTaWgdhpQkVllgtvc6mrbtk0f8EV+furKzM
        qooxbDinjvIfFFn0ZrfSsgA1m7ElwKde3cs6fLA91c77zfAkPGGBVrvCdO8pooJH2w3ZeHygnTMiO
        y9du0YzGWeBAKfUp4zXuBPrnBWAMzVLtzof7wUVSW038K0ArGnJ7dxtc4aRB3y7sRdseQSRsSIfyb
        MdUFhVvfrNsNxVXII1zwbitya6AEqT753Rh/rZ5yywk13JzP9MLorXZyUE/OetoKt2VztUICOHp89
        PJvm55Jw==;
Received: from [201.162.168.201] (port=20442 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBOu8-000zkz-PA; Mon, 09 Mar 2020 15:21:37 -0500
Date:   Mon, 9 Mar 2020 15:24:49 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] fs: select: Replace zero-length array with
 flexible-array member
Message-ID: <20200309202449.GA9027@embeddedor>
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
X-Source-IP: 201.162.168.201
X-Source-L: No
X-Exim-ID: 1jBOu8-000zkz-PA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.168.201]:20442
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
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
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 11d0285d46b7..f38a8a7480f7 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -97,7 +97,7 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 struct poll_table_page {
 	struct poll_table_page * next;
 	struct poll_table_entry * entry;
-	struct poll_table_entry entries[0];
+	struct poll_table_entry entries[];
 };
 
 #define POLL_TABLE_FULL(table) \
@@ -826,7 +826,7 @@ SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
 struct poll_list {
 	struct poll_list *next;
 	int len;
-	struct pollfd entries[0];
+	struct pollfd entries[];
 };
 
 #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
-- 
2.25.0

