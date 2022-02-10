Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF624B1991
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 00:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345714AbiBJXfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 18:35:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiBJXfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:35:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADAF5F64;
        Thu, 10 Feb 2022 15:35:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CEFCF21126;
        Thu, 10 Feb 2022 23:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644536128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2Yicem2YyHeYev4jh35sFR/3S6yxP16YJIZJw/2u2E=;
        b=IRejTp/lbCDisc33iEc4E7PVz/okwunBODuHyI/b85cHeu50KxfVz4Lm1ulBn16HHIvtlA
        ybEwfsOogFOgpBDauYwGb+Akw4qrm8puoflgsBEzORq8jfHdN6f4ykyJ3bj8AO7gbIdRoY
        JxHa2lsbMPUq7RCvp7L2aTnG70bRko0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644536128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2Yicem2YyHeYev4jh35sFR/3S6yxP16YJIZJw/2u2E=;
        b=akwWvp114tx/QzY8BBRxePKACalrKHFoVw/bZPcO2rBeEBJtdQRh+pMHD3FVXfuxr+1IuH
        CB/Fb6z1JJ/iymCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AE5C13C55;
        Thu, 10 Feb 2022 23:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eHQaAjihBWKSUAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 10 Feb 2022 23:35:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Jan Kara" <jack@suse.cz>, "Wu Fengguang" <fengguang.wu@intel.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Philipp Reisner" <philipp.reisner@linbit.com>,
        "Lars Ellenberg" <lars.ellenberg@linbit.com>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        "Jens Axboe" <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/11] MM: document and polish read-ahead code.
In-reply-to: <20220210122440.vqth5mwsqtv6vjpq@quack3.lan>
References: <164447124918.23354.17858831070003318849.stgit@noble.brown>,
 <164447147257.23354.2801426518649016278.stgit@noble.brown>,
 <20220210122440.vqth5mwsqtv6vjpq@quack3.lan>
Date:   Fri, 11 Feb 2022 10:35:17 +1100
Message-id: <164453611721.27779.1299851963795418722@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Feb 2022, Jan Kara wrote:
> Hi Neil!
> 
> On Thu 10-02-22 16:37:52, NeilBrown wrote:
> > Add some "big-picture" documentation for read-ahead and polish the code
> > to make it fit this documentation.
> > 
> > The meaning of ->async_size is clarified to match its name.
> > i.e. Any request to ->readahead() has a sync part and an async part.
> > The caller will wait for the sync pages to complete, but will not wait
> > for the async pages.  The first async page is still marked PG_readahead

Thanks for the review!

> 
> So I don't think this is how the code was meant. My understanding of
> readahead comes from a comment:

I can't be sure what was "meant" but what I described is very close to
what the code actually does.

> 
> /*
>  * On-demand readahead design.
>  *
> ....
> 
> in mm/readahead.c. The ra->size is how many pages should be read.
> ra->async_size is the "lookahead size" meaning that we should place a
> marker (PageReadahead) at "ra->size - ra->async_size" to trigger next
> readahead.

This description of PageReadahead and ->async_size focuses on *what*
happens, not *why*.  Importantly it doesn't help answer the question "What
should I set ->async_size to?"

The implication in the code is that when we sequentially access a page
that was read-ahead (read before it was explicitly requested), we trigger
more read ahead.  So ->async_size should refer to that part of the
readahead request which was not explicitly requested.  With that
understanding, it becomes possible to audit all the places that
->async_size are set and to see if they make sense.

> 
> > 
> > - in try_context_readahead(), the async_sync is set correctly rather
> >   than being set to 1.  Prior to Commit 2cad40180197 ("readahead: make
> >   context readahead more conservative") it was set to ra->size which
> >   is not correct (that implies no sync component).  As this was too
> >   high and caused problems it was reduced to 1, again incorrect but less
> >   problematic.  The setting provided with this patch does not restore
> >   those problems, and is now not arbitrary.
> 
> I agree the 1 there looks strange as it effectively discards all the logic
> handling the lookahead size. I agree with the tweak there but I would do
> this behavioral change as a separate commit since it can have performance
> implications.
> 
> > - The calculation of ->async_size in the initial_readahead section of
> >   ondemand_readahead() now makes sense - it is zero if the chosen
> >   size does not exceed the requested size.  This means that we will not
> >   set the PG_readahead flag in this case, but as the requested size
> >   has not been satisfied we can expect a subsequent read ahead request
> >   any way.
> 
> So I agree that setting of ->async_size to ->size in initial_readahead
> section does not make great sence but if you look a bit below into readit
> section, you will notice the ->async_size is overwritten there to something
> meaninful. So I think the code actually does something sensible, maybe it
> could be written in a more readable way.

I'm certainly focusing on making the code look sensible and be
consistent with the documentation, rather than fixing actual faults in
behaviour.  Code that makes sense is easier to maintain.

I came very close to removing that code after readit: but I agree it
needs a separate patch and needs more thought.  It looks like a bandaid
that addressed some specific problem which was probably caused by one of
the size fields being set "wrongly" earlier.

>  
> > Note that the current function names page_cache_sync_ra() and
> > page_cache_async_ra() are misleading.  All ra request are partly sync
> > and partly async, so either part can be empty.
> 
> The meaning of these names IMO is:
> page_cache_sync_ra() - tell readahead that we currently need a page
> ractl->_index and would prefer req_count pages fetched ahead.

I don't think that is what req_count means.  req_count is the number of
pages that are needed *now* to satisfy the current read request.
page_cache_sync_ra() has the job of determining how many more pages (if
any) to read-ahead to satisfy future requests.  Sometimes it reads
another req_count - sometimes not.

> 
> page_cache_async_ra() - called when we hit the lookahead marker to give
> opportunity to readahead code to prefetch more pages.

Yes, but page_cache_async_ra() is given a req_count which, as above, is
the number of pages needed to satisfy *this* request.  That wouldn't
make sense if it was a pure future-readahead request.

In practice, the word "sync" is used to mean "page was missing" and
"async" here means "PG_readahead was found".  But that isn't what those
words usually mean.

They both call ondemand_readahead() passing False or True respectively
to hit_readahead_marker - which makes that meaning clear in the code...
but it still isn't clear in the name.

> 
> > A page_cache_sync_ra() request will usually set ->async_size non-zero,
> > implying it is not all synchronous.
> > When a non-zero req_count is passed to page_cache_async_ra(), the
> > implication is that some prefix of the request is synchronous, though
> > the calculation made there is incorrect - I haven't tried to fix it.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> 
> 								Honza


Thanks,
NeilBrown
