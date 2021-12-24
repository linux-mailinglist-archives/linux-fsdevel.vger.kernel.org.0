Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0A847EC19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351692AbhLXGXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351571AbhLXGXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7758DC061759;
        Thu, 23 Dec 2021 22:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TXOg6vAqASAtXPc4PNjieJzyV7xM2+Tbu5xGMKnWiwg=; b=Xs9iWhoTKLK3zCqDrDiBJ9agGb
        RCP0wHnFSbW5sI/jLd4O634Q6AnHsu3zpw1JUZyorSLPs4Qk5fjcjifU8s1BhitewH+Iqc9da0WKR
        y5g5wk5ErDspgUCncqSG/RGzXOBarTvKUsg2Tmy80w9HCLebL2/h7D1YYtAUJqHO3ucmS7zySuc1B
        9oeMfW+nTEEOX5ObVVGFAujTLUAdBwHKpz5IZeY1KgAjuHpRlON2feYCOVGTABQtTjr7EYHqzudje
        CDauuNIuPtSkhysUkzbwycfRQCqyQ1l2CCWUDjp6VomRMrLO43XIfjd6YrhPFg7LUIyB73OdDZrRR
        wWhz05FQ==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dz7-00Dn8N-IH; Fri, 24 Dec 2021 06:23:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 11/13] mm: mark swap_lock and swap_active_head static
Date:   Fri, 24 Dec 2021 07:22:44 +0100
Message-Id: <20211224062246.1258487-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

swap_lock and swap_active_head are only used in swapfile.c, so mark them
static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swapfile.h | 2 --
 mm/swapfile.c            | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index 809cd01ef2c57..54078542134c1 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -6,8 +6,6 @@
  * these were static in swapfile.c but frontswap.c needs them and we don't
  * want to expose them to the dozens of source files that include swap.h
  */
-extern spinlock_t swap_lock;
-extern struct plist_head swap_active_head;
 extern struct swap_info_struct *swap_info[];
 extern unsigned long generic_max_swapfile_size(void);
 extern unsigned long max_swapfile_size(void);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 82342c77791bb..bf0df7aa7158f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -49,7 +49,7 @@ static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
 static void free_swap_count_continuations(struct swap_info_struct *);
 
-DEFINE_SPINLOCK(swap_lock);
+static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
 atomic_long_t nr_swap_pages;
 /*
@@ -71,7 +71,7 @@ static const char Unused_offset[] = "Unused swap offset entry ";
  * all active swap_info_structs
  * protected with swap_lock, and ordered by priority.
  */
-PLIST_HEAD(swap_active_head);
+static PLIST_HEAD(swap_active_head);
 
 /*
  * all available (active, not full) swap_info_structs
-- 
2.30.2

