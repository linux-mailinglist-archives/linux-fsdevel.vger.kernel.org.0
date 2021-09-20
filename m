Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9EB4128AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 00:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhITWMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 18:12:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38178 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhITWKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 18:10:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E5F422045;
        Mon, 20 Sep 2021 22:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632175747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxUUqfDmleC1byPtEZP8EjRtwfdiwNUWBaRXwsInV2w=;
        b=PSQHpvdYyiBx70zCvJuExd1Mqu1syG03bk12zCtBJmsBOXH4t776LFDGFvzikiIBwQn+Oi
        0ZdoXFM75gvHWh6dhtcFSMtHliyHma0jCmgR9UBE4l6URbC3FBT4M1yQnEA5rjieFit9mp
        gzGnAEf9lKbFvH5fru1a9i1a6wVAN28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632175747;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxUUqfDmleC1byPtEZP8EjRtwfdiwNUWBaRXwsInV2w=;
        b=iPuOAo3Q6mlwVwCAoPUe1sn3GuU7biOXGMPcAokUYLidt+uesD8NzC58J5aZx75jQh0tYO
        koMCRTzgEkyVeeDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 726CB13B2E;
        Mon, 20 Sep 2021 22:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ijWADIAGSWFwTwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 20 Sep 2021 22:09:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "Theodore Tso" <tytso@mit.edu>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <CAOQ4uxiCbppj0QApyxbqmGPwQy+bb4588KMu+uPZaFTGwAdMag@mail.gmail.com>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <YSkQ31UTVDtBavOO@infradead.org>,
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>,
 <YSnhHl0HDOgg07U5@infradead.org>,
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>,
 <YS8ppl6SYsCC0cql@infradead.org>, <20210901152251.GA6533@fieldses.org>,
 <163055605714.24419.381470460827658370@noble.neil.brown.name>,
 <20210905160719.GA20887@fieldses.org>,
 <163089177281.15583.1479086104083425773@noble.neil.brown.name>,
 <CAOQ4uxjbjkqEEXTe7V4vaUUM1gyJwe6iSAaz=PdxJyU2M14K-w@mail.gmail.com>,
 <163149382437.8417.3479990258042844514@noble.neil.brown.name>,
 <CAOQ4uxgFf5c0to7f4cT9c9JwWisYRf-kxiZS4BuyXaQV=bLbJg@mail.gmail.com>,
 <163157398661.3992.2107487416802405356@noble.neil.brown.name>,
 <CAOQ4uxiCbppj0QApyxbqmGPwQy+bb4588KMu+uPZaFTGwAdMag@mail.gmail.com>
Date:   Tue, 21 Sep 2021 08:09:01 +1000
Message-id: <163217574130.3992.9566275136281939557@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Sep 2021, Amir Goldstein wrote:
> On Tue, Sep 14, 2021 at 1:59 AM NeilBrown <neilb@suse.de> wrote:
> >
> > On Mon, 13 Sep 2021, Amir Goldstein wrote:
> > >
> > > Right, so the right fix IMO would be to provide similar semantics
> > > to the NFS client, like your first patch set tried to do.
> > >
> >
> > Like every other approach, this sounds good and sensible ...  until
> > you examine the details.
> >
> > For NFSv3 (RFC1813) this would be a protocol violation.
> > Section 3.3.3 (LOOKUP) says:
> >   A server will not allow a LOOKUP operation to cross a mountpoint to
> >   the root of a different filesystem, even if the filesystem is
> >   exported.
> >
> > The filesystem is represented by the fsid, so this implies that the fsid
> > of an object reported by LOOKUP must be the same as the fsid of the
> > directory used in the LOOKUP.
> >
> > Linux NFS does allow this restriction to be bypassed with the "crossmnt"
> > export option.  Maybe if crossmnt were given it would be defensible to
> > change the fsid - if crossmnt is not given, we leave the current
> > behaviour.  Note that this is a hack and while it is extremely useful,
> > it does not produce a seemly experience.  You can get exactly the same
> > problems with "find" - just not as uniformly (mounting with "-o noac"
> > makes them uniform).
> >
>=20
> I don't understand why we would need to talk about NFSv3.
> This btrfs export issue has been with us for a while.
> I see no reason to address it for old protocols if we can address
> it with a new protocol with better support for the concept of fsid hierarch=
y.
>=20
> > For NFSv4, we need to provide a "mounted-on" fileid for any mountpoint.
> > btrfs doesn't have a mounted-on fileid that can be used.  We can fake
> > something that might work reasonably well - but it would be fake.  (but
> > then ... btrfs already provided bogus information in getdents when there
> > is a subvol root in the directory).
> >
>=20
> That seems easy to solve by passing some flag to ->encode_fh()
> or if the behavior is persistent in btrfs by some mkfs/module/mount option
> then btrfs_encode_fh() will always encode the subvol root inode as
> resident of the parent tree-id, because nfsd anyway does not ->encode_fh()
> for export roots, right?

