Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706F21212B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfEBRnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 13:43:15 -0400
Received: from gateway30.websitewelcome.com ([192.185.197.25]:18859 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbfEBRnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 13:43:15 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2019 13:43:15 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A6996FE19
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2019 11:57:38 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id MF1ehMRhfiQerMF1eh1xTd; Thu, 02 May 2019 11:57:38 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.203] (port=38124 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hMF1b-00233d-Ko; Thu, 02 May 2019 11:57:37 -0500
Date:   Thu, 2 May 2019 11:57:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] posix_acl: Use struct_size() helper
Message-ID: <20190502165733.GA3679@embeddedor>
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
X-Source-IP: 189.250.119.203
X-Source-L: No
X-Exim-ID: 1hMF1b-00233d-Ko
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.203]:38124
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace code of the following form:

sizeof(struct posix_acl) + count * sizeof(struct posix_acl_entry)

with:

struct_size(acl, a_entries, count)

and so on...

Notice that variable size is unnecessary, hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/posix_acl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 2fd0fde16fe1..d654d8f87280 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -175,9 +175,9 @@ EXPORT_SYMBOL(posix_acl_init);
 struct posix_acl *
 posix_acl_alloc(int count, gfp_t flags)
 {
-	const size_t size = sizeof(struct posix_acl) +
-	                    count * sizeof(struct posix_acl_entry);
-	struct posix_acl *acl = kmalloc(size, flags);
+	struct posix_acl *acl;
+
+	acl = kmalloc(struct_size(acl, a_entries, count), flags);
 	if (acl)
 		posix_acl_init(acl, count);
 	return acl;
@@ -193,9 +193,9 @@ posix_acl_clone(const struct posix_acl *acl, gfp_t flags)
 	struct posix_acl *clone = NULL;
 
 	if (acl) {
-		int size = sizeof(struct posix_acl) + acl->a_count *
-		           sizeof(struct posix_acl_entry);
-		clone = kmemdup(acl, size, flags);
+		clone = kmemdup(acl,
+				struct_size(clone, a_entries, acl->a_count),
+				flags);
 		if (clone)
 			refcount_set(&clone->a_refcount, 1);
 	}
-- 
2.21.0

