Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B16467B6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 17:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358326AbhLCQei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 11:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352984AbhLCQeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:34:37 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10B9C061751;
        Fri,  3 Dec 2021 08:31:13 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id a11so3253566ilj.6;
        Fri, 03 Dec 2021 08:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VkuP0/IYglzLHQH3LqznH+bbxsL03I8CCKw6nfJS4uQ=;
        b=NyHs3cD/45x7BO3po9KtdoYOrrfO2R1lTXX/Li2KQpeDZ74TaLj3r9UuY+by31nl9c
         BXwdwa6FhVq30Xm0mhyAB9Gfw80Xtv7QZkx8PxeX+4gjfcJRlVEHr+kaTUbzWgURL67D
         C9x1jnubMaB+XkB2YUgtDyBc8JA53sFwOAOxTuKQdtFkZgd3Gj7/tmqwAz3tBBn/O2c9
         2UpBiXgUTpC2WwWAgH0q1hNq4x2DMhcHghIXfe6Jx4LbdYbQVfU9MkKctIRnQ/2W9kpe
         ngTIhcsi3TitBU1JcyIyDNyziMq5I2p8aUFXYR4fZb8IUXJ7SLrEz1LJOYiC0DLMzORY
         AiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkuP0/IYglzLHQH3LqznH+bbxsL03I8CCKw6nfJS4uQ=;
        b=Y15DlkIVEVP2bH0jwE1zOcW4+y198je8B7CVaTcRrvAZopHX7uAUcHtOFQTlzJugVQ
         R0thW824goDPzvLys4PAo1iAT906NkCSvCFLwbUngh29we8ytqqS6waU2Qk8QY5GDd1I
         xxyLSH9ipGC30C9cFawKbhzeSz17L4K3/3HQA/OD/Sp+TNI9sNoCP1dGjVRqcTKubii6
         dI/mPrZV1c0S+fBi3a0pWixu2PU0s05V5R2+XyPPsO9SILAW4xwt8jwPfO1HXyKeXIRx
         mtbRt3aEapeektyfzHJM2/HjXNDBOUArrpdr3WsacoGCnVjlE66QLhD9T9ngIQ+ZyZys
         G6fg==
X-Gm-Message-State: AOAM530HT1GiDlhz5s4MKGZ0hLLt8c9/LpT7684ARh1g7nTtnQGnMSO2
        7+j+yTdnRZ/4QpNsHB0uJVWATuJ9y8dyPqrh3lE=
X-Google-Smtp-Source: ABdhPJxkKaaqmP1yD5KkT1WDGPhrs4U093UJFle+O8eEAxczRSvS3cNUQHrli4Wg3ThB1a7h6iPIJY6gFYSC+ira9KQ=
X-Received: by 2002:a05:6e02:1ba8:: with SMTP id n8mr21448557ili.254.1638549072984;
 Fri, 03 Dec 2021 08:31:12 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com> <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
 <Yao51m9EXszPsxNN@redhat.com>
