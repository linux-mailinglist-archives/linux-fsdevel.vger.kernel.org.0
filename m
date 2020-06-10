Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0641F5C8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgFJUOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbgFJUNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70062C08C5C4;
        Wed, 10 Jun 2020 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dF5YEmT9Y0mz257W7R1ii4B+4s7NOgT8Bu3BT5oY2ho=; b=EPazLIDr93LkbLUXA/XEkeIaqW
        M4D79yYSexbJQKp4e7KgytNN1RX1Nja+Sf2bh71IH+fgX9WefFpfjzq3AjwsoykssxyFGtS5KUr55
        56VWS40jx1q3jaLhLRK04asv4UV4fKk2EPMm9myplwpUCa+xuu6ydF8i3d5KjPZQUktBBQH5Qy1sM
        srz+sg4k/ihuArvqE0GnoZj2vWQWawyqnpwH6WJGW5L1cIKz9TelPRgraZVkKNdDzFM5SFa4zFNoi
        wfeN4vKsMjoejlApTe2M6X5zQozWPwcroZYe1JmW0LgwLGHiV794dsCexOSIy7R+hLKPSVBrZAvR6
        26HRoWrA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003Sv-9t; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/51] mm: Print the inode number in dump_page
Date:   Wed, 10 Jun 2020 13:12:56 -0700
Message-Id: <20200610201345.13273-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The inode number helps correlate this page with debug messages elsewhere
in the kernel.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 384eef80649d..e30e35b41d0e 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -133,15 +133,16 @@ void __dump_page(struct page *page, const char *reason)
 			goto out_mapping;
 		}
 
-		if (probe_kernel_read(&dentry_first,
-			&host->i_dentry.first, sizeof(struct hlist_node *))) {
+		if (probe_kernel_read(&dentry_first, &host->i_dentry.first,
+					sizeof(struct hlist_node *))) {
 			pr_warn("mapping->a_ops:%ps with invalid mapping->host inode address %px\n",
 				a_ops, host);
 			goto out_mapping;
 		}
 
 		if (!dentry_first) {
-			pr_warn("mapping->a_ops:%ps\n", a_ops);
+			pr_warn("mapping->a_ops:%ps ino %lx\n", a_ops,
+					host->i_ino);
 			goto out_mapping;
 		}
 
@@ -156,8 +157,8 @@ void __dump_page(struct page *page, const char *reason)
 			 * crash, but it's unlikely that we reach here with a
 			 * corrupted struct page
 			 */
-			pr_warn("mapping->aops:%ps dentry name:\"%pd\"\n",
-								a_ops, &dentry);
+			pr_warn("mapping->aops:%ps ino %lx dentry name:\"%pd\"\n",
+					a_ops, host->i_ino, &dentry);
 		}
 	}
 out_mapping:
-- 
2.26.2

