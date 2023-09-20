Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E87A7926
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjITK1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 06:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjITK1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:27:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E25694;
        Wed, 20 Sep 2023 03:27:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAA4C433C8;
        Wed, 20 Sep 2023 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695205651;
        bh=AL7XxZWUXlzUV5MacTTl6s8AOlMQDcV2eRErhEj9M1k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nSJ9nCUsfilp17okswe9miOtdP03/Glc9WuhcxDoaqjIxMA8g8FlTY0oI4FzfinZ1
         XSHR1byf0d8DbNrDQ4tDrjFzwbB4eGDcK7Zu7c0V0WnAa8BQ6qtZ5SINNqjtyCAsBE
         1Z+EJK9WlC/37TWk3wFm7IUBFGa/8OD+T7KcI4bgmsEwea7/zlzgmKO3lHw/HNbS+F
         IxwxS7eXzrY6A6eSdgKqozJSaMBiBd+vAL5JkDwFpu4phwVrj68/c0PUW5XazPEirn
         qcXPf+Y4bDk5Ru9tq4tMX2YNRtsnpE6CAdyu2oOBRuVJEiqkL0W6FtkY4yQn1jd/IL
         0l14sjlKp5XBA==
Message-ID: <3c3d424b7b87fef8df56b2f80c4d3fef7d36311b.camel@kernel.org>
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem
 types
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 20 Sep 2023 06:27:29 -0400
In-Reply-To: <CAOQ4uxjfP+TrDded+Zps6k6GQM+UsEuW0R2PT_fMEH8ouY_aUg@mail.gmail.com>
References: <20230411124037.1629654-1-amir73il@gmail.com>
         <20230412184359.grx7qyujnb63h4oy@quack3>
         <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
         <20230417162721.ouzs33oh6mb7vtft@quack3>
         <CAOQ4uxjfP+TrDded+Zps6k6GQM+UsEuW0R2PT_fMEH8ouY_aUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-09-20 at 11:26 +0300, Amir Goldstein wrote:
> On Mon, Apr 17, 2023 at 7:27=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >=20
> > On Thu 13-04-23 12:25:41, Amir Goldstein wrote:
> > > On Wed, Apr 12, 2023 at 9:44=E2=80=AFPM Jan Kara <jack@suse.cz> wrote=
:
> > > >=20
> > > > Hi Amir!
> > > >=20
> > > > On Tue 11-04-23 15:40:37, Amir Goldstein wrote:
> > > > > If kernel supports FAN_REPORT_ANY_FID, use this flag to allow tes=
ting
> > > > > also filesystems that do not support fsid or NFS file handles (e.=
g. fuse).
> > > > >=20
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >=20
> > > > > Jan,
> > > > >=20
> > > > > I wanted to run an idea by you.
> > > > >=20
> > > > > My motivation is to close functional gaps between fanotify and in=
otify.
> > > > >=20
> > > > > One of the largest gaps right now is that FAN_REPORT_FID is limit=
ed
> > > > > to a subset of local filesystems.
> > > > >=20
> > > > > The idea is to report fid's that are "good enough" and that there
> > > > > is no need to require that fid's can be used by open_by_handle_at=
()
> > > > > because that is a non-requirement for most use cases, unpriv list=
ener
> > > > > in particular.
> > > >=20
> > > > OK. I'd note that if you report only inode number, you are prone to=
 the
