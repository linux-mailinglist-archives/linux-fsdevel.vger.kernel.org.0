Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A551F7A24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgFLOwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 10:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLOwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:52:21 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C7DC03E96F;
        Fri, 12 Jun 2020 07:52:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p20so10464344iop.11;
        Fri, 12 Jun 2020 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxIGr9FPyH+Gs91n0/fHkQIhX/ZfGolDhhvbaK9CMlU=;
        b=qfmIpy0vKvOQEg/Mekd63hToHWPWLlIvidIzy+oN0SOwAisx5FaGV15mzFf4/SG1XD
         YkkeaiRj7mIZnBq6r3kLIUASIbZeSu8HznRwCFWmNMbbEq6qTLki9uRl/2bA37R0Yd8f
         x1BT9M8ZDilHh7sgnQfXaJEg50uQ6CSlIqzCStBBrKrEYU6u5T3+lE1PvOVHytWhvX7o
         HZLneUwAmGVYQZa8vOEeO8p8EQmsPvqSLeipOxZNj/gj9FRuZEccTkNCBQfIZ4WzsD8I
         H82KAkf9tQpw3z5iVbukpynC6cAX/HddRbOOUP7jADQxGuvEpfAbnlHWDguonIx2hLwd
         W2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxIGr9FPyH+Gs91n0/fHkQIhX/ZfGolDhhvbaK9CMlU=;
        b=ikUfAj0sA6fMDqmhaPJm/AmZIqE8vqFPgE34ezR3W3cIO2AsN1ZpEv2hZxaxBfju8K
         fnnP44BTwCOke3vEaBY9f9z6Wt7x3xtmPr0I3n7JPHZrx5WnW+jyX53Z6mgAop+WPPfz
         mhJzX2OrVSUzKLKzu338somYvsBd59qqEgYbS84pxwPw3MEkPQlwxfuTGKE9o53GPn9n
         z6j5Lw8nq4r0K8wflVGgf8gUHrXKw99aZ3hmJ9NHKXgt9tgiaIDgXA/IfdNfwV39+Cyx
         o0/Ub1PdTjauCPbmDpMINEoUkxpYBCe6pxBEvsdqBfcYNqbb1743UQ2/Af68hq/CAXhe
         GvwA==
X-Gm-Message-State: AOAM532VnJcvg1T+Tm7k5bFU2cGOyBPqV11Q8kRarJl/Ejc7098m7NUM
        1XG2wNjdTlABm3UUgmongFxjgV4CCxU4JT31jng=
X-Google-Smtp-Source: ABdhPJwkwYAHKc1eSyBzc7anF6WXW3t6WgRRKZVAv0DvCcQ7TbDLRDreyBbhq8KXqUrYsEfQKddTA6prsuzBI4O8TTA=
X-Received: by 2002:a05:6602:491:: with SMTP id y17mr14024412iov.72.1591973539142;
 Fri, 12 Jun 2020 07:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200612092603.GB3183@techsingularity.net> <CAOQ4uxikbJ19npQFWzGm6xnqXm0W8pV3NOWE0ZxS9p_G2A39Aw@mail.gmail.com>
 <20200612131854.GD3183@techsingularity.net>
In-Reply-To: <20200612131854.GD3183@techsingularity.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 12 Jun 2020 17:52:08 +0300
Message-ID: <CAOQ4uxghy5zOT6i=shZfFHsXOgPrd7-4iPkJBDcsHU6bUSFUFg@mail.gmail.com>
Subject: Re: [PATCH] fs: Do not check if there is a fsnotify watcher on pseudo inodes
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 4:18 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Jun 12, 2020 at 12:52:28PM +0300, Amir Goldstein wrote:
> > On Fri, Jun 12, 2020 at 12:26 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > The kernel uses internal mounts for a number of purposes including pipes.
> > > On every vfs_write regardless of filesystem, fsnotify_modify() is called
> > > to notify of any changes which incurs a small amount of overhead in fsnotify
> > > even when there are no watchers.
> > >
> > > A patch is pending that reduces, but does not eliminte, the overhead
> > > of fsnotify but for the internal mounts, even the small overhead is
> > > unnecessary. The user API is based on the pathname and a dirfd and proc
> > > is the only visible path for inodes on an internal mount. Proc does not
> > > have the same pathname as the internal entry so even if fatrace is used
> > > on /proc, no events trigger for the /proc/X/fd/ files.
> > >
> >
> > This looks like a good direction and I was going to suggest that as well.
> > However, I am confused by the use of terminology "internal mount".
> > The patch does not do anything dealing with "internal mount".
>
> I was referring to users of kern_mount.

I see. I am not sure if all kern_mount hand out only anonymous inodes,
but FYI, now there a MNT_NS_INTERNAL that is not SB_KERNMOUNT:
df820f8de4e4 ovl: make private mounts longterm

>
> > If alloc_file_pseudo() is only called for filesystems mounted as
> > internal mounts,
>
> I believe this is the case and I did not find a counter-example.  The
> changelog that introduced the helper is not explicit but it was created
> in the context of converting a number of internal mounts like pipes,
> anon inodes to a common helper. If I'm wrong, Al will likely point it out.
>
> > please include this analysis in commit message.
> > In any case, not every file of internal mount is allocated with
> > alloc_file_pseudo(),
> > right?
>
> Correct. It is not required and there is at least one counter example
> in arch/ia64/kernel/perfmon.c but I don't think that is particularly
> important, I don't think anyone is kept awake at night worrying about
> small performance overhead on Itanium.
>
> > So maybe it would be better to list all users of alloc_file_pseudo()
> > and say that they all should be opted out of fsnotify, without mentioning
> > "internal mount"?
> >
>
> The users are DMA buffers, CXL, aio, anon inodes, hugetlbfs, anonymous
> pipes, shmem and sockets although not all of them necessary end up using
> a VFS operation that triggers fsnotify.  Either way, I don't think it
> makes sense (or even possible) to watch any of those with fanotify so
> setting the flag seems reasonable.
>

I also think this seems reasonable, but the more accurate reason IMO
is found in the comment for d_alloc_pseudo():
"allocate a dentry (for lookup-less filesystems)..."

> I updated the changelog and maybe this is clearer.

I still find the use of "internal mount" terminology too vague.
"lookup-less filesystems" would have been more accurate,
because as you correctly point out, the user API to set a watch
requires that the marked object is looked up in the filesystem.

There are also some kernel internal users that set watches
like audit and nfsd, but I think they are also only interested in
inodes that have a path at the time that the mark is setup.

Thanks,
Amir.
