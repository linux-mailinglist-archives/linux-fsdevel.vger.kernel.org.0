Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8F6AE0DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 14:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCGNkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 08:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCGNkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:40:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924DD38EB1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 05:39:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F5C2B81891
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 13:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E63C433EF;
        Tue,  7 Mar 2023 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678196341;
        bh=Azne0EVegoPs4bJoZ2SCv2WogrmTZxOsnYwCDOf8R7w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rZ7RsTqSnY8eDyweyqa16HQLnu5oE8TH+fyq8x0vc54OX89lVGxkiHEX1DoFIzoAq
         60v011N2YlRCYT7nE1cKSSWXBQNoQS5SjJMXH6SXN1VicHQgDEYGc6W0EQPmGXqPV8
         F57O7mR/l7ytVLSu9UsKPKGUtGZQ6fhm5jWj/FHRIvRU46PQE4Od/y4uAtNd9I0ckZ
         ZhuWGsyDDr6apAP3orX7bk49pSNsexuDfK+HF3krgT9DPHTX6DrjodU/GNfG54LHWw
         eHG6PHDLCwXd/EyKb92UspYxENcxhtjTHDtOHUEqXhOHJvspHPn2KwA4VLPpFtv1+p
         voo+9FauRp8nA==
Message-ID: <7069b15f7fb0abcc63d462930eb5a8984e148ce1.camel@kernel.org>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 07 Mar 2023 08:38:58 -0500
In-Reply-To: <20230307101548.6gvtd62zah5l3doe@wittgenstein>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
         <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
         <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
         <20230307101548.6gvtd62zah5l3doe@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-03-07 at 11:15 +0100, Christian Brauner wrote:
