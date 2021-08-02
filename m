Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D33DE1D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhHBVu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 17:50:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45376 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhHBVu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:50:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E11B81FFE8;
        Mon,  2 Aug 2021 21:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627941015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gu8r9ex7vph1OrGyVCdH5edfutPPZNcg5LDRN8eMTHQ=;
        b=dJgqr9lxZibtEfpw14t4BQ/4zkJu/pEj0G9eC1//Zq6OdgioL/c2kIERMOZN9SByBBRzSs
        M9F/TCr+Y+qnbKcoxeTCSS2/JDGu454v90A+ycrTNDZTHgBY5GDR1fpm2jEsb08afY2n2c
        LgdpYEp9G0BhgTK5MOnaRAOZmJmAQLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627941015;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gu8r9ex7vph1OrGyVCdH5edfutPPZNcg5LDRN8eMTHQ=;
        b=vG1JjLx1Hefqvwz4O60nU+4bPy7MIZQ0KRJNcC4GPpfZVIVUeFdw5323OafSbVx65FpQHA
        L05KNg6T2xYeITDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ED5113CB3;
        Mon,  2 Aug 2021 21:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L2FpO5NoCGE0CgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 Aug 2021 21:50:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Forza" <forza@tnonline.net>
Cc:     "Amir Goldstein" <amir73il@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
In-reply-to: <697c3b9.eed85c8a.17b0621a43a@tnonline.net>
References: <697c3b9.eed85c8a.17b0621a43a@tnonline.net>
Date:   Tue, 03 Aug 2021 07:50:09 +1000
Message-id: <162794100936.32159.5414108054735553873@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 02 Aug 2021, Forza wrote:
>=20
> ---- From: Amir Goldstein <amir73il@gmail.com> -- Sent: 2021-08-02 - 09:54 =
----
>=20
> > On Mon, Aug 2, 2021 at 8:41 AM NeilBrown <neilb@suse.de> wrote:
> >>
> >> On Mon, 02 Aug 2021, Al Viro wrote:
> >> > On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
> >> >
> >> > > It think we need to bite-the-bullet and decide that 64bits is not
> >> > > enough, and in fact no number of bits will ever be enough.  overlayfs
> >> > > makes this clear.
> >> >
> >> > Sure - let's go for broke and use XML.  Oh, wait - it's 8 months too
> >> > early...
> >> >
> >> > > So I think we need to strongly encourage user-space to start using
> >> > > name_to_handle_at() whenever there is a need to test if two things a=
re
> >> > > the same.
> >> >
> >> > ... and forgetting the inconvenient facts, such as that two different
> >> > fhandles may correspond to the same object.
> >>
> >> Can they?  They certainly can if the "connectable" flag is passed.
> >> name_to_handle_at() cannot set that flag.
> >> nfsd can, so using name_to_handle_at() on an NFS filesystem isn't quite
> >> perfect.  However it is the best that can be done over NFS.
> >>
> >> Or is there some other situation where two different filehandles can be
> >> reported for the same inode?
> >>
> >> Do you have a better suggestion?
> >>
> >=20
> > Neil,
> >=20
> > I think the plan of "changing the world" is not very realistic.
> > Sure, *some* tools can be changed, but all of them?
> >=20
> > I went back to read your initial cover letter to understand the
> > problem and what I mostly found there was that the view of
> > /proc/x/mountinfo was hiding information that is important for
> > some tools to understand what is going on with btrfs subvols.
> >=20
> > Well I am not a UNIX history expert, but I suppose that
> > /proc/PID/mountinfo was created because /proc/mounts and
> > /proc/PID/mounts no longer provided tool with all the information
> > about Linux mounts.
> >=20
> > Maybe it's time for a new interface to query the more advanced
> > sb/mount topology? fsinfo() maybe? With mount2 compatible API for
> > traversing mounts that is not limited to reporting all entries inside
> > a single page. I suppose we could go for some hierarchical view
> > under /proc/PID/mounttree. I don't know - new API is hard.
> >=20
> > In any case, instead of changing st_dev and st_ino or changing the
> > world to work with file handles, why not add inode generation (and
> > maybe subvol id) to statx().
> > filesystem that care enough will provide this information and tools that
> > care enough will use it.
> >=20
> > Thanks,
> > Amir.
>=20
> I think it would be better and easier if nfs provided clients with
> virtual inodes and kept an internal mapping to actual filesystem
> inodes.  Samba does this with the mount.cifs -o noserverino option,
> and as far as I know it works pretty well.=20

This approach does have it's place, but it is far from perfect.
POSIX expects an inode number to be unique and stable for the lifetime
of the file.  Different applications have different expectations ranging
from those which don't care at all to those which really need the full
lifetime and full uniqueness (like an indexing tool).

Dynamically provided inode numbers cannot provide the full guarantee.
If implemented on the NFS client, it could ensure two inodes that are in
cache have different inode numbers, and it could ensure inode numbers
are not reused for a very long time, but it could not ensure they remain
stable for the lifetime of the file.  To do that last, it would need
stable storage to keep a copy of all the metadata of the whole
filesystem.

Implementing it on the NFS server would provide fewer guarantees.  The
server has limited insight into the client-side cache, so inode numbers
might change while a file was in cache on the client.

NeilBrown



>=20
> This  could be made either as an export option (/mnt/foo *(noserverino) or =
like in the Samba case, a mount option.=20
>=20
> This way existing tools will continue to work and we don't have to reinvent=
 various Linux subsystems. Because it's an option, users that don't use btrfs=
 or other filesystems with snapshots, can simply skip it.=20
>=20
> Thanks,=20
> Forza=20
>=20
>=20
