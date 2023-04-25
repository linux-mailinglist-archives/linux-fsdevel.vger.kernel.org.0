Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A66EEA64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjDYWrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 18:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjDYWri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:47:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6951083FF;
        Tue, 25 Apr 2023 15:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=87iK9xe7jEqj8FLY0xzpJ9YnRE4JGcq0drEI9hyBNkg=; b=4GfYCANTWjgXmoHN3XcHAVqKhO
        Wm5QWX6++YtnjHBHGHTg60GjAXJv2MBHw1WsvoLZQiL4aS3HYRPL8o038Zyy//LYPN/RYVgeyVeQM
        X6i7qDdmf+qoG5ZqIXTdD3rlXXv2jPXqw4g075XwfVDxzP3KdNKp6mh5iKdURhV0fWZfqvoVebtTK
        XEdzUgPdfKi+1WkSFhz9VnapS1pwd6iQxOqpytTjH2F6h2JPQXoFKpKBlVqziSdShIbFjFi/DVJXW
        MivQsut8Fi7nthd99bs6L4ydH/A6Eucfaj0zSPGiVhbBOGE0y1pHBncki098sN+u6OuPqW7q7irHu
        BJGorXPQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prRRU-002Lqt-2S;
        Tue, 25 Apr 2023 22:47:24 +0000
Date:   Tue, 25 Apr 2023 15:47:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>, hughd@google.com,
        willy@infradead.org
Cc:     akpm@linux-foundation.org, brauner@kernel.org, djwong@kernel.org,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org, hare@suse.de,
        kbusch@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/8] shmem: convert to use folio_test_hwpoison()
Message-ID: <ZEhYfHePaLpoUhbp@bombadil.infradead.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
 <20230421214400.2836131-3-mcgrof@kernel.org>
 <ZEMRbcHSQqyek8Ov@casper.infradead.org>
 <CGME20230425110913eucas1p22cf9d4c7401881999adb12134b985273@eucas1p2.samsung.com>
 <20230425110025.7tq5vdr2jfom2zdh@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425110025.7tq5vdr2jfom2zdh@localhost>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 01:00:25PM +0200, Pankaj Raghav wrote:
> On Fri, Apr 21, 2023 at 11:42:53PM +0100, Matthew Wilcox wrote:
> > On Fri, Apr 21, 2023 at 02:43:54PM -0700, Luis Chamberlain wrote:
> > > The PageHWPoison() call can be converted over to the respective folio call
> > > folio_test_hwpoison(). This introduces no functional changes.
> > 
> > Um, no.  Nobody should use folio_test_hwpoison(), it's a nonsense.
> > 
> > Individual pages are hwpoisoned.  You're only testing the head page
> > if you use folio_test_hwpoison().  There's folio_has_hwpoisoned() to
> > test if _any_ page in the folio is poisoned.  But blindly converting
> > PageHWPoison to folio_test_hwpoison() is wrong.
> 
> I see a pattern in shmem.c where first the head is tested and for large
> folios, any of pages in the folio is tested for poison flag. Should we
> factor it out as a helper in shmem.c and use it here?
> 
> static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
> ...
> 	if (folio_test_hwpoison(folio) ||
> 	    (folio_test_large(folio) &&
> 	     folio_test_has_hwpoisoned(folio))) {
> 	..

Hugh's commit 72887c976a7c9e ("shmem: minor fixes to splice-read
implementation") is on point about this :

  "Perhaps that ugliness can be improved at the mm end later"

So how about we put some lipstick on this guy now (notice right above it
a similar compound page check for is_page_hwpoison()):

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c68d67b832f..6a4a571dbe50 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -883,6 +883,13 @@ static inline bool is_page_hwpoison(struct page *page)
 	return PageHuge(page) && PageHWPoison(compound_head(page));
 }
 
+static inline bool is_folio_hwpoison(struct folio *folio)
+{
+	if (folio_test_hwpoison(folio))
+		return true;
+	return folio_test_large(folio) && folio_test_has_hwpoisoned(folio);
+}
+
 /*
  * For pages that are never mapped to userspace (and aren't PageSlab),
  * page_type may be used.  Because it is initialised to -1, we invert the
diff --git a/mm/shmem.c b/mm/shmem.c
index ef7ad684f4fb..b7f47f6b75d5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3013,9 +3013,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		if (folio) {
 			folio_unlock(folio);
 
-			if (folio_test_hwpoison(folio) ||
-			    (folio_test_large(folio) &&
-			     folio_test_has_hwpoisoned(folio))) {
+			if (is_folio_hwpoison(folio)) {
 				error = -EIO;
 				break;
 			}
