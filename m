Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4298C7A504D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjIRRCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjIRRCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:02:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DAEAC;
        Mon, 18 Sep 2023 10:02:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C11C32785;
        Mon, 18 Sep 2023 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695047388;
        bh=kJa0GvslCCcWNV+hoWf/bww4C4/mthZSRBqChvvgee0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=guDI6Ni1l8l6BlhUUQMujoFH6hG+mfolikP/DaDNJta6Y43W00WHf90XlGHF6fHLo
         NLgTDf8e1LD6OKhsssCr5QyqmFMLYPcQv4q2Sge6U1hWlCbIZBfkFgLTH5Q2JJqC0V
         /TixeU5oylxH/lRszFSHlcZoVIh8rI3E8dQ8uH0fj7KYaAnRtezR9wKqFF/cuEG423
         b4X1uiT7KuLkQQ/pMTDyNEsMyTpQnMkajMWonbBz/hYRMOVjVDjbgXjp/BSqBX2LNb
         mdFN1nlYAXuq2dTc7swZjhVeGzk3qAQNPkqN6kNHs11fgf7J/JMBCYd5b8O9l89Ovl
         WOwmwv1x1PPNQ==
Message-ID: <3183d8b21e78dce2c1d5cbc8a1304f2937110621.camel@kernel.org>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Sep 2023 10:29:46 -0400
In-Reply-To: <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
         <20230913152238.905247-3-mszeredi@redhat.com>
         <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
         <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
         <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-09-14 at 17:26 +0200, Christian Brauner wrote:
> On Thu, Sep 14, 2023 at 12:13:54PM +0200, Miklos Szeredi wrote:
> > On Thu, 14 Sept 2023 at 11:28, Christian Brauner <brauner@kernel.org> w=
rote:
> > >=20
> > > On Wed, Sep 13, 2023 at 05:22:35PM +0200, Miklos Szeredi wrote:
> > > > Add a way to query attributes of a single mount instead of having t=
o parse
> > > > the complete /proc/$PID/mountinfo, which might be huge.
> > > >=20
> > > > Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a =
mount
> > > > needs to be queried based on path, then statx(2) can be used to fir=
st query
> > > > the mount ID belonging to the path.
> > > >=20
> > > > Design is based on a suggestion by Linus:
> > > >=20
> > > >   "So I'd suggest something that is very much like "statfsat()", wh=
ich gets
> > > >    a buffer and a length, and returns an extended "struct statfs" *=
AND*
> > > >    just a string description at the end."
> > >=20
> > > So what we agreed to at LSFMM was that we split filesystem option
> > > retrieval into a separate system call and just have a very focused
> > > statx() for mounts with just binary and non-variable sized informatio=
n.
> > > We even gave David a hard time about this. :) I would really love if =
we
> > > could stick to that.
> > >=20
> > > Linus, I realize this was your suggestion a long time ago but I would
> > > really like us to avoid structs with variable sized fields at the end=
 of
> > > a struct. That's just so painful for userspace and universally dislik=
ed.
> > > If you care I can even find the LSFMM video where we have users of th=
at
> > > api requesting that we please don't do this. So it'd be great if you
> > > wouldn't insist on it.
> >=20
> > I completely missed that.
>=20
> No worries, I think the discussion touching on this starts at:
> https://youtu.be/j3fp2MtRr2I?si=3Df-YBg6uWq80dV3VC&t=3D1603
> (with David talking quietly without a microphone for some parts
> unfortunately...)
>=20
> > What I'm thinking is making it even simpler for userspace:
> >=20
> > struct statmnt {
> >   ...
> >   char *mnt_root;
> >   char *mountpoint;
> >   char *fs_type;
> >   u32 num_opts;
> >   char *opts;
> > };
> >=20
> > I'd still just keep options nul delimited.
> >=20
> > Is there a good reason not to return pointers (pointing to within the
> > supplied buffer obviously) to userspace?
>=20
> It's really unpleasant to program with. Yes, I think you pointed out
> before that it often doesn't matter much as long as the system call is
> really only relevant to some special purpose userspace.
>=20
> But statmount() will be used pretty extensively pretty quickly for the
> purpose of finding out mount options on a mount (Querying a whole
> sequences of mounts via repeated listmount() + statmount() calls on the
> other hand will be rarer.).
>=20
> And there's just so many tools that need this: libmount, systemd, all
> kinds of container runtimes, path lookup libraries such as libpathrs,
> languages like go and rust that expose and wrap these calls and so on.
>=20
> Most of these tools don't need to know about filesystem mount options
> and if they do they can just query that through an extra system call. No
> harm in doing that.
>=20
> The agreement we came to to split out listing submounts into a separate
> system call was exactly to avoid having to have a variable sized pointer
> at the end of the struct statmnt (That's also part of the video above
> btw.) and to make it as simple as possible.
>=20
> Plus, the format for how to return arbitrary filesystem mount options
> warrants a separate discussion imho as that's not really vfs level
> information.
>=20
> > > This will also allow us to turn statmnt() into an extensible argument
> > > system call versioned by size just like we do any new system calls wi=
th
> > > struct arguments (e.g., mount_setattr(), clone3(), openat2() and so o=
n).
> > > Which is how we should do things like that.
> >=20
> > The mask mechanism also allow versioning of the struct.
>=20
> Yes, but this is done with reserved space which just pushes away the
> problem and bloats the struct for the sake of an unknown future. If we
> were to use an extensible argument struct we would just version by size.
> The only requirement is that you extend by 64 bit (see struct
> clone_args) which had been extended.
>=20
>=20

