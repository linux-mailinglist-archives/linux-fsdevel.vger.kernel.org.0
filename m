Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE2598F55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 23:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347045AbiHRVSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 17:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347041AbiHRVRq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:17:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50B7D39B4
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E4wpWtZzYIevzpBbBnTerCEmxL2Wh7527eJL2rvGkAg=; b=vWKNgjakPOh34CQ04vNlIAhzb+
        fpraPWqoLZaFdrcIAUAd6m/TZmU4h/pN8wQOzAL9x3Bg8L5a1d2YFiMX6uH0r7ACHxQKHZHo5+64g
        CzjY0nXrajL7AafJ6ns4vyYQT4kFIBs0DBkKg1QmfRycUJ5fzMJwQqmfZ4hkjMKHHrN10q12w+o95
        HhUTaaVhA9uhZeSmra2vH5NgYYrBaCcPBf+BWYN1bxRDErtoZQ6yhdexKgPc3Yt9EmoSMjujYQd13
        Dp+DQpaiSWKNI5BVXpxcu2HlzDO0/2OQGlZt42kFOJQcSgHJjzATFLy8yvvFOLgQS9ElO5n6g3qu/
        yn8dae6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOmmM-00AHZS-ND; Thu, 18 Aug 2022 21:10:14 +0000
Date:   Thu, 18 Aug 2022 22:10:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC] vmap_folio()
Message-ID: <Yv6qtlSGsHpg02cT@casper.infradead.org>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvvdFrtiW33UOkGr@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 07:08:22PM +0100, Matthew Wilcox wrote:
> For these reasons, I proposing the logical equivalent to this:
> 
> +void *folio_map_local(struct folio *folio)
> +{
> +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> +               return folio_address(folio);
> +       if (!folio_test_large(folio))
> +               return kmap_local_page(&folio->page);
> +       return vmap_folio(folio);
> +}
> 
> (where vmap_folio() is a new function that works a lot like vmap(),
> chunks of this get moved out-of-line, etc, etc., but this concept)

This vmap_folio() compiles but is otherwise untested.  Anything I
obviously got wrong here?

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dd6cdb201195..1867759c33ff 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2848,6 +2848,42 @@ void *vmap(struct page **pages, unsigned int count,
 }
 EXPORT_SYMBOL(vmap);
 
+#ifdef CONFIG_HIGHMEM
+/**
+ * vmap_folio - Map an entire folio into virtually contiguous space
+ * @folio: The folio to map.
+ *
+ * Maps all pages in @folio into contiguous kernel virtual space.  This
+ * function is only available in HIGHMEM builds; for !HIGHMEM, use
+ * folio_address().  The pages are mapped with PAGE_KERNEL permissions.
+ *
+ * Return: The address of the area or %NULL on failure
+ */
+void *vmap_folio(struct folio *folio)
+{
+	size_t size = folio_size(folio);
+	struct vm_struct *area;
+	unsigned long addr;
+
+	might_sleep();
+
+	area = get_vm_area_caller(size, VM_MAP, __builtin_return_address(0));
+	if (!area)
+		return NULL;
+
+	addr = (unsigned long)area->addr;
+	if (vmap_range_noflush(addr, addr + size,
+				folio_pfn(folio) << PAGE_SHIFT,
+				PAGE_KERNEL, folio_shift(folio))) {
+		vunmap(area->addr);
+		return NULL;
+	}
+	flush_cache_vmap(addr, addr + size);
+
+	return area->addr;
+}
+#endif
+
 #ifdef CONFIG_VMAP_PFN
 struct vmap_pfn_data {
 	unsigned long	*pfns;