> On Fri, Mar 03, 2023 at 11:13:51PM +0800, Gao Xiang wrote:
> > Hi Alexander,
> >=20
> > On 2023/3/3 21:57, Alexander Larsson wrote:
> > > On Mon, Feb 27, 2023 at 10:22=E2=80=AFAM Alexander Larsson <alexl@red=
hat.com> wrote:
> > > >=20
> > > > Hello,
> > > >=20
> > > > Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] =
the
> > > > Composefs filesystem. It is an opportunistically sharing, validatin=
g
> > > > image-based filesystem, targeting usecases like validated ostree
> > > > rootfs:es, validated container images that share common files, as w=
ell
> > > > as other image based usecases.
> > > >=20
> > > > During the discussions in the composefs proposal (as seen on LWN[3]=
)
> > > > is has been proposed that (with some changes to overlayfs), similar
> > > > behaviour can be achieved by combining the overlayfs
> > > > "overlay.redirect" xattr with an read-only filesystem such as erofs=
.
> > > >=20
> > > > There are pros and cons to both these approaches, and the discussio=
n
> > > > about their respective value has sometimes been heated. We would li=
ke
> > > > to have an in-person discussion at the summit, ideally also involvi=
ng
> > > > more of the filesystem development community, so that we can reach
> > > > some consensus on what is the best apporach.
> > >=20
> > > In order to better understand the behaviour and requirements of the
> > > overlayfs+erofs approach I spent some time implementing direct suppor=
t
> > > for erofs in libcomposefs. So, with current HEAD of
> > > github.com/containers/composefs you can now do:
> > >=20
> > > $ mkcompose --digest-store=3Dobjects --format=3Derofs source-dir imag=
e.erofs
> >=20
> > Thanks you for taking time on working on EROFS support.  I don't have
> > time to play with it yet since I'd like to work out erofs-utils 1.6
> > these days and will work on some new stuffs such as !pagesize block
> > size as I said previously.
> >=20
> > >=20
> > > This will produce an object store with the backing files, and a erofs
> > > file with the required overlayfs xattrs, including a made up one
> > > called "overlay.fs-verity" containing the expected fs-verity digest
> > > for the lower dir. It also adds the required whiteouts to cover the
> > > 00-ff dirs from the lower dir.
> > >=20
> > > These erofs files are ordered similarly to the composefs files, and w=
e
> > > give similar guarantees about their reproducibility, etc. So, they
> > > should be apples-to-apples comparable with the composefs images.
> > >=20
> > > Given this, I ran another set of performance tests on the original cs=
9
> > > rootfs dataset, again measuring the time of `ls -lR`. I also tried to
> > > measure the memory use like this:
> > >=20
> > > # echo 3 > /proc/sys/vm/drop_caches
> > > # systemd-run --scope sh -c 'ls -lR mountpoint' > /dev/null; cat $(ca=
t
> > > /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
> > >=20
> > > These are the alternatives I tried:
> > >=20
> > > xfs: the source of the image, regular dir on xfs
> > > erofs: the image.erofs above, on loopback
> > > erofs dio: the image.erofs above, on loopback with --direct-io=3Don
> > > ovl: erofs above combined with overlayfs
> > > ovl dio: erofs dio above combined with overlayfs
> > > cfs: composefs mount of image.cfs
> > >=20
> > > All tests use the same objects dir, stored on xfs. The erofs and
> > > overlay implementations are from a stock 6.1.13 kernel, and composefs
> > > module is from github HEAD.
> > >=20
> > > I tried loopback both with and without the direct-io option, because
> > > without direct-io enabled the kernel will double-cache the loopbacked
> > > data, as per[1].
> > >=20
> > > The produced images are:
> > >   8.9M image.cfs
> > > 11.3M image.erofs
> > >=20
> > > And gives these results:
> > >             | Cold cache | Warm cache | Mem use
> > >             |   (msec)   |   (msec)   |  (mb)
> > > -----------+------------+------------+---------
> > > xfs        |   1449     |    442     |    54
> > > erofs      |    700     |    391     |    45
> > > erofs dio  |    939     |    400     |    45
> > > ovl        |   1827     |    530     |   130
> > > ovl dio    |   2156     |    531     |   130
> > > cfs        |    689     |    389     |    51
> > >=20
> > > I also ran the same tests in a VM that had the latest kernel includin=
g
> > > the lazyfollow patches (ovl lazy in the table, not using direct-io),
> > > this one ext4 based:
> > >=20
> > >             | Cold cache | Warm cache | Mem use
> > >             |   (msec)   |   (msec)   |  (mb)
> > > -----------+------------+------------+---------
> > > ext4       |   1135     |    394     |    54
> > > erofs      |    715     |    401     |    46
> > > erofs dio  |    922     |    401     |    45
> > > ovl        |   1412     |    515     |   148
> > > ovl dio    |   1810     |    532     |   149
> > > ovl lazy   |   1063     |    523     |    87
> > > cfs        |    719     |    463     |    51
> > >=20
> > > Things noticeable in the results:
> > >=20
> > > * composefs and erofs (by itself) perform roughly  similar. This is
> > >    not necessarily news, and results from Jingbo Xu match this.
> > >=20
> > > * Erofs on top of direct-io enabled loopback causes quite a drop in
> > >    performance, which I don't really understand. Especially since its
> > >    reporting the same memory use as non-direct io. I guess the
> > >    double-cacheing in the later case isn't properly attributed to the
> > >    cgroup so the difference is not measured. However, why would the
> > >    double cache improve performance?  Maybe I'm not completely
> > >    understanding how these things interact.
> >=20
> > We've already analysed the root cause of composefs is that composefs
> > uses a kernel_read() to read its path while irrelevant metadata
> > (such as dir data) is read together.  Such heuristic readahead is a
> > unusual stuff for all local fses (obviously almost all in-kernel
> > filesystems don't use kernel_read() to read their metadata. Although
> > some filesystems could readahead some related extent metadata when
> > reading inode, they at least does _not_ work as kernel_read().) But
> > double caching will introduce almost the same impact as kernel_read()
> > (assuming you read some source code of loop device.)
> >=20
> > I do hope you already read what Jingbo's latest test results, and that
> > test result shows how bad readahead performs if fs metadata is
> > partially randomly used (stat < 1500 files):
> > https://lore.kernel.org/r/83829005-3f12-afac-9d05-8ba721a80b4d@linux.al=
ibaba.com
> >=20
> > Also you could explicitly _disable_ readahead for composefs
> > manifiest file (because all EROFS metadata read is without
> > readahead), and let's see how it works then.
> >=20
> > Again, if your workload is just "ls -lR".  My answer is "just async
> > readahead the whole manifest file / loop device together" when
> > mounting.  That will give the best result to you.  But I'm not sure
> > that is the real use case you propose.
> >=20
> > >=20
> > > * Stacking overlay on top of erofs causes about 100msec slower
> > >    warm-cache times compared to all non-overlay approaches, and much
> > >    more in the cold cache case. The cold cache performance is helped
> > >    significantly by the lazyfollow patches, but the warm cache overhe=
ad
> > >    remains.
> > >=20
> > > * The use of overlayfs more than doubles memory use, probably
> > >    because of all the extra inodes and dentries in action for the
> > >    various layers. The lazyfollow patches helps, but only partially.
> > >=20
> > > * Even though overlayfs+erofs is slower than cfs and raw erofs, it is
> > >    not that much slower (~25%) than the pure xfs/ext4 directory, whic=
h
> > >    is a pretty good baseline for comparisons. It is even faster when
> > >    using lazyfollow on ext4.
> > >=20
> > > * The erofs images are slightly larger than the equivalent composefs
> > >    image.
> > >=20
> > > In summary: The performance of composefs is somewhat better than the
> > > best erofs+ovl combination, although the overlay approach is not
> > > significantly worse than the baseline of a regular directory, except
> > > that it uses a bit more memory.
> > >=20
> > > On top of the above pure performance based comparisons I would like t=
o
> > > re-state some of the other advantages of composefs compared to the
> > > overlay approach:
> > >=20
> > > * composefs is namespaceable, in the sense that you can use it (given
> > >    mount capabilities) inside a namespace (such as a container) witho=
ut
> > >    access to non-namespaced resources like loopback or device-mapper
> > >    devices. (There was work on fixing this with loopfs, but that seem=
s
> > >    to have stalled.)
> > >=20
> > > * While it is not in the current design, the simplicity of the format
> > >    and lack of loopback makes it at least theoretically possible that
> > >    composefs can be made usable in a rootless fashion at some point i=
n
> > >    the future.
> > Do you consider sending some commands to /dev/cachefiles to configure
> > a daemonless dir and mount erofs image directly by using "erofs over
> > fscache" but in a daemonless way?  That is an ongoing stuff on our side=
.
> >=20
> > IMHO, I don't think file-based interfaces are quite a charmful stuff.
> > Historically I recalled some practice is to "avoid directly reading
> > files in kernel" so that I think almost all local fses don't work on
> > files directl and loopback devices are all the ways for these use
> > cases.  If loopback devices are not okay to you, how about improving
> > loopback devices and that will benefit to almost all local fses.
> >=20
> > >=20
> > > And of course, there are disadvantages to composefs too. Primarily
> > > being more code, increasing maintenance burden and risk of security
> > > problems. Composefs is particularly burdensome because it is a
> > > stacking filesystem and these have historically been shown to be hard
> > > to get right.
> > >=20
> > >=20
> > > The question now is what is the best approach overall? For my own
> > > primary usecase of making a verifying ostree root filesystem, the
> > > overlay approach (with the lazyfollow work finished) is, while not
> > > ideal, good enough.
> >=20
> > So your judgement is still "ls -lR" and your use case is still just
> > pure read-only and without writable stuff?
> >=20
> > Anyway, I'm really happy to work with you on your ostree use cases
> > as always, as long as all corner cases work out by the community.
> >=20
> > >=20
> > > But I know for the people who are more interested in using composefs
> > > for containers the eventual goal of rootless support is very
> > > important. So, on behalf of them I guess the question is: Is there
> > > ever any chance that something like composefs could work rootlessly?
> > > Or conversely: Is there some way to get rootless support from the
> > > overlay approach? Opinions? Ideas?
> >=20
> > Honestly, I do want to get a proper answer when Giuseppe asked me
> > the same question.  My current view is simply "that question is
> > almost the same for all in-kernel fses with some on-disk format".
>=20
> As far as I'm concerned filesystems with on-disk format will not be made
> mountable by unprivileged containers. And I don't think I'm alone in
> that view.
>=20

