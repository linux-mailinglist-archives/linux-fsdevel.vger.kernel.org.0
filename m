Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC94A3CF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 05:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357641AbiAaErv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 23:47:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55406 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357627AbiAaEru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:47:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3A46210F6;
        Mon, 31 Jan 2022 04:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643604468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSwv6L43SXyMlXVFJGlpTzOhU1MUr66mHSDbc0nI8sU=;
        b=kbhC7LbG6ekBVlb+v84wL/oJji0/oHE7f9OLpcNLQUfoIJ+f06Pjzma4QZ4kZ4OSH1Wm4v
        c9f6jgsDwEu60fn4dkQl8w0Yw7+Cy0cuLjd8pKFlPWDc7wHgGs7Dx1iFGLM7ZyhHDh0Gr5
        2e2yj2MyTOdtsPfDc7zpQF+SHtdZahc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643604468;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSwv6L43SXyMlXVFJGlpTzOhU1MUr66mHSDbc0nI8sU=;
        b=Fh71L0tWoun0kUKQXBPCMtWp8Se+0egFg+WMYHfh7K2k5iExd1baBYE2V/bvBbf1E0044Y
        HAiHoHRZwdpWG6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5950713638;
        Mon, 31 Jan 2022 04:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1oJJBvFp92HXFAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jan 2022 04:47:45 +0000
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
In-reply-to: <YfdlbxezYSOSYmJf@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>,
 <164360183348.4233.761031466326833349.stgit@noble.brown>,
 <YfdlbxezYSOSYmJf@casper.infradead.org>
Date:   Mon, 31 Jan 2022 15:47:41 +1100
Message-id: <164360446180.18996.6767388833611575467@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 31 Jan 2022, Matthew Wilcox wrote:
> On Mon, Jan 31, 2022 at 03:03:53PM +1100, NeilBrown wrote:
> > diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> > index 182b24a14804..5f74e2585f50 100644
> > --- a/fs/fuse/dax.c
> > +++ b/fs/fuse/dax.c
> > @@ -781,6 +781,9 @@ static int fuse_dax_writepages(struct address_space *=
mapping,
> >  	struct inode *inode =3D mapping->host;
> >  	struct fuse_conn *fc =3D get_fuse_conn(inode);
> > =20
> > +	if (wbc->sync_mode =3D=3D WB_SYNC_NONE &&
> > +	    fc->num_background >=3D fc->congestion_threshold)
> > +		return 0;
> >  	return dax_writeback_mapping_range(mapping, fc->dax->dev, wbc);
>=20
> This makes no sense.  Doing writeback for DAX means flushing the
> CPU cache (in a terribly inefficient way), but it's not going to
> be doing anything in the background; it's a sync operation.

Fair enough ...  I was just being consistent.  I didn't wonder if dax
might be a bit special, but figured the change couldn't hurt.


>=20
> > +++ b/fs/fuse/file.c
> > @@ -958,6 +958,8 @@ static void fuse_readahead(struct readahead_control *=
rac)
> > =20
> >  	if (fuse_is_bad(inode))
> >  		return;
> > +	if (fc->num_background >=3D fc->congestion_threshold)
> > +		return;
>=20
> This seems like a bad idea to me.  If we don't even start reads on
> readahead pages, they'll get ->readpage called on them one at a time
> and the reading thread will block.  It's going to lead to some nasty
> performance problems, exactly when you don't want them.  Better to
> queue the reads internally and wait for congestion to ease before
> submitting the read.
>=20

Isn't that exactly what happens now? page_cache_async_ra() sees that
inode_read_congested() returns true, so it doesn't start readahead.
???

NeilBrown
