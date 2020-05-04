Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F821C3EAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgEDPio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726551AbgEDPio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 11:38:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19992C061A0E;
        Mon,  4 May 2020 08:38:44 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t3so5422696otp.3;
        Mon, 04 May 2020 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQmiZ2oynlhDfde2EHPhdAI1YOCtUf9mJwJbeZ1phXA=;
        b=LLdJgfk1v3kAIY+VoLISzPL7wnGft9Y5B9LAEqA9liHp8SRaQjP8RlqzOXUktcNnnP
         JfLWB12JPPeGdyrE5ZZPtqGjNBITxDv5H+h9xzFbAmi+wIcZqGn1ms/YoNb2LH1hZtih
         6FdoSRuputT5mDOtQAMS1JvXhlvnau9Wfinxswhns6BVDlNh0FY92pwqwBXFlt8m6jYx
         vrcHVRjxx1sh6xnVb6zS8NCK56Q5zQBWs+LEebscmCunxIYUC2FXBbiyOoVR4taRMTE0
         BZiaaLuf9k237O0RO1vOVcjy/FeivKTax6cU4mpLh0CGaV0fLrOHBIFKrjxEzKSREU3I
         XCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQmiZ2oynlhDfde2EHPhdAI1YOCtUf9mJwJbeZ1phXA=;
        b=dF41VW3Buev8snXWbpig4fLIz0UOH3VDfx/j+zJIwzlrbIJ3/pGkv2D9aaicbdGgjd
         pWnxo5lqcBg4cZXWUEn27HPXVxDfj4iVjCeIHxtMZesvTK1ls/zMkjbl5BM81zWtywhg
         CLLejrx7vaLYEJZ+PZojl7uUr1uV9tpJC9N+5FUYmejCA6AiOhrTVmzo7miGXsoQinWh
         HNcGRi2bk4cpZSlgr9k3w2pJb9ijy2IaXtSKhAZAfQPWCEcoBJAwqd1g0FhyP0yika6Y
         +/VjItRtFvSol01AYh4m52ANQMX8AzqZJueHAr4MxdypK1SXF/GD9iQreCbdIFmnCe3F
         H9DA==
X-Gm-Message-State: AGi0PuaX/74qwhfvNVqodipjae0h7c5t37RrFzI1Gh9iv5AGWj38mg3r
        chAOdkLJNJsrFaRpkGpQJ8z6l4uU9TPmvx7os0wzuLER
X-Google-Smtp-Source: APiQypK30ppvBdUJTltS7axkgnOzEYXoHyr1dwoOOZ9tmfqmC3j+MRh3bml/HVpypkfHGMVyWOD+7huhTdt6XADF4JM=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr14907515otb.162.1588606723375;
 Mon, 04 May 2020 08:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
 <20200501041444.GJ23230@ZenIV.linux.org.uk> <20200501073127.GB13131@miu.piliscsaba.redhat.com>
 <CAEjxPJ6Tr-MD85yh-zRcCKwMTZ7bcw4vAXQ2=CjScG71ac4Vzw@mail.gmail.com> <CAJfpegvZ+ASrpbEpeKx-h3mK7fedd7EfgAfm7TL7dgPmy7tppg@mail.gmail.com>
In-Reply-To: <CAJfpegvZ+ASrpbEpeKx-h3mK7fedd7EfgAfm7TL7dgPmy7tppg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 4 May 2020 11:38:32 -0400
Message-ID: <CAEjxPJ7S-i+CvGSiBWhPZ6xLFZanzA8OgRLgvL5X7VBkKF4Eqg@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow unprivileged whiteout creation
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 4, 2020 at 7:18 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, May 1, 2020 at 8:40 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, May 1, 2020 at 3:34 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Fri, May 01, 2020 at 05:14:44AM +0100, Al Viro wrote:
> > > > On Thu, Apr 09, 2020 at 11:28:59PM +0200, Miklos Szeredi wrote:
> > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > >
> > > > > Whiteouts, unlike real device node should not require privileges to create.
> > > > >
> > > > > The general concern with device nodes is that opening them can have side
> > > > > effects.  The kernel already avoids zero major (see
> > > > > Documentation/admin-guide/devices.txt).  To be on the safe side the patch
> > > > > explicitly forbids registering a char device with 0/0 number (see
> > > > > cdev_add()).
> > > > >
> > > > > This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
> > > > > i.e. it won't have any side effect.
> > > >
> > > > >  int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> > > > >  {
> > > > > +   bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
> > > > >     int error = may_create(dir, dentry);
> > > > >
> > > > >     if (error)
> > > > >             return error;
> > > > >
> > > > > -   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
> > > > > +   if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
> > > > > +       !is_whiteout)
> > > > >             return -EPERM;
> > > >
> > > > Hmm...  That exposes vfs_whiteout() to LSM; are you sure that you won't
> > > > end up with regressions for overlayfs on sufficiently weird setups?
> > >
> > > You're right.  OTOH, what can we do?  We can't fix the weird setups, only the
> > > distros/admins can.
> > >
> > > Can we just try this, and revert to calling ->mknod directly from overlayfs if
> > > it turns out to be a problem that people can't fix easily?
> > >
> > > I guess we could add a new ->whiteout security hook as well, but I'm not sure
> > > it's worth it.  Cc: LMS mailing list; patch re-added for context.
> >
> > I feel like I am still missing context but IIUC this change is
> > allowing unprivileged userspace to explicitly call mknod(2) with the
> > whiteout device number and skip all permission checks (except the LSM
> > one). And then you are switching vfs_whiteout() over to using
> > vfs_mknod() internally since it no longer does permission checking and
> > that was why vfs_whiteout() was separate originally to avoid imposing
> > any checks on overlayfs-internal creation of whiteouts?
> >
> > If that's correct, then it seems problematic since we have no way in
> > the LSM hook to distinguish the two cases (userspace invocation of
> > mknod(2) versus overlayfs-internal operation).  Don't know offhand
> > what credential is in effect in the overlayfs case (mounter or
> > current) but regardless Android seems to use current regardless, and
> > that could easily fail.
>
> The major point is: whiteouts are *not* device files, not in the real
> sense, it just happens that whiteouts are represented by the file
> having a char/0/0 type.
>
> Also the fact that overlayfs invocation is indistinguishable from
> userspace invocation is very much on purpose.  Whiteout creation was
> the exception before this change, not the rule.
>
> If you consider the above, how should this be handled from an LSM perspective?

In that case, I guess you can leave the patch as is aside from moving
the capable() check last, and we will just need to allow creation of
these files to the mounter context for overlayfs-internal usage. It
doesn't appear to be safe to skip the hook call altogether for the
general case (e.g. userspace mknod(2)).
