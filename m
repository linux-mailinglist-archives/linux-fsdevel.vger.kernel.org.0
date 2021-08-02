Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57B3DE28E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 00:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhHBWhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 18:37:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43330 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhHBWhC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:37:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 169132202D;
        Mon,  2 Aug 2021 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627943811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bwgb2YMkESE1NM618W3Z7AHMaRWY4C9otpFNBRJYGuI=;
        b=2UwYCVdOoKf+0Cq5TDYhQUs9amOfRKLDgDmZSikJVjB5qH5xGVb0dqdGAkS/qjeD1ZSq0X
        AOUkPBvSE6pirV7txiPXu6jlTigBmjB61+gkQqCKAIDi0yvXQv57QAmhFhFx7MlD4vkPnb
        Qmtk0D69BPFCHc9sR5RoUF/WAkpfXHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627943811;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bwgb2YMkESE1NM618W3Z7AHMaRWY4C9otpFNBRJYGuI=;
        b=yyaZT8gDa9kdYjYOcxCY0ZUxYcdV+THhHk16EeAaWaqeutjEBM/can7uOFzevqfOHD29yb
        18m4Npn/SASujlCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E48F613C96;
        Mon,  2 Aug 2021 22:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XT47KH9zCGFXFQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 Aug 2021 22:36:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
In-reply-to: <20210802221434.GG6890@fieldses.org>
References: <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>,
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>,
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>,
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>,
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>,
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>,
 <20210802123930.GA6890@fieldses.org>,
 <162793864421.32159.6348977485257143426@noble.neil.brown.name>,
 <20210802215059.GF6890@fieldses.org>,
 <162794157037.32159.9608382458264702109@noble.neil.brown.name>,
 <20210802221434.GG6890@fieldses.org>
Date:   Tue, 03 Aug 2021 08:36:44 +1000
Message-id: <162794380480.32159.709590144894407738@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 03 Aug 2021, J. Bruce Fields wrote:
> On Tue, Aug 03, 2021 at 07:59:30AM +1000, NeilBrown wrote:
> > On Tue, 03 Aug 2021, J. Bruce Fields wrote:
> > > On Tue, Aug 03, 2021 at 07:10:44AM +1000, NeilBrown wrote:
> > > > On Mon, 02 Aug 2021, J. Bruce Fields wrote:
> > > > > On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
> > > > > > For btrfs, the "location" is root.objectid ++ file.objectid.  I t=
hink
> > > > > > the inode should become (file.objectid ^ swab64(root.objectid)). =
 This
> > > > > > will provide numbers that are unique until you get very large sub=
vols,
> > > > > > and very many subvols.
> > > > >=20
> > > > > If you snapshot a filesystem, I'd expect, at least by default, that
> > > > > inodes in the snapshot to stay the same as in the snapshotted
> > > > > filesystem.
> > > >=20
> > > > As I said: we need to challenge and revise user-space (and meat-space)
> > > > expectations.=20
> > >=20
> > > The example that came to mind is people that export a snapshot, then
> > > replace it with an updated snapshot, and expect that to be transparent
> > > to clients.
> > >=20
> > > Our client will error out with ESTALE if it notices an inode number
> > > changed out from under it.
> >=20
> > Will it?
>=20
> See fs/nfs/inode.c:nfs_check_inode_attributes():
>=20
> 	if (nfsi->fileid !=3D fattr->fileid) {
>                 /* Is this perhaps the mounted-on fileid? */
>                 if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
>                     nfsi->fileid =3D=3D fattr->mounted_on_fileid)
>                         return 0;
>                 return -ESTALE;
>         }

That code fires if the fileid (inode number) reported for a particular
filehandle changes.  I'm saying that won't happen.

If you reflink (aka snaphot) a btrfs subtree (aka "subvol"), then the
new sub-tree will ALREADY have different filehandles than the original
subvol.  Whether it has the same inode numbers or different ones is
irrelevant to NFS.

(on reflection, I didn't say that as clearly as I could have done last time)

NeilBrown
