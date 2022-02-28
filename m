Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4714C622D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 05:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiB1E3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 23:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiB1E3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 23:29:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1647D4BFCB;
        Sun, 27 Feb 2022 20:28:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61D1A218E8;
        Mon, 28 Feb 2022 04:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646022531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FPzF05jy4Lj+xN0S4t3JP0Ps1aypp/wDx8I4+Iqxubk=;
        b=KTKRfFeMJNY4Kas0gLfr2ci5O4rpSpGgRuuehMeCfAqhR5B6qXPxFB5GniigMdWOLTq4Fw
        lre1oTgL8cw4I+/2dLHqyNwuWmUnLm9JABg0nQFYZy5u9hW83Km4UGyFx2KhaX5/d3QrMO
        YBDFK8ktP/c1DFgkf5f+yEzCWH+CnmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646022531;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FPzF05jy4Lj+xN0S4t3JP0Ps1aypp/wDx8I4+Iqxubk=;
        b=Q9qGQb/xet2qxvGejWBvL5/23K1IiiF5M1w8BjbodbmDpG/m1LTY/jbErHf2ZxTGYYAqYQ
        d5wmOAXudLIkq4DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1402D12FC5;
        Mon, 28 Feb 2022 04:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xr9TL3pPHGLfbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 28 Feb 2022 04:28:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Jan Kara" <jack@suse.cz>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Wu Fengguang" <fengguang.wu@intel.com>,
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
In-reply-to: <20220224182622.n7abfey3asszyq3x@quack3.lan>
References: <164447124918.23354.17858831070003318849.stgit@noble.brown>,
 <164447147257.23354.2801426518649016278.stgit@noble.brown>,
 <20220210122440.vqth5mwsqtv6vjpq@quack3.lan>,
 <164453611721.27779.1299851963795418722@noble.neil.brown.name>,
 <20220224182622.n7abfey3asszyq3x@quack3.lan>
