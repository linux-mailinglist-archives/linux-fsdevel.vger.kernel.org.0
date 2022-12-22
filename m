Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA9653E64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 11:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiLVKhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 05:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiLVKhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:37:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A10AE63;
        Thu, 22 Dec 2022 02:37:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D966823B54;
        Thu, 22 Dec 2022 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671705425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yo4+JtMNWgimMUFjJc8zNYW9/ztT5sGqCS8xZ/+rDNE=;
        b=yQ9Owk3mPeS97kyxEIDBOmPQwvae4qE5xjuDHw+1MjR4aULPnMJ3wQoVHl6NjW/amthkBr
        S/zIs3dEzU5g7HJmGvzKAPKxNAzZEQZVqzyo7wJ0YbOL1eCa8coCt+Knitv/lHacK4sFfe
        BCQ2Qd/IOPHHSsF7r/xb47vplV0VbOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671705425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yo4+JtMNWgimMUFjJc8zNYW9/ztT5sGqCS8xZ/+rDNE=;
        b=vgqDeCKfT6jrpgJwRU87O6bhd83Z6sMy5qtIJikIJsHglVpG3JH4tMjPGyKq1tKW3QD5lV
        K4HX37uRixDHARAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3FF413918;
        Thu, 22 Dec 2022 10:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hOfML1EzpGPfYwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 10:37:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3B42FA0732; Thu, 22 Dec 2022 11:37:05 +0100 (CET)
Date:   Thu, 22 Dec 2022 11:37:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 5/8] reiserfs: Convert do_journal_end() to use
 kmap_local_folio()
Message-ID: <20221222103705.f2s7bpwv2g7x2bwt@quack3>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-6-willy@infradead.org>
 <Y55WUrzblTsw6FfQ@iweiny-mobl>
 <Y6GB75HMEKfcGcsO@casper.infradead.org>
 <20221220111801.jhukawk3lbuonxs3@quack3>
 <Y6HpzAFNA33jQ3bl@iweiny-desk3>
 <Y6IAUetp7nihz9Qu@casper.infradead.org>
 <Y6JMazsjbPRJ7oMM@iweiny-desk3>
 <Y6NYonXNGL58+rV8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6NYonXNGL58+rV8@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 21-12-22 19:04:02, Matthew Wilcox wrote:
> On Tue, Dec 20, 2022 at 03:59:39PM -0800, Ira Weiny wrote:
> > On Tue, Dec 20, 2022 at 06:34:57PM +0000, Matthew Wilcox wrote:
> > > On Tue, Dec 20, 2022 at 08:58:52AM -0800, Ira Weiny wrote:
> > > > On Tue, Dec 20, 2022 at 12:18:01PM +0100, Jan Kara wrote:
> > > > > On Tue 20-12-22 09:35:43, Matthew Wilcox wrote:
> > > > > > But that doesn't solve the "What about fs block size > PAGE_SIZE"
> > > > > > problem that we also want to solve.  Here's a concrete example:
> > > > > > 
> > > > > >  static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
> > > > > >  {
> > > > > > -       struct page *page = bh->b_page;
> > > > > > +       struct folio *folio = bh->b_folio;
> > > > > >         char *addr;
> > > > > >         __u32 checksum;
> > > > > >  
> > > > > > -       addr = kmap_atomic(page);
> > > > > > -       checksum = crc32_be(crc32_sum,
> > > > > > -               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
> > > > > > -       kunmap_atomic(addr);
> > > > > > +       BUG_ON(IS_ENABLED(CONFIG_HIGHMEM) && bh->b_size > PAGE_SIZE);
> > > > > > +
> > > > > > +       addr = kmap_local_folio(folio, offset_in_folio(folio, bh->b_data));
> > > > > > +       checksum = crc32_be(crc32_sum, addr, bh->b_size);
> > > > > > +       kunmap_local(addr);
> > > > > >  
> > > > > >         return checksum;
> > > > > >  }
> > > > > > 
> > > > > > I don't want to add a lot of complexity to handle the case of b_size >
> > > > > > PAGE_SIZE on a HIGHMEM machine since that's not going to benefit terribly
> > > > > > many people.  I'd rather have the assertion that we don't support it.
> > > > > > But if there's a good higher-level abstraction I'm missing here ...
> > > > > 
> > > > > Just out of curiosity: So far I was thinking folio is physically contiguous
> > > > > chunk of memory. And if it is, then it does not seem as a huge overkill if
> > > > > kmap_local_folio() just maps the whole folio?
> > > > 
> > > > Willy proposed that previously but we could not come to a consensus on how to
> > > > do it.
> > > > 
> > > > https://lore.kernel.org/all/Yv2VouJb2pNbP59m@iweiny-desk3/
> > > > 
> > > > FWIW I still think increasing the entries to cover any foreseeable need would
> > > > be sufficient because HIGHMEM does not need to be optimized.  Couldn't we hide
> > > > the entry count into some config option which is only set if a FS needs a
> > > > larger block size on a HIGHMEM system?
> > > 
> > > "any foreseeable need"?  I mean ... I'd like to support 2MB folios,
> > > even on HIGHMEM machines, and that's 512 entries.  If we're doing
> > > memcpy_to_folio(), we know that's only one mapping, but still, 512
> > > entries is _a lot_ of address space to be reserving on a 32-bit machine.
> > 
> > I'm confused.  A memcpy_to_folio() could loop to map the pages as needed
> > depending on the amount of data to copy.  Or just map/unmap in a loop.
> > 
> > This seems like an argument to have a memcpy_to_folio() to hide such nastiness
> > on HIGHMEM from the user.
> 
> I see that you are confused.  What I'm not quite sure of is how I confused
> you, so I'm just going to try again in different words.
> 
> Given the desire to support 2MB folios on x86/ARM PAE systems, we can't
> have a kmap_local_entire_folio() because that would take up too much
> address space.

Is that really a problem? I mean sure 2MB is noticeable in 32-bit address
space but these mappings are very shortlived due to their nature (and the
API kind of enforces that) so there'd hardly be more than a handful of them
existing in parallel on a system. Or is my expectation wrong?

But I agree the solution with memcpy_to/from_folio() works as well.

> > [*] I only play a file system developer on TV.  ;-)
> 
> That's OK, I'm only pretending to be an MM developer.  Keep quiet, and
> I think we can get away with this.

"All the world's a stage, and all the men and women merely players." :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