You're absolutely not alone in that view. This is even more unsafe with
network and clustered filesystems, as you're trusting remote hardware
that is accessible by other users than just the local host. We have had
long-standing open requests to allow unprivileged users to mount
arbitrary remote filesystems, and I've never seen a way to do that
safely.

> The idea that ever more parts of the kernel with a massive
> attack surface such as a filesystem need to vouchesafe for the safety in
> the face of every rando having access to
> unshare --mount --user --map-root is a dead end and will just end up
> trapping us in a neverending cycle of security bugs (Because every
> single bug that's found after making that fs mountable from an
> unprivileged container will be treated as a security bug no matter if
> justified or not. So this is also a good way to ruin your filesystem's
> reputation.).
>=20
> And honestly, if we set the precedent that it's fine for one filesystem
> with an on-disk format to be able to be mounted by unprivileged
> containers then other filesystems eventually want to do this as well.
>=20
> At the rate we currently add filesystems that's just a matter of time
> even if none of the existing ones would also want to do it. And then
> we're left arguing that this was just an exception for one super
> special, super safe, unexploitable filesystem with an on-disk format.
>=20
> Imho, none of this is appealing. I don't want to slowly keep building a
> future where we end up running fuzzers in unprivileged container to
> generate random images to crash the kernel.
>=20
> I have more arguments why I don't think is a path we will ever go down
> but I don't want this to detract from the legitimate ask of making it
> possible to mount trusted images from within unprivileged containers.
> Because I think that's perfectly legitimate.
>=20
> However, I don't think that this is something the kernel needs to solve
> other than providing the necessary infrastructure so that this can be
> solved in userspace.
>=20
> Off-list, Amir had pointed to a blog I wrote last week (cf. [1]) where I
> explained how we currently mount into mount namespaces of unprivileged
> cotainers which had been quite a difficult problem before the new mount
> api. But now it's become almost comically trivial. I mean, there's stuff
> that will still be good to have but overall all the bits are already
> there.
>=20
> Imho, delegated mounting should be done by a system service that is
> responsible for all the steps that require privileges. So for most
> filesytems not mountable by unprivileged user this would amount to:
>=20
> fd_fs =3D fsopen("xfs")
> fsconfig(FSCONFIG_SET_STRING, "source", "/sm/sm")
> fsconfig(FSCONFIG_CMD_CREATE)
> fd_mnt =3D fsmount(fd_fs)
> // Only required for attributes that require privileges against the sb
> // of the filesystem such as idmapped mounts
> mount_setattr(fd_mnt, ...)
>=20
> and then the fd_mnt can be sent to the container which can then attach
> it wherever it wants to. The system level service doesn't even need to
> change namespaces via setns(fd_userns|fd_mntns) like I illustrated in
> the post I did. It's sufficient if we sent it via AF_UNIX for example
> that's exposed to the container.
>=20
> Of course, this system level service would be integrated with mount(8)
> directly over a well-defined protocol. And this would be nestable as
> well by e.g., bind-mounting the AF_UNIX socket.
>=20
> And we do already support a rudimentary form of such integration through
> systemd. For example via mount -t ddi (cf. [2]) which makes it possible
> to mount discoverable disk images (ddi). But that's just an
> illustration.=20
>=20
> This should be integrated with mount(8) and should be a simply protocol
> over varlink or another lightweight ipc mechanism that can be
> implemented by systemd-mountd (which is how I coined this for lack of
> imagination when I came up with this) or by some other component if
> platforms like k8s really want to do their own thing.
>=20
> This also allows us to extend this feature to the whole system btw and
> to all filesystems at once. Because it means that if systemd-mountd is
> told what images to trust (based on location, from a specific registry,
> signature, or whatever) then this isn't just useful for unprivileged
> containers but also for regular users on the host that want to mount
> stuff.
>=20
> This is what we're currently working on.
>=20

