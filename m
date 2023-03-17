Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4CF6BE71C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 11:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCQKn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 06:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCQKnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:43:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A91B1165E;
        Fri, 17 Mar 2023 03:43:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 449631FE73;
        Fri, 17 Mar 2023 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679049803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=deQFA7TD3kp7a2tFPZHUMYv9MT3jjYq+TC4fiGinDEs=;
        b=NmQ1hyth5qRE678Uo3LQnyTdg0QQSYpHOUPH7Uhuc4G43s/Q0vvr/DUvri19hj91joa5LE
        hFCEleVrUuJbUsG+BimyBZBOCIfxBJiIDV80Z9fsxXw1oySqpE4cp+/zsI1b/NzEN98+ko
        T131W4JpotVd1/+2SSdSDPm2mvLWoZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679049803;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=deQFA7TD3kp7a2tFPZHUMYv9MT3jjYq+TC4fiGinDEs=;
        b=+NeEMil1mpgbidAjq5vNwGwIMLmjxya2mK0WEBJXywic5vP42eTHWjt9xpdFzGx4iMCyG/
        Za3BUsW4qdht6PCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1478B13A3E;
        Fri, 17 Mar 2023 10:43:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gEpjBEtEFGRgdwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 17 Mar 2023 10:43:23 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-doc@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 3/6] mm, pagemap: remove SLOB and SLQB from comments and documentation
Date:   Fri, 17 Mar 2023 11:43:04 +0100
Message-Id: <20230317104307.29328-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230317104307.29328-1-vbabka@suse.cz>
References: <20230317104307.29328-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SLOB has been removed and SLQB never merged, so remove their mentions
from comments and documentation of pagemap.

In stable_page_flags() also correct an outdated comment mentioning that
PageBuddy() means a page->_refcount of -1, and remove compound_head()
from the PageSlab() call, as that's already implicitly there thanks to
PF_NO_TAIL.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 Documentation/admin-guide/mm/pagemap.rst | 6 +++---
 fs/proc/page.c                           | 9 ++++-----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index b5f970dc91e7..c8f380271cad 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -91,9 +91,9 @@ Short descriptions to the page flags
    The page is being locked for exclusive access, e.g. by undergoing read/write
    IO.
 7 - SLAB
-   The page is managed by the SLAB/SLOB/SLUB/SLQB kernel memory allocator.
-   When compound page is used, SLUB/SLQB will only set this flag on the head
-   page; SLOB will not flag it at all.
+   The page is managed by the SLAB/SLUB kernel memory allocator.
+   When compound page is used, either will only set this flag on the head
+   page.
 10 - BUDDY
     A free memory block managed by the buddy system allocator.
     The buddy system organizes free memory in blocks of various orders.
diff --git a/fs/proc/page.c b/fs/proc/page.c
index 6249c347809a..195b077c0fac 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -125,7 +125,7 @@ u64 stable_page_flags(struct page *page)
 	/*
 	 * pseudo flags for the well known (anonymous) memory mapped pages
 	 *
-	 * Note that page->_mapcount is overloaded in SLOB/SLUB/SLQB, so the
+	 * Note that page->_mapcount is overloaded in SLAB, so the
 	 * simple test in page_mapped() is not enough.
 	 */
 	if (!PageSlab(page) && page_mapped(page))
@@ -165,9 +165,8 @@ u64 stable_page_flags(struct page *page)
 
 
 	/*
-	 * Caveats on high order pages: page->_refcount will only be set
-	 * -1 on the head page; SLUB/SLQB do the same for PG_slab;
-	 * SLOB won't set PG_slab at all on compound pages.
+	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
+	 * on the head page.
 	 */
 	if (PageBuddy(page))
 		u |= 1 << KPF_BUDDY;
@@ -185,7 +184,7 @@ u64 stable_page_flags(struct page *page)
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
 
 	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
-	if (PageTail(page) && PageSlab(compound_head(page)))
+	if (PageTail(page) && PageSlab(page))
 		u |= 1 << KPF_SLAB;
 
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
-- 
2.39.2

