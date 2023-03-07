Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB73A6ADB91
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 11:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCGKQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 05:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCGKP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:15:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56AA51CAA
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 02:15:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A66FD612D2
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 10:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89340C4339B;
        Tue,  7 Mar 2023 10:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678184154;
        bh=fP8+4P4ZJ7c1dw44+IsLb+SQNjZgETBG40a2VTMdXNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OW1/OOoeuT7xEr3bEHNNf6xZmgDUoD0GBI2KmopYCJtabd4RKc9v1uewfy8QwIQ5x
         i0xHqFFKxVXd8QiWOWOMKl1imWHmRzBhqF79hS97QiEuJtTjv82UFWpE7jfiTKQpB+
         G5qVocsiKu7+YP5pe3v3HUSPf7B0GjKkgCuCYI9a/3L2ldKCngWhfGlftTggCWcChl
         k0y46zqV8tSPv24xENG4R/pSU1o3cJuZnVPY0tL0b+hkCwQw6myFCg6rSYq+6hdAbv
         JSN4fA5bdFJ6BvKDKl7upKt4rNjoscflDenE4R3bggr2/A8dAeGOBZvl2dTXt1NSfP
         TBeD8ZHRWolAg==
Date:   Tue, 7 Mar 2023 11:15:48 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
Message-ID: <20230307101548.6gvtd62zah5l3doe@wittgenstein>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 03, 2023 at 11:13:51PM +0800, Gao Xiang wrote:
> Hi Alexander,
> 
> On 2023/3/3 21:57, Alexander Larsson wrote:
> > On Mon, Feb 27, 2023 at 10:22 AM Alexander Larsson <alexl@redhat.com> wrote:
> > > 
> > > Hello,
> > > 
> > > Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
> > > Composefs filesystem. It is an opportunistically sharing, validating
> > > image-based filesystem, targeting usecases like validated ostree
> > > rootfs:es, validated container images that share common files, as well
> > > as other image based usecases.
> > > 
> > > During the discussions in the composefs proposal (as seen on LWN[3])
> > > is has been proposed that (with some changes to overlayfs), similar
> > > behaviour can be achieved by combining the overlayfs
> > > "overlay.redirect" xattr with an read-only filesystem such as erofs.
> > > 
> > > There are pros and cons to both these approaches, and the discussion
> > > about their respective value has sometimes been heated. We would like
> > > to have an in-person discussion at the summit, ideally also involving
> > > more of the filesystem development community, so that we can reach
> > > some consensus on what is the best apporach.
> > 
> > In order to better understand the behaviour and requirements of the
> > overlayfs+erofs approach I spent some time implementing direct support
> > for erofs in libcomposefs. So, with current HEAD of
> > github.com/containers/composefs you can now do:
> > 
> > $ mkcompose --digest-store=objects --format=erofs source-dir image.erofs
> 
> Thanks you for taking time on working on EROFS support.  I don't have
> time to play with it yet since I'd like to work out erofs-utils 1.6
> these days and will work on some new stuffs such as !pagesize block
> size as I said previously.
> 
> > 
> > This will produce an object store with the backing files, and a erofs
> > file with the required overlayfs xattrs, including a made up one
> > called "overlay.fs-verity" containing the expected fs-verity digest
> > for the lower dir. It also adds the required whiteouts to cover the
> > 00-ff dirs from the lower dir.
> > 
> > These erofs files are ordered similarly to the composefs files, and we
> > give similar guarantees about their reproducibility, etc. So, they
> > should be apples-to-apples comparable with the composefs images.
> > 
> > Given this, I ran another set of performance tests on the original cs9
> > rootfs dataset, again measuring the time of `ls -lR`. I also tried to
> > measure the memory use like this:
> > 
> > # echo 3 > /proc/sys/vm/drop_caches
> > # systemd-run --scope sh -c 'ls -lR mountpoint' > /dev/null; cat $(cat
> > /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
> > 
> > These are the alternatives I tried:
> > 
> > xfs: the source of the image, regular dir on xfs
> > erofs: the image.erofs above, on loopback
> > erofs dio: the image.erofs above, on loopback with --direct-io=on
> > ovl: erofs above combined with overlayfs
> > ovl dio: erofs dio above combined with overlayfs
> > cfs: composefs mount of image.cfs
> > 
> > All tests use the same objects dir, stored on xfs. The erofs and
> > overlay implementations are from a stock 6.1.13 kernel, and composefs
> > module is from github HEAD.
> > 
> > I tried loopback both with and without the direct-io option, because
> > without direct-io enabled the kernel will double-cache the loopbacked
> > data, as per[1].
> > 
> > The produced images are:
> >   8.9M image.cfs
> > 11.3M image.erofs
> > 
> > And gives these results:
> >             | Cold cache | Warm cache | Mem use
> >             |   (msec)   |   (msec)   |  (mb)
> > -----------+------------+------------+---------
> > xfs        |   1449     |    442     |    54
> > erofs      |    700     |    391     |    45
> > erofs dio  |    939     |    400     |    45
> > ovl        |   1827     |    530     |   130
> > ovl dio    |   2156     |    531     |   130
> > cfs        |    689     |    389     |    51
> > 
> > I also ran the same tests in a VM that had the latest kernel including
> > the lazyfollow patches (ovl lazy in the table, not using direct-io),
> > this one ext4 based:
> > 
> >             | Cold cache | Warm cache | Mem use
> >             |   (msec)   |   (msec)   |  (mb)
> > -----------+------------+------------+---------
> > ext4       |   1135     |    394     |    54
> > erofs      |    715     |    401     |    46
> > erofs dio  |    922     |    401     |    45
> > ovl        |   1412     |    515     |   148
> > ovl dio    |   1810     |    532     |   149
> > ovl lazy   |   1063     |    523     |    87
> > cfs        |    719     |    463     |    51
> > 
> > Things noticeable in the results:
> > 
> > * composefs and erofs (by itself) perform roughly  similar. This is
> >    not necessarily news, and results from Jingbo Xu match this.
> > 
> > * Erofs on top of direct-io enabled loopback causes quite a drop in
> >    performance, which I don't really understand. Especially since its
> >    reporting the same memory use as non-direct io. I guess the
> >    double-cacheing in the later case isn't properly attributed to the
> >    cgroup so the difference is not measured. However, why would the
> >    double cache improve performance?  Maybe I'm not completely
> >    understanding how these things interact.
> 
> We've already analysed the root cause of composefs is that composefs
> uses a kernel_read() to read its path while irrelevant metadata
> (such as dir data) is read together.  Such heuristic readahead is a
> unusual stuff for all local fses (obviously almost all in-kernel
> filesystems don't use kernel_read() to read their metadata. Although
> some filesystems could readahead some related extent metadata when
> reading inode, they at least does _not_ work as kernel_read().) But
> double caching will introduce almost the same impact as kernel_read()
> (assuming you read some source code of loop device.)
> 
> I do hope you already read what Jingbo's latest test results, and that
> test result shows how bad readahead performs if fs metadata is
> partially randomly used (stat < 1500 files):
> https://lore.kernel.org/r/83829005-3f12-afac-9d05-8ba721a80b4d@linux.alibaba.com
> 
> Also you could explicitly _disable_ readahead for composefs
> manifiest file (because all EROFS metadata read is without
> readahead), and let's see how it works then.
> 
> Again, if your workload is just "ls -lR".  My answer is "just async
> readahead the whole manifest file / loop device together" when
> mounting.  That will give the best result to you.  But I'm not sure
> that is the real use case you propose.
> 
> > 
> > * Stacking overlay on top of erofs causes about 100msec slower
> >    warm-cache times compared to all non-overlay approaches, and much
> >    more in the cold cache case. The cold cache performance is helped
> >    significantly by the lazyfollow patches, but the warm cache overhead
> >    remains.
> > 
> > * The use of overlayfs more than doubles memory use, probably
> >    because of all the extra inodes and dentries in action for the
> >    various layers. The lazyfollow patches helps, but only partially.
> > 
> > * Even though overlayfs+erofs is slower than cfs and raw erofs, it is
> >    not that much slower (~25%) than the pure xfs/ext4 directory, which
> >    is a pretty good baseline for comparisons. It is even faster when
> >    using lazyfollow on ext4.
> > 
> > * The erofs images are slightly larger than the equivalent composefs
> >    image.
> > 
> > In summary: The performance of composefs is somewhat better than the
> > best erofs+ovl combination, although the overlay approach is not
> > significantly worse than the baseline of a regular directory, except
> > that it uses a bit more memory.
> > 
> > On top of the above pure performance based comparisons I would like to
> > re-state some of the other advantages of composefs compared to the
> > overlay approach:
> > 
> > * composefs is namespaceable, in the sense that you can use it (given
> >    mount capabilities) inside a namespace (such as a container) without
> >    access to non-namespaced resources like loopback or device-mapper
> >    devices. (There was work on fixing this with loopfs, but that seems
> >    to have stalled.)
> > 
> > * While it is not in the current design, the simplicity of the format
> >    and lack of loopback makes it at least theoretically possible that
> >    composefs can be made usable in a rootless fashion at some point in
> >    the future.
> Do you consider sending some commands to /dev/cachefiles to configure
> a daemonless dir and mount erofs image directly by using "erofs over
> fscache" but in a daemonless way?  That is an ongoing stuff on our side.
> 
> IMHO, I don't think file-based interfaces are quite a charmful stuff.
> Historically I recalled some practice is to "avoid directly reading
> files in kernel" so that I think almost all local fses don't work on
> files directl and loopback devices are all the ways for these use
> cases.  If loopback devices are not okay to you, how about improving
> loopback devices and that will benefit to almost all local fses.
> 
> > 
> > And of course, there are disadvantages to composefs too. Primarily
> > being more code, increasing maintenance burden and risk of security
> > problems. Composefs is particularly burdensome because it is a
> > stacking filesystem and these have historically been shown to be hard
> > to get right.
> > 
> > 
> > The question now is what is the best approach overall? For my own
> > primary usecase of making a verifying ostree root filesystem, the
> > overlay approach (with the lazyfollow work finished) is, while not
> > ideal, good enough.
> 
> So your judgement is still "ls -lR" and your use case is still just
> pure read-only and without writable stuff?
> 
> Anyway, I'm really happy to work with you on your ostree use cases
> as always, as long as all corner cases work out by the community.
> 
> > 
> > But I know for the people who are more interested in using composefs
> > for containers the eventual goal of rootless support is very
> > important. So, on behalf of them I guess the question is: Is there
> > ever any chance that something like composefs could work rootlessly?
> > Or conversely: Is there some way to get rootless support from the
> > overlay approach? Opinions? Ideas?
> 
> Honestly, I do want to get a proper answer when Giuseppe asked me
> the same question.  My current view is simply "that question is
> almost the same for all in-kernel fses with some on-disk format".

