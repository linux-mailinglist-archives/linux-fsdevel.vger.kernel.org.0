Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC685A92C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 11:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiIAJI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 05:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiIAJHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:07:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2ED13419C;
        Thu,  1 Sep 2022 02:06:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6291022302;
        Thu,  1 Sep 2022 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662023189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=50nRSQyk1QI9hFhV212TIh+r/CdBOfcrQIb/TCXpMNg=;
        b=O5vzmoJzcxlCgyu6A22ZqfiRq7FtslJRe5nEwyx+iAICCIY83IOVAxbUJR77VZsi6zzjxV
        5ABgsatN6KiutI+2xWkckWKoXanoQYyAEm3Zd1SRjFP4B5YTacLniMUHhVShxLwfJFQJoD
        5oNnxBJhsCs2TM4gNQGyC0f6354K8qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662023189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=50nRSQyk1QI9hFhV212TIh+r/CdBOfcrQIb/TCXpMNg=;
        b=HQd7tUGwjFXnUO3Le+M69ODGktLs4sIBlRIsKKJJIc9SQdO/yGlCDjqrzs3lQAqqyPs/o8
        FW6Ih0TJiB7zoaCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F61F13A79;
        Thu,  1 Sep 2022 09:06:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IKtVExV2EGPoRAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Sep 2022 09:06:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DC9BFA067C; Thu,  1 Sep 2022 11:06:28 +0200 (CEST)
Date:   Thu, 1 Sep 2022 11:06:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] NFS: direct-io: convert to FOLL_PIN pages
Message-ID: <20220901090628.h4debwejkirrhqtj@quack3>
References: <20220827083607.2345453-6-jhubbard@nvidia.com>
 <YwqfWoAE2Awp4YvT@ZenIV>
 <353f18ac-0792-2cb7-6675-868d0bd41d3d@nvidia.com>
 <Ywq5ILRNxsbWvFQe@ZenIV>
 <Ywq5VrSrY341UVpL@ZenIV>
 <217b4a17-1355-06c5-291e-7980c0d3cea6@nvidia.com>
 <20220829160808.rwkkiuelipr3huxk@quack3>
 <a53b2d14-687a-16c9-2f63-4f94876f8b3c@nvidia.com>
 <20220831094349.boln4jjajkdtykx3@quack3>
 <Yw/+/U9GFaNnARdk@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw/+/U9GFaNnARdk@ZenIV>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-09-22 01:38:21, Al Viro wrote:
> On Wed, Aug 31, 2022 at 11:43:49AM +0200, Jan Kara wrote:
> 
> > So after looking into that a bit more, I think a clean approach would be to
> > provide iov_iter_pin_pages2() and iov_iter_pages_alloc2(), under the hood
> > in __iov_iter_get_pages_alloc() make sure we use pin_user_page() instead of
> > get_page() in all the cases (using this in pipe_get_pages() and
> > iter_xarray_get_pages() is easy) and then make all bio handling use the
> > pinning variants for iters. I think at least iov_iter_is_pipe() case needs
> > to be handled as well because as I wrote above, pipe pages can enter direct
> > IO code e.g. for splice(2).
> > 
> > Also I think that all iov_iter_get_pages2() (or the _alloc2 variant) users
> > actually do want the "pin page" semantics in the end (they are accessing
> > page contents) so eventually we should convert them all to
> > iov_iter_pin_pages2() and remove iov_iter_get_pages2() altogether. But this
> > will take some more conversion work with networking etc. so I'd start with
> > converting bios only.
> 
> Not sure, TBH...
> 
> FWIW, quite a few of the callers of iov_iter_get_pages2() do *NOT* need to
> grab any references for BVEC/XARRAY/PIPE cases.  What's more, it would be
> bloody useful to have a variant that doesn't grab references for
> !iter->user_backed case - that could be usable for KVEC as well, simplifying
> several callers.
> 
> Requirements:
> 	* recepients of those struct page * should have a way to make
> dropping the page refs conditional (obviously); bio machinery can be told
> to do so.
> 	* callers should *NOT* do something like
> 	"set an ITER_BVEC iter, with page references grabbed and stashed in
> bio_vec array, call async read_iter() and drop the references in array - the
> refs we grab in dio will serve"
> Note that for sync IO that pattern is fine whether we grab/drop anything
> inside read_iter(); for async we could take depopulating the bio_vec
> array to the IO completion or downstream of that.
> 	* the code dealing with the references returned by iov_iter_..._pages
> should *NOT* play silly buggers with refcounts - something like "I'll grab
> a reference, start DMA and report success; page will stay around until I
> get around to dropping the ref and callers don't need to wait for that" deep
> in the bowels of infinibad stack (or something equally tasteful) is seriously
> asking for trouble.

I agree we could get away without grabbing references in some cases. But it
is a performance vs robustness tradeoff I'd say. E.g. with XARRAY case I
can see people feeding pages from struct address_space and it is unclear
what else than page reference would protect them from being freed by
reclaim. Furthermore if e.g. writeback can happen for such struct
address_space (or other filesystem operations requiring stable data), we
really need a full page pin and not just page reference to signal that the
page may be under DMA and may be changing under your hands. So I'm not
against having some special cases that avoid grabbing page reference / page
pin but I think it is justified only in performance sensitive cases and
when we can make sure filesystem backed page (because of above mentioned
data stability issues) or anon page (because of cow handling) cannot
possibly enter this path.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
