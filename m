Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565EB7752BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 08:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjHIGQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjHIGQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:16:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C5A1FEA;
        Tue,  8 Aug 2023 23:16:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.218.230])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96DB566071B0;
        Wed,  9 Aug 2023 07:16:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691561794;
        bh=d1JzgXg4it2dCo40JY/rVCAzdGTdQgXd73Ed8NneIJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIfFg+hwomA6kJQ+/JBDTwe+MUKcElOB/asCqG5r5ymzocPhDA8EpyfVwu6vPedGH
         AqiRsRHT0SdaFo38dPgrD7e3IOoB4mjRzdxY/rUD2nOLteO1zLdxr9zVzSKaEbQ8iU
         NDsAsCOkbl7swLM1pmaXJtPNxQF8Y4OOtQyMAsyXEUD9tEIXRjRGJAwWpqtAstrDm2
         Vd0ili0WhU5ag1TXV2+GBEr0moPF/PiHekR7mciB3A0psNAcy0ItsCMCI19PPKSr5W
         t7G4S6lrUO6Kd3KdVn52Fm8O5Jqs2CALuCsu3sV1JOZvCiXaLOoj53ZcPVLd0FhvGN
         rzz1EPAlimj5w==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v28 3/6] fs/proc/task_mmu: Add fast paths to get/clear PAGE_IS_WRITTEN flag
Date:   Wed,  9 Aug 2023 11:16:00 +0500
Message-Id: <20230809061603.1969154-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809061603.1969154-1-usama.anjum@collabora.com>
References: <20230809061603.1969154-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding fast code paths to handle specifically only get and/or clear
operation of PAGE_IS_WRITTEN, increases its performance by 0-35%.
The results of some test cases are given below:

Test-case-1
t1 = (Get + WP) time
t2 = WP time
                       t1            t2
Without this patch:    140-170mcs    90-115mcs
With this patch:       110mcs        80mcs
Worst case diff:       35% faster    30% faster

Test-case-2
t3 = atomic Get and WP
                      t3
Without this patch:   120-140mcs
With this patch:      100-110mcs
Worst case diff:      21% faster

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
The test to measure the performance can be found: https://is.gd/FtSKcD
8 8192 3 1 0 and 8 8192 3 1 1 arguments have been used to produce the
above mentioned results.
---
 fs/proc/task_mmu.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0e219a44e97cd..e336ec0151185 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2107,6 +2107,43 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
 		return 0;
 	}
 
+	if (!p->vec_out) {
+		/* Fast path for performing exclusive WP */
+		for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
+			if (pte_uffd_wp(ptep_get(pte)))
+				continue;
+			make_uffd_wp_pte(vma, addr, pte);
+			if (!flush) {
+				start = addr;
+				flush = true;
+			}
+		}
+		goto flush_and_return;
+	}
+
+	if (!p->arg.category_anyof_mask && !p->arg.category_inverted &&
+	    p->arg.category_mask == PAGE_IS_WRITTEN &&
+	    p->arg.return_mask == PAGE_IS_WRITTEN) {
+		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
+			unsigned long next = addr + PAGE_SIZE;
+
+			if (pte_uffd_wp(ptep_get(pte)))
+				continue;
+			ret = pagemap_scan_output(p->cur_vma_category | PAGE_IS_WRITTEN,
+						  p, addr, &next);
+			if (next == addr)
+				break;
+			if (~p->arg.flags & PM_SCAN_WP_MATCHING)
+				continue;
+			make_uffd_wp_pte(vma, addr, pte);
+			if (!flush) {
+				start = addr;
+				flush = true;
+			}
+		}
+		goto flush_and_return;
+	}
+
 	for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
 		unsigned long categories = p->cur_vma_category |
 					   pagemap_page_category(p, vma, addr, ptep_get(pte));
@@ -2131,6 +2168,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
 		}
 	}
 
+flush_and_return:
 	if (flush)
 		flush_tlb_range(vma, start, addr);
 
-- 
2.39.2

