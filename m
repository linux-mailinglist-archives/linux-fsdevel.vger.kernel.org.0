Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A0D515A35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 05:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382164AbiD3Drh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 23:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbiD3Drf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 23:47:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E83D3478;
        Fri, 29 Apr 2022 20:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=71R9XH5yVaDQhBaSEWsIsrB/I87XgzXqtUttxLlkDN8=; b=RvjQvYRtkTbHgE6mZYaoNE/ybY
        lJWGsZLQbdrBY60qxCvfB06x08gEPiz0hpATD1SLYXWzVgqiUSSd0nq1SwSqskyJppwEa/j241s5i
        kKCOBtSJboxY9u0JnGyvS9MERpRozYRm8t/H9njU+S6zY9ERMcjJbB4HvYN7WB6KVUjEwuPZm74TZ
        RmVmKQF4HrNMqAKwWXnN4ZVyckviIGLb3a8lfX2pX8S+YbUT6a/FwruWY+HxY3k77h2dnRSdnA9gt
        clGAOzQFjdSBhau7xnqBw+v/Qg7c2eUXZP4DJjCTGoWwyytoqXiYZ0uIBgxGAgdz5Vvz6SKrQcQNx
        4r+pHrgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nke1f-00D33c-Ez; Sat, 30 Apr 2022 03:44:07 +0000
Date:   Sat, 30 Apr 2022 04:44:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <Ymywh003c+Hd4Zu9@casper.infradead.org>
References: <20220413033425.GM16799@magnolia>
 <YlbjOPEQP66gc1WQ@casper.infradead.org>
 <20220418174747.GF17025@magnolia>
 <20220422215943.GC17025@magnolia>
 <Ymq4brjhBcBvcfIs@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymq4brjhBcBvcfIs@bfoster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 11:53:18AM -0400, Brian Foster wrote:
> The above is the variant of generic/068 failure I was reproducing and
> used to bisect [1]. With some additional tracing added to ioend
> completion, what I'm seeing is that the bio_for_each_folio_all() bvec
> iteration basically seems to go off the rails. What happens more
> specifically is that at some point during the loop, bio_next_folio()
> actually lands into the second page of the just processed folio instead
> of the actual next folio (i.e. as if it's walking to the next page from
> the head page of the folio instead of to the next 16k folio). I suspect
> completion is racing with some form of truncation/reclaim/invalidation
> here, what exactly I don't know, that perhaps breaks down the folio and
> renders the iteration (bio_next_folio() -> folio_next()) unsafe. To test
> that theory, I open coded and modified the loop to something like the
> following:
> 
>                 for (bio_first_folio(&fi, bio, 0); fi.folio; ) {
>                         f = fi.folio;
>                         l = fi.length;
>                         bio_next_folio(&fi, bio);
>                         iomap_finish_folio_write(inode, f, l, error);
>                         folio_count++;
>                 }
> 
> ... to avoid accessing folio metadata after writeback is cleared on it
> and this seems to make the problem disappear (so far, I'll need to let
> this spin for a while longer to be completely confident in that).

_Oh_.

It's not even a terribly weird race, then.  It's just this:

CPU 0				CPU 1
				truncate_inode_partial_folio()
				folio_wait_writeback();
bio_next_folio(&fi, bio)
iomap_finish_folio_write(fi.folio)
folio_end_writeback(folio)
				split_huge_page()
bio_next_folio()
... oops, now we only walked forward one page instead of the entire folio.

So ... I think we can fix this with:

+++ b/include/linux/bio.h
@@ -290,7 +290,8 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
 {
        fi->_seg_count -= fi->length;
        if (fi->_seg_count) {
-               fi->folio = folio_next(fi->folio);
+               fi->folio = (struct folio *)folio_page(fi->folio,
+                               (fi->offset + fi->length) / PAGE_SIZE);
                fi->offset = 0;
                fi->length = min(folio_size(fi->folio), fi->_seg_count);
        } else if (fi->_i + 1 < bio->bi_vcnt) {

(I do not love this, have not even compiled it; it's late.  We may be
better off just storing next_folio inside the folio_iter).