This is a very cool idea, and sounds like a reasonable way forward. I'd
be interested to hear more about this (and in particular what sort of
security model and use-cases you envision for this).

> (There's stuff that we can do to make this more powerful __if__ we need
> to. One example would probably that we _could_ make it possible to mark
> a superblock as being owned by a specific namespace with similar
> permission checks as what we currently do for idmapped mounts
> (privileged in the superblock of the fs, privileged over the ns to
> delegate to etc). IOW,
>=20
> fd_fs =3D fsopen("xfs")
> fsconfig(FSCONFIG_SET_STRING, "source", "/sm/sm")
> fsconfig(FSCONFIG_SET_FD, "owner", fd_container_userns)
>=20
> which completely sidesteps the issue of making that on-disk filesystem
> mountable by unpriv users.
>=20
> But let me say that this is completely unnecessary today as you can do:
>=20
> fd_fs =3D fsopen("xfs")
> fsconfig(FSCONFIG_SET_STRING, "source", "/sm/sm")
> fsconfig(FSCONFIG_CMD_CREATE)
> fd_mnt =3D fsmount(fd_fs)
> mount_setattr(fd_mnt, MOUNT_ATTR_IDMAP)
>=20
> which changes ownership across the whole filesystem. The only time you
> really want what I mention here is if you want to delegate control over
> __every single ioctl and potentially destructive operation associated
> with that filesystem__ to an unprivileged container which is almost
> never what you want.)
>=20
> [1]: https://brauner.io/2023/02/28/mounting-into-mount-namespaces.html
> [2]: https://github.com/systemd/systemd/pull/26695

--=20
Jeff Layton <jlayton@kernel.org>