->encode_fh has nothing to do with getting the mounted-on fileid.
With a normal mount point, there are two inodes, one in each vfsmount.
We can call ->getattr to get kstat info including the inode number.
nfsd does that for the underlying vfsmnt/inode to get the mounted-on
fileid.  What should it do for btrfs "subvols"?

>=20
> > But these are relatively minor.  The bigger problem is /proc/mounts.  If
> > btrfs maintainers were willing to have every active subvolume appear in
> > /proc/mounts, then I would be happy to fiddle the NFS fsid and allow
> > every active NFS/btrfs subvolume to appear in /proc/mounts on the NFS
> > client.  But they aren't.  So I am not.
> >
>=20
> I don't understand why you need to tie the two together.

Because they are the same thing.
The most concrete reason is that any name that appears in /proc/mounts is
public.  People understand that when they mount filesystems.  People
don't need to understand that when creating private subvols.
There is anecdotal evidence that people might expect subvol paths to be
private.  If they then access those subvols via NFS, the names suddenly
become public.

> I would suggest:
> 1. Export different fsid's per subvols to NFSv4 based on statx()
> exported tree-id
> 2. NFS client side uses user configuration to determine which subvols
> to auto-mount

That is a non-started.  Subvols currently don't need mounting, they
transparently appear.  Requiring client-side configuration would be a
major cost for some users.

> 3. [optional] Provide a way to configure btrfs using mkfs/module/mount opti=
on
>     to behave locally the same as the NFS client, which will allow
> user configuration
>     to determine with subvols to auto-mount locally
>=20
> I admit that my understanding of the full picture is limited, but I don't
> understand why #3 is a strict dependency for #1 and #2.
>=20
> > > > And I really don't see how an nfs export option would help...  Differ=
ent
> > > > people within and organisation and using the same export might have
> > > > different expectations.
> > >
> > > That's true.
> > > But if admin decides to export a specific btrfs mount as a non-unified
> > > filesystem, then NFS clients can decide whether ot not to auto-mount the
> > > exported subvolumes and different users on the client machine can decide
> > > if they want to rsync or rsync --one-file-system, just as they would wi=
th
> > > local btrfs.
> > >
> > > And maybe I am wrong, but I don't see how the decision on whether to
> > > export a non-unified btrfs can be made a btrfs option or a nfsd global
> > > option, that's why I ended up with export option.
> >
> > Just because a btrfs option and global nfsd option are bad, that doesn't
> > mean an export option must be good.  It needs to be presented and
> > defended on its own merits.
> >
> > My current opinion (and I must admit I am feeling rather jaded about the
> > whole thing), is that while btrfs is a very interesting and valuable
> > experiment in fs design, it contains core mistakes that cannot be
> > incrementally fixed.  It should be marked as legacy with all current
> > behaviour declared as intentional and not subject to change.  This would
> > make way for a new "betrfs" which was designed based on all that we have
> > learned.  It would use the same code base, but present a more coherent
> > interface.  Exactly what that interface would be has yet to be decided,
> > but we would not be bound to maintain anything just because btrfs
> > supports it.
> >
>=20
> There is no need for a new driver name (like ext3=3D>ext4)
> Both ext4 and xfs have features that can be determined in mkfs time.
> This user experience change does not involve on-disk format changes,
> so it is a much easier case, because at least technically, there is nothing
> preventing an administrator from turning the user experience feature
> on and off with proper care of the consequences.
>=20
> Which brings me to another point.
> This discussion presents several technical challenges and you have
> been very creative in presenting technical solutions, but I think that
> the nature of the problem is more on the administrative side.
>=20
> I see this as an unfortunate flaw in our design process, when
> filesystem developers have long discussions about issues where
> some of the material stakeholders (i.e. administrators) are not in the loop.
> But I do not have very good ideas on how to address this flaw.

I agree this is more than a technical question.  I don't see it as
particularly an admin issue, because non-admin users can create subvols.

I see it as a conceptual problem.  What is a "subvol"? What do we want
it to be.  Does it make sense for the subvol namespace to align with the
filesystem namespace?
Subvols are more than directories, but less than filesystems.  How can
be best characterise them and thing about them? Are they directories
with extra features, or filesystems with some limitation (and some extra
features)?  Or are they something completely new?
What sort of identity information do applications *need* about files an
filesystems and how can we best provide that within the context of
existing APIs?

NeilBrown
