Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C481A2E82E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jan 2021 05:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbhAAEaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Dec 2020 23:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbhAAEaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Dec 2020 23:30:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4273AC061573;
        Thu, 31 Dec 2020 20:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=03MHVj7uFca2pur9ftrcvmwDErnMJojp89WXgKNO4AA=; b=ulXhILNkO4Vn79Fz0WFS5QtaVf
        qFVb6mSuOHgqmfqc1tMBC67fYnpVzBFFXg3A4KfH4e8wRzR55lj+uaovFmy4DxEmleKrSjZ2LdGbQ
        ac7wa5VoRQUnjiBgRnbVQWRzf+hGu+NG1PQyfbh3wrjL5bHHzEEx1Ps0vVzBbjNC1KRlsMaYiEQtE
        S0WcdNbWWEbIvEBHdnKLZWUqsXVgFNXvgRWbsh7EcrPb1WPDe2yvILSvE3WKeDBEn6e5kpJ/5lbqr
        eA+tcvY7ADwkPGBS/IS5raxViLjPSg3TI2JwcGA/8KrnyVI8vj0kKe6Ek0zxYU6WWZLOOHKajeUkL
        8ZUS163Q==;
Received: from [2601:1c0:6280:3f0::2c43] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kvC41-0006xy-6o; Fri, 01 Jan 2021 04:29:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vineet Gupta <vgupts@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
Date:   Thu, 31 Dec 2020 20:29:14 -0800
Message-Id: <20210101042914.5313-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/dax.c uses copy_user_page() but ARC does not provide that interface,
resulting in a build error.

Provide copy_user_page() in <asm/page.h> (beside copy_page()) and
add <asm/page.h> to fs/dax.c to fix the build error.

../fs/dax.c: In function 'copy_cow_page_dax':
../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]

Fixes: cccbce671582 ("filesystem-dax: convert to dax_direct_access()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Dan Williams <dan.j.williams@intel.com>
Acked-by: Vineet Gupta <vgupts@synopsys.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
---
v2: rebase, add more Cc:

 arch/arc/include/asm/page.h |    1 +
 fs/dax.c                    |    1 +
 2 files changed, 2 insertions(+)

--- lnx-511-rc1.orig/fs/dax.c
+++ lnx-511-rc1/fs/dax.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <asm/page.h>
 #include <asm/pgalloc.h>
 
 #define CREATE_TRACE_POINTS
--- lnx-511-rc1.orig/arch/arc/include/asm/page.h
+++ lnx-511-rc1/arch/arc/include/asm/page.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #define clear_page(paddr)		memset((paddr), 0, PAGE_SIZE)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 #define copy_page(to, from)		memcpy((to), (from), PAGE_SIZE)
 
 struct vm_area_struct;
