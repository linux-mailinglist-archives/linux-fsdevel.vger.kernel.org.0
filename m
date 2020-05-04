Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7601C37DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgEDLTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 07:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDLTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 07:19:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570CCC061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2020 04:19:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k8so13549204ejv.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnhHp4z6/JfitEDp77Ovs3sPoUEeRYCqXcr3ouUaioY=;
        b=pmQakzRLRsJk/F4L60ClrnRIEH/nzG0J2iy0rKYUgm9VNbjh832jl9Yhbx2oimEt8s
         vFC1RO5ii4yZoiTtkjqe1eNFHGh/eW+SuC+6Q09N1w662AYyuOTJLe8VyjMhwhk3LiIB
         Ml5MAmKoGGI0sZPKcG5uSL6uzHCJDnFlRMuzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnhHp4z6/JfitEDp77Ovs3sPoUEeRYCqXcr3ouUaioY=;
        b=MVhG+geXS7qFq/UG08ARfUvFmS0Sv8BPCAfNxCg+uvP4Ot1nnTPD8nmSgG6OAG2At0
         zqG452nyFV7n5tSxu5s50n4SdiNOPjZELYoQ4mlf1dNIR5V7ZuFLwP6ul3vRXiqqnsHI
         pzFa6WYc693qBX/12bKDRUZgqoXbyJiU8hdhr7DikQarGyzkXq8fF1FGnV+vX7AEgfxi
         Ys0RNpGwAxY/xvAKPUSNEvnaX93FZbdqMWcxC3wUCWdUA0F8isy3hH09DV2ibwm7PdTB
         O5YqF+3CXCxsISFt75ZZEubNxa4i4F7TOELjirEeSbZGvj6czbDNQmw44CArnFn3UnsE
         8h3Q==
X-Gm-Message-State: AGi0PuZBMu8EcE78RC/zbJOBNonN1F9Dk2tRUMEgPscmvPw6aZXq5MQd
        WZWiB6CW30oYeWwIQO4T9b3lXyDCrS8jDghwODZFIyEfjzA=
X-Google-Smtp-Source: APiQypKtOEJXmmcQClOPLZPgv4ey3QaTiM7LQBxA26hvnZWHW0kpfX0633B0Kl2NTByXsbhh2QEjpKZCaStzxta0jNg=
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr14957699ejx.43.1588591138981;
 Mon, 04 May 2020 04:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
 <20200501041444.GJ23230@ZenIV.linux.org.uk> <20200501073127.GB13131@miu.piliscsaba.redhat.com>
 <CAEjxPJ6Tr-MD85yh-zRcCKwMTZ7bcw4vAXQ2=CjScG71ac4Vzw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Tr-MD85yh-zRcCKwMTZ7bcw4vAXQ2=CjScG71ac4Vzw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 4 May 2020 13:18:47 +0200
Message-ID: <CAJfpegvZ+ASrpbEpeKx-h3mK7fedd7EfgAfm7TL7dgPmy7tppg@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 1, 2020 at 8:40 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 1, 2020 at 3:34 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Fri, May 01, 2020 at 05:14:44AM +0100, Al Viro wrote:
> > > On Thu, Apr 09, 2020 at 11:28:59PM +0200, Miklos Szeredi wrote:
> > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > >
> > > > Whiteouts, unlike real device node should not require privileges to create.
> > > >
> > > > The general concern with device nodes is that opening them can have side
> > > > effects.  The kernel already avoids zero major (see
> > > > Documentation/admin-guide/devices.txt).  To be on the safe side the patch
> > > > explicitly forbids registering a char device with 0/0 number (see
> > > > cdev_add()).
> > > >
> > > > This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
> > > > i.e. it won't have any side effect.
> > >
> > > >  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> > > >  {
> > > > +   bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
> > > >     int error = may_create(dir, dentry);
> > > >
> > > >     if (error)
> > > >             return error;
> > > >
> > > > -   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> > > > +   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> > > > +       !is_whiteout)
> > > >             return -EPERM;
> > >
> > > Hmm...  That exposes vfs_whiteout() to LSM; are you sure that you won't
> > > end up with regressions for overlayfs on sufficiently weird setups?
> >
> > You're right.  OTOH, what can we do?  We can't fix the weird setups, only the
> > distros/admins can.
> >
> > Can we just try this, and revert to calling ->mknod directly from overlayfs if
> > it turns out to be a problem that people can't fix easily?
> >
> > I guess we could add a new ->whiteout security hook as well, but I'm not sure
> > it's worth it.  Cc: LMS mailing list; patch re-added for context.
>
> I feel like I am still missing context but IIUC this change is
> allowing unprivileged userspace to explicitly call mknod(2) with the
> whiteout device number and skip all permission checks (except the LSM
> one). And then you are switching vfs_whiteout() over to using
> vfs_mknod() internally since it no longer does permission checking and
> that was why vfs_whiteout() was separate originally to avoid imposing
> any checks on overlayfs-internal creation of whiteouts?
>
> If that's correct, then it seems problematic since we have no way in
> the LSM hook to distinguish the two cases (userspace invocation of
> mknod(2) versus overlayfs-internal operation).  Don't know offhand
> what credential is in effect in the overlayfs case (mounter or
> current) but regardless Android seems to use current regardless, and
> that could easily fail.

The major point is: whiteouts are *not* device files, not in the real
sense, it just happens that whiteouts are represented by the file
having a char/0/0 type.

Also the fact that overlayfs invocation is indistinguishable from
userspace invocation is very much on purpose.  Whiteout creation was
the exception before this change, not the rule.

If you consider the above, how should this be handled from an LSM perspective?

Thanks,
Miklos
