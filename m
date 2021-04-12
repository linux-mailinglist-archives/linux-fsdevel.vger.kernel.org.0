Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5637D35BDEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbhDLI4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 04:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbhDLIx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:53:29 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2E4C06134A
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 01:53:11 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id o17so2696181vko.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4dnJwSozK/OuprgW1/k3MPNDhDkpsPOnCAcH3ZfMrg=;
        b=JgE7hwpO31aXQWKQrcW/Ezx/yhhuXdk3E3Gtspl9jxftrmGbyMmYOcnOL+rGwN56HI
         YI1Dbu/sgrxlzZJSOF/2MuqAxV8VhK7nfn5458tdbejAGEokmylV4zLRqhQlGncJKSU1
         11hWrvKtRohrVvwcBl1bqiaWKdrC+KTLwEVAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4dnJwSozK/OuprgW1/k3MPNDhDkpsPOnCAcH3ZfMrg=;
        b=dQ2tANtQI2ZP8Lf2GZt/uOSt2ZPCqmCXbFdnbqL3a/CKK422Gkad8vtKt1JewnWUS0
         T4nRZvFC0/wef/hxrL4bFap1eI4siYmz+8NAw4WxVdzyFTa14ZA2aZDOUHbWhvwpW8i+
         wt6TUl0qv0MpStbsubjzFKeRYwgLWMUpF++SgOXlEWYZFdw1NWQZUrxhRezpiUal65ut
         rLFX+GczFto9tABEsqMFSLA+zDiAeTLzHe3cuoD1Y+VotCgl1y9hbWOn/d3o0fIZL4e3
         MasqGs5tdS13NlVEXu068N2Ifi3S8YFow1nNLwO74LN6VAmL6ygWDszzzHLghkOzupKL
         YFMg==
X-Gm-Message-State: AOAM531fB7l6QcbEe0spwe4dzLUeqDLO6zEK2tv97BLqFk5EceoUBWyJ
        fWINyOwmbuWCoXVHzY1xkjD4WGbWcxagvKMtNAu0jQ==
X-Google-Smtp-Source: ABdhPJwuXKPa0NtAbkpjbOfpldg6CUF9FdLG91jSFNDHX/OMCoFlwj9LSKMoNP49NUerSMtb8SG+WHQ+AgPg1IM55EU=
X-Received: by 2002:a1f:4ec3:: with SMTP id c186mr18512956vkb.11.1618217590754;
 Mon, 12 Apr 2021 01:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210409162422.1326565-1-brauner@kernel.org> <20210409162422.1326565-3-brauner@kernel.org>
 <YHDxxunCKNuV34Oz@zeniv-ca.linux.org.uk> <20210410123037.qlfjyv55ncdjpwn3@wittgenstein>
In-Reply-To: <20210410123037.qlfjyv55ncdjpwn3@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Apr 2021 10:53:00 +0200
Message-ID: <CAJfpegsONBtvy+ykW2jy6e903wFqXaYvJ_pYSNSQ=eiPc=MzFQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ecryptfs: use private mount in path
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 10, 2021 at 2:30 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sat, Apr 10, 2021 at 12:31:02AM +0000, Al Viro wrote:
> > On Fri, Apr 09, 2021 at 06:24:21PM +0200, Christian Brauner wrote:
> >
> > > Reading through the codebase of ecryptfs it currently takes path->mnt
> > > and then retrieves that path whenever it needs to perform operations in
> > > the underlying filesystem. Simply drop the old path->mnt once we've
> > > created a private mount and place the new private mnt into path->mnt.
> > > This should be all that is needed to make this work since ecryptfs uses
> > > the same lower path's vfsmount to construct the paths it uses to operate
> > > on the underlying filesystem.
> >
> > > +   mnt = clone_private_mount(&path);
> >
> > Incidentally, why is that thing anything other than a trivial wrapper
> > for mnt_clone_internal() (if that - I'm not convinced that the check of
> > unbindable is the right thing to do here).  Miklos?
>
> The unbindable check is irrelevant at least for both ecryptfs and for
> the corresponding cachefiles change I sent out since they don't care
> about it.
> In practice it doesn't matter to be honest. MS_UNBINDABLE is wildly
> esoteric in userspace (We had a glaring bug with that some time ago that
> went completely unnoticed for years.). Especially unlikely to be used
> for a users home directory (ecryptfs) or /var/cache/fscache
> (cachefiles). So even by leaving this check in it's very unlikely for
> any regressions to appear.
>
> I hadn't seen mnt_clone_internal() but it's different in so far as it
> sets MNT_INTERNAL whereas clone_private_mount() uses MNT_NS_INTERNAL.
> Which points me to another potential problem here:
> clone_private_mount() seems to want kern_unmount() to be called instead
> of just a simple mntput()?

Yes, that's stated in a comment in the clone_private_mount() helper.

The difference is that short term mounts take a small penalty on each
mntput(), while longterm mounts take a fairly large penalty on
kern_unmount().  It's just a performance thing, AFAIK.

As for MS_UNBINDABLE, my recollection is that it was copy-pasted from
regular bind mount.  I agree that it can be moved to overlayfs (or
removed altogether, with some thought into what MS_UNBINDABLE actually
is used for).

Thanks,
Miklos
