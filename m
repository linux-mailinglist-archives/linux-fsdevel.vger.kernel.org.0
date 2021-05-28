Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29BD39423A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 13:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhE1L57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 07:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhE1L56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 07:57:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE03DC061574;
        Fri, 28 May 2021 04:56:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f30so4972825lfj.1;
        Fri, 28 May 2021 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPgnXkvgPC2FCM76SzDk31Ok99btV/EjkXWXd50lL6E=;
        b=W5qszfWOQ8gLPmoTsTGFVujJ1QKlPZ4ZMivIkNKr91Rw3I2anHXWaqVHWrg+r78bi4
         yMf6WMkeJyhvliZ0UuvqukuYv4mTYrwgph1gs50hqW0MiSNHz4N35q9A3jmZzQmvPuxp
         bJinolTV12FDEd4+HQ0I0TU3DfmTRW0Nya/ne9JB7jHU5MKvR2pebaQNncFL2jvLDUCH
         azmsbTCcgnpsie8u8LgGv7efUW9Qb6nLyuP7rTXyB+lkUMSqikOkrVld6QCeSTs3C/kk
         /sYzBA6T49wAunTLP8IiqCOkpSqwUXitu1KIWHDZmQaOL7YDdaNQyM2p3jxrUCQPkWiq
         kpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPgnXkvgPC2FCM76SzDk31Ok99btV/EjkXWXd50lL6E=;
        b=C1klHb2qKLVPkQ4ZdqthHhD6EHZy1wzeYXr9xjmbbu6hM61H6SK6xpRchFEY7gdmaM
         B7USLg4GNdQQkeOuwWUcMSDg8/q9lH9LekCYKvKRI2Lx9693BbC8jtFax3j67/GmQx3X
         jRpMhCogqj5YESHxHW291ZkWNJckzPDX7d9DFzKe/WeszTRKKqvUTQn75HjEuOUt4L6H
         tIVYhgozrzxGvQYRqT/i7giJmt5jFKvHaRzbxz79bQ+A0lU9qO96MwR6oSCeRCuz6JIO
         mvunUmBexvHQL7y98UT28W59sswedwG1o8CK24WvoZqI60Im3sTG/o+8Pu4cyx6Ilczx
         VCmQ==
X-Gm-Message-State: AOAM530cmlMzA/ERIrCmA0UtlxAoGQdTabPRHzoI4eJn7NdSSdBBJArY
        MrS7T19SJtCx8uMKjs8nUj6so0cFitz47z1l8Bk=
X-Google-Smtp-Source: ABdhPJyVZVNO0iCwwkDwK5pW9d3vqq3p+dTMqiT8Bjoltbm7sR2VYchj2th2sAFkzqQa6HkIznAvcILuKZ8hqTjXoNI=
X-Received: by 2002:ac2:44af:: with SMTP id c15mr5463648lfm.651.1622202982156;
 Fri, 28 May 2021 04:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
 <YLCwIfYxM7jYKQxe@kroah.com>
In-Reply-To: <YLCwIfYxM7jYKQxe@kroah.com>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Fri, 28 May 2021 19:56:10 +0800
Message-ID: <CAC2o3D+GH31Q2oxDgBVu8BfEUXuDovUM7uKJq=uHb3Ay+WjhSQ@mail.gmail.com>
Subject: Re: [REPOST PATCH v4 0/5] kernfs: proposed locking and concurrency improvement
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Kent <raven@themaw.net>, Tejun Heo <tj@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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

On Fri, May 28, 2021 at 4:56 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 28, 2021 at 02:33:42PM +0800, Ian Kent wrote:
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
>
> Fox, can you take some time and test these to verify it all still works
> properly with your benchmarks?

Sure, I will take a look.
Actually, I've tested it before, but I will test it again to confirm it.

> thanks,
>
> greg k-h

thanks,
fox
