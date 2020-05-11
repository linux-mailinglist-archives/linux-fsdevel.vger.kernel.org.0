Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0E1CD9B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 14:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgEKM0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729957AbgEKM0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 08:26:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BC9C05BD09
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 05:26:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l3so7750740edq.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EN8bcyFVSWdG2LyezQQ8oCrjUutuFeHxXpmjXGuS0M=;
        b=TocUd7QBMuxELeVQIclwEwhNwZ51aFXx4DeH5YgrrumzZciDVWnPvzltX/S1ugv1ii
         5E0iZOqOZgwgYeazNVKnAscq1Gf0jJaYh7zXejxjfmsLdTBq4ann9CBZ0Zp+Et1gnOx6
         csGJZAegn3dXfqJgRVFCHUXWbN4lRvZ4bmgmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EN8bcyFVSWdG2LyezQQ8oCrjUutuFeHxXpmjXGuS0M=;
        b=pS8zPLVSqrGYKs9hrch8yJsfNccClEp4fR+u/asqALOHRKOUlvivbf4P2hnuuCubuc
         8Gqo/HCHEPyylDSwPlAD2vS3HmCEUvT6hiuBl5c/y30SmheGACj7egTIcXyjb888sQpP
         rU4HSuFo60Afs8Lr4Xu2pzfMBM0k7uQduB2m43BsXAbPmLl1oiv+mQPPgVbK3rs/RFxg
         jrUZELNAHjVmpSg86MPfVDDxMdK9guMUjTSLFPhnzK7eem4G88grTMG/7glmomF6i9AJ
         b1yfyB/fx+6Rj7FhfWDt525O4PFeu72XKL6fqK9hlZRes0+IGsjs1X2vBexS2XVm2cnj
         z4uA==
X-Gm-Message-State: AGi0PubzpoqiZQNtu6Kob7WTArS5Txtqe8hZk4quNje2+Sch8KFXykkn
        xdAH/yCUiuYOYCGgiRfpDVaoYKb4nwlyImYj5VSXPBnQH14=
X-Google-Smtp-Source: APiQypI0RnkmhdnNNKq94iFMEVCCm1LcUFOTW66OOLC6+dFFohZ56vzj/6GxcQ/jT8FOFcqF+Rlp5uYkhgYIYqDhLNo=
X-Received: by 2002:aa7:cdd9:: with SMTP id h25mr13644594edw.17.1589199964897;
 Mon, 11 May 2020 05:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <1585733475-5222-1-git-send-email-chakragithub@gmail.com>
 <CAJfpegtk=pbLgBzM92tRq8UMUh+vxcDcwLL77iAcv=Mxw3r4Lw@mail.gmail.com>
 <CAH7=fosGV3AOcU9tG0AK3EJ2yTXZL3KGfsuVUA5gMBjC4Nn-WQ@mail.gmail.com>
 <CAH7=fosz9KDSBN86+7OxYTLJWUSdUSkeLZR5Y0YyM6=GE0BdOw@mail.gmail.com>
 <CAJfpegvWBHootLiE_zsw35G6Ee387V=Da_wCzaV9NhZQVDKYGg@mail.gmail.com> <CAH7=fosn3fnNBkKzHNBSvoQh+Gjpi2J0mZ3rRENitMmFmpHcUw@mail.gmail.com>
In-Reply-To: <CAH7=fosn3fnNBkKzHNBSvoQh+Gjpi2J0mZ3rRENitMmFmpHcUw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 11 May 2020 14:25:53 +0200
Message-ID: <CAJfpegu4BzWybuBH=-ojqZ5Qfw4+0Lv+yqbTrerw3+tb=qghWw@mail.gmail.com>
Subject: Re: [PATCH] fuse:rely on fuse_perm for exec when no mode bits set
To:     Chakra Divi <chakragithub@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 8, 2020 at 12:14 PM Chakra Divi <chakragithub@gmail.com> wrote:
>
> On Tue, Apr 28, 2020 at 1:51 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Apr 27, 2020 at 3:46 PM Chakra Divi <chakragithub@gmail.com> wrote:
> > >
> > > On Tue, Apr 21, 2020 at 4:21 PM Chakra Divi <chakragithub@gmail.com> wrote:
> > > >
> > > > On Mon, Apr 20, 2020 at 4:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > On Wed, Apr 1, 2020 at 11:31 AM Chakra Divi <chakragithub@gmail.com> wrote:
> > > > > >
> > > > > > In current code, for exec we are checking mode bits
> > > > > > for x bit set even though the fuse_perm_getattr returns
> > > > > > success. Changes in this patch avoids mode bit explicit
> > > > > > check, leaves the exec checking to fuse file system
> > > > > > in uspace.
> > > > >
> > > > > Why is this needed?
> > > >
> > > > Thanks for responding Miklos. We have an use case with our remote file
> > > > system mounted on fuse , where permissions checks will happen remotely
> > > > without the need of mode bits. In case of read, write it worked
> > > > without issues. But for executable files, we found that fuse kernel is
> > > > explicitly checking 'x' mode bit set on the file. We want this
> > > > checking also to be pushed to remote instead of kernel doing it - so
> > > > modified the kernel code to send getattr op to usespace in exec case
> > > > too.
> > >
> > > Any help on this Miklos....
> >
> > I still don't understand what you are requesting.  What your patch
> > does is unconditionally allow execution, even without any 'x' bits in
> > the mode.  What does that achieve?
>
> Thanks for the help Miklos. We have a network based filesystem that
> supports acls.
> As our filesystem give granular access, we wipe out the mode bits and
> completely rely on ACLs.

Are you using POSIX ACLs?   Why can't you translate the ACL's back
into mode bits (that's what all filesystems do)?

>
> Fuse works well for all other ops (with default_permissions disabled )
>  as all the checks are done at the filesystems.
> But only executables have problems because fuse kernel rejects the
> execution by doing access checks on mode bit.
> To push this check to filesystem, in the above patch - i'm relying on
> return value from fuse_perm_getattr() ignoring the mode bits.
>
> When the fuse module is asked to rely on filesystem for access checks,
> why do we need this explicit check for executables?

Because there's no other check.  Have you noticed that with your patch
*all* files become executable?  I guess that's not what you wanted...

Thanks,
Miklos
