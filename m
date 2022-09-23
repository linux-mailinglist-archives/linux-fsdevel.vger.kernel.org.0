Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038135E7AB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiIWM1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiIWM0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:26:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A513505E;
        Fri, 23 Sep 2022 05:22:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 141DA1F92C;
        Fri, 23 Sep 2022 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663935764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWHeuxh4DhTU4e8+sDFIgUuNnvFHgGUFoyEReSRgGTY=;
        b=GaS3P1mTSVy7nSKrfrj/ufMsJsJTty09ODjZQD7Oil8VPuL9kb5L9beX55XjUmTXKt1Khg
        C9qw8QX+RAXmqHhFkH98ZIxe2yS2l4qcpdJz70A6dQonZHj9MTnoX7Mc1FhsCrWsw0JYCy
        8Oga72G9TOuH67EiyKlPNlYkr81TbLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663935764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWHeuxh4DhTU4e8+sDFIgUuNnvFHgGUFoyEReSRgGTY=;
        b=B9eWBL1C7tXZz2ObeTj77PXquEvf2OzUBEKJwPMz5GnRUw5EvSKpLvEKLIx65rjNnBrrVL
        b0EHoJAfEr5c3dCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E508513A00;
        Fri, 23 Sep 2022 12:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cwLLNxOlLWO9cgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 23 Sep 2022 12:22:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 78FD3A0685; Fri, 23 Sep 2022 14:22:43 +0200 (CEST)
Date:   Fri, 23 Sep 2022 14:22:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20220923122243.bbw6agvopkhz5yud@quack3>
References: <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV>
 <a6f95605-c2d5-6ec5-b85c-d1f3f8664646@nvidia.com>
 <20220922112935.pep45vfqfw5766gq@quack3>
 <Yy0lztxfwfGXFme4@ZenIV>
 <7e652ba4-8b03-59e0-a9ef-1118c4bbd492@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e652ba4-8b03-59e0-a9ef-1118c4bbd492@nvidia.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 22-09-22 21:05:16, John Hubbard wrote:
> On 9/22/22 20:19, Al Viro wrote:
> > On Thu, Sep 22, 2022 at 01:29:35PM +0200, Jan Kara wrote:
> > 
> >>> This rule would mostly work, as long as we can relax it in some cases, to
> >>> allow pinning of both source and dest pages, instead of just destination
> >>> pages, in some cases. In particular, bio_release_pages() has lost all
> >>> context about whether it was a read or a write request, as far as I can
> >>> tell. And bio_release_pages() is the primary place to unpin pages for
> >>> direct IO.
> >>
> >> Well, we already do have BIO_NO_PAGE_REF bio flag that gets checked in
> >> bio_release_pages(). I think we can easily spare another bio flag to tell
> >> whether we need to unpin or not. So as long as all the pages in the created
> >> bio need the same treatment, the situation should be simple.
> > 
> > Yes.  Incidentally, the same condition is already checked by the creators
> > of those bio - see the assorted should_dirty logics.
> 
> Beautiful!
> 
> > 
> > While we are at it - how much of the rationale around bio_check_pages_dirty()
> > doing dirtying is still applicable with pinning pages before we stick them
> > into bio?  We do dirty them before submitting bio, then on completion
> > bio_check_pages_dirty() checks if something has marked them clean while
> > we'd been doing IO; if all of them are still dirty we just drop the pages
> > (well, unpin and drop), otherwise we arrange for dirty + unpin + drop
> > done in process context (via schedule_work()).  Can they be marked clean by
> > anyone while they are pinned?  After all, pinning is done to prevent
> > writeback getting done on them while we are modifying the suckers...
> 
> I certainly hope not. And in fact, we should really just say that that's
> a rule: the whole time the page is pinned, it simply must remain dirty
> and writable, at least with the way things are right now.

I agree the page should be staying dirty the whole time it is pinned. I
don't think it is feasible to keep it writeable in the page tables because
that would mean you would need to block e.g. munmap() until the pages gets
unpinned and that will almost certainly upset some current userspace.

But keeping page dirty should be enough so that we can get rid of all these
nasty calls to set_page_dirty() from IO completion.

> This reminds me that I'm not exactly sure what the rules for
> FOLL_LONGTERM callers should be, with respect to dirtying. At the
> moment, most, if not all of the code that does "set_page_dirty_lock();
> unpin_user_page()" is wrong.

Right.

> To fix those cases, IIUC, the answer is: you must make the page dirty
> properly, with page_mkwrite(), not just with set_page_dirty_lock(). And

Correct, and GUP (or PUP) actually does that under the hood so I don't
think we need to change anything there.

> that has to be done probably a lot earlier, for reasons that I'm still
> vague on. But perhaps right after pinning the page. (Assuming that we
> hold off writeback while the page is pinned.)

Holding off writeback is not always doable - as Christoph mentions, for
data integrity writeback we'll have to get the data to disk before the page
is unpinned (as for longterm users it can take days for the page to be
unpinned). But we can just writeback the page without clearing the dirty
bit in these cases. We may need to use bounce pages to be able to safely
writeback pinned pages but that's another part of the story...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
