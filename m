Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5E686EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 20:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjBATLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 14:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjBATLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:11:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D1B6DB1F;
        Wed,  1 Feb 2023 11:11:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E33F61921;
        Wed,  1 Feb 2023 19:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA6AC433EF;
        Wed,  1 Feb 2023 19:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675278700;
        bh=x9kB8ybCkflPA0D/nMACka4ig3kq3n8fS1qo7Kh2d0o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lWumsHgKp6tj5nL7a4IzEkigCc67Lkl+hSY5AaIupK2mGTXMO5RDyjjz6MUAxUKGG
         i39gS9JElU+8XS71KHldN8v/UXHvixbtjC2WRa4UWxNFioX9SGY/obBdKaPMM+0fFr
         UmqhWUM3JKPrEDhGrEiApmjCU0Es0UPZkrXSxwvfOoklEY9NpRUtPSXzvOD1h29/h1
         di/vHo3g7iTGnCfqvi1hY7fPU5GkJnBrB4AHCssyM3seTFH7Wd/lIRmhiqZosklphe
         s0IxfoH1moL9r/6j9Ahx8rjqBddQBZU9WUQjLK6PDIAgi28SUnnJxklwhpAzUj5rkt
         QImOt7+TnBWNg==
Message-ID: <908fa2728d9d503534622d87c3c63831f9fe6f38.camel@kernel.org>
Subject: Re: replacement i_version counter for xfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 01 Feb 2023 14:11:39 -0500
In-Reply-To: <20230131232358.GQ360264@dread.disaster.area>
References: <57c413ed362c0beab06b5d83b7fc4b930c7662c4.camel@kernel.org>
         <20230125000227.GM360264@dread.disaster.area>
         <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
         <20230130015413.GN360264@dread.disaster.area>
         <2d8e60ea6eb5f8b79e22c0a15d9266a24b4f7995.camel@kernel.org>
         <20230131232358.GQ360264@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-02-01 at 10:23 +1100, Dave Chinner wrote:
