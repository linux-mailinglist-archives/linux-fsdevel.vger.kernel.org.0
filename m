Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CD83D9C33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 05:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhG2DgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 23:36:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54514 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhG2DgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 23:36:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1BCE220006;
        Thu, 29 Jul 2021 03:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627529773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mBfNkidGHKZ/oUryaQcD0ed3trip+Ck2y+rQ4lfw5k=;
        b=c9/6wVj6jR0kvNtCecPD8/6ECNnFmAneRF8qDgQbgjfjaPwg+9LDGYreJa78dJb02zkoFA
        Dzyl0QpORudP3MloQS+IS6cU2lw6/xdur4uX/8krqBM2NiUsX/JArmRTsLKoUFmXPB5zcW
        s+rQGzJa6ch3prqkfjhWqCeOnpanF58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627529773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mBfNkidGHKZ/oUryaQcD0ed3trip+Ck2y+rQ4lfw5k=;
        b=n3TZHTw7kmoR6n5Z2sp2PEfselbvHKMUlXAEWrVv3mFBXJKG4Abfe4FQ6HaHFjUrqfIUp9
        n4SPGOAh9vzy96CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6344E13483;
        Thu, 29 Jul 2021 03:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4/skCCkiAmHLJgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 29 Jul 2021 03:36:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Cc:     "Neal Gompa" <ngompa13@gmail.com>,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
In-reply-to: <20210729023751.GL10170@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <20210728125819.6E52.409509F4@e16-tech.com>,
 <20210728140431.D704.409509F4@e16-tech.com>,
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>,
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>,
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>,
 <20210729023751.GL10170@hungrycats.org>
Date:   Thu, 29 Jul 2021 13:36:06 +1000
Message-id: <162752976632.21659.9573422052804077340@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Jul 2021, Zygo Blaxell wrote:
> On Thu, Jul 29, 2021 at 08:50:50AM +1000, NeilBrown wrote:
> > On Wed, 28 Jul 2021, Neal Gompa wrote:
> > > On Wed, Jul 28, 2021 at 3:02 AM NeilBrown <neilb@suse.de> wrote:
> > > >
> > > > On Wed, 28 Jul 2021, Wang Yugui wrote:
> > > > > Hi,
> > > > >
> > > > > This patchset works well in 5.14-rc3.
> > > >
> > > > Thanks for testing.
> > > >
> > > > >
> > > > > 1, fixed dummy inode(255, BTRFS_FIRST_FREE_OBJECTID - 1 )  is chang=
ed to
> > > > > dynamic dummy inode(18446744073709551358, or 18446744073709551359, =
...)
> > > >
> > > > The BTRFS_FIRST_FREE_OBJECTID-1 was a just a hack, I never wanted it =
to
> > > > be permanent.
> > > > The new number is ULONG_MAX - subvol_id (where subvol_id starts at 25=
7 I
> > > > think).
> > > > This is a bit less of a hack.  It is an easily available number that =
is
> > > > fairly unique.
> > > >
> > > > >
> > > > > 2, btrfs subvol mount info is shown in /proc/mounts, even if nfsd/n=
fs is
> > > > > not used.
> > > > > /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test
> > > > > /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub1
> > > > > /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub2
> > > > >
> > > > > This is a visiual feature change for btrfs user.
> > > >
> > > > Hopefully it is an improvement.  But it is certainly a change that ne=
eds
> > > > to be carefully considered.
> > >=20
> > > I think this is behavior people generally expect, but I wonder what
> > > the consequences of this would be with huge numbers of subvolumes. If
> > > there are hundreds or thousands of them (which is quite possible on
> > > SUSE systems, for example, with its auto-snapshotting regime), this
> > > would be a mess, wouldn't it?
> >=20
> > Would there be hundreds or thousands of subvols concurrently being
> > accessed? The auto-mounted subvols only appear in the mount table while
> > that are being accessed, and for about 15 minutes after the last access.
> > I suspect that most subvols are "backup" snapshots which are not being
> > accessed and so would not appear.
>=20
> bees dedupes across subvols and polls every few minutes for new data
> to dedupe.  bees doesn't particularly care where the "src" in the dedupe
> call comes from, so it will pick a subvol that has a reference to the
> data at random (whichever one comes up first in backref search) for each
> dedupe call.  There is a cache of open fds on each subvol root so that it
> can access files within that subvol using openat().  The cache quickly
> populates fully, i.e. it holds a fd to every subvol on the filesystem.
> The cache has a 15 minute timeout too, so bees would likely keep the
> mount table fully populated at all times.

OK ... that is very interesting and potentially helpful - thanks.

Localizing these daemons in a separate namespace would stop them from
polluting the public namespace, but I don't know how easy that would
be..

Do you know how bees opens these files?  Does it use path-names from the
root, or some special btrfs ioctl, or ???
If path-names are not used, it might be possible to suppress the
automount.=20

>=20
> plocate also uses openat() and it can also be active on many subvols
> simultaneously, though it only runs once a day, and it's reasonable to
> exclude all snapshots from plocate for performance reasons.
>=20
> My bigger concern here is that users on btrfs can currently have private
> subvols with secret names.  e.g.
>=20
> 	user$ mkdir -m 700 private
> 	user$ btrfs sub create private/secret
> 	user$ cd private/secret
> 	user$ ...do stuff...
>=20
> Would "secret" now be visible in the very public /proc/mounts every time
> the user is doing stuff?

Yes, the secret would be publicly visible.  Unless we hid it.

It is conceivable that the content of /proc/mounts could be limited to
mountpoints where the process reading had 'x' access to the mountpoint.=20
However to be really safe we would want to require 'x' access to all
ancestors too, and possibly some 'r' access.  That would get
prohibitively expensive.

We could go with "owned by root, or owned by user" maybe.

Thanks,
NeilBrown


>=20
> > > Or can we add a way to mark these things to not show up there or is
> > > there some kind of behavioral change we can make to snapper or other
> > > tools to make them not show up here?
> >=20
> > Certainly it might make sense to flag these in some way so that tools
> > can choose the ignore them or handle them specially, just as nfsd needs
> > to handle them specially.  I was considering a "local" mount flag.
>=20
> I would definitely want an 'off' switch for this thing until the impact
> is better understood.
>=20
> > NeilBrown
> >=20
> > >=20
> > >=20
> > >=20
> > > --=20
> > > =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=
=A4=EF=BC=81/ Always, there's only one truth!
> > >=20
> > >=20
>=20
>=20
