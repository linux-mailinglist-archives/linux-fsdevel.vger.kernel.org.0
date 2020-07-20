Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF9225B7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 11:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgGTJZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 05:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgGTJZ1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:25:27 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738D922482;
        Mon, 20 Jul 2020 09:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595237127;
        bh=vyyX1LP4325hfnYgliYCjSjLjNxzM/CYe+v7FBLTqDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5qTGQIOWj1V9NU4yK00jz5UQP5Nt5v+OLzEYnJ2fYYF2s2RpuPHOjWCkAadxsvBt
         KfGvj5cZa5KE3IDq7FgOMY35cboLHnI1EYroJXHTtzwIE4rD8KANUXvfFp/YUVmUzZ
         gfaX0xMnS7xqZREdic3XBeaF92Yg2TjKzwFszmFw=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH 2/6] mmap: make mlock_future_check() global
Date:   Mon, 20 Jul 2020 12:24:31 +0300
Message-Id: <20200720092435.17469-3-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720092435.17469-1-rppt@kernel.org>
References: <20200720092435.17469-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

It will be used by the upcoming secret memory implementation.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/internal.h | 3 +++
 mm/mmap.c     | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9886db20d94f..af0a92f8f6bc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -349,6 +349,9 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
 extern void mlock_vma_page(struct page *page);
 extern unsigned int munlock_vma_page(struct page *page);
 
+extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
+			      unsigned long len);
+
 /*
  * Clear the page's PageMlocked().  This can be useful in a situation where
  * we want to unconditionally remove a page from the pagecache -- e.g.,
diff --git a/mm/mmap.c b/mm/mmap.c
index 59a4682ebf3f..4dd40a4fedfb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1310,9 +1310,8 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
 	return hint;
 }
 
-static inline int mlock_future_check(struct mm_struct *mm,
-				     unsigned long flags,
-				     unsigned long len)
+int mlock_future_check(struct mm_struct *mm, unsigned long flags,
+		       unsigned long len)
 {
 	unsigned long locked, lock_limit;
 
-- 
2.26.2

