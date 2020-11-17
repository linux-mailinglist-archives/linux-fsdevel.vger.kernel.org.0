Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B682B5952
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 06:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKQFdj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 00:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgKQFdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 00:33:38 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B996C0613CF;
        Mon, 16 Nov 2020 21:33:38 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id m13so19911219ioq.9;
        Mon, 16 Nov 2020 21:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BetriBQNj2aNFzDqX6Jj7L6aSvpB97k2W5ppiZhSeFY=;
        b=jmPQW4ypj8cDV5AP+JpEXpdfTmTf/IDEHF4fpDErUuawzkGuQFpWkKkjayx0k8j/ke
         rtoKT2SeodsSTJxy7joamFxguJteN5Vmw51P9oAPV7/fA6Yak+37+M65GiGlGLdLLCVD
         ujoxWHx/nYS6Rr/EoqR2a6fH8cSiE6KWFaHvudkFQJfSkoTgKNjibMOqL+zIxzfcHS0z
         nKO94ykmp2h7423hmHCSjrT3YfQJfP+WiVpjik0Q6QCznsrIGe2UluEpc4cAd1p6HMUX
         qlTK140+yR+DpmVENgzgRjdZs3YY2OiVs/NgaJiNSB8Gpu5+TeCCcnBfEKVkmmLZMlgc
         +Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BetriBQNj2aNFzDqX6Jj7L6aSvpB97k2W5ppiZhSeFY=;
        b=pShqfLOazJOvppEt8b6kr5jpIk5OEga3rVEPmT73Kbd3WuL+uV61tyryXmOR/ZcRmx
         0+hUm7DQtZ2ndailLU10A2DPW0w0M0xajsEIhqodDxQnO4yWQCO6zL9eRZHCABWXeu6O
         ltVHtH9uWpXd38WvFUsuiqH/MWItq+hJfhIc566MA0ZRZC4MuaJ+SCukyah+g8+D0SS2
         jQEkDkXBfcr+CfCPYnaWQwdiu3u3WYZN8cMxJBCfUTS+p4EBE7wewIQ+vcrSFbFwLB6g
         Cz67jkMNaaJ02VEAlHW2d8rCNcN9GSZW59M8YiWe921ofLM2NW9Q7kSrYjsw4a3kn7Lj
         WV8w==
X-Gm-Message-State: AOAM533DD2Kxt0Tr/rzbo6M4cXRJUMxBT+QLR6R7qYI4Da0+i8hI0jSm
        1Kker51JX+ht5eQNeDE1Ijsjv+D0gqxG3MdHJr0=
X-Google-Smtp-Source: ABdhPJzegrcwLmLV6DrLxV2vcf5VaLE2vhTuXpaHLVU5eikSFgPlp9SiWw0JgCkTU8Cle8HgPA7Qmt2sl6cLjumDLF0=
X-Received: by 2002:a02:70ce:: with SMTP id f197mr2485740jac.120.1605591217710;
 Mon, 16 Nov 2020 21:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20201116045758.21774-1-sargun@sargun.me> <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com> <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
 <20201116163615.GA17680@redhat.com> <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
 <20201116210950.GD9190@redhat.com>
