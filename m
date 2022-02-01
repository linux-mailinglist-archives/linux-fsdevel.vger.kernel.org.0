Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF9E4A559E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 04:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiBAD2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 22:28:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44988 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiBAD2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:28:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 184A21F380;
        Tue,  1 Feb 2022 03:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643686119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnoIP/3lS2a5Wp0nWWdb1aUmOWSWSXrqJavkOYpCFRU=;
        b=hzdvtY6rU+mv4qdrRURT4uhGrmJ1m53yn9echhcQHVd/ZoxYDs5C+AM5kCeJiU0E+XBdUn
        koj0cwglU7O6yCH1LB1tDEjjPWxRH8K6ov2rN7Scg7L7xS2/sIjWtak8vf1yvO+boxRQl+
        ZInlCCnrbxSY84XWJenriM3ySdPrh+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643686119;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnoIP/3lS2a5Wp0nWWdb1aUmOWSWSXrqJavkOYpCFRU=;
        b=JnzexhLGFInf7jahcoFunnrZ3lpIjauz9WKkH/gJeaZ05dgrUsiNfhhc5gsFznGv7rz2G+
        IRw5ZGJW0cVDXwCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AE3413CE3;
        Tue,  1 Feb 2022 03:28:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id THf6COOo+GHFbAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 01 Feb 2022 03:28:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fuse: remove reliance on bdi congestion
In-reply-to: <YfiUaJ59A3px+DqP@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>,
 <164360183348.4233.761031466326833349.stgit@noble.brown>,
 <YfdlbxezYSOSYmJf@casper.infradead.org>,
 <164360446180.18996.6767388833611575467@noble.neil.brown.name>,
 <YffgKva2Dz3cTwhr@casper.infradead.org>,
 <164367002370.18996.7242801209611375112@noble.neil.brown.name>,
 <YfiUaJ59A3px+DqP@casper.infradead.org>
Date:   Tue, 01 Feb 2022 14:28:32 +1100
Message-id: <164368611206.1660.3728723868309208734@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 01 Feb 2022, Matthew Wilcox wrote:
> On Tue, Feb 01, 2022 at 10:00:23AM +1100, NeilBrown wrote:
> > On Tue, 01 Feb 2022, Matthew Wilcox wrote:
> > > On Mon, Jan 31, 2022 at 03:47:41PM +1100, NeilBrown wrote:
> > > > On Mon, 31 Jan 2022, Matthew Wilcox wrote:
> > > > > > +++ b/fs/fuse/file.c
> > > > > > @@ -958,6 +958,8 @@ static void fuse_readahead(struct readahead_c=
ontrol *rac)
> > > > > > =20
> > > > > >  	if (fuse_is_bad(inode))
> > > > > >  		return;
> > > > > > +	if (fc->num_background >=3D fc->congestion_threshold)
> > > > > > +		return;
> > > > >=20
> > > > > This seems like a bad idea to me.  If we don't even start reads on
> > > > > readahead pages, they'll get ->readpage called on them one at a time
> > > > > and the reading thread will block.  It's going to lead to some nasty
> > > > > performance problems, exactly when you don't want them.  Better to
> > > > > queue the reads internally and wait for congestion to ease before
> > > > > submitting the read.
> > > > >=20
> > > >=20
> > > > Isn't that exactly what happens now? page_cache_async_ra() sees that
> > > > inode_read_congested() returns true, so it doesn't start readahead.
> > > > ???
> > >=20
> > > It's rather different.  Imagine the readahead window has expanded to
> > > 256kB (64 pages).  Today, we see congestion and don't do anything.
> > > That means we miss the async readahed opportunity, find a missing
> > > page and end up calling into page_cache_sync_ra(), by which time
> > > we may or may not be congested.
> > >=20
> > > If the inode_read_congested() in page_cache_async_ra() is removed and
> > > the patch above is added to replace it, we'll allocate those 64 pages a=
nd
> > > add them to the page cache.  But then we'll return without starting IO.
> > > When we hit one of those !uptodate pages, we'll call ->readpage on it,
> > > but we won't do anything to the other 63 pages.  So we'll go through a
> > > protracted slow period of sending 64 reads, one at a time, whether or
> > > not congestion has eased.  Then we'll hit a missing page and proceed
> > > to the sync ra case as above.
> >=20
> > Hmmm... where is all this documented?
> > The entry for readahead in vfs.rst says:
> >=20
> >     If the filesystem decides to stop attempting I/O before reaching the
> >     end of the readahead window, it can simply return.
> >=20
> > but you are saying that if it simply returns, it'll most likely just get
> > called again.  So maybe it shouldn't say that?
>=20
> That's not what I'm saying at all.  I'm saying that if ->readahead fails
> to read the page, ->readpage will be called to read the page (if it's
> actually accessed).

Yes, I see that now - thanks.

But looking at the first part of what you wrote - currently if
congestion means we skip page_cache_async_ra() (and it is the
WB_sync_congested (not async!) which causes us to skip that) then we end
up in page_cache_sync_ra() - which also calls ->readahead but without
the 'congested' protection.

Presumably the sync readahead asks for fewer pages or something?  What is
the logic there?

>=20
> > What do other filesystems do?
> > ext4 sets REQ_RAHEAD, but otherwise just pushes ahead and submits all
> > requests. btrfs seems much the same.
> > xfs uses iomp_readahead ..  which again sets REQ_RAHEAD but otherwise
> > just does a normal read.
> >=20
> > The effect of REQ_RAHEAD seems to be primarily to avoid retries on
> > failure.
> >=20
> > So it seems that core read-ahead code it not set up to expect readahead
> > to fail, though it is (begrudgingly) permitted.
>=20
> Well, yes.  The vast majority of reads don't fail.

Which makes one wonder why we have the special-case handling.  The code
that tests REQ_RAHEAD has probably never been tested.  Fortunately it is
quite simple code....

>=20
> > The current inode_read_congested() test in page_cache_async_ra() seems
> > to be just delaying the inevitable (and in fairness, the comment does
> > say "Defer....").  Maybe just blocking on the congestion is an equally
> > good way to delay it...
>=20
> I don't think we should _block_ for an async read request.  We're in the
> context of a process which has read a different page.  Maybe what we
> need is a readahead_abandon() call that removes the just-added pages
> from the page cache, so we fall back to doing a sync readahead?

Well, we do potentially block - when allocating a bio or other similar
structure, and when reading an index block to know where to read from.
But we don't block waiting for the read, and we don't block waiting to
allocate the page to read-ahead.  Just how much blocking is acceptable,
I wonder.  Maybe we should punt readahead to a workqueue and let it do
the small-time waiting.

Why does the presence of an unlocked non-uptodate page cause readahead
to be skipped?  Is this somehow related to the PG_readahead flag?  If we
set PG_readahead on the first page that we decided to skip in
->readahead, would that help?

>=20
> > I note that ->readahead isn't told if the read-ahead is async or not, so
> > my patch will drop sync read-ahead on congestion, which the current code
> > doesn't do.
>=20
> Now that we have a readahead_control, it's simple to add that
> information to it.

True.

>=20
> > So maybe this congestion tracking really is useful, and we really want
> > to keep it.
> >=20
> > I really would like to see that high-level documentation!!
>=20
> I've done my best to add documentation.  There's more than before
> I started.

I guess it's my turn then - if I can manage to understand it.

Thanks,
NeilBrown