Date:   Mon, 28 Feb 2022 15:28:39 +1100
Message-id: <164602251992.20161.9146570952337454229@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 25 Feb 2022, Jan Kara wrote:
> On Fri 11-02-22 10:35:17, NeilBrown wrote:
> > On Thu, 10 Feb 2022, Jan Kara wrote:
> > > Hi Neil!
> > >=20
> > > On Thu 10-02-22 16:37:52, NeilBrown wrote:
> > > > Add some "big-picture" documentation for read-ahead and polish the co=
de
> > > > to make it fit this documentation.
> > > >=20
> > > > The meaning of ->async_size is clarified to match its name.
> > > > i.e. Any request to ->readahead() has a sync part and an async part.
> > > > The caller will wait for the sync pages to complete, but will not wait
> > > > for the async pages.  The first async page is still marked PG_readahe=
ad
> >=20
> > Thanks for the review!
> >=20
> > >=20
> > > So I don't think this is how the code was meant. My understanding of
> > > readahead comes from a comment:
> >=20
> > I can't be sure what was "meant" but what I described is very close to
> > what the code actually does.
> >=20
> > >=20
> > > /*
> > >  * On-demand readahead design.
> > >  *
> > > ....
> > >=20
> > > in mm/readahead.c. The ra->size is how many pages should be read.
> > > ra->async_size is the "lookahead size" meaning that we should place a
> > > marker (PageReadahead) at "ra->size - ra->async_size" to trigger next
> > > readahead.
> >=20
> > This description of PageReadahead and ->async_size focuses on *what*
> > happens, not *why*.  Importantly it doesn't help answer the question "What
> > should I set ->async_size to?"
>=20
> Sorry for delayed reply. I was on vacation and then catching up with stuff.
> I know you have submitted another version of the patches but not much has
> changed in this regard so I figured it might be better to continue
> discussion here.
>=20
> So my answer to "What should I set ->async_size to?" is: Ideally so that it
> takes application to process data between ->async_size and ->size as long
> as it takes the disk to load the next chunk of data into the page cache.
> This is explained in the comment:
>=20
>  * To overlap application thinking time and disk I/O time, we do
>  * `readahead pipelining': Do not wait until the application consumed all
>  * readahead pages and stalled on the missing page at readahead_index;
>  * Instead, submit an asynchronous readahead I/O as soon as there are
>  * only async_size pages left in the readahead window. Normally async_size
>  * will be equal to size, for maximum pipelining.
>=20
> Now because things such as think time or time to read pages is difficult to
> estimate, we just end up triggering next readahead as soon as we are at lea=
st
> a bit confident application is going to use the pages. But I don't think
> there was ever any intent to have "sync" and "async" parts of the request
> or that ->size - ->async_size is what must be read. Any function in the
> readahead code is free to return without doing anything regardless of
> passed parameters and the caller needs to deal with that, ->size is just a
> hint to the filesystem how much we expect to be useful to read...

I don't think it is only "difficult" to estimate.  It is impossible and
there is no evidence in the code of any attempt to estimate.  So I think
you are reading more into that comment than is there.

Certainly we want to overlap "think" and "read".  The issue I think is
not timing but size - how much to read.
At one extreme you can maximum overlap by requesting the whole file when
the first byte is read.  There are obvious problems with that approach.
As you say, we need to be "at least a bit confident that the application
is going to use the pages".  The way I read the comment and the code,
that is the primary issue: How can we be confident that the data will be
used?

Obviously we cannot, but we can manage the risk.  The read ahead
calculations are all about risk management.  We limit the potential
waste by only pre-reading a fixed multiple of the number of pages that
have been explicitly requested - that multiple is 1.  So if 32 pages
have been read, it is now safe to read-ahead an extra 32 (or maybe it's
1.5... anyway it is a simple function of how much has been requested).

The "when to read it" question is based on finding a balance between
achieving maximum confidence that the pattern continues to be a
sequential read (so don't read too early) and loading the pages so
they'll be ready when needed (so don't read too late).  There is no
"obviously right" answer - but we can clearly see the solution that the
code chooses in *almost* all circumstances.  It starts a new
opportunistic read when the first page from the last opportunistic read
is first accessed.  I think that pattern is clear enough that it is
worth documenting, and I can see no justification for diverging from
that pattern.

You express a doubt that 'there was ever any intent to have "sync" and
"async" parts of the request' and you may well be correct.  But there is
nonetheless an observed reality that some of the pages passed to
->readhead() (or ->readpages()) are wanted immediately, and some are
not.   And those that are not are the number placed in ->async_size.=20

When writing documentation the intent of the author is of some interest,
but the behaviour of the code is paramount.

>=20
> > The implication in the code is that when we sequentially access a page
> > that was read-ahead (read before it was explicitly requested), we trigger
> > more read ahead.  So ->async_size should refer to that part of the
> > readahead request which was not explicitly requested.  With that
> > understanding, it becomes possible to audit all the places that
> > ->async_size are set and to see if they make sense.
>=20
> I don't think this "implication" was ever intended :) But it may have
> happened that some guesses how big ->async_size should be have ended like
> that because of the impracticality of the original definition of how large
> ->async_size should be.
>=20
> In fact I kind of like what you suggest ->async_size should be - it is
> possible to actually implement that unlike the original definition - but it
> is more of "let's redesign how readahead size is chosen" than "let's
> document how readahead size is chosen" :).

I don't think I'm changing the design - I'm describing the design in a
possibly novel way.

I accept that "number of pages that aren't needed immediately" and
"where to set the PG_readahead" flag are not intrinsically related and
that maybe I have been unduly swayed by the field name "async_size".

I certainly want the filesystem to know which pages are explisitly
request, and which are being read opportunistically, so it can handle
them differently.  The filesystem already sees "async_size" so it is
easy to use that.  Maybe I should have added a new field which is the
actual async size, can kept it separate from the currently misnamed
"async_size".  But it didn't seem like a useful exercise.

>=20
> > > > Note that the current function names page_cache_sync_ra() and
> > > > page_cache_async_ra() are misleading.  All ra request are partly sync
> > > > and partly async, so either part can be empty.
> > >=20
> > > The meaning of these names IMO is:
> > > page_cache_sync_ra() - tell readahead that we currently need a page
> > > ractl->_index and would prefer req_count pages fetched ahead.
> >=20
> > I don't think that is what req_count means.  req_count is the number of
> > pages that are needed *now* to satisfy the current read request.
> > page_cache_sync_ra() has the job of determining how many more pages (if
> > any) to read-ahead to satisfy future requests.  Sometimes it reads
> > another req_count - sometimes not.
>=20
> So this is certainly true for page_cache_sync_readahead() call in
> filemap_get_pages() but the call of page_cache_sync_ra() from
> do_sync_mmap_readahead() does not quite follow what you say - we need only
> one page there but request more.

Yes...  and no.  That code in do_sync_mmap_readahead() runs if
VM_SEQ_READ is set.  That means MADV_SEQUENTIAL has been passed with
madvise().  So the application has explicitly said "I will access this
mapping sequentially" which effectively mean "if I access any bytes, you
can assume I'll want to access a great many subsequent bytes".  So the
"request" here can be reasonably seen as asking for "as much as
possible".

So while this is read-ahead, it is quite different from the heuristic
read-ahead that we've been discussing so far.  This isn't "might be
needed, so don't bother if it seems too hard", this is "will be needed,
so treat it like any other read request".

>=20
> > > page_cache_async_ra() - called when we hit the lookahead marker to give
> > > opportunity to readahead code to prefetch more pages.
> >=20
> > Yes, but page_cache_async_ra() is given a req_count which, as above, is
> > the number of pages needed to satisfy *this* request.  That wouldn't
> > make sense if it was a pure future-readahead request.
>=20
> Again, usage of req_count in page_cache_async_ra() is not always the number
> of pages immediately needed.

I think it is ... or should be.
The use in f2fs/dir.c doesn't seem obvious, but I don't know the
context.
In every other case, the number comes either from an explicit
request, or from a confirmed desire (promise?) to read the file
sequentially.

>=20
> > In practice, the word "sync" is used to mean "page was missing" and
> > "async" here means "PG_readahead was found".  But that isn't what those
> > words usually mean.
> >
> > They both call ondemand_readahead() passing False or True respectively
> > to hit_readahead_marker - which makes that meaning clear in the code...
> > but it still isn't clear in the name.
>=20
> I agree the naming is somewhat confusing :)

Thanks :-)

NeilBrown