> > > > problem that some inode gets freed (file deleted) and then realloca=
ted (new
> > > > file created) and the resulting identifier is the same. It can be
> > > > problematic for a listener to detect these cases and deal with them=
.
> > > > Inotify does not have this problem at least for some cases because =
'wd'
> > > > uniquely identifies the marked inode. For other cases (like watchin=
g dirs)
> > > > inotify has similar sort of problems. I'm muttering over this becau=
se in
> > > > theory filesystems not having i_generation counter on disk could ap=
proach
> > > > the problem in a similar way as FAT and then we could just use
> > > > FILEID_INO64_GEN for the file handle.
> > >=20
> > > Yes, of course we could.
> > > The problem with that is that user space needs to be able to query th=
e fid
> > > regardless of fanotify.
> > >=20
> > > The fanotify equivalent of wd is the answer to that query.
> > >=20
> > > If any fs would export i_generation via statx, then FILEID_INO64_GEN
> > > would have been my choice.
> >=20
> > One problem with making up i_generation (like FAT does it) is that when
> > inode gets reclaimed and then refetched from the disk FILEID_INO64_GEN =
will
> > change because it's going to have different i_generation. For NFS this =
is
> > annoying but I suppose it mostly does not happen since client's accesse=
s
> > tend to keep the inode in memory. For fanotify it could be more likely =
to
> > happen if watching say the whole filesystem and I suppose the watching
> > application will get confused by this. So I'm not convinced faking
> > i_generation is a good thing to do. But still I want to brainstorm a bi=
t
> > about it :)
> >=20
> > > But if we are going to change some other API for that, I would not ch=
ange
> > > statx(), I would change name_to_handle_at(...., AT_HANDLE_FID)
> > >=20
> > > This AT_ flag would relax this check in name_to_handle_at():
> > >=20
> > >         /*
> > >          * We need to make sure whether the file system
> > >          * support decoding of the file handle
> > >          */
> > >         if (!path->dentry->d_sb->s_export_op ||
> > >             !path->dentry->d_sb->s_export_op->fh_to_dentry)
> > >                 return -EOPNOTSUPP;
> > >=20
> > > And allow the call to proceed to the default export_encode_fh() imple=
mentation.
> > > Alas, the default implementation encodes FILEID_INO32_GEN.
> > >=20
> > > I think we can get away with a default implementation for FILEID_INO6=
4_GEN
> > > as long as the former (INO32) is used for fs with export ops without =
->encode_fh
> > > (e.g. ext*) and the latter (INO64) is used for fs with no export ops.
> >=20
> > These default calls seem a bit too subtle to me. I'd rather add explici=
t
> > handlers to filesystems that really want FILEID_INO32_GEN encoding and =
then
> > have a fallback function for filesystems not having s_export_op at all.
> >=20
> > But otherwise the proposal to make name_to_handle_at() work even for
> > filesystems not exportable through NFS makes sense to me. But I guess w=
e
> > need some buy-in from VFS maintainers for this.
> >=20
>=20
> Hi Jan,
>=20
> I seem to have dropped the ball on this after implementing AT_HANDLE_FID.
> It was step one in a larger plan.
>=20
> Christian, Jeff,
>=20
> Do you have an objection to this plan:
> 1. Convert all "legacy" FILEID_INO32_GEN fs with non-empty
>     s_export_op and no explicit ->encode_fh() to use an explicit
>     generic_encode_ino32_gen_fh()
> 2. Relax requirement of non-empty s_export_op for AT_HANDLE_FID
>     to support encoding a (non-NFS) file id on all fs
> 3. For fs with empty s_export_op, allow fallback of AT_HANDLE_FID
>     in exportfs_encode_inode_fh() to encode FILEID_INO64_GEN
>=20
>=20

This plan sounds reasonable.

> > > > Also I have noticed your workaround with using st_dev for fsid. As =
I've
> > > > checked, there are actually very few filesystems that don't set fsi=
d these
> > > > days. So maybe we could just get away with still refusing to report=
 on
> > > > filesystems without fsid and possibly fixup filesystems which don't=
 set
> > > > fsid yet and are used enough so that users complain?
> > >=20
> > > I started going down this path to close the gap with inotify.
> > > inotify is capable of watching all fs including pseudo fs, so I would
> > > like to have this feature parity.
> >=20
> > Well, but with pseudo filesystems (similarly as with FUSE) the notifica=
tion
> > was always unreliable. As in: some cases worked but others did not. I'm=
 not
> > sure that is something we should try to replicate :)
> >=20
> > So still I'd be interested to know which filesystems we are exactly
> > interested to support and whether we are not better off to explicitly a=
dd
> > fsid support to them like we did for tmpfs.
> >=20
>=20
> Since this email, kernfs derivative fs gained fsid as well.
> Quoting your audit of remaining fs from another thread:
>=20
> > ...As far as I remember
> > fanotify should be now able to handle anything that provides f_fsid in =
its
> > statfs(2) call. And as I'm checking filesystems not setting fsid curren=
tly are:
> >=20
> > afs, coda, nfs - networking filesystems where inotify and fanotify have
> >   dubious value anyway
>=20
> Be that as it may, there may be users that use inotify on network fs
> and it even makes a lot of sense in controlled environments with
> single NFS client per NFS export (e.g. home dirs), so I think we will
> need to support those fs as well.
>=20
> Maybe the wise thing to do is to opt-in to monitor those fs after all?
> Maybe with explicit opt-in to watch a single fs, fanotify group will
> limit itself to marks on a specific sb and then a null fsid won't matter?
>=20

Caution here. Most of these filesystems don't have protocol support for
anything like inotify (the known exception being SMB). You can monitor
such a network filesystem, but you won't get events for things that
happen on remote hosts.

This is confusing for users, and we've always rejected supporting the
notify interfaces on NFS for this reason.

> >=20
> > configfs, debugfs, devpts, efivarfs, hugetlbfs, openpromfs, proc, pstor=
e,
> > ramfs, sysfs, tracefs - virtual filesystems where fsnotify functionalit=
y is
> >   quite limited. But some special cases could be useful. Adding fsid su=
pport
> >   is the same amount of trouble as for kernfs - a few LOC. In fact, we
> >   could perhaps add a fstype flag to indicate that this is a filesystem
> >   without persistent identification and so uuid should be autogenerated=
 on