As far as I'm concerned filesystems with on-disk format will not be made
mountable by unprivileged containers. And I don't think I'm alone in
that view. The idea that ever more parts of the kernel with a massive
attack surface such as a filesystem need to vouchesafe for the safety in
the face of every rando having access to
unshare --mount --user --map-root is a dead end and will just end up
trapping us in a neverending cycle of security bugs (Because every
single bug that's found after making that fs mountable from an
unprivileged container will be treated as a security bug no matter if
justified or not. So this is also a good way to ruin your filesystem's
reputation.).

And honestly, if we set the precedent that it's fine for one filesystem
with an on-disk format to be able to be mounted by unprivileged
containers then other filesystems eventually want to do this as well.

At the rate we currently add filesystems that's just a matter of time
even if none of the existing ones would also want to do it. And then
we're left arguing that this was just an exception for one super
special, super safe, unexploitable filesystem with an on-disk format.

Imho, none of this is appealing. I don't want to slowly keep building a
future where we end up running fuzzers in unprivileged container to
generate random images to crash the kernel.

I have more arguments why I don't think is a path we will ever go down
but I don't want this to detract from the legitimate ask of making it
possible to mount trusted images from within unprivileged containers.
Because I think that's perfectly legitimate.

However, I don't think that this is something the kernel needs to solve
other than providing the necessary infrastructure so that this can be
solved in userspace.

