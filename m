Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422CA7063A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEQJLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 05:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEQJLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 05:11:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B63420A
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 02:11:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9231A6442D
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 09:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29101C433EF;
        Wed, 17 May 2023 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684314690;
        bh=xT4zU3jH2jelP24jCUJi2iX6shHo2mZAKa/XoyVDquI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsS4ucaV8pB5HoWbtlvYULgqgbkrB1jsNCwlCaIVA0LZyVx+OtDz/AmDRivah1/QJ
         fMIjtr3OsJZCuRbVebTvLtQrhPyqCP5uL3h3xSQ4loS3KhVyg9p9nPW9jCtfx3aE4w
         twwFXhAPurGQTOyNf2wszjFAzJAHE5VfngFpGsFFda7tlrZcZbZFjgNFonSgOAL0I3
         N9BxAlybLvVXaVJVdKpZ/myr7vN6ALMDiNuPa0/B/m86/EkIF12NsHfnyF4xSDA4Ow
         HR5nPV4yloQ0LjiUpO7QE8pipJzksjXUOH2s7DFRJ3c6Dz8N8udKjISRITgc1+LIcK
         fExB0TQB/VIRw==
Date:   Wed, 17 May 2023 11:11:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        cyphar@cyphar.com, lennart@poettering.net,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
References: <20230516001348.286414-1-andrii@kernel.org>
 <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 11:02:42AM -0700, Andrii Nakryiko wrote:
> On Tue, May 16, 2023 at 2:07 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, May 15, 2023 at 05:13:46PM -0700, Andrii Nakryiko wrote:
> > > Current UAPI of BPF_OBJ_PIN and BPF_OBJ_GET commands of bpf() syscall
> > > forces users to specify pinning location as a string-based absolute or
> > > relative (to current working directory) path. This has various
> > > implications related to security (e.g., symlink-based attacks), forces
> > > BPF FS to be exposed in the file system, which can cause races with
> > > other applications.
> > >
> > > One of the feedbacks we got from folks working with containers heavily
> > > was that inability to use purely FD-based location specification was an
> > > unfortunate limitation and hindrance for BPF_OBJ_PIN and BPF_OBJ_GET
> > > commands. This patch closes this oversight, adding path_fd field to
> >
> > Cool!
> >
> > > BPF_OBJ_PIN and BPF_OBJ_GET UAPI, following conventions established by
> > > *at() syscalls for dirfd + pathname combinations.
> > >
> > > This now allows interesting possibilities like working with detached BPF
> > > FS mount (e.g., to perform multiple pinnings without running a risk of
> > > someone interfering with them), and generally making pinning/getting
> > > more secure and not prone to any races and/or security attacks.
> > >
> > > This is demonstrated by a selftest added in subsequent patch that takes
> > > advantage of new mount APIs (fsopen, fsconfig, fsmount) to demonstrate
> > > creating detached BPF FS mount, pinning, and then getting BPF map out of
> > > it, all while never exposing this private instance of BPF FS to outside
> > > worlds.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf.h            |  4 ++--
> > >  include/uapi/linux/bpf.h       |  5 +++++
> > >  kernel/bpf/inode.c             | 16 ++++++++--------
> > >  kernel/bpf/syscall.c           |  8 +++++---
> > >  tools/include/uapi/linux/bpf.h |  5 +++++
> > >  5 files changed, 25 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 36e4b2d8cca2..f58895830ada 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -2077,8 +2077,8 @@ struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
> > >  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> > >  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
> > >
> > > -int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
> > > -int bpf_obj_get_user(const char __user *pathname, int flags);
> > > +int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
> > > +int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
> > >
> > >  #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
> > >  #define DEFINE_BPF_ITER_FUNC(target, args...)                        \
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 1bb11a6ee667..db2870a52ce0 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -1420,6 +1420,11 @@ union bpf_attr {
> > >               __aligned_u64   pathname;
> > >               __u32           bpf_fd;
> > >               __u32           file_flags;
> > > +             /* same as dirfd in openat() syscall; see openat(2)
> > > +              * manpage for details of dirfd/path_fd and pathname semantics;
> > > +              * zero path_fd implies AT_FDCWD behavior
> > > +              */
> > > +             __u32           path_fd;
> > >       };
> >
> > So 0 is a valid file descriptor and can trivially be created and made to
> > refer to any file. Is this a conscious decision to have a zero value
> > imply AT_FDCWD and have you done this somewhere else in bpf already?
> > Because that's contrary to how any file descriptor based apis work.
> >
> > How this is usually solved for extensible structs is to have a flag
> > field that raises a flag to indicate that the fd fiel is set and thus 0
> > can be used as a valid value.
> >
> > The way you're doing it right now is very counterintuitive to userspace
> > and pretty much guaranteed to cause subtle bugs.
> 
> Yes, it's a very bpf()-specific convention we've settled on a while
> ago. It allows a cleaner and simpler backwards compatibility story
> without having to introduce new flags every single time. Most of BPF
> UAPI by now dictates that (otherwise valid) FD 0 can't be used to pass
> it to bpf() syscall. Most of the time users will be blissfully unaware
> because libbpf and other BPF libraries are checking for fd == 0 and
> dup()'ing them to avoid ever returning FD 0 to the user.
> 
> tl;dr, a conscious decision consistent with the rest of BPF UAPI. It
> is a bpf() peculiarity, yes.

Adding fsdevel so we're aware of this quirk.

So I'm not sure whether this was ever discussed on fsdevel when you took
the decision to treat fd 0 as AT_FDCWD or in general treat fd 0 as an
invalid value.

If it was discussed then great but if not then I would like to make it
very clear that if in the future you decide to introduce custom
semantics for vfs provided infrastructure - especially when exposed to
userspace - that you please Cc us.

You often make it very clear on the list that you don't like it when
anything that touches bpf code doesn't end up getting sent to the bpf
mailing list. It is exactly the same for us.

This is not a rant I'm really just trying to make sure that we agree on
common ground when it comes to touching each others code or semantic
assumptions.

I personally find this extremely weird to treat fd 0 as anything other
than a random fd number as it goes against any userspace assumptions and
drastically deviates from basically every file descriptor interface we
have. I mean, you're not just saying fd 0 is invalid you're even saying
it means AT_FDCWD.

For every other interface, including those that pass fds in structs
whose extensibility is premised on unknown fields being set to zero,
have ways to make fd 0 work just fine. You could've done that to without
inventing custom fd semantics.
