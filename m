Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1267952D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 11:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjAXK3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 05:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjAXK3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:29:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB90D3F2AD;
        Tue, 24 Jan 2023 02:29:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80BC721A1A;
        Tue, 24 Jan 2023 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674556172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MLnaHPg0lfs1dnTmMfHc1r7guqRG5LzksqQFwaLpDzQ=;
        b=mIiJuq3CDQzuKHiOkGgeqtxnFWEvHm/PtewFED0mXeFmMIembhuuVVlWTd1lHkgCUjLCPS
        y+VsoEu0mhqd2ph1m48lAdBcx2lYGPFC+wbi6MqdUjGakZwEfzifEnpEQcYqhydnP5AtY2
        JeIRUmB1NqJmpETNKVrmbbcfB6iodao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674556172;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MLnaHPg0lfs1dnTmMfHc1r7guqRG5LzksqQFwaLpDzQ=;
        b=7BTH3OyJbyXk8y4Xu0KOlsQgd4h/Dt6lXPi2h/YYuyveKjcJDfmFECgWG2qgB4qo37Vyjz
        Lr/nEFTReUPl2/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69E15139FB;
        Tue, 24 Jan 2023 10:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hPvUGQyzz2OAdQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 10:29:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0863AA06B5; Tue, 24 Jan 2023 11:29:32 +0100 (CET)
Date:   Tue, 24 Jan 2023 11:29:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or
 just list)
Message-ID: <20230124102931.g7e33syuhfo7s36h@quack3>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <Y862ZL5umO30Vu/D@casper.infradead.org>
 <20230123164218.qaqqg3ggbymtlwjx@quack3>
 <Y87E5HAo7ZoHyrbE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87E5HAo7ZoHyrbE@casper.infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 23-01-23 17:33:24, Matthew Wilcox wrote:
> On Mon, Jan 23, 2023 at 05:42:18PM +0100, Jan Kara wrote:
> > On Mon 23-01-23 16:31:32, Matthew Wilcox wrote:
> > > On Fri, Jan 20, 2023 at 05:55:48PM +0000, David Howells wrote:
> > > >  (3) Make the bio struct carry a pair of flags to indicate the cleanup
> > > >      mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (equivalent to
> > > >      FOLL_GET) and BIO_PAGE_PINNED (equivalent to BIO_PAGE_PINNED) is
> > > >      added.
> > > 
> > > I think there's a simpler solution than all of this.
> > > 
> > > As I understand the fundamental problem here, the question is
> > > when to copy a page on fork.  We have the optimisation of COW, but
> > > O_DIRECT/RDMA/... breaks it.  So all this page pinning is to indicate
> > > to the fork code "You can't do COW to this page".
> > > 
> > > Why do we want to track that information on a per-page basis?  Wouldn't it
> > > be easier to have a VM_NOCOW flag in vma->vm_flags?  Set it the first
> > > time somebody does an O_DIRECT read or RDMA pin.  That's it.  Pages in
> > > that VMA will now never be COWed, regardless of their refcount/mapcount.
> > > And the whole "did we pin or get this page" problem goes away.  Along
> > > with folio->pincount.
> > 
> > Well, but anon COW code is not the only (planned) consumer of the pincount.
> > Filesystems also need to know whether a (shared pagecache) page is pinned
> > and can thus be modified behind their backs. And for that VMA tracking
> > isn't really an option.
> 
> Bleh, I'd forgotten about that problem.  We really do need to keep
> track of which pages are under I/O for this case, because we need to
> tell the filesystem that they are now available for writeback.
> 
> That said, I don't know that we need to keep track of it in the
> pages themselves.  Can't we have something similar to rmap which
> keeps track of a range of pinned pages, and have it taken care of
> at a higher level (ie unpin the pages in the dio_iodone_t rather
> than in the BIO completion handler)?

We could but bear in mind that there are more places than just (the two)
direct IO paths. There are many GUP users that can be operating on mmapped
pagecache and that can modify page data. Also note that e.g. direct IO is
rather performance sensitive so any CPU overhead that is added to that path
gets noticed. That was actually the reason why we keep pinned pages on the
LRU - John tried to remove them while pinning but the overhead was not
acceptable.

Finally, since we need to handle pinning for anon pages as well, just
(ab)using the page refcount looks like the least painful solution.

> I'm not even sure why pinned pagecache pages remain on the LRU.
> They should probably go onto the unevictable list with the mlocked
> pages, then on unpin get marked dirty and placed on the active list.
> There's no point in writing back a pinned page since it can be
> written to at any instant without any part of the kernel knowing.

True but as John said sometimes we need to writeout even pinned page - e.g.
on fsync(2). For some RDMA users which keep pages pinned for days or
months, this is actually crutial...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
