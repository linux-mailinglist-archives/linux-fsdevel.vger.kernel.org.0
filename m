Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8A3F9D04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 18:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhH0Qwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 12:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234297AbhH0QwT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630083089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zltTk4Y5c4tY2vgCMzhETo7fDPnjlrUk0T/NxlEENxc=;
        b=W3xUo7qDrVJjUiYfwpwEw2VUFCqAkvmyHFkkPIMeWzhuK6eJhyJzxeQDWJ2Y+E/6S5ERbK
        SltydVGiyv9kBMmHEZXjsFWRBcDX4j1pIJ4o2oF03HJU/bIsd1EEY3oIGxvzJwNgN4GbLd
        jr8+CVeAT6c5F9yPneTgjV8Iv1J/ApY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-y3UaVDVzPnqtm79cLGJbsQ-1; Fri, 27 Aug 2021 12:51:28 -0400
X-MC-Unique: y3UaVDVzPnqtm79cLGJbsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AED901009E28;
        Fri, 27 Aug 2021 16:51:26 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F364B60C81;
        Fri, 27 Aug 2021 16:51:17 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v7 17/19] gup: Introduce FOLL_NOFAULT flag to disable page faults
Date:   Fri, 27 Aug 2021 18:49:24 +0200
Message-Id: <20210827164926.1726765-18-agruenba@redhat.com>
In-Reply-To: <20210827164926.1726765-1-agruenba@redhat.com>
References: <20210827164926.1726765-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new FOLL_NOFAULT flag that causes get_user_pages to return
-EFAULT when it would otherwise trigger a page fault.  This is roughly
similar to FOLL_FAST_ONLY but available on all architectures, and less
fragile.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/mm.h | 3 ++-
 mm/gup.c           | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..958246aa343f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2850,7 +2850,8 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
 #define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
 				 * and return without waiting upon it */
-#define FOLL_POPULATE	0x40	/* fault in page */
+#define FOLL_POPULATE	0x40	/* fault in pages (with FOLL_MLOCK) */
+#define FOLL_NOFAULT	0x80	/* do not fault in pages */
 #define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
 #define FOLL_NUMA	0x200	/* force NUMA hinting page fault */
 #define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
diff --git a/mm/gup.c b/mm/gup.c
index 03ab03b68dc7..69056adcc8c9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -932,6 +932,8 @@ static int faultin_page(struct vm_area_struct *vma,
 	/* mlock all present pages, but do not fault in new pages */
 	if ((*flags & (FOLL_POPULATE | FOLL_MLOCK)) == FOLL_MLOCK)
 		return -ENOENT;
+	if (*flags & FOLL_NOFAULT)
+		return -EFAULT;
 	if (*flags & FOLL_WRITE)
 		fault_flags |= FAULT_FLAG_WRITE;
 	if (*flags & FOLL_REMOTE)
@@ -2857,7 +2859,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
-				       FOLL_FAST_ONLY)))
+				       FOLL_FAST_ONLY | FOLL_NOFAULT)))
 		return -EINVAL;
 
 	if (gup_flags & FOLL_PIN)
-- 
2.26.3

