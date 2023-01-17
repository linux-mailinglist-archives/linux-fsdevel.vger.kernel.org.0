Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DC866E084
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 15:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjAQOZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 09:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjAQOZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:25:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744253D08F;
        Tue, 17 Jan 2023 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QdqcFyVr8K0bup5NOO0aq0lzzZUH+Wzn1LDI5nJW77c=; b=mxTYTDSKj/goJrJLHb58cdw9tT
        ltWEFXNkv2h+QwO6+wa951yVIN2Ne2cAd/sL1NcQBFjDgSh0Z5Yxbzm7vqkdHTQxhDynpGX3W4ojD
        BZZMKmdbqJ8mZ9bv6x2ITjaDUD4ixBchGeDLZ2mRhHynzgZhjqgbRL2mMEguCaxMwVVAdSOB9SF6F
        wOu3B+/o7udidpfKTD0ewrLsnpSSZqJbmFd6rHc/8oQEVK7ol9EsNwq1H/GJsC3Qc711MH8wFJgGB
        plQQf08SB3V51oZbhdP0hOzaUzu8+m0Q7le2pM8BN16PE0mv8Yo2LdUy6lmeY21Ts5rRCRvjPKqhk
        K9g8FxsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHmsY-009kDG-01; Tue, 17 Jan 2023 14:23:58 +0000
Date:   Tue, 17 Jan 2023 14:23:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Amy Parker <apark0006@student.cerritos.edu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dax: use switch statement over chained ifs
Message-ID: <Y8avfR1Q4BzDe9sH@casper.infradead.org>
References: <CAPOgqxF_xEgKspetRJ=wq1_qSG3h8mkyXC58TXkUvx0agzEm_A@mail.gmail.com>
 <Y8YK4c6KQg2xjM+E@casper.infradead.org>
 <CAPOgqxEYzDkfX9re+yZry4BNV8PGAd_G-qsWdpePAOC4dNcAgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPOgqxEYzDkfX9re+yZry4BNV8PGAd_G-qsWdpePAOC4dNcAgQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 09:07:23PM -0800, Amy Parker wrote:
> On Mon, Jan 16, 2023 at 6:41 PM Matthew Wilcox <willy@infradead.org> wrote:
> > CAUTION: This email originated from outside your organization. Exercise caution when opening attachments or clicking links, especially from unknown senders.

Muahaha.  I am evil.

> > Thanks for the patch!  Two problems.  First, your mailer seems to have
> > mangled the patch; in my tree these are tab indents, and the patch has
> > arrived with four-space indents, so it can't be applied.
> 
> Ah, gotcha. Next time I'll just use git send-email, was hoping this
> time I'd be able to use my normal mailing system directly. (Also
> hoping my mail server isn't applying anything outgoing that messes it
> up... should probably check on that)

Feel free to send me the patch again, off-list, and I can check if it
arrived correctly.

> > The second problem is that this function should simply not exist.
> > I forget how we ended up with enum page_entry_size, but elsewhere
> > we simply pass 'order' around.  So what I'd really like to see is
> > a patch series that eliminates page_entry_size everywhere.
> 
> Hmm, alright... I'm not really familiar with the enum/how it's used, I
> pretty much just added this as a cleanup. If you've got any
> information on it so I know how to actually work with it, that'd be
> great!

The intent is to describe which "layer" of the page tables we're trying
to hadle a fault for -- PTE, PMD or PUD.  But as you can see by this
pe_order() function, the rest of the kernel tends to use the order
to communicate this information, so pass in 0, PMD_ORDER or PUD_ORDER.
Also PMD_ORDER and PUD_ORDER should exist in mm.h ;-)

> > I can outline a way to do that in individual patches if that would be
> > helpful.
> 
> Alright - although, would it actually need to be individual patches?
> I'm not 100% sure whether the page_entry_size used across the kernel
> is the same enum or different enums, my guess looking at the grep
> context summary is that they are the same, but the number of usages (I
> count 18) should fit in a single patch just fine...

I'd take it step by step.  First, I'd lift pe_order() to mm.h.
Second patch, convert dax_finish_sync_fault() to take an order instead
of a pe_size, making each caller call pe_order().  And do it at
the start of each function, eg the very first line of
__xfs_filemap_fault() should be

	unsigned int order = pe_order(pe_size);

Third, convert dax_iomap_fault() to take an order instead of a pe_size.
Fourth, convert huge_fault() to take an order.  Fifth, remove the
enum and pe_order.

This makes it easier to review, as well as looking good for your
contribution stats ;-)