> On Tue, Jan 31, 2023 at 06:55:41AM -0500, Jeff Layton wrote:
> > On Mon, 2023-01-30 at 12:54 +1100, Dave Chinner wrote:
> > > On Wed, Jan 25, 2023 at 06:47:12AM -0500, Jeff Layton wrote:
> > > > On Wed, 2023-01-25 at 11:02 +1100, Dave Chinner wrote:
> > > > > IIUC the rest of the justification for i_version is that ctime mi=
ght
> > > > > lack the timestamp granularity to disambiguate sub-timestamp
> > > > > granularity changes, so i_version is needed to bridge that gap.
> > > > >=20
> > > > > Given that XFS has nanosecond timestamp resolution in the on-disk
> > > > > format, both i_version and ctime changes are journalled, and
> > > > > ctime/i_version will always change at exactly the same time in th=
e
> > > > > same transactions, there are no inherent sub-timestamp granularit=
y
> > > > > problems with ctime within XFS. Any deficiency in ctime resolutio=
n
> > > > > comes solely from the granularity of the VFS inode timestamp
> > > > > functions.
> > > > >=20
> > > > > And so if current_time() was to provide fine-grained nanosecond
> > > > > timestamp resolution for exported XFS filesystems (i.e. use
> > > > > ktime_get_real_ts64() conditionally), then it seems to me that th=
e
> > > > > nfsd i_version function becomes completely redundant.
> > > > >=20
> > > > > i.e. we are pretty much guaranteed that ctime on exported
> > > > > filesystems will always be different for explicit modifications t=
o
> > > > > the same inode, and hence we can just use ctime as the version
> > > > > change identifier without needing any on-disk format changes at a=
ll.
> > > > >=20
> > > > > And we can optimise away that overhead when the filesystem is not
> > > > > exported by just using the coarse timestamps because there is no
> > > > > need for sub-timer-tick disambiguation of single file
> > > > > modifications....
> > > > >=20
> > > >=20
> > > > Ok, so conditional on (maybe) a per fstype flag, and whether the
> > > > filesystem is exported?
> > >=20
> > > Not sure why a per-fstype flag is necessary?
> > >=20
> >=20
> > I was thinking most filesystems wouldn't need these high-res timestamps=
,
> > so we could limit it to those that opt in via a fstype flag.
>=20
> We'd only need high-res timestamps when NFS is in use, not all the
> time. We already have timestamp granularity information in the
> superblock, so if the filesystem is exported and the sb indicates
> that it has sub-jiffie timestamp resolution, we can then use
> high-res timestamps for ctime and the need for i_version goes away
> completely....
>=20
> > > > It's not trivial to tell whether something is exported though. We
> > > > typically only do that sort of checking within nfsd. That involves =
an
> > > > upcall into mountd, at a minimum.
> > > >=20
> > > > I don't think you want to be plumbing calls to exportfs into xfs fo=
r
> > > > this. It may be simpler to just add a new on-disk counter and be do=
ne
> > > > with it.
> > >=20
> > > I didn't ever expect for XFS to have to be aware of the fact that a
> > > user has exported the filesystem. If "filesystem has been exported"
> > > tracking is required, then we add a flag/counter to the superblock,
> > > and the NFSd subsystem updates the counter/flag when it is informed
> > > that part of the filesystem has been exported/unexported.
> > >=20
> > > The NFSd/export subsystem is pinning filesystems in memory when they
> > > are exported. This is evident by the fact we cannot unmount an
> > > exported filesystem - it has to be unexported before it can be
> > > unmounted. I suspect that it's the ex_path that is stored in the
> > > svc_export structure, because stuff like this is done in the
> > > filehandle code:
> > >=20
> > > static bool is_root_export(struct svc_export *exp)
> > > {
> > >         return exp->ex_path.dentry =3D=3D exp->ex_path.dentry->d_sb->=
s_root;
> > > }
> > >=20
> > > static struct super_block *exp_sb(struct svc_export *exp)
> > > {
> > >         return exp->ex_path.dentry->d_sb;
> > > }
> > >=20
> > > i.e. the file handle code assumes the existence of a pinned path
> > > that is the root of the exported directory tree. This points to the
> > > superblock behind the export so that it can do stuff like pull the
> > > device numbers, check sb->s_type->fs_flags fields (e.g
> > > FS_REQUIRES_DEV), etc as needed to encode/decode/verify filehandles.
> > >=20
> > > Somewhere in the code this path must be pinned to the svc_export for
> > > the life of the svc_export (svc_export_init()?), and at that point
> > > the svc_export code could update the struct super_block state
> > > appropriately....
> > >=20
> >=20
> > No, it doesn't quite work like that. The exports table is loaded on-
> > demand by nfsd via an upcall to mountd.
> >=20
> > If you set up a filesystem to be exported by nfsd, but don't do any nfs
> > activity against it, you'll still be able to unmount the filesystem
> > because the export entry won't have been loaded by the kernel yet. Once
> > a client talks to nfsd and touches the export, the kernel will upcall
> > and that's when the dentry gets pinned.
>=20
> I think you've missed the forest for the trees. Yes, the pinning
> mechanism works slightly differently to what I described, but the
> key take-away is that there is a *reliable mechanism* that tracks
> when a filesystem is effectively exported by the NFSd and high res
> timestamps would be required.
>=20

No, there really isn't, unless you're willing to upcall for that info.

> Hence it's still trivial for those triggers to mark the sb with
> "export pinned" state (e.g. a simple counter) for other code to vary
> their algorithms based on whether the filesystem is being actively
> accessed by remote NFS clients or not.
>=20

All of this happens _on_ _demand_ when there are requests to the NFS
server. The kernel has no idea whether a particular subtree is exported
until it upcalls and talks to mountd. If you want to base any behavior
in the filesystem on whether it's exported, you need do that upcall
first.

Bear in mind that I say _dentry_ here and not filesystem. Exports are
not necessarily done on filesystem boundaries. If we don't know whether
the parent directory of a dentry is exported, then we have to look it up
in the exports table, and we may have to perform an upcall, depending on
what's currently cached there.

