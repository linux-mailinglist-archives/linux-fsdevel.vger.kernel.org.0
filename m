Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA9838C6A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhEUMjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhEUMjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 08:39:01 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0D6C061763
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 05:37:37 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id o192so10258829vsd.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njboqj4vUiFzE7pfQXxgggntztlAq5fmF71S0Jmw2oQ=;
        b=o2FmGmPxL+Xvpp+r18WUv09psrrIut/NYqQB3YFjQL9E1TT7mh4pdsVVPwqQH7Y/Ab
         TMX+iuBpk+EWuIfSLMZvI4p3HBhgtvfuaQLE74dfPsLbnmj4GNNtFILQq4xonXECs2Xg
         luwBtWTPdmJTlDepwYV6YfzlXhHdnCg+CG5mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njboqj4vUiFzE7pfQXxgggntztlAq5fmF71S0Jmw2oQ=;
        b=WfKlPYg7GTgfsmRrXev3Wec33rhCOFY10SvJ4u65vMyzNRkIfCOofHJ5I5+hAL3p0/
         +7/53QkMS+VEztDWHx+OFsaOJr6dtqBlbUAKve6nIG0pMKfjUdDmvHQpsJpJa+V36dJi
         hu6ws+g3jm3xOOIGJECG9KNm1K4HOxQNsWDX6oZgEAsa0gs4RPtOCvYzNYE1tpCko4Fk
         Lpc1GAKG9uK43KklLk71eznjvtmLVIaT58vzH+NHH0UUY0iJdCSCKpCEkLXOlBx/UE/2
         TPCj0tu2xeToNl8v4zct3xVE1ONSqxlaSiWmZa6A8elaB17YJ2l7XyLslap8kCFKjX2E
         cZLg==
X-Gm-Message-State: AOAM532nHXMuJT6BDdobuXk0tIZ6T5wOBHuWGCW/i5qSyoLDcPTZJwD6
        l9GZOPzJK8RmMJKrTaLhzYp17CWkswuvDuLdh8BlXg==
X-Google-Smtp-Source: ABdhPJyas05tLLIDBA3UJ9G3HlWZ9Viz/tUcF4iiOb4gQdzkbues8ByWakkKXBysdgZ9B4lVGBn673e1F17hVqL4zW0=
X-Received: by 2002:a67:ebcd:: with SMTP id y13mr10057804vso.9.1621600656516;
 Fri, 21 May 2021 05:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154654.1791183-1-groug@kaod.org> <20210520154654.1791183-5-groug@kaod.org>
 <CAJfpegugQM-ChaGiLyfPkbFr9c=_BiOBQkJTeEz5yN0ujO_O4A@mail.gmail.com>
 <20210521103921.153a243d@bahia.lan> <CAJfpegsNBCX+2k4S_yqdTS15TTu=pbiRgw6SbvdVYoUSmGboGA@mail.gmail.com>
 <20210521120616.49d52565@bahia.lan>
In-Reply-To: <20210521120616.49d52565@bahia.lan>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 May 2021 14:37:25 +0200
Message-ID: <CAJfpegvBB-zRuZAM0m7fxMFCfw=CzN3uT3CqoQrRgizaTH4sOw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] virtiofs: Skip submounts in sget_fc()
To:     Greg Kurz <groug@kaod.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 May 2021 at 12:06, Greg Kurz <groug@kaod.org> wrote:
>
> On Fri, 21 May 2021 10:50:34 +0200
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > On Fri, 21 May 2021 at 10:39, Greg Kurz <groug@kaod.org> wrote:
> > >
> > > On Fri, 21 May 2021 10:26:27 +0200
> > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > > On Thu, 20 May 2021 at 17:47, Greg Kurz <groug@kaod.org> wrote:
> > > > >
> > > > > All submounts share the same virtio-fs device instance as the root
> > > > > mount. If the same virtiofs filesystem is mounted again, sget_fc()
> > > > > is likely to pick up any of these submounts and reuse it instead of
> > > > > the root mount.
> > > > >
> > > > > On the server side:
> > > > >
> > > > > # mkdir ${some_dir}
> > > > > # mkdir ${some_dir}/mnt1
> > > > > # mount -t tmpfs none ${some_dir}/mnt1
> > > > > # touch ${some_dir}/mnt1/THIS_IS_MNT1
> > > > > # mkdir ${some_dir}/mnt2
> > > > > # mount -t tmpfs none ${some_dir}/mnt2
> > > > > # touch ${some_dir}/mnt2/THIS_IS_MNT2
> > > > >
> > > > > On the client side:
> > > > >
> > > > > # mkdir /mnt/virtiofs1
> > > > > # mount -t virtiofs myfs /mnt/virtiofs1
> > > > > # ls /mnt/virtiofs1
> > > > > mnt1 mnt2
> > > > > # grep virtiofs /proc/mounts
> > > > > myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
> > > > > none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
> > > > > none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
> > > > >
> > > > > And now remount it again:
> > > > >
> > > > > # mount -t virtiofs myfs /mnt/virtiofs2
> > > > > # grep virtiofs /proc/mounts
> > > > > myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
> > > > > none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
> > > > > none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
> > > > > myfs /mnt/virtiofs2 virtiofs rw,seclabel,relatime 0 0
> > > > > # ls /mnt/virtiofs2
> > > > > THIS_IS_MNT2
> > > > >
> > > > > Submount mnt2 was picked-up instead of the root mount.
> > > >
> > >
> > > > Why is this a problem?
> > > >
> > >
> > > It seems very weird to mount the same filesystem again
> > > and to end up in one of its submounts. We should have:
> > >
> > > # ls /mnt/virtiofs2
> > > mnt1 mnt2
> >
> > Okay, sorry, I understand the problem.  The solution is wrong,
> > however: the position of the submount on that list is no indication
> > that it's the right one (it's possible that the root sb will go away
> > and only a sub-sb will remain).
> >
>
> Ah... I had myself convinced this could not happen, i.e. you can't
> unmount a parent sb with a sub-sb still mounted.

No, but it's possible for sub-sb to continue existing after it's no
longer a submount of original mount.
>
> How can this happen ?

E.g. move the submount out of the way, then unmount the parent, or
detach submount (umount -l) while keeping something open in there and
umount the parent.

> > Even just setting a flag in the root, indicating that it's the root
> > isn't fully going to solve the problem.
> >
> > Here's issue in full:
> >
> > case 1:  no connection for "myfs" exists
> >     - need to create fuse_conn, sb
> >
> > case 2: connection for "myfs" exists but only sb for submount
>
> How would we know this sb isn't a root sb ?
>
> >     - only create sb for root, reuse fuse_conn
> >
> > case 3: connection for "myfs" as well as root sb exists
> >    - reuse sb
> >
> > I'll think about how to fix this properly, it's probably going to be
> > rather more involved...
> >
>
> Sure. BTW I'm wondering why we never reuse sbs for submounts ?

Right, same general issue.

An sb can be identified by its root nodeid, so I guess the proper fix
to make the root nodeid be the key for virtio_fs_test_super().

Thanks,
Miklos
