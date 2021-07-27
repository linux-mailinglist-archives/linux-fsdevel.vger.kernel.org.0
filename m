Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E193D6D07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 05:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhG0DJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 23:09:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44474 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbhG0DJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 23:09:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1284B22019;
        Tue, 27 Jul 2021 03:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627357777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADAJ0xRh1XICgfjWMOlNhyNJ5UxRHdIAobMT7+CzNzw=;
        b=MDaJ6ioB9xpCfvLmF7/OrVZ8BVNK06CP7wr8B84iyhptD97IBxCwe00N6BLr5FhZWRv7ro
        4TeioBLN3olfKzQbu6+UuC6xCsXIs/4XaN8RymSzZQbba73lcwiINXRa2GdE28gFRswiFe
        EhoZ0o7vTE9Z5CV1w5OKwRBFjfPTBvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627357777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADAJ0xRh1XICgfjWMOlNhyNJ5UxRHdIAobMT7+CzNzw=;
        b=/wi4abGKP+tM1SmABu/nTaRDwc+NdvHwOFIAuRRvzx6Xh74A6wMcVMZFWkuBM3EfPb5dZB
        Yuc3SE8Om6nk8WDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EAA413B5C;
        Tue, 27 Jul 2021 03:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XWb3Nk6C/2ACKQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 03:49:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Goldwyn Rodrigues" <rgoldwyn@suse.de>
Cc:     "Matthew Wilcox" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs: reduce pointers while using file_ra_state_init()
In-reply-to: <20210727024630.ia4sne4gbruvssgy@fiona>
References: <20210726164647.brx3l2ykwv3zz7vr@fiona>,
 <162733718119.4153.5949006309014161476@noble.neil.brown.name>,
 <YP9p8G6eu30+d2jH@casper.infradead.org>,
 <162735275468.4153.4700285307587386171@noble.neil.brown.name>,
 <20210727024630.ia4sne4gbruvssgy@fiona>
Date:   Tue, 27 Jul 2021 13:49:31 +1000
Message-id: <162735777193.4153.15638869819515863315@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 27 Jul 2021, Goldwyn Rodrigues wrote:
> On 12:25 27/07, NeilBrown wrote:
> > On Tue, 27 Jul 2021, Matthew Wilcox wrote:
> > > On Tue, Jul 27, 2021 at 08:06:21AM +1000, NeilBrown wrote:
> > > > You seem to be assuming that inode->i_mapping->host is always 'inode'.
> > > > That is not the case.
> > >=20
> > > Weeeelllll ... technically, outside of the filesystems that are
> > > changed here, the only assumption in common code that is made is that
> > > inode_to_bdi(inode->i_mapping->host->i_mapping->host) =3D=3D
> > > inode_to_bdi(inode)
> >=20
> > Individual filesystems doing their own thing is fine.  Passing just an
> > inode to inode_to_bdi is fine.
> >=20
> > But the patch changes do_dentry_open()
>=20
> But do_dentry_open() is setting up the file pointer (f) based on
> inode (and it's i_mapping). Can f->f_mapping change within
> do_dentry_open()?

do_dentry_open calls file_ra_state_init() to copy ra_pages from the bdi
for inode->i_mapping->host->i_mapping.
I do think there is some pointless indirection here, and it should be
sufficient to pass inode->i_mapping (aka f->f_mapping) to
file_ra_state_init(). (though in 2004, Andrew Morton thought otherwise)
But you have changed do_dentry_open() to not follow the ->i_mapping link
at all.
So in the coda case f->f_ra will be inititalied from the bdi for coda
instead of the bdi for the filesystem coda uses for local storage.

So this is a change in behaviour.  Maybe not a serious one, but one that
needs to be understood.

https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?i=
d=3D1c211088833a27daa4512348bcae9890e8cf92d4

Hmm.  drivers/dax/device.c does some funky things with ->i_mapping too.
I wonder if that would be affected by this change....  probably not, it
looks like it is the same super_block and so the same ra info for both
mappings.

NeilBrown

>=20
> >=20
> > >=20
> > > Looking at inode_to_bdi, that just means that they have the same i_sb.
> > > Which is ... not true for character raw devices?
> > >         if (++raw_devices[minor].inuse =3D=3D 1)
> > >                 file_inode(filp)->i_mapping =3D
> > >                         bdev->bd_inode->i_mapping;
> > > but then, who's using readahead on a character raw device?  They
> > > force O_DIRECT.  But maybe this should pass inode->i_mapping->host
> > > instead of inode.
> >=20
> > Also not true in coda.
> >=20
> > coda (for those who don't know) is a network filesystem which fetches
> > whole files (and often multiple files) at a time (like the Andrew
> > filesystem).  The files are stored in a local filesystem which acts as a
> > cache.
> >=20
> > So an inode in a 'coda' filesystem access page-cache pages from a file
> > in e.g. an 'ext4' filesystem.  This is done via the ->i_mapping link.
> > For (nearly?) all other filesystems, ->i_mapping is a link to ->i_data
> > in the same inode.
> >=20
> > >=20
> > > > In particular, fs/coda/file.c contains
> > > >=20
> > > > 	if (coda_inode->i_mapping =3D=3D &coda_inode->i_data)
> > > > 		coda_inode->i_mapping =3D host_inode->i_mapping;
> > > >=20
> > > > So a "coda_inode" shares the mapping with a "host_inode".
> > > >=20
> > > > This is why an inode has both i_data and i_mapping.
> > > >=20
> > > > So I'm not really sure this patch is safe.  It might break codafs.
> > > >=20
> > > > But it is more likely that codafs isn't used, doesn't work, should be
> > > > removed, and i_data should be renamed to i_mapping.
> > >=20
> > > I think there's also something unusual going on with either ocfs2
> > > or gfs2.  But yes, I don't understand the rules for when I need to
> > > go from inode->i_mapping->host.
> > >=20
> >=20
> > Simple.  Whenever you want to work with the page-cache pages, you cannot
> > assume anything in the original inode is relevant except i_mapping (and
> > maybe i_size I guess).
> >=20
> > NeilBrown
>=20
> --=20
> Goldwyn
>=20
>=20