Fixed size structs are much nicer to deal with, and most of the fields
we're talking about don't change ofetn enough to make trying to strive
for perfect atomicity worthwhile.

What sort of interface are you thinking for fetching variable-length
string info? It sounds a lot like getxattr that uses a mnt_id in place
of a pathname. getmntattr() ?


> > >=20
> > > Other than that I really think this is on track for what we ultimatel=
y
> > > want.
> > >=20
> > > > +struct stmt_str {
> > > > +     __u32 off;
> > > > +     __u32 len;
> > > > +};
> > > > +
> > > > +struct statmnt {
> > > > +     __u64 mask;             /* What results were written [uncond]=
 */
> > > > +     __u32 sb_dev_major;     /* Device ID */
> > > > +     __u32 sb_dev_minor;
> > > > +     __u64 sb_magic;         /* ..._SUPER_MAGIC */
> > > > +     __u32 sb_flags;         /* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZ=
YTIME} */
> > > > +     __u32 __spare1;
> > > > +     __u64 mnt_id;           /* Unique ID of mount */
> > > > +     __u64 mnt_parent_id;    /* Unique ID of parent (for root =3D=
=3D mnt_id) */
> > > > +     __u32 mnt_id_old;       /* Reused IDs used in proc/.../mounti=
nfo */
> > > > +     __u32 mnt_parent_id_old;
> > > > +     __u64 mnt_attr;         /* MOUNT_ATTR_... */
> > > > +     __u64 mnt_propagation;  /* MS_{SHARED,SLAVE,PRIVATE,UNBINDABL=
E} */
> > > > +     __u64 mnt_peer_group;   /* ID of shared peer group */
> > > > +     __u64 mnt_master;       /* Mount receives propagation from th=
is ID */
> > > > +     __u64 propagate_from;   /* Propagation from in current namesp=
ace */
> > > > +     __u64 __spare[20];
> > > > +     struct stmt_str mnt_root;       /* Root of mount relative to =
root of fs */
> > > > +     struct stmt_str mountpoint;     /* Mountpoint relative to roo=
t of process */
> > > > +     struct stmt_str fs_type;        /* Filesystem type[.subtype] =
*/
> > >=20

A bit tangential to this discussion, but one thing we could consider is
adding something like a mnt_change_cookie field that increments on any
significant changes on the mount: i.e. remounts with new options,
changes to parentage or propagation, etc.

That might make it more palatable to do something with separate syscalls
for the string-based fields. You could do:

statmnt(...);
getmntattr(mnt, "mnt.fstype", ...);
statmnt(...);

...and then if the mnt_change_cookie hasn't changed, you know that the
string option was stable during that window.


> > > I think if we want to do this here we should add:
> > >=20
> > > __u64 fs_type
> > > __u64 fs_subtype
> > >=20
> > > fs_type can just be our filesystem magic number and we introduce magi=
c
> >=20
> > It's already there: sb_magic.
> >=20
> > However it's not a 1:1 mapping (ext* only has one magic).
>=20
> That's a very odd choice but probably fixable by giving it a subtype.
>=20
> >=20
> > > numbers for sub types as well. So we don't need to use strings here.
> >=20
> > Ugh.
>=20
> Hm, idk. It's not that bad imho. We'll have to make some ugly tradeoffs.

--=20
Jeff Layton <jlayton@kernel.org>