Off-list, Amir had pointed to a blog I wrote last week (cf. [1]) where I
explained how we currently mount into mount namespaces of unprivileged
cotainers which had been quite a difficult problem before the new mount
api. But now it's become almost comically trivial. I mean, there's stuff
that will still be good to have but overall all the bits are already
there.

Imho, delegated mounting should be done by a system service that is
responsible for all the steps that require privileges. So for most
filesytems not mountable by unprivileged user this would amount to:

fd_fs = fsopen("xfs")
fsconfig(FSCONFIG_SET_STRING, "source", "/sm/sm")
fsconfig(FSCONFIG_CMD_CREATE)
fd_mnt = fsmount(fd_fs)
// Only required for attributes that require privileges against the sb
// of the filesystem such as idmapped mounts
mount_setattr(fd_mnt, ...)

and then the fd_mnt can be sent to the container which can then attach
it wherever it wants to. The system level service doesn't even need to
change namespaces via setns(fd_userns|fd_mntns) like I illustrated in
the post I did. It's sufficient if we sent it via AF_UNIX for example
that's exposed to the container.

Of course, this system level service would be integrated with mount(8)
directly over a well-defined protocol. And this would be nestable as
well by e.g., bind-mounting the AF_UNIX socket.

And we do already support a rudimentary form of such integration through
systemd. For example via mount -t ddi (cf. [2]) which makes it possible
to mount discoverable disk images (ddi). But that's just an
illustration. 

