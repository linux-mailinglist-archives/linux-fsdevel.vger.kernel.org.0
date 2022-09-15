Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711ED5B960B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 10:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIOIQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIOIQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:16:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A097B26;
        Thu, 15 Sep 2022 01:16:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DFC6833889;
        Thu, 15 Sep 2022 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663229785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NTSN1xqCruJC4ZaRq7lW0AZpNYYRS+bGOmEnOKZF9Ng=;
        b=TL4DUwJH0HUGXwxd/0idnCPEo+CBe3TRIIAOzAv3or6KpnMBKH8UrgVOEscEUXI89QSLzn
        CLAOW8OOV+ygGlmhBOpIDZSDslOawYQInGjO8KtALpwdS4X7Vy/YxjGDRoOS3f7wEqeHJW
        9FsixXYInXb+FrMfcZMlwBxWBiV3GhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663229785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NTSN1xqCruJC4ZaRq7lW0AZpNYYRS+bGOmEnOKZF9Ng=;
        b=HRlirllTGDI6NxtxuhafI4mnGPWJH/XlnVOAZ7P1+Mbk2Sx/n62L5kDAJwc2bT/o7UV9Kj
        5arHv2C81Yvn6CCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8A9C139C8;
        Thu, 15 Sep 2022 08:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V478MFnfImOjdgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 15 Sep 2022 08:16:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 10690A0682; Thu, 15 Sep 2022 10:16:25 +0200 (CEST)
Date:   Thu, 15 Sep 2022 10:16:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <20220915081625.6a72nza6yq4l5etp@quack3>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyIEgD8ksSZTsUdJ@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-09-22 17:42:40, Al Viro wrote:
> On Wed, Sep 14, 2022 at 04:52:33PM +0200, Jan Kara wrote:
> > > =================================================================================
> > > CASE 5: Pinning in order to write to the data within the page
> > > -------------------------------------------------------------
> > > Even though neither DMA nor Direct IO is involved, just a simple case of "pin,
> > > write to a page's data, unpin" can cause a problem. Case 5 may be considered a
> > > superset of Case 1, plus Case 2, plus anything that invokes that pattern. In
> > > other words, if the code is neither Case 1 nor Case 2, it may still require
> > > FOLL_PIN, for patterns like this:
> > > 
> > > Correct (uses FOLL_PIN calls):
> > >     pin_user_pages()
> > >     write to the data within the pages
> > >     unpin_user_pages()
> > > 
> > > INCORRECT (uses FOLL_GET calls):
> > >     get_user_pages()
> > >     write to the data within the pages
> > >     put_page()
> > > =================================================================================
> > 
> > Yes, that was my point.
> 
> The thing is, at which point do we pin those pages?  pin_user_pages() works by
> userland address; by the time we get to any of those we have struct page
> references and no idea whether they are still mapped anywhere.

Yes, pin_user_pages() currently works by page address but there's nothing
fundamental about that. Technically, pin is currently just another type of
page reference so we can as well just pin the page when given struct page.
In fact John Hubbart has added such helper in this series.

> How would that work?  What protects the area where you want to avoid running
> into pinned pages from previously acceptable page getting pinned?  If "they
> must have been successfully unmapped" is a part of what you are planning, we
> really do have a problem...

But this is a very good question. So far the idea was that we lock the
page, unmap (or writeprotect) the page, and then check pincount == 0 and
that is a reliable method for making sure page data is stable (until we
unlock the page & release other locks blocking page faults and writes). But
once suddently ordinary page references can be used to create pins this
does not work anymore. Hrm.

Just brainstorming ideas now: So we'd either need to obtain the pins early
when we still have the virtual address (but I guess that is often not
practical but should work e.g. for normal direct IO path) or we need some
way to "simulate" the page fault when pinning the page, just don't map it
into page tables in the end. This simulated page fault could be perhaps
avoided if rmap walk shows that the page is already mapped somewhere with
suitable permissions.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
