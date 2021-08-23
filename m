Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5A3F44B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 07:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhHWFwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 01:52:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57574 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhHWFwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 01:52:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D692521F2A;
        Mon, 23 Aug 2021 05:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629697921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4iErQiaXqFxK5RhLttHlBJp3hFnIIgCgpe0bRYAxeA=;
        b=0P+yRzaAjLZzOwjLwnO+ST7oqJZRVUIBYH/8reyeVumiChNsSSEwDYJmVXtoGCaPktoOaj
        KR6TOU2OzmpXXTrji3GDTILJo8lUyCIw1FZKD0eqPD/6Ea8JmTtkGmv6uYibxpUsHSotC/
        RXFz3BXqrKpKgwqDSHM93WXr1JRuIEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629697921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4iErQiaXqFxK5RhLttHlBJp3hFnIIgCgpe0bRYAxeA=;
        b=paBDsK2beDKmwINS44QOydx0LeA/J4VNMRURJOwOZ5bodeFivZgTi0BwkgLcBbvKcHkYgH
        jQPaLx9/iCTkCRDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B8E013A23;
        Mon, 23 Aug 2021 05:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yaacCn43I2HPOgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Aug 2021 05:51:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Cc:     "Wang Yugui" <wangyugui@e16-tech.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <20210822192917.GF29026@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>,
 <20210818225454.9558.409509F4@e16-tech.com>,
 <162932318266.9892.13600254282844823374@noble.neil.brown.name>,
 <20210819021910.GB29026@hungrycats.org>,
 <162942805745.9892.7512463857897170009@noble.neil.brown.name>,
 <20210822192917.GF29026@hungrycats.org>
Date:   Mon, 23 Aug 2021 15:51:54 +1000
Message-id: <162969791499.9892.11536866623369257320@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 Aug 2021, Zygo Blaxell wrote:
>=20
> Subvol IDs are not reusable.  They are embedded in shared object ownership
> metadata, and persist for some time after subvols are deleted.

Hmmm...  that's interesting.  Makes some sense too.  I did wonder how
ownership across multiple snapshots was tracked.

>=20
> > > > My preference would be for btrfs to start re-using old object-ids and
> > > > root-ids, and to enforce a limit (set at mkfs or tunefs) so that the
> > > > total number of bits does not exceed 64.  Unfortunately the maintaine=
rs
> > > > seem reluctant to even consider this.
> > >=20
> > > It was considered, implemented in 2011, and removed in 2020.  Rationale
> > > is in commit b547a88ea5776a8092f7f122ddc20d6720528782 "btrfs: start
> > > deprecation of mount option inode_cache".  It made file creation slower,
> > > and consumed disk space, iops, and memory to run.  Nobody used it.
> > > Newer on-disk data structure versions (free space tree, 2015) didn't
> > > bother implementing inode_cache's storage requirement.
> >=20
> > Yes, I saw that.  Providing reliable functional certainly can impact
> > performance and consume disk-space.  That isn't an excuse for not doing
> > it.=20
> > I suspect that carefully tuned code could result in typical creation
> > times being unchanged, and mean creation times suffering only a tiny
> > cost.  Using "max+1" when the creation rate is particularly high might
> > be a reasonable part of managing costs.
> > Storage cost need not be worse than the cost of tracking free blocks
> > on the device.
>=20
> The cost of _tracking_ free object IDs is trivial compared to the cost
> of _reusing_ an object ID on btrfs.

I hadn't thought of that.

>=20
> If btrfs doesn't reuse object numbers, btrfs can append new objects
> to the last partially filled leaf.  If there are shared metadata pages
> (i.e. snapshots), btrfs unshares a handful of pages once, and then future
> writes use densely packed new pages and delayed allocation without having
> to read anything.
>=20
> If btrfs reuses object numbers, the filesystem has to pack new objects
> into random previously filled metadata leaf nodes, so there are a lot
> of read-modify-writes scattered over old metadata pages, which spreads
> the working set around and reduces cache usage efficiency (i.e. uses
> more RAM).  If there are snapshots, each shared page that is modified
> for the first time after the snapshot comes with two-orders-of-magnitude
> worst-case write multipliers.

I don't really follow that .... but I'll take your word for it for now.

>=20
> The two-algorithm scheme (switching from "reuse freed inode" to "max+1"
> under load) would be forced into the "max+1" mode half the time by a
> daily workload of alternating git checkouts and builds.  It would save
> only one bit of inode namespace over the lifetime of the filesystem.
>=20
> > "Nobody used it" is odd.  It implies it would have to be explicitly
> > enabled, and all it would provide anyone is sane behaviour.  Who would
> > imagine that to be an optional extra.
>=20
> It always had to be explicitly enabled.  It was initially a workaround
> for 32-bit ino_t that was limiting a few users, but ino_t got better
> and the need for inode_cache went away.
>=20
> NFS (particularly NFSv2) might be the use case inode_cache has been
> waiting for.  btrfs has an i_version field for NFSv4, so it's not like
> there's no precedent for adding features in btrfs to support NFS.

NFSv2 is not worth any effort.  NFSv4 is.  NFSv3 ... some, but not a lot.

>=20
> On the other hand, the cost of ino_cache gets worse with snapshots,
> and the benefit in practice takes years to decades to become relevant.
> Users who are exporting snapshots over NFS are likely to be especially
> averse to using inode_cache.

That's the real killer.  Everything will work fine for years until it
doesn't.  And once it doesn't ....  what do you do?

Thanks for lot for all this background info.  I've found it to be very
helpful for my general understanding.

Thanks,
NeilBrown
