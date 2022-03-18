Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36A64DDA56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 14:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiCRNR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 09:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiCRNR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:17:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ECF2DD988;
        Fri, 18 Mar 2022 06:16:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4754F21101;
        Fri, 18 Mar 2022 13:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647609367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3kv0AiWNbv68LeKn1hsglF0Wmdg9GUXlOxnUzosnJE=;
        b=RK4Lrt9+CnrVCuQbkXrZvk5QH0vUSOjRUd7C+Ln3z0RmN1oYZuIH4Bu4rjLqpRetncL8OD
        KG64pV77vbFy92MPEtx4ZyQaB54ufzgzMG7rYRZrCUXkkrVsheQFzZs4zNAHAYRgabSebV
        /K6+C8WFYtSwLA6AxvWlF7lvcry/RK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647609367;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3kv0AiWNbv68LeKn1hsglF0Wmdg9GUXlOxnUzosnJE=;
        b=1Y3jQ8OtUy1BzZ6aMZOd8GtTDjO5qg9IFlggqVA4rKJsXb0vV9+Bbv5EoIr+0SUymPvHwF
        7X/IPap+IsNs/uCw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D008EA3B9E;
        Fri, 18 Mar 2022 13:16:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E0483A0615; Fri, 18 Mar 2022 14:16:00 +0100 (CET)
Date:   Fri, 18 Mar 2022 14:16:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Ashish Sangwan <a.sangwan@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <20220318131600.iv7ct2m4o52plkhl@quack3.lan>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
 <YjNN5SzHELGig+U4@casper.infradead.org>
 <CAHk-=wiZvOpaP0DVyqOnspFqpXRaT6q53=gnA2psxnf5dbt7bw@mail.gmail.com>
 <YjOlJL7xwktKoLFN@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjOlJL7xwktKoLFN@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-03-22 21:16:20, Matthew Wilcox wrote:
> On Thu, Mar 17, 2022 at 12:26:35PM -0700, Linus Torvalds wrote:
> > That whole "xyz_writeback_keepwrite()" thing seems odd. It's used in
> > only one place (the folio version isn't used at all):
> > 
> >   ext4_writepage():
> > 
> >      ext4_walk_page_buffers() fails:
> >                 redirty_page_for_writepage(wbc, page);
> >                 keep_towrite = true;
> >       ext4_bio_write_page().
> > 
> > which just looks odd. Why does it even try to continue to do the
> > writepage when the page buffer thing has failed?
> > 
> > In the regular write path (ie ext4_write_begin()), a
> > ext4_walk_page_buffers() failure is fatal or causes a retry). Why is
> > ext4_writepage() any different? Particularly since it wants to keep
> > the page dirty, then trying to do the writeback just seems wrong.
> > 
> > So this code is all a bit odd, I suspect there are decades of "people
> > continued to do what they historically did" changes, and it is all
> > worrisome.
> 
> I found the commit: 1c8349a17137 ("ext4: fix data integrity sync in
> ordered mode").  Fortunately, we have a documented test for this,
> generic/127, so we'll know if we've broken it.

I agree with Dave that 'keep_towrite' thing is kind of self-inflicted
damage on the ext4 side (we need to write out some blocks underlying the
page but cannot write all from the transaction commit code, so we need to
keep xarray tags intact so that data integrity sync cannot miss the page).
Also it is no longer needed in the current default ext4 setup. But if you
have blocksize < pagesize and mount the fs with 'dioreadlock,data=ordered'
mount options, the hack is still needed AFAIK and we don't have a
reasonable way around it.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
