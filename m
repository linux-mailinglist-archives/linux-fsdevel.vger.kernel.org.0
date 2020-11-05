Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125F22A73A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 01:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbgKEAPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 19:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733094AbgKEANH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:13:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E78C0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 16:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SEQAqZtKm/3mthF4BjoqrZXyqbdphKwVws9Ga2oR7lc=; b=uEFqFxLI3jl0UIRvF09syqWnrz
        igKMq8bnPY40xYM0fU1/aRkd8oGyNTRVjK59xJTmW9gQlD/cpYpnUyq2w0sFjy5RIwHLnBGUC1+BW
        VU7dJA/7FLUrX7QEuz9N5tkPN2duai46gXLVNm6gX7s06swynlmdIjBXFoGg+cAEUeaKl6DK3ciXc
        4eLhhvSBdXiaHKa81NCCIplBlv5RS6QVMNNzmYyIltP9zGwWllplJwBHkHSTueqTWmVuhIoGPbpfB
        aOl0DOznxoOaS78Hw5cYz/BtVPbZm8n3Bwb17EQ9v6LEh1H0s/V6DJzzz+35rcqomMZ1uMqx33crc
        GLL+Ttag==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaSti-0001rh-E1; Thu, 05 Nov 2020 00:13:02 +0000
Date:   Thu, 5 Nov 2020 00:13:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH v2 02/18] mm/filemap: Remove dynamically allocated array
 from filemap_read
Message-ID: <20201105001302.GF17076@casper.infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
 <20201104204219.23810-3-willy@infradead.org>
 <20201104213005.GB3365678@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104213005.GB3365678@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 04:30:05PM -0500, Kent Overstreet wrote:
> On Wed, Nov 04, 2020 at 08:42:03PM +0000, Matthew Wilcox (Oracle) wrote:
> > Increasing the batch size runs into diminishing returns.  It's probably
> > better to make, eg, three calls to filemap_get_pages() than it is to
> > call into kmalloc().
> 
> I have to disagree. Working with PAGEVEC_SIZE pages is eventually going to be
> like working with 4k pages today, and have you actually read the slub code for
> the kmalloc fast path? It's _really_ fast, there's no atomic operations and it
> doesn't even have to disable preemption - which is why you never see it showing
> up in profiles ever since we switched to slub.
> 
> It would however be better to have a standard abstraction for this rather than
> open coding it - perhaps adding it to the pagevec code. Please don't just drop
> it, though.

I have the beginnings of a patch for that, but I got busy with other stuff
and didn't finish it.

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 081d934eda64..b067d8aab874 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -18,13 +18,21 @@ struct page;
 struct address_space;
 
 struct pagevec {
-	unsigned char nr;
-	bool percpu_pvec_drained;
-	struct page *pages[PAGEVEC_SIZE];
+	union {
+		struct {
+			unsigned char sz;
+			unsigned char nr;
+			bool percpu_pvec_drained;
+			struct page *pages[];
+		};
+		void *__p[PAGEVEC_SIZE + 1];
+	};
 };
 
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
+struct pagevec *pagevec_alloc(unsigned int sz, gfp_t gfp);
+void pagevec_free(struct pagevec *);
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
 				struct address_space *mapping,
 				pgoff_t start, unsigned nr_entries,
@@ -54,6 +62,7 @@ static inline unsigned pagevec_lookup_tag(struct pagevec *pvec,
 
 static inline void pagevec_init(struct pagevec *pvec)
 {
+	pvec->sz = PAGEVEC_SIZE;
 	pvec->nr = 0;
 	pvec->percpu_pvec_drained = false;
 }
@@ -63,6 +72,11 @@ static inline void pagevec_reinit(struct pagevec *pvec)
 	pvec->nr = 0;
 }
 
+static inline unsigned pagevec_size(struct pagevec *pvec)
+{
+	return pvec->sz;
+}
+
 static inline unsigned pagevec_count(struct pagevec *pvec)
 {
 	return pvec->nr;
