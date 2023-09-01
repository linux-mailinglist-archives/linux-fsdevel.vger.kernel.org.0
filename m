Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588E378F9DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbjIAIUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 04:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241886AbjIAIUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:20:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B3610DE;
        Fri,  1 Sep 2023 01:20:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B16B32185C;
        Fri,  1 Sep 2023 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693556430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0WI96qvBSKjcD8skIYDzJyfhIXrX2VNlBg1bDAXSO7w=;
        b=r4AvfguvEQvHBhS4L8lDsEaveieeJTkNCYi5f+9IRURkHs9QHXGXU55bgZKYP/UIN96eLm
        Su7gVEZFmwF5EXNaNlCErp7Hgj8GQqdQewKT6RBq+dcvYVgxoLUZe9WovHMiX8iQwt+NsA
        NGR32KTwfyM1j9J07mti1C+WlqZc3DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693556430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0WI96qvBSKjcD8skIYDzJyfhIXrX2VNlBg1bDAXSO7w=;
        b=LDBeIJn7DjHmpeWPe/JUiDen1A1u3hmJEXiXvjRyh5pbOBnd20g14NvrGZHMhmcFppSIaI
        jb3axaR9hQtT2aCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27C7D1358B;
        Fri,  1 Sep 2023 08:20:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M/8FCc6e8WSYGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 01 Sep 2023 08:20:30 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     seanjc@google.com
Cc:     ackerleytng@google.com, akpm@linux-foundation.org,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        chao.p.peng@linux.intel.com, chenhuacai@kernel.org,
        david@redhat.com, isaku.yamahata@gmail.com, jarkko@kernel.org,
        jmorris@namei.org, kirill.shutemov@linux.intel.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, liam.merwick@oracle.com,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mail@maciej.szmigiero.name,
        maz@kernel.org, michael.roth@amd.com, mpe@ellerman.id.au,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, paul@paul-moore.com, pbonzini@redhat.com,
        qperret@google.com, serge@hallyn.com, tabba@google.com,
        vannapurve@google.com, vbabka@suse.cz, wei.w.wang@intel.com,
        willy@infradead.org, yu.c.zhang@linux.intel.com
Subject: [PATCH gmem FIXUP] mm, compaction: make testing mapping_unmovable() safe
Date:   Fri,  1 Sep 2023 10:20:26 +0200
Message-ID: <20230901082025.20548-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Kirill pointed out, mapping can be removed under us due to
truncation. Test it under folio lock as already done for the async
compaction / dirty folio case. To prevent locking every folio with
mapping to do the test, do it only for unevictable folios, as we can
expect the unmovable mapping folios are also unevictable - it is the
case for guest memfd folios.

Also incorporate comment update suggested by Matthew.

Fixes: 3424873596ce ("mm: Add AS_UNMOVABLE to mark mapping as completely unmovable")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Feel free to squash into 3424873596ce.

 mm/compaction.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a3d2b132df52..e0e439b105b5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -862,6 +862,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 	/* Time to isolate some pages for migration */
 	for (; low_pfn < end_pfn; low_pfn++) {
+		bool is_dirty, is_unevictable;
 
 		if (skip_on_failure && low_pfn >= next_skip_pfn) {
 			/*
@@ -1047,10 +1048,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!mapping && (folio_ref_count(folio) - 1) > folio_mapcount(folio))
 			goto isolate_fail_put;
 
-		/* The mapping truly isn't movable. */
-		if (mapping && mapping_unmovable(mapping))
-			goto isolate_fail_put;
-
 		/*
 		 * Only allow to migrate anonymous pages in GFP_NOFS context
 		 * because those do not depend on fs locks.
@@ -1062,8 +1059,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!folio_test_lru(folio))
 			goto isolate_fail_put;
 
+		is_unevictable = folio_test_unevictable(folio);
+
 		/* Compaction might skip unevictable pages but CMA takes them */
-		if (!(mode & ISOLATE_UNEVICTABLE) && folio_test_unevictable(folio))
+		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
 			goto isolate_fail_put;
 
 		/*
@@ -1075,26 +1074,42 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if ((mode & ISOLATE_ASYNC_MIGRATE) && folio_test_writeback(folio))
 			goto isolate_fail_put;
 
-		if ((mode & ISOLATE_ASYNC_MIGRATE) && folio_test_dirty(folio)) {
-			bool migrate_dirty;
+		is_dirty = folio_test_dirty(folio);
+
+		if (((mode & ISOLATE_ASYNC_MIGRATE) && is_dirty)
+		    || (mapping && is_unevictable)) {
+			bool migrate_dirty = true;
+			bool is_unmovable;
 
 			/*
-			 * Only pages without mappings or that have a
-			 * ->migrate_folio callback are possible to migrate
-			 * without blocking. However, we can be racing with
-			 * truncation so it's necessary to lock the page
-			 * to stabilise the mapping as truncation holds
-			 * the page lock until after the page is removed
-			 * from the page cache.
+			 * Only folios without mappings or that have
+			 * a ->migrate_folio callback are possible to migrate
+			 * without blocking.
+			 *
+			 * Folios from unmovable mappings are not migratable.
+			 *
+			 * However, we can be racing with truncation, which can
+			 * free the mapping that we need to check. Truncation
+			 * holds the folio lock until after the folio is removed
+			 * from the page so holding it ourselves is sufficient.
+			 *
+			 * To avoid this folio locking to inspect every folio
+			 * with mapping for being unmovable, we assume every
+			 * such folio is also unevictable, which is a cheaper
+			 * test. If our assumption goes wrong, it's not a bug,
+			 * just potentially wasted cycles.
 			 */
 			if (!folio_trylock(folio))
 				goto isolate_fail_put;
 
 			mapping = folio_mapping(folio);
-			migrate_dirty = !mapping ||
-					mapping->a_ops->migrate_folio;
+			if ((mode & ISOLATE_ASYNC_MIGRATE) && is_dirty) {
+				migrate_dirty = !mapping ||
+						mapping->a_ops->migrate_folio;
+			}
+			is_unmovable = mapping && mapping_unmovable(mapping);
 			folio_unlock(folio);
-			if (!migrate_dirty)
+			if (!migrate_dirty || is_unmovable)
 				goto isolate_fail_put;
 		}
 
-- 
2.41.0

