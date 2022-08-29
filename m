Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8575A510F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 18:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiH2QIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 12:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiH2QIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:08:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ECE86B7A;
        Mon, 29 Aug 2022 09:08:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB8A6227E4;
        Mon, 29 Aug 2022 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661789291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGbWwfYuYN9T84wUp5KX7hENmHOxLt+bOTLxbPFr6cs=;
        b=Nz1DGpzfoyENhZNtQaMGDJXT2EGuJi02N9O2TjnP3C7kjF7GBdJ9i0keBKz9wTGzpq4R+b
        J+1+lahpOmmUy/XQKckOlDAXrewROaSvkEy/OEUJJHRZE2k9l2bw3cN30Ksra6fe8nTL89
        3VAAHD8HpHvlgddeyw67uD4L+0G/hfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661789291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGbWwfYuYN9T84wUp5KX7hENmHOxLt+bOTLxbPFr6cs=;
        b=uWr6d3d+E9HF7DuQEGYclf7K4yBkjwT1b9FAlRObNlmpiMlQ6+mTxnqJxBgw5uD6CwbPQd
        AMW5jFIeY6HdVwBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E31071352A;
        Mon, 29 Aug 2022 16:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vlVgN2rkDGNfGAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 29 Aug 2022 16:08:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0F8C0A066D; Mon, 29 Aug 2022 18:08:08 +0200 (CEST)
Date:   Mon, 29 Aug 2022 18:08:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] NFS: direct-io: convert to FOLL_PIN pages
Message-ID: <20220829160808.rwkkiuelipr3huxk@quack3>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-6-jhubbard@nvidia.com>
 <YwqfWoAE2Awp4YvT@ZenIV>
 <353f18ac-0792-2cb7-6675-868d0bd41d3d@nvidia.com>
 <Ywq5ILRNxsbWvFQe@ZenIV>
 <Ywq5VrSrY341UVpL@ZenIV>
 <217b4a17-1355-06c5-291e-7980c0d3cea6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <217b4a17-1355-06c5-291e-7980c0d3cea6@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 28-08-22 21:59:49, John Hubbard wrote:
> On 8/27/22 17:39, Al Viro wrote:
> > On Sun, Aug 28, 2022 at 01:38:57AM +0100, Al Viro wrote:
> >> On Sat, Aug 27, 2022 at 04:55:18PM -0700, John Hubbard wrote:
> >>> On 8/27/22 15:48, Al Viro wrote:
> >>>> On Sat, Aug 27, 2022 at 01:36:06AM -0700, John Hubbard wrote:
> >>>>> Convert the NFS Direct IO layer to use pin_user_pages_fast() and
> >>>>> unpin_user_page(), instead of get_user_pages_fast() and put_page().
> >>>>
> >>>> Again, this stuff can be hit with ITER_BVEC iterators
> >>>>
> >>>>> -		result = iov_iter_get_pages_alloc2(iter, &pagevec,
> >>>>> +		result = dio_w_iov_iter_pin_pages_alloc(iter, &pagevec,
> >>>>>  						  rsize, &pgbase);
> >>>>
> >>>> and this will break on those.
> >>>
> >>> If anyone has an example handy, of a user space program that leads
> >>> to this situation (O_DIRECT with ITER_BVEC), it would really help
> >>> me reach enlightenment a lot quicker in this area. :)
> >>
> >> Er...  splice(2) to O_DIRECT-opened file on e.g. ext4?  Or
> >> sendfile(2) to the same, for that matter...
> > 
> > s/ext4/nfs/ to hit this particular codepath, obviously.
> 
> OK, I have a solution to this that's pretty easy:
> 
> 1) Get rid of the user_backed_iter(i) check in
> dio_w_iov_iter_pin_pages() and dio_w_iov_iter_pin_pages_alloc(), and
> 
> 2) At the call sites, match up the unpin calls appropriately.
> 
> ...and apply a similar fix for the fuse conversion patch.
> 
> However, the core block/bio conversion in patch 4 still does depend upon
> a key assumption, which I got from a 2019 email discussion with
> Christoph Hellwig and others here [1], which says:
> 
>     "All pages released by bio_release_pages should come from
>      get_get_user_pages...".
> 
> I really hope that still holds true. Otherwise this whole thing is in
> trouble.
> 
> [1] https://lore.kernel.org/kvm/20190724053053.GA18330@infradead.org/

Well as far as I've checked that discussion, Christoph was aware of pipe
pages etc. (i.e., bvecs) entering direct IO code. But he had some patches
[2] which enabled GUP to work for bvecs as well (using the kernel mapping
under the hood AFAICT from a quick glance at the series). I suppose we
could also handle this in __iov_iter_get_pages_alloc() by grabbing pin
reference instead of plain get_page() for the case of bvec iter. That way
we should have only pinned pages in bio_release_pages() even for the bvec
case.

[2] http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/gup-bvec

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