In-Reply-To: <Yao51m9EXszPsxNN@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 3 Dec 2021 18:31:01 +0200
Message-ID: <CAOQ4uxjk4piLyx67Ena-FfypDVWzRqVN0xmFUXXPYa+SC4Q-vQ@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, Luca.Boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 3, 2021 at 5:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Nov 17, 2021 at 09:36:42AM +0200, Amir Goldstein wrote:
> > On Wed, Nov 17, 2021 at 3:58 AM David Anderson <dvander@google.com> wrote:
> > >
> > > Mark Salyzyn (3):
> > >   Add flags option to get xattr method paired to __vfs_getxattr
> > >   overlayfs: handle XATTR_NOSECURITY flag for get xattr method
> > >   overlayfs: override_creds=off option bypass creator_cred
> > >
> > > Mark Salyzyn + John Stultz (1):
> > >   overlayfs: inode_owner_or_capable called during execv
> > >
> > > The first three patches address fundamental security issues that should
> > > be solved regardless of the override_creds=off feature.
> > >
> > > The fourth adds the feature depends on these other fixes.
> > >
> > > By default, all access to the upper, lower and work directories is the
> > > recorded mounter's MAC and DAC credentials.  The incoming accesses are
> > > checked against the caller's credentials.
> > >
> > > If the principles of least privilege are applied for sepolicy, the
> > > mounter's credentials might not overlap the credentials of the caller's
> > > when accessing the overlayfs filesystem.  For example, a file that a
> > > lower DAC privileged caller can execute, is MAC denied to the
> > > generally higher DAC privileged mounter, to prevent an attack vector.
> > >
> > > We add the option to turn off override_creds in the mount options; all
> > > subsequent operations after mount on the filesystem will be only the
> > > caller's credentials.  The module boolean parameter and mount option
> > > override_creds is also added as a presence check for this "feature",
> > > existence of /sys/module/overlay/parameters/overlay_creds
> > >
> > > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > > Signed-off-by: David Anderson <dvander@google.com>
> > > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > > Cc: John Stultz <john.stultz@linaro.org>
> > > Cc: linux-doc@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-unionfs@vger.kernel.org
> > > Cc: linux-security-module@vger.kernel.org
> > > Cc: kernel-team@android.com
> > > Cc: selinux@vger.kernel.org
> > > Cc: paulmoore@microsoft.com
> > > Cc: Luca.Boccassi@microsoft.com
> > >
> > > ---
> > >
> > > v19
> > > - rebase.
> > >
> >
> > Hi David,
> >
> > I see that the patch set has changed hands (presumably to Android upstreaming
> > team), but you just rebased v18 without addressing the maintainers concerns [1].
> >
>
> BTW, where is patch 1 of the series. I can't seem to find it.
>
> I think I was running into issues with getxattr() on underlying filesystem
> as well (if mounter did not have sufficient privileges) and tried to fix
> it. But did not find a good solution at that point of time.
>
> https://lore.kernel.org/linux-unionfs/1467733854-6314-6-git-send-email-vgoyal@redhat.com/
>
> So basically when overlay inode is being initialized, code will try to
> query "security.selinux" xattr on underlying file to initialize selinux
> label on the overlay inode. For regular filesystems, they bypass the
> security check by calling __vfs_getxattr() when trying to initialize
> this selinux security label. But with layered filesystem, it still
> ends up calling vfs_getxattr() on underlying filesyste. Which means
> it checks for caller's creds and if caller is not priviliged enough,
> access will be denied.
>
> To solve this problem, looks like this patch set is passing a flag
> XATTR_NOSECUROTY so that permission checks are skipped in getxattr()
> path in underlying filesystem. As long as this information is
> not leaked to user space (and remains in overlayfs), it probably is
> fine? And if information is not going to user space, then it probably
> is fine for unprivileged overlayfs mounts as well?
>
> I see a comment from Miklos as well as you that it is not safe to
> do for unprivileged mounts. Can you help me understand why that's
> the case.
>
>
> > Specifically, the patch 2/4 is very wrong for unprivileged mount and
>
> Can you help me understand why it is wrong. (/me should spend more
> time reading the patch. But I am taking easy route of asking you. :-)).
>

I should have spent more time reading the patch too :-)
I was not referring to the selinux part. That looks fine I guess.

I was referring to the part of:
"Check impure, opaque, origin & meta xattr with no sepolicy audit
(using __vfs_getxattr) since these operations are internal to
overlayfs operations and do not disclose any data."
I don't know how safe that really is to ignore the security checks
for reading trusted xattr and allow non-privileged mounts to do that.
Certainly since non privileged mounts are likely to use userxattr
anyway, so what's the reason to bypass security?

> > I think that the very noisy patch 1/4 could be completely avoided:
>
> How can it completely avoided. If mounter is not privileged then
> vfs_getxattr() on underlying filesystem will fail. Or if
> override_creds=off, then caller might not be privileged enough to
> do getxattr() but we still should be able to initialize overlay
> inode security label.
>

My bad. I didn't read the description of the selinux problem
with the re-post and forgot about it.

> > Can't you use -o userxattr mount option
>
> user xattrs done't work for device nodes and symlinks.
>
> BTW, how will userxattr solve the problem completely. It can be used
> to store overlay specific xattrs but accessing security xattrs on
> underlying filesystem will still be a problem?

It cannot.
As long as the patch sticks with passing through the
getxattr flags, it looks fine to me.
passing security for trusted.overlay seems dodgy.

Thanks,
Amir.