This should be integrated with mount(8) and should be a simply protocol
over varlink or another lightweight ipc mechanism that can be
implemented by systemd-mountd (which is how I coined this for lack of
imagination when I came up with this) or by some other component if
platforms like k8s really want to do their own thing.

This also allows us to extend this feature to the whole system btw and
to all filesystems at once. Because it means that if systemd-mountd is
told what images to trust (based on location, from a specific registry,
signature, or whatever) then this isn't just useful for unprivileged
containers but also for regular users on the host that want to mount
stuff.

This is what we're currently working on.

(There's stuff that we can do to make this more powerful __if__ we need
to. One example would probably that we _could_ make it possible to mark
a superblock as being owned by a specific namespace with similar
permission checks as what we currently do for idmapped mounts
(privileged in the superblock of the fs, privileged over the ns to
delegate to etc). IOW,

fd_fs = fsopen("xfs")
fsconfig(FSCONFIG_SET_STRING, "source", "/sm/sm")
fsconfig(FSCONFIG_SET_FD, "owner", fd_container_userns)

which completely sidesteps the issue of making that on-disk filesystem
mountable by unpriv users.

But let me say that this is completely unnecessary today as you can do:

fd_fs = fsopen("xfs")
fsconfig(FSCONFIG_SET_STRING, "source", "/sm/sm")
fsconfig(FSCONFIG_CMD_CREATE)
fd_mnt = fsmount(fd_fs)
mount_setattr(fd_mnt, MOUNT_ATTR_IDMAP)

which changes ownership across the whole filesystem. The only time you
really want what I mention here is if you want to delegate control over
__every single ioctl and potentially destructive operation associated
with that filesystem__ to an unprivileged container which is almost
never what you want.)

[1]: https://brauner.io/2023/02/28/mounting-into-mount-namespaces.html
[2]: https://github.com/systemd/systemd/pull/26695
