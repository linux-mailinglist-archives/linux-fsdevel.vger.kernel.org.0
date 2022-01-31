Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B294A52BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 00:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiAaXAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 18:00:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34870 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiAaXAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:00:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0A4C1F380;
        Mon, 31 Jan 2022 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643670032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IljsixcEjc3xrld9Nu5EuyjOHQ/tnbkGIqjw9m1QExA=;
        b=fsAf9O8IM7yigQiRbwYGvosRn1kNjcqV7r/JdY9FLb8efSzYQe5vN1S36TI5PkIubpIv65
        zbWyiuCqJb6DgHLFZC79GnI5XHI2YLCZnM4Xaf3hzMYoUZTbwI3H6n/qPIBPEJ0RFU37G+
        rZ9UKFfY71yeielfXcipBAEkpEijFkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643670032;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IljsixcEjc3xrld9Nu5EuyjOHQ/tnbkGIqjw9m1QExA=;
        b=+hW84kZGs/Q7UiOk7HAn/cszUmvI6EZclnHek/eXNoL2DlgZHvdzVuRFmGrXaeiS4ppWAI
        x50pk5uFSM9F2iDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1001413CCD;
        Mon, 31 Jan 2022 23:00:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1GYyLwxq+GF8HgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jan 2022 23:00:28 +0000
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
In-reply-to: <YffgKva2Dz3cTwhr@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>,
 <164360183348.4233.761031466326833349.stgit@noble.brown>,
 <YfdlbxezYSOSYmJf@casper.infradead.org>,
 <164360446180.18996.6767388833611575467@noble.neil.brown.name>,
 <YffgKva2Dz3cTwhr@casper.infradead.org>
Date:   Tue, 01 Feb 2022 10:00:23 +1100
Message-id: <164367002370.18996.7242801209611375112@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 01 Feb 2022, Matthew Wilcox wrote:
> On Mon, Jan 31, 2022 at 03:47:41PM +1100, NeilBrown wrote:
> > On Mon, 31 Jan 2022, Matthew Wilcox wrote:
> > > > +++ b/fs/fuse/file.c
> > > > @@ -958,6 +958,8 @@ static void fuse_readahead(struct readahead_contr=
ol *rac)
> > > > =20
> > > >  	if (fuse_is_bad(inode))
> > > >  		return;
> > > > +	if (fc->num_background >=3D fc->congestion_threshold)
> > > > +		return;
> > >=20
> > > This seems like a bad idea to me.  If we don't even start reads on
> > > readahead pages, they'll get ->readpage called on them one at a time
> > > and the reading thread will block.  It's going to lead to some nasty
> > > performance problems, exactly when you don't want them.  Better to
> > > queue the reads internally and wait for congestion to ease before
> > > submitting the read.
> > >=20
> >=20
> > Isn't that exactly what happens now? page_cache_async_ra() sees that
> > inode_read_congested() returns true, so it doesn't start readahead.
> > ???
>=20
> It's rather different.  Imagine the readahead window has expanded to
> 256kB (64 pages).  Today, we see congestion and don't do anything.
> That means we miss the async readahed opportunity, find a missing
> page and end up calling into page_cache_sync_ra(), by which time
> we may or may not be congested.
>=20
> If the inode_read_congested() in page_cache_async_ra() is removed and
> the patch above is added to replace it, we'll allocate those 64 pages and
> add them to the page cache.  But then we'll return without starting IO.
> When we hit one of those !uptodate pages, we'll call ->readpage on it,
> but we won't do anything to the other 63 pages.  So we'll go through a
> protracted slow period of sending 64 reads, one at a time, whether or
> not congestion has eased.  Then we'll hit a missing page and proceed
> to the sync ra case as above.

Hmmm... where is all this documented?
The entry for readahead in vfs.rst says:

    If the filesystem decides to stop attempting I/O before reaching the
    end of the readahead window, it can simply return.

but you are saying that if it simply returns, it'll most likely just get
called again.  So maybe it shouldn't say that?

What do other filesystems do?
ext4 sets REQ_RAHEAD, but otherwise just pushes ahead and submits all
requests. btrfs seems much the same.
xfs uses iomp_readahead ..  which again sets REQ_RAHEAD but otherwise
just does a normal read.

The effect of REQ_RAHEAD seems to be primarily to avoid retries on
failure.

So it seems that core read-ahead code it not set up to expect readahead
to fail, though it is (begrudgingly) permitted.

The current inode_read_congested() test in page_cache_async_ra() seems
to be just delaying the inevitable (and in fairness, the comment does
say "Defer....").  Maybe just blocking on the congestion is an equally
good way to delay it...

I note that ->readahead isn't told if the read-ahead is async or not, so
my patch will drop sync read-ahead on congestion, which the current code
doesn't do.

So maybe this congestion tracking really is useful, and we really want
to keep it.

I really would like to see that high-level documentation!!

Thanks,
NeilBrown

=20
