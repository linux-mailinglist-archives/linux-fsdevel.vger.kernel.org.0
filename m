Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA22F6993B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 12:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjBPL4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 06:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPL4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:56:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ADD53574;
        Thu, 16 Feb 2023 03:56:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 595FA1FE07;
        Thu, 16 Feb 2023 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676548572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULeOsmeRWlu2iwQvL7JPfZ/4t11CdcUZPAn+Hh+0Z9Q=;
        b=m4oUtuDwrM7EElnSEku7NyUtsy0MA2HvUdwMQDdT9wxpp2CfILhHqTYAR7GuphyhcfFzDf
        DiraWxNJrSXL+Q5IWysB+sx5mefAiyK6myr5en9DhVAiY2y4jSt3DkY3BT4tNPshuFRYhV
        UAGTqxEMGr59vi6gbLkwfy0SwCEwBXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676548572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULeOsmeRWlu2iwQvL7JPfZ/4t11CdcUZPAn+Hh+0Z9Q=;
        b=eh8edWArsKrgZ72r9dQcSP6FX7aEzxbJlgzyPvRWJAi+K/kzirphimpjeRb9upVhSPR26B
        xAmBB0b9a2H7SbAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48175131FD;
        Thu, 16 Feb 2023 11:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id miOTEdwZ7mMEMwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 16 Feb 2023 11:56:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B24AAA06E1; Thu, 16 Feb 2023 12:56:11 +0100 (CET)
Date:   Thu, 16 Feb 2023 12:56:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/5] mm: Do not reclaim private data from pinned page
Message-ID: <20230216115611.lauxr34lqigrc73n@quack3>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-1-jack@suse.cz>
 <Y+Ucq8A+WMT0ZUnd@casper.infradead.org>
 <20230210112954.3yzlyi4hjgci36yn@quack3>
 <Y+oI+AYsADUZsB7m@infradead.org>
 <20230214130629.hcnvwpgqzhc3ulgg@quack3>
 <406c3480-ab59-5263-b7bf-d47df0f6267c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406c3480-ab59-5263-b7bf-d47df0f6267c@nvidia.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-02-23 13:40:17, John Hubbard wrote:
> On 2/14/23 05:06, Jan Kara wrote:
> > On Mon 13-02-23 01:55:04, Christoph Hellwig wrote:
> >> I think we need to distinguish between short- and long terms pins.
> >> For short term pins like direct I/O it doesn't make sense to take them
> >> off the lru, or to do any other special action.  Writeback will simplify
> >> have to wait for the short term pin.
> >>
> >> Long-term pins absolutely would make sense to be taken off the LRU list.
> > 
> > Yeah, I agree distinguishing these two would be nice as we could treat them
> > differently then. The trouble is a bit with always-crowded struct page. But
> > now it occurred to me that if we are going to take these long-term pinned
> > pages out from the LRU, we could overload the space for LRU pointers with
> > the counter (which is what I think John originally did). So yes, possibly
> > we could track separately long-term and short-term pins. John, what do you
> > think? Maybe time to revive your patches from 2018 in a bit different form?
> > ;)
> > 
> 
> Oh wow, I really love this idea. We kept running into problems because
> long- and short-term pins were mixed up together (except during
> creation), and this, at long last, separates them. Very nice. I'd almost
> forgotten about the 2018 page.lru adventures, too. ha :)
> 
> One objection might be that pinning is now going to be taking a lot of
> space in struct page / folio, but I think it's warranted, based on the
> long-standing, difficult problems that it would solve.

Well, it doesn't need to consume more space in the struct page than it
already does currently AFAICS. We could just mark the folio as unevictable
and make sure folio_evictable() returns false for such pages. Then we
should be safe to use space of lru pointers for whatever we need.

> We could even leave most of these patches, and David Howells' patches,
> intact, by using an approach similar to the mm_users and mm_count
> technique: maintain a long-term pin count in one of the folio->lru
> fields, and any non-zero count there creates a single count in
> folio->_pincount.

Oh, you mean that the first longterm pin would take one short-term pin?
Yes, that should be possible but I'm not sure that would be a huge win. I
can imagine users can care about distinguishing these states:

1) unpinned
2) has any pin
3) has only short term pins

Now distinguishing between 1 and 2+3 would still be done by
folio_maybe_dma_pinned(). Your change will allow us to not look at lru
pointers in folio_maybe_dma_pinned() so that's some simplification and
perhaps performance optimization (potentially is can save us a need to pull
in another cacheline but mostly _refcount and lru will be in the same
cacheline anyway) so maybe it's worth it in the end.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
