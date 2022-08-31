Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F505A7A71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 11:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiHaJn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 05:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiHaJnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:43:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606A8CE4BC;
        Wed, 31 Aug 2022 02:43:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD2992226F;
        Wed, 31 Aug 2022 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661939029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wf21pEEc2qn4pGtb/SmWthvBwjNCurQ6Mq3fuLKCgXM=;
        b=ZCv8hkQMv8VLUCjw+uWsF2LGUYsHrCxsVqq3OQGJcExeJM0/HRGBDw8+/sxrpshYy2Oa6v
        2swiTLpvpZjw3UzuYHRoCD3p8cxabr9zKD9K0aRKKqOX8D3uLDV5eAFnU9JbpejhZ7Ws3a
        iDt5IueX4Sm74kxBss2tlSq3x1auDNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661939029;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wf21pEEc2qn4pGtb/SmWthvBwjNCurQ6Mq3fuLKCgXM=;
        b=dbelnQ/VdnnD4iu+J0ymYt3LS1MSca1P78Kt0qZxPB51wzUaPAjopEjwqz/m9HSF/ZLIPg
        JDWp+J0k//jhQACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6DDE1332D;
        Wed, 31 Aug 2022 09:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FXOYLFUtD2PMTAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 09:43:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2F5D0A067B; Wed, 31 Aug 2022 11:43:49 +0200 (CEST)
Date:   Wed, 31 Aug 2022 11:43:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20220831094349.boln4jjajkdtykx3@quack3>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-6-jhubbard@nvidia.com>
 <YwqfWoAE2Awp4YvT@ZenIV>
 <353f18ac-0792-2cb7-6675-868d0bd41d3d@nvidia.com>
 <Ywq5ILRNxsbWvFQe@ZenIV>
 <Ywq5VrSrY341UVpL@ZenIV>
 <217b4a17-1355-06c5-291e-7980c0d3cea6@nvidia.com>
 <20220829160808.rwkkiuelipr3huxk@quack3>
 <a53b2d14-687a-16c9-2f63-4f94876f8b3c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a53b2d14-687a-16c9-2f63-4f94876f8b3c@nvidia.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 29-08-22 12:59:26, John Hubbard wrote:
> On 8/29/22 09:08, Jan Kara wrote:
> >> However, the core block/bio conversion in patch 4 still does depend upon
> >> a key assumption, which I got from a 2019 email discussion with
> >> Christoph Hellwig and others here [1], which says:
> >>
> >>     "All pages released by bio_release_pages should come from
> >>      get_get_user_pages...".
> >>
> >> I really hope that still holds true. Otherwise this whole thing is in
> >> trouble.
> >>
> >> [1] https://lore.kernel.org/kvm/20190724053053.GA18330@infradead.org/
> > 
> > Well as far as I've checked that discussion, Christoph was aware of pipe
> > pages etc. (i.e., bvecs) entering direct IO code. But he had some patches
> > [2] which enabled GUP to work for bvecs as well (using the kernel mapping
> > under the hood AFAICT from a quick glance at the series). I suppose we
> > could also handle this in __iov_iter_get_pages_alloc() by grabbing pin
> > reference instead of plain get_page() for the case of bvec iter. That way
> > we should have only pinned pages in bio_release_pages() even for the bvec
> > case.
> 
> OK, thanks, that looks viable. So, that approach assumes that the
> remaining two cases in __iov_iter_get_pages_alloc() will never end up
> being released via bio_release_pages():
> 
>     iov_iter_is_pipe(i)
>     iov_iter_is_xarray(i)
> 
> I'm actually a little worried about ITER_XARRAY, which is a recent addition.
> It seems to be used in ways that are similar to ITER_BVEC, and cephfs is
> using it. It's probably OK for now, for this series, which doesn't yet
> convert cephfs.

So after looking into that a bit more, I think a clean approach would be to
provide iov_iter_pin_pages2() and iov_iter_pages_alloc2(), under the hood
in __iov_iter_get_pages_alloc() make sure we use pin_user_page() instead of
get_page() in all the cases (using this in pipe_get_pages() and
iter_xarray_get_pages() is easy) and then make all bio handling use the
pinning variants for iters. I think at least iov_iter_is_pipe() case needs
to be handled as well because as I wrote above, pipe pages can enter direct
IO code e.g. for splice(2).

Also I think that all iov_iter_get_pages2() (or the _alloc2 variant) users
actually do want the "pin page" semantics in the end (they are accessing
page contents) so eventually we should convert them all to
iov_iter_pin_pages2() and remove iov_iter_get_pages2() altogether. But this
will take some more conversion work with networking etc. so I'd start with
converting bios only.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
