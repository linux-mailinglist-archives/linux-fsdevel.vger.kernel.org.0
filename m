Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4C3DB30D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 07:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhG3F6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 01:58:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51830 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbhG3F6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:58:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 100022238B;
        Fri, 30 Jul 2021 05:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627624694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTRH/OYio0D4QPjATbqxXdI9yfVMbySsNkg6tU+Cye8=;
        b=EV650qU5HyFBDOyYdmgsDF1mEj2Pj7Fb4hLrAi6uCsyc0YvOuZ9VpSh3gHCMQN8V1ExJP6
        gpjgTf3725oaO9xAvyypXwvNCIWJoHf6iK10+Wib2HoqHB5wbsqABGq/JXI2X3+dIzlpQF
        3knXPWUg44bw4JI3Y/nDsQoJ7DKrtA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627624694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTRH/OYio0D4QPjATbqxXdI9yfVMbySsNkg6tU+Cye8=;
        b=AO+FcYH1ftcTRQ+U4RqzRpwgi0JrZL0WmGrnBCPIxh+nFSvITYzG1/9UW4sjOX7naT+UtP
        QDbGBZf+azZUcJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FAE813BF9;
        Fri, 30 Jul 2021 05:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qfHVM/GUA2GqfwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 30 Jul 2021 05:58:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Cc:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>,
        "Neal Gompa" <ngompa13@gmail.com>,
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
In-reply-to: <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <20210728125819.6E52.409509F4@e16-tech.com>,
 <20210728140431.D704.409509F4@e16-tech.com>,
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>,
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>,
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>,
 <20210729023751.GL10170@hungrycats.org>,
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>,
 <20210729232017.GE10106@hungrycats.org>,
 <162761259105.21659.4838403432058511846@noble.neil.brown.name>,
 <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>
Date:   Fri, 30 Jul 2021 15:58:07 +1000
Message-id: <162762468711.21659.161298577376336564@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jul 2021, Qu Wenruo wrote:
>=20
> On 2021/7/30 =E4=B8=8A=E5=8D=8810:36, NeilBrown wrote:
> >
> > I've been pondering all the excellent feedback, and what I have learnt
> > from examining the code in btrfs, and I have developed a different
> > perspective.
>=20
> Great! Some new developers into the btrfs realm!

:-)

>=20
> >
> > Maybe "subvol" is a poor choice of name because it conjures up
> > connections with the Volumes in LVM, and btrfs subvols are very different
> > things.  Btrfs subvols are really just subtrees that can be treated as a
> > unit for operations like "clone" or "destroy".
> >
> > As such, they don't really deserve separate st_dev numbers.
> >
> > Maybe the different st_dev numbers were introduced as a "cheap" way to
> > extend to size of the inode-number space.  Like many "cheap" things, it
> > has hidden costs.
> >
> > Maybe objects in different subvols should still be given different inode
> > numbers.  This would be problematic on 32bit systems, but much less so on
> > 64bit systems.
> >
> > The patch below, which is just a proof-of-concept, changes btrfs to
> > report a uniform st_dev, and different (64bit) st_ino in different subvol=
s.
> >
> > It has problems:
> >   - it will break any 32bit readdir and 32bit stat.  I don't know how big
> >     a problem that is these days (ino_t in the kernel is "unsigned long",
> >     not "unsigned long long). That surprised me).
> >   - It might break some user-space expectations.  One thing I have learnt
> >     is not to make any assumption about what other people might expect.
>=20
> Wouldn't any filesystem boundary check fail to stop at subvolume boundary?

You mean like "du -x"?? Yes.  You would lose the misleading illusion
that there are multiple filesystems.  That is one user-expectation that
would need to be addressed before people opt-in

>=20
> Then it will go through the full btrfs subvolumes/snapshots, which can
> be super slow.
>=20
> >
> > However, it would be quite easy to make this opt-in (or opt-out) with a
> > mount option, so that people who need the current inode numbers and will
> > accept the current breakage can keep working.
> >
> > I think this approach would be a net-win for NFS export, whether BTRFS
> > supports it directly or not.  I might post a patch which modifies NFS to
> > intuit improved inode numbers for btrfs exports....
>=20
> Some extra ideas, but not familiar with VFS enough to be sure.
>=20
> Can we generate "fake" superblock for each subvolume?

I don't see how that would help.  Either subvols are like filesystems
and appear in /proc/mounts, or they aren't like filesystems and don't
get different st_dev.  Either of these outcomes can be achieved without
fake superblocks.  If you really need BTRFS subvols to have some
properties of filesystems but not all, then you are in for a whole world
of pain.

Maybe btrfs subvols should be treated more like XFS "managed trees".  At
least there you have precedent and someone else to share the pain.
Maybe we should train people to use "quota" to check the usage of a
subvol, rather than "du" (which will stop working with my patch if it
contains refs to other subvols) or "df" (which already doesn't work), or
"btrs df"

> Like using the subolume UUID to replace the FSID of each subvolume.
> Could that migrate the problem?

Which problem, exactly?  My first approach to making subvols work on NFS
took essentially that approach.  It was seen (quite reasonably) as a
hack to work around poor behaviour in btrfs.

Given that NFS has always seen all of a btrfs filesystem as have a
uniform fsid, I'm now of the opinion that we don't want to change that,
but should just fix the duplicate-inode-number problem.

If I could think of some way for NFSD to see different inode numbers
than VFS, I would push hard for fixs nfsd by giving it more sane inode
numbers.

Thanks,
NeilBrown