IOW, basing any behavior on whether a filesystem is exported is a much
more difficult proposition than what you're suggesting above. We have to
do that to handle NFS RPCs, but I doubt local users would be as happy
with that.

> > > > If this is what you choose to do for xfs, then the question becomes=
: who
> > > > is going to do that timestamp rework?
> > >=20
> > > Depends on what ends up needing to be changed, I'm guessing...
> > >=20
> > > > Note that there are two other lingering issues with i_version. Neit=
her
> > > > of these are xfs-specific, but they may inform the changes you want=
 to
> > > > make there:
> > > >=20
> > > > 1/ the ctime and i_version can roll backward on a crash.
> > >=20
> > > Yup, because async transaction engines allow metadata to appear
> > > changed in memory before it is stable on disk. No difference between
> > > i_version or ctime here at all.
> > >=20
> >=20
> > There is a little difference. The big danger here is that the i_version
> > could roll backward after being seen by a client, and then on a
> > subsequent change, we'd end up with a duplicate i_version that reflects
> > a different state of the file from what the client has observed.
> >=20
> > ctime is probably more resilient here, as to get the same effect you'd
> > need to crash and roll back, _and_ have the clock roll backward too.
> >=20
> > > > 2/ the ctime and i_version are both currently updated before write =
data
> > > > is copied to the pagecache. It would be ideal if that were done
> > > > afterward instead. (FWIW, I have some draft patches for btrfs and e=
xt4
> > > > for this, but they need a lot more testing.)
> > >=20
> > > AFAICT, changing the i_version after the page cache has been written
> > > to does not fix the visibility and/or crash ordering issue.  The new
> > > data is published for third party access when the folio the data is
> > > written into is unlocked, not when the entire write operation
> > > completes.  Hence we can start writeback on data that is part of a
> > > write operation before the write operation has completed and updated
> > > i_version.
> > >=20
> > > If we then crash before the write into the page cache completes and
> > > updates i_version, we can now have changed data on disk without a
> > > i_version update in the metadata to even recover from the journal.
> > > Hence with a post-write i_version update, none of the clients will
> > > see that their caches are stale because i_version/ctime hasn't
> > > changed despite the data on disk having changed.
> > >=20
> > > As such, I don't really see what "update i_version after page cache
> > > write completion" actually achieves by itself.  Even "update
> > > i_version before and after write" doesn't entirely close down the
> > > crash hole in i_version, either - it narrows it down, but it does
> > > not remove it...
> > >=20
> >=20
> > This issue is not about crash resilience.
> >=20
> > The worry we have is that a client could see a change attribute change
> > and do a read of the data before the writer has copied the data to the
> > pagecache. If it does that and the i_version doesn't change again, then
> > the client will be stuck with stale data in its cache.
>=20
> That can't happen with XFS. Buffered reads cannot run concurrently
> with buffered writes because we serialise entire write IO requests
> against entire read IO requests via the i_rwsem. i.e. buffered reads
> use shared locking, buffered writes use exclusive locking.
>=20
> As a result, the kiocb_modified() call to change i_version/ctime in
> the write path is done while we hold the i_rwsem exclusively. i.e.
> the version change is done while concurrent readers are blocked
> waiting for the write to complete the data copy into the page cache.
> Hence there is no transient state between the i_version/ctime update
> and the data copy-in completion that buffered readers can observe.
>=20
> Yes, this is another aspect where XFS is different to every other
> Linux filesystem - none of the other filesystems have this "atomic"
> buffered write IO path. Instead, they use folio locks to serialise
> page cache access and so reads can run concurrently with write
> operations as long as they aren't trying to access the same folio at
> the same time. Hence you can get concurrent overlapping reads and
> writes and this is the root cause of all the i_version/ctime update
> problems you are talking about.
>=20

That's good to know. So we don't really need to do this second bump on
xfs at all.

> > By bumping the times and/or version after the change, we ensure that
> > this doesn't happen. The client might briefly associate the wrong data
> > with a particular change attr, but that situation should be short-lived=
.
>=20
> Unless the server crashes mid-write....

Right, but then we're back to problem #1 above.

--=20
Jeff Layton <jlayton@kernel.org>