> >   mount (likely in alloc_super()) and f_fsid generated from sb->s_uuid.
> >   This way we could handle all these filesystems with trivial amount of
> >   effort.
> >=20
>=20
> Christian,
>=20
> I recall that you may have had reservations on initializing s_uuid
> and f_fsid in vfs code?
> Does an opt-in fstype flag address your concerns?
> Will you be ok with doing the tmpfs/kernfs trick for every fs
> that opted-in with fstype flag in generic vfs code?
>=20
> > freevxfs - the only real filesystem without f_fsid. Trivial to handle o=
ne
> >   way or the other.
> >=20
>=20
> Last but not least, btrfs subvolumes.
> They do have an fsid, but it is different from the sb fsid,
> so we disallow (even inode) fanotify marks.
>=20
> I am not sure how to solve this one,
> but if we choose to implement the opt-in fanotify flag for
> "watch single fs", we can make this problem go away, along
> with the problem of network fs fsid and other odd fs that we
> do not want to have to deal with.
>=20
> On top of everything, it is a fast solution and it doesn't
> involve vfs and changing any fs at all.
>=20

FWIW, we have a long standing bug open on dealing with btrfs subvolumes
with nfsd:

    https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D389

You may want to look over that before you dive in to solutions here.

> > > If we can get away with fallback to s_dev as fsid in vfs_statfs()
> > > I have no problem with that, but just to point out - functionally
> > > it is equivalent to do this fallback in userspace library as the
> > > fanotify_get_fid() LTP helper does.
> >=20
> > Yes, userspace can workaround this but I was more thinking about avoidi=
ng
> > adding these workarounds into fanotify in kernel *and* to userspace.
> >=20
> > > > > I chose a rather generic name for the flag to opt-in for "good en=
ough"
> > > > > fid's.  At first, I was going to make those fid's self describing=
 the
> > > > > fact that they are not NFS file handles, but in the name of simpl=
icity
> > > > > to the API, I decided that this is not needed.
> > > >=20
> > > > I'd like to discuss a bit about the meaning of the flag. On the fir=
st look
> > > > it is a bit strange to have a flag that says "give me a fh, if you =
don't
> > > > have it, give me ino". It would seem cleaner to have "give me fh" k=
ind of
> > > > interface (FAN_REPORT_FID) and "give me ino" kind of interface (new
> > > > FAN_REPORT_* flag). I suspect you've chosen the more complex meanin=
g
> > > > because you want to allow a usecase where watches of filesystems wh=
ich
> > > > don't support filehandles are mixed with watches of filesystems whi=
ch do
> > > > support filehandles in one notification group and getting filehandl=
es is
> > > > actually prefered over getting just inode numbers? Do you see real =
benefit
> > > > in getting file handles when userspace has to implement fallback fo=
r
> > > > getting just inode numbers anyway?
> > > >=20
> > >=20
> > > Yes, there is a benefit, because a real fhandle has no-reuse guarante=
e.
> > >=20
> > > Even if we implement the kernel fallback to FILEID_INO64_GEN, it does
> > > not serve as a statement from the filesystem that i_generation is use=
ful
> > > and in fact, i_generation will often be zero in simple fs and ino wil=
l be
> > > reusable.
> > >=20
> > > Also, I wanted to have a design where a given fs/object always return=
s
> > > the same FID regardless of the init flags.
> > >=20
> > > Your question implies that if
> > > "userspace has to implement fallback for getting just inode numbers",
> > > then it doesn't matter if we report fhandle or inode, but it is not a=
ccurate.
> > >=20
> > > The fanotify_get_fid() LTP helper always gets a consistent FID for a
> > > given fs/object. You do not need to feed it the fanotify init flags t=
o
> > > provide a consistent answer.
> > >=20
> > > For all the reasons above, I think that a "give me ino'' flag is not =
useful.
> > > IMO, the flag just needs better marketing.
> > > This is a "I do not need/intend to open_by_handle flag".
> > > Suggestions for a better name are welcome.
> >=20
> > I see, yes, these reasons make sense.
> >=20
> > > For all I care, we do not need to add an opt-in flag at all.
> > > We could simply start to support fs that were not supported before.
> > > This sort of API change is very common and acceptable.
> > >=20
> > > There is no risk if the user tries to call open_by_handle_at() with t=
he
> > > fanotify encoded FID, because in this case the fs is guaranteed to
> > > return ESTALE, because fs does not support file handles.
> > >=20
> > > This is especially true, if we can get away with seamless change
> > > of behavior for vfs_statfs(), because that seamless change would
> > > cause FAN_REPORT_FID to start working on fs like fuse that
> > > support file handles and have zero fsid.
> >=20
> > Yeah. Actually I like the idea of a seamless change to start reporting =
fsid
> > and also to start reporting "fake" handles. In the past we've already
> > enabled tmpfs like this...
> >=20
>=20
> I am now leaning towards a combination of:
> 1. Seamless change of behavior for vfs_statfs() and
>     name_to_handle_at(..., AT_HANDLE_FID) for the simple cases
>     using an opt-in fstype flag
> AND
> 2. Simple interim fallback for other fs with an opt-in fanotify flag (*)
>=20
> Thoughts?
>=20
> Thanks,
> Amir.
>=20
> (*) We did some similar opt-in games in overlayfs to support lower
>      fs with null uuid - in the default configuration, overlayfs allows a
>      single lower layer with null uuid, but not multi lower layers with
>      null uuid. When advances features are enabled, even single
>      lower layer with null uuid is not allowed

--=20
Jeff Layton <jlayton@kernel.org>
