Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26113659BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhDTNRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 09:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232412AbhDTNRd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:17:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A58626101C;
        Tue, 20 Apr 2021 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618924622;
        bh=WQBjtjBUVixKPUq09lDhJ2RWgVokupnypM/eycKpBe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o20bjAEWBJIEF1h8/qnesID8pJlsOtYuQBEFthZNIuah5vjhGL7mYjpmIzPheyOx4
         zLmqEbpr2OKL7I9OmN22sKr2N7ibr2TrEl5aMvAOxoDBtPZqdRTGpZoyJ2PJqkfxJV
         Qbxe7kAtQvCe0Cszrfy03TeNMo4aOoMIbPjQ/IhtksgBNK+KbWwn5JjkQyeTlh+9GW
         7ayegBRJ7F9EeOZgbRVUmdGD+Gtl0pbyUlvLoUAxk3zVPW/ZgQB24WZZ3cq+M4yt5b
         cS+Z7QvAnRl9GQRZmMTOmd34XlEqDq8drJq7x8VbwE6eT/oQpXisCqiOOov/gnN9P+
         LmH3i4FuAUXpw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v2 2/2] secretmem/gup: don't check if page is secretmem without reference
Date:   Tue, 20 Apr 2021 16:16:10 +0300
Message-Id: <20210420131611.8259-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210420131611.8259-1-rppt@kernel.org>
References: <20210420131611.8259-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The check in gup_pte_range() whether a page belongs to a secretmem mapping
is performed before grabbing the page reference.

To avoid potential race move the check after try_grab_compound_head().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index c3a17b189064..4b58c016e949 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2080,13 +2080,13 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
-		if (page_is_secretmem(page))
-			goto pte_unmap;
-
 		head = try_grab_compound_head(page, 1, flags);
 		if (!head)
 			goto pte_unmap;
 
+		if (page_is_secretmem(page))
+			goto pte_unmap;
+
 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
 			put_compound_head(head, 1, flags);
 			goto pte_unmap;
-- 
2.28.0