In-Reply-To: <20201116210950.GD9190@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 17 Nov 2020 07:33:26 +0200
Message-ID: <CAOQ4uxhkRauEM46nbhZuGdJmP8UGQpe+fw_FtXy+S4eaR4uxTA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:09 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Nov 16, 2020 at 10:18:03PM +0200, Amir Goldstein wrote:
> > On Mon, Nov 16, 2020 at 6:36 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Mon, Nov 16, 2020 at 05:20:04PM +0200, Amir Goldstein wrote:
> > > > On Mon, Nov 16, 2020 at 4:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > On Sun, Nov 15, 2020 at 08:57:58PM -0800, Sargun Dhillon wrote:
> > > > > > Overlayfs added the ability to setup mounts where all syncs could be
> > > > > > short-circuted in (2a99ddacee43: ovl: provide a mount option "volatile").
> > > > > >
> > > > > > A user might want to remount this fs, but we do not let the user because
> > > > > > of the "incompat" detection feature. In the case of volatile, it is safe
> > > > > > to do something like[1]:
> > > > > >
> > > > > > $ sync -f /root/upperdir
> > > > > > $ rm -rf /root/workdir/incompat/volatile
> > > > > >
> > > > > > There are two ways to go about this. You can call sync on the underlying
> > > > > > filesystem, check the error code, and delete the dirty file if everything
> > > > > > is clean. If you're running lots of containers on the same filesystem, or
> > > > > > you want to avoid all unnecessary I/O, this may be suboptimal.
> > > > > >
> > > > >
> > > > > Hi Sargun,
> > > > >
> > > > > I had asked bunch of questions in previous mail thread to be more
> > > > > clear on your requirements but never got any response. It would
> > > > > have helped understanding your requirements better.
> > > > >
> > > > > How about following patch set which seems to sync only dirty inodes of
> > > > > upper belonging to a particular overlayfs instance.
> > > > >
> > > > > https://lore.kernel.org/linux-unionfs/20201113065555.147276-1-cgxu519@mykernel.net/
> > > > >
> > > > > So if could implement a mount option which ignores fsync but upon
> > > > > syncfs, only syncs dirty inodes of that overlayfs instance, it will
> > > > > make sure we are not syncing whole of the upper fs. And we could
> > > > > do this syncing on unmount of overlayfs and remove dirty file upon
> > > > > successful sync.
> > > > >
> > > > > Looks like this will be much simpler method and should be able to
> > > > > meet your requirements (As long as you are fine with syncing dirty
> > > > > upper inodes of this overlay instance on unmount).
> > > > >
> > > >
> > > > Do note that the latest patch set by Chengguang not only syncs dirty
> > > > inodes of this overlay instance, but also waits for in-flight writeback on
> > > > all the upper fs inodes and I think that with !ovl_should_sync(ofs)
> > > > we will not re-dirty the ovl inodes and lose track of the list of dirty
> > > > inodes - maybe that can be fixed.
> > > >
> > > > Also, I am not sure anymore that we can safely remove the dirty file after
> > > > sync dirty inodes sync_fs and umount. If someone did sync_fs before us
> > > > and consumed the error, we may have a copied up file in upper whose
> > > > data is not on disk, but when we sync_fs on unmount we won't get an
> > > > error? not sure.
> > >
> > > May be we can save errseq_t when mounting overlay and compare with
> > > errseq_t stored in upper sb after unmount. That will tell us whether
> > > error has happened since we mounted overlay. (Similar to what Sargun
> > > is doing).
> > >
> >
> > I suppose so.
> >
> > > In fact, if this is a concern, we have this issue with user space
> > > "sync <upper>" too? Other sync might fail and this one succeeds
> > > and we will think upper is just fine. May be container tools can
> > > keep a file/dir open at the time of mount and call syncfs using
> > > that fd instead. (And that should catch errors since that fd
> > > was opened, I am assuming).
> > >
> >
> > Did not understand the problem with userspace sync.
>
> Say volatile container A is using upper/ which is on xfs. Assume, container A
> does following.
>
> 1. Container A writes some data/copies up some files.
> 2. sync -f upper/
> 3. Remove incompat dir.
> 4. Remount overlay and restart container A.
>
> Now normally if some error happend in writeback on upper/, then "sync -f"
> should catch that and return an error. In that case container manager can
> throw away the container.
>
> What if another container B was doing same thing and issues ssues
> "sync -f upper/" and that sync reports errors. Now container A issues
> sync and IIUC, we will not see error on super block because it has
> already been seen by container B.
>
> And container A will assume that all data written by it safely made
> it to disk and it is safe to remove incompat/volatile/ dir.
>
> If container manager keeps a file descriptor open to one of the files
> in upper/, and uses that for sync, then it will still catch the
> error because file->f_sb_err should be previous to error happened
> and we will get any error since then.
>

Yeh, we should probably record upper sb_err on mount either way,
On fsync in volatile, instead of noop we can check if upper fs had
writeback errors since volatile mount and return error instead of 0.



> >
> > > >
> > > > I am less concerned about ways to allow re-mount of volatile
> > > > overlayfs than I am about turning volatile overlayfs into non-volatile.
> > >
> > > If we are not interested in converting volatile containers into
> > > non-volatile, then whole point of these patch series is to detect
> > > if any writeback error has happened or not. If writeback error has
> > > happened, then we detect that at remount and possibly throw away
> > > container.
> > >
> > > What happens today if writeback error has happened. Is that page thrown
> > > away from page cache and read back from disk? IOW, will user lose
> > > the data it had written in page cache because writeback failed. I am
> > > assuming we can't keep the dirty page around for very long otherwise
> > > it has potential to fill up all the available ram with dirty pages which
> > > can't be written back.
> > >
> >
> > Right. the resulting data is undefined after error.
>
> So application will not come to know of error until and unless it does
> an fsync()? IOW, if I write to a file and read back same pages after
> a while, I might not get back what I had written. So application
> should first write data, fsync it and upon successful fsync, consume
> back the data written?

I think so. Think of ENOSPC and delayed disk space allocation
and COW blocks with btrfs clones.
Filesystems will do their best to reserve space in such cases
before actual blocks allocation, but it doesn't always work.

>
> If yes, this is a problem for volatile containers. If somebody is
> using these to build images, there is a possibility that image
> is corrupted (because writeback error led to data loss). If yes,
> then safe way to generate image with volatile containers
> will be to first sync upper (or sync on umount somehow) and if
> no errors are reported, then it is safe to read back that data
> and pack into image.
>

I guess if we change fsync and syncfs to do nothing but return
error if any writeback error happened since mount we will be ok?

> >
> > > Why is it important to detect writeback error only during remount. What
> > > happens if container overlay instance is already mounted and writeback
> > > error happens. We will not detct that, right?
> > >
> > > IOW, if capturing writeback error is important for volatile containers,
> > > then capturing it only during remount time is not enough. Normally
> > > fsync/syncfs should catch it and now we have skipped those, so in
> > > the process we lost mechanism to detect writeback errrors for
> > > volatile containers?
> > >
> >
> > Yes, you are right.
> > It's an issue with volatile that we should probably document.
> >
> > I think upper files data can "evaporate" even as the overlay is still mounted.
>
> How do we reliably consume that data back (if it can evaporate). That
> means, syncing whole fs (syncfs) is a requirement for volatile containers
> before data written is read back. Otherwise we don't know if we are
> reading back correct data or corrupted data.
>
> Thanks
> Vivek
>
