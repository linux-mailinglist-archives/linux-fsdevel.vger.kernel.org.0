Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DDB37B6B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 09:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhELHRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 03:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 03:17:25 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9C9C061574;
        Wed, 12 May 2021 00:16:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p20so4340700ljj.8;
        Wed, 12 May 2021 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwjeWzlPG2g5R+sdmU5M5sb7j3swoy8IxQdEsMvbG4Q=;
        b=uCv4YBESQQQmcSlke+/ZnTw1MWxd4lYlbdQCcK/E3D362iuX8reUFZ3rM6y3a1lx8U
         j+/deS+1QDnaa3dD/OZVSVG7RNeapw0DW5ielpoKkjTKbbJKW6b5yAMP71i6qJuAuPxe
         CMusQC6VujXGI7mMyZ2ap+OTFweuLT9OhwMFqu09uFqKBc481SaBwjI6T8OvtHv7D4GJ
         hmZLoBuhzdeM/KwODW7byoJTugwFd8WMtyi1RPPRrUuPjcBuCa25drVWs6cW7lF4dVlz
         vTV58mlOLcMb8d5B6xjh4CHHZhjPikH1H5nZ6y3EHnQ0QnxaPR4RDOqg8Y5Quikg5yG9
         cJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwjeWzlPG2g5R+sdmU5M5sb7j3swoy8IxQdEsMvbG4Q=;
        b=LtOxfwGos9ySkbvDy3Dkbopg8lorvuqqARV9MdVMF1PhFO1VsoB37amYQaWHzmkTe+
         ND0nb3T29FNWX7o+uWPajCa2aOvtPo/WaX4GBQW7e9XXjXhju2zzwdo2x/yfqWwqiBma
         2IfvcxKAXUafh1gu6M1Bp66l7IcMxu7MZ5AvFMl/ZbC7BgW7sRZ0uHtZf6G3sxHC03BZ
         ugfh2fhDkIKCCLKQ4FHKChNNqyNApZeSbgLqZnvefj45/vRtZ4dTuCP0Sq+ADqTb5uga
         FH34nUTk290nPQkEIkKuvo6wK8F+vRFArNn61E8XcmdxVQwjkzE5O87i+pJnGcFGYHeK
         QD1Q==
X-Gm-Message-State: AOAM530aYXBolO6Wh1A9xIH1vzlZnsXyetCelj9GBT/8yFSCpcVQOf7Y
        qRUdQvp0fppZmYmqdKS4KgSbVemWR5yV/yclphQzix2d3nUV/w==
X-Google-Smtp-Source: ABdhPJzwbF45068sOKuVbS99RuyNasIiO4Bu8vGIxmyAYguPlecABZY6BfxGYP/E+Hlv3/Y2M2tvvzz5avozG52uMTo=
X-Received: by 2002:a05:651c:224:: with SMTP id z4mr26981747ljn.457.1620803775316;
 Wed, 12 May 2021 00:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
 <YJtz6mmgPIwEQNgD@kroah.com>
In-Reply-To: <YJtz6mmgPIwEQNgD@kroah.com>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Wed, 12 May 2021 15:16:01 +0800
Message-ID: <CAC2o3D+28g67vbNOaVxuF0OfE0RjFGHVwAcA_3t1AAS_b_EnPg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] kernfs: proposed locking and concurrency improvement
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Kent <raven@themaw.net>, Tejun Heo <tj@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@sandeen.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 2:21 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 12, 2021 at 08:38:35AM +0800, Ian Kent wrote:
> > There have been a few instances of contention on the kernfs_mutex during
> > path walks, a case on very large IBM systems seen by myself, a report by
> > Brice Goglin and followed up by Fox Chen, and I've since seen a couple
> > of other reports by CoreOS users.
> >
> > The common thread is a large number of kernfs path walks leading to
> > slowness of path walks due to kernfs_mutex contention.
> >
> > The problem being that changes to the VFS over some time have increased
> > it's concurrency capabilities to an extent that kernfs's use of a mutex
> > is no longer appropriate. There's also an issue of walks for non-existent
> > paths causing contention if there are quite a few of them which is a less
> > common problem.
> >
> > This patch series is relatively straight forward.
> >
> > All it does is add the ability to take advantage of VFS negative dentry
> > caching to avoid needless dentry alloc/free cycles for lookups of paths
> > that don't exit and change the kernfs_mutex to a read/write semaphore.
> >
> > The patch that tried to stay in VFS rcu-walk mode during path walks has
> > been dropped for two reasons. First, it doesn't actually give very much
> > improvement and, second, if there's a place where mistakes could go
> > unnoticed it would be in that path. This makes the patch series simpler
> > to review and reduces the likelihood of problems going unnoticed and
> > popping up later.
> >
> > The patch to use a revision to identify if a directory has changed has
> > also been dropped. If the directory has changed the dentry revision
> > needs to be updated to avoid subsequent rb tree searches and after
> > changing to use a read/write semaphore the update also requires a lock.
> > But the d_lock is the only lock available at this point which might
> > itself be contended.
> >
> > Changes since v3:
> > - remove unneeded indirection when referencing the super block.
> > - check if inode attribute update is actually needed.
> >
> > Changes since v2:
> > - actually fix the inode attribute update locking.
> > - drop the patch that tried to stay in rcu-walk mode.
> > - drop the use a revision to identify if a directory has changed patch.
> >
> > Changes since v1:
> > - fix locking in .permission() and .getattr() by re-factoring the attribute
> >   handling code.
> > ---
> >
> > Ian Kent (5):
> >       kernfs: move revalidate to be near lookup
> >       kernfs: use VFS negative dentry caching
> >       kernfs: switch kernfs to use an rwsem
> >       kernfs: use i_lock to protect concurrent inode updates
> >       kernfs: add kernfs_need_inode_refresh()
> >
> >
> >  fs/kernfs/dir.c             | 170 ++++++++++++++++++++----------------
> >  fs/kernfs/file.c            |   4 +-
> >  fs/kernfs/inode.c           |  45 ++++++++--
> >  fs/kernfs/kernfs-internal.h |   5 +-
> >  fs/kernfs/mount.c           |  12 +--
> >  fs/kernfs/symlink.c         |   4 +-
> >  include/linux/kernfs.h      |   2 +-
> >  7 files changed, 147 insertions(+), 95 deletions(-)
> >
> > --
> > Ian
> >
>
> Any benchmark numbers that you ran that are better/worse with this patch
> series?  That woul dbe good to know, otherwise you aren't changing
> functionality here, so why would we take these changes?  :)

Let me run it on my benchmark and bring back the result to you.

> thanks,
>
> greg k-h


thanks,
fox
