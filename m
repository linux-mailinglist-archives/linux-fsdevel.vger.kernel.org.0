Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9817A20BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjIOOV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 10:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjIOOVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:21:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAEEF3;
        Fri, 15 Sep 2023 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HhqRWnfOFQmhtzhnv8gfqh6lm+Imi8Fsr7KKLz7N0CA=; b=ZAFN3W4nMASD2f9xgs7ZQX6ljK
        ZE54cWK5jw2+Sxw46PIOJA0UT2U5uUkdTZr2k8KtDrXX41eNaAyPpkouQr6gf2KB8iRM8JlWgsjPq
        t5J8O6xrgRo4ZmbpLLDrG0qoZub5CnCxyF7xiWItr/5duXyu508Qh+WsEzlNdenRG20Q1ZqBJGjrT
        P3pHnkskJkhMaKdgyszIiS2taMgR4RYA9tvPdRy46Qyos8b+Pf1/YITWhln/UD8jr6YsVX77kS86O
        Jfgys6odI16/xcwKtGf2mj3NH9cxT2EOf0oVU6upGq60J67ibRP5ZTz6zAZLmzeIzhKi8c1Z+62nx
        ZyxDzIsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qh9h3-00ACmq-G6; Fri, 15 Sep 2023 14:21:13 +0000
Date:   Fri, 15 Sep 2023 15:21:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hannes Reineke <hare@suse.de>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-ID: <ZQRoWVntO22VWL8K@casper.infradead.org>
References: <20230814144100.596749-1-willy@infradead.org>
 <94635da5-ce28-a8fb-84e3-7a9f5240fe6a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94635da5-ce28-a8fb-84e3-7a9f5240fe6a@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 01:27:17PM -0700, Hugh Dickins wrote:
> > This problem predates the folio work; it could for example have been
> > triggered by mmaping a THP in tmpfs and using that as the target of an
> > O_DIRECT read.
> > 
> > Fixes: 800d8c63b2e98 ("shmem: add huge pages support")
> 
> No. It's a good catch, but bug looks specific to the folio work to me.
> 
> Almost all shmem pages are dirty from birth, even as soon as they are
> brought back from swap; so it is not necessary to re-mark them dirty.
> 
> The exceptions are pages allocated to holes when faulted: so you did
> get me worried as to whether khugepaged could collapse a pmd-ful of
> those into a THP without marking the result as dirty.
> 
> But no, in v6.5-rc6 the collapse_file() success path has
> 	if (is_shmem)
> 		folio_mark_dirty(folio);
> and in v5.10 the same appears as
> 		if (is_shmem)
> 			set_page_dirty(new_page);
> 
> (IIRC, that or marking pmd dirty was missed from early shmem THP
> support, but fairly soon corrected, and backported to stable then.
> I have a faint memory of versions which assembled pmd_dirty from
> collected pte_dirtys.)
> 
> And the !is_shmem case is for CONFIG_READ_ONLY_THP_FOR_FS: writing
> into those pages, by direct IO or whatever, is already prohibited.
> 
> It's dem dirty (or not dirty) folios dat's the trouble!

Thanks for the correction!  Could it happen with anon THP?
They're not kept dirty from birth ... are they?
