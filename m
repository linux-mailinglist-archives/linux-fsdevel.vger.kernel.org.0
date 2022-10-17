Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92946017EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 21:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJQTnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJQTnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:43:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED33F6C13F;
        Mon, 17 Oct 2022 12:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eMB2pSDfV1bvP74oVN4aFjBLP7duahTznx7nvBtIcM4=; b=EmLMG3n6bQLAwe5nnRsLuJ4ZBS
        cjHOQcsxuhlbPqT0a3g5qKJtSobZMizB4tJnZEuAoh8ZE5XdFetLn8HpSeXwIvWe3qhwOaPqONtAt
        96/FVt8rbsIJTPaK4ebs73/f7bGN3D8q0l5dqqPUQIXrRLMhVkXDm14+xDGb/3ls4aBSB80WQShhb
        v729KoAFrHiSm5OTzznGNoomhcnGdYS0DCAgXSMLkGs8hf68yZMkxSh2jzaj1ZLTvS6Fd5V+n96k0
        LHaXY1tU9GF7kVFi+Sdy3uNzK3dlBai/XDQK/VRqvsyXh/R/0oQH4yryDspeZMg0msyUmVB23yxKN
        n7pbe8Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okW1a-00A5Lc-LA; Mon, 17 Oct 2022 19:43:46 +0000
Date:   Mon, 17 Oct 2022 20:43:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] filemap: find_lock_entries() now updates start
 offset
Message-ID: <Y02wcnTOMH+KnnML@casper.infradead.org>
References: <20221017161800.2003-1-vishal.moola@gmail.com>
 <20221017161800.2003-2-vishal.moola@gmail.com>
 <Y02JTOtYEbAyo+zu@casper.infradead.org>
 <CAOzc2py24=NBFX6mWZ9s0eRH-rU87n-mYsVK=TW_jtx646z_qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzc2py24=NBFX6mWZ9s0eRH-rU87n-mYsVK=TW_jtx646z_qQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 12:37:48PM -0700, Vishal Moola wrote:
> On Mon, Oct 17, 2022 at 9:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Oct 17, 2022 at 09:17:59AM -0700, Vishal Moola (Oracle) wrote:
> > > +++ b/mm/shmem.c
> > > @@ -932,21 +932,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> > >
> > >       folio_batch_init(&fbatch);
> > >       index = start;
> > > -     while (index < end && find_lock_entries(mapping, index, end - 1,
> > > +     while (index < end && find_lock_entries(mapping, &index, end - 1,
> >
> > Sorry for not spotting this in earlier revisions, but this is wrong.
> > Before, find_lock_entries() would go up to (end - 1) and then the
> > index++ at the end of the loop would increment index to "end", causing
> > the loop to terminate.  Now we don't increment index any more, so the
> > condition is wrong.
> 
> The condition is correct. Index maintains the exact same behavior.
> If a find_lock_entries() finds a folio, index is set to be directly after
> the last page in that folio, or simply incrementing for a value entry.
> The only time index is not changed at all is when find_lock_entries()
> finds no folios, which is the same as the original behavior as well.

Uh, right.  I had the wrong idea in my head that index wouldn't increase
past end-1, but of course it can.

> > I suggest just removing the 'index < end" half of the condition.
> 
> I hadn't thought about it earlier but this index < end check seems
> unnecessary anyways. If index > end then find_lock_entries()
> shouldn't find any folios which would cause the loop to terminate.
> 
> I could send an updated version getting rid of the "index < end"
> condition as well if you would like?

Something to consider is that if end is 0 then end-1 is -1, which is
effectively infinity, and we'll do the wrong thing?  So maybe just
leave it alone, and go with v3 as-is?
