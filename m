Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD1838C246
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhEUIwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhEUIwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:52:23 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE32DC061763
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 01:50:45 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id s15so9980919vsi.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFPnGBBo9uPK7q1bx3/OHNBziL1VS1FaR/jW/45G8No=;
        b=Zk2iAnAYEgvulBteJzqiLG+YcF0Ge6ONYvZ2Cwv9EegLGu04xZ46iosv1yP+M/Cwo1
         gDqkELTiUclVGOOcOD5+zDlFcEvVuobHjKQetErpTDXYmOrE9yyPHTnsmet7bty32vgX
         vD4peK29KWDUju0YLfeYstIJQiIln2ZJvkO0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFPnGBBo9uPK7q1bx3/OHNBziL1VS1FaR/jW/45G8No=;
        b=eT3p6ZuvwyBJ0JOj9UWjd6l3DH6IPM/dikGl1EPx3+BXrBSvm8HJFGxgLOHJ3fODSM
         HZC7+wHSqUE7rBJoSD19xEer9BccOMOkQp8otPkevJVBksJ6c7n2YFijH+P8H/0Bsikx
         n0MO4Q8601bRVII0QhufpnnwN0BpGbGBhUj7PrdhRXINLfVT2WGweKlReGp9dUd6p/NS
         GGhBMnNTD5j+/X4RoLQqwWCi0gwPo4ojKNsvpc7T7s45jgrgSPWj/Ddt89HCwlsYNKFl
         lSjA9sGvQK8qBu703on40d2m+2BM8xBxLpJByVmEjk2qiM4qL9O+WUwDGTrFalTH8sld
         sloQ==
X-Gm-Message-State: AOAM531E1T3tbkjubmDtkDus9aT10GpKjfuOH7YurCS5e8n/iKNUOQlx
        Ma5y2q9xf81XB6krBkZcegdLNHq2+6puETSgIf4OGQ==
X-Google-Smtp-Source: ABdhPJzP8cEKt6HEzMuSAdCnzlwE1Q7BGhy6FcshRLFe8hP1JWwWgnnZk9hiwMntEVdIPB7+uiVNg8pi50V7JB0yuDw=
X-Received: by 2002:a05:6102:3239:: with SMTP id x25mr8079662vsf.47.1621587044884;
 Fri, 21 May 2021 01:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154654.1791183-1-groug@kaod.org> <20210520154654.1791183-5-groug@kaod.org>
 <CAJfpegugQM-ChaGiLyfPkbFr9c=_BiOBQkJTeEz5yN0ujO_O4A@mail.gmail.com> <20210521103921.153a243d@bahia.lan>
In-Reply-To: <20210521103921.153a243d@bahia.lan>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 May 2021 10:50:34 +0200
Message-ID: <CAJfpegsNBCX+2k4S_yqdTS15TTu=pbiRgw6SbvdVYoUSmGboGA@mail.gmail.com>
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

On Fri, 21 May 2021 at 10:39, Greg Kurz <groug@kaod.org> wrote:
>
> On Fri, 21 May 2021 10:26:27 +0200
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > On Thu, 20 May 2021 at 17:47, Greg Kurz <groug@kaod.org> wrote:
> > >
> > > All submounts share the same virtio-fs device instance as the root
> > > mount. If the same virtiofs filesystem is mounted again, sget_fc()
> > > is likely to pick up any of these submounts and reuse it instead of
> > > the root mount.
> > >
> > > On the server side:
> > >
> > > # mkdir ${some_dir}
> > > # mkdir ${some_dir}/mnt1
> > > # mount -t tmpfs none ${some_dir}/mnt1
> > > # touch ${some_dir}/mnt1/THIS_IS_MNT1
> > > # mkdir ${some_dir}/mnt2
> > > # mount -t tmpfs none ${some_dir}/mnt2
> > > # touch ${some_dir}/mnt2/THIS_IS_MNT2
> > >
> > > On the client side:
> > >
> > > # mkdir /mnt/virtiofs1
> > > # mount -t virtiofs myfs /mnt/virtiofs1
> > > # ls /mnt/virtiofs1
> > > mnt1 mnt2
> > > # grep virtiofs /proc/mounts
> > > myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
> > > none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
> > > none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
> > >
> > > And now remount it again:
> > >
> > > # mount -t virtiofs myfs /mnt/virtiofs2
> > > # grep virtiofs /proc/mounts
> > > myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
> > > none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
> > > none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
> > > myfs /mnt/virtiofs2 virtiofs rw,seclabel,relatime 0 0
> > > # ls /mnt/virtiofs2
> > > THIS_IS_MNT2
> > >
> > > Submount mnt2 was picked-up instead of the root mount.
> >
>
> > Why is this a problem?
> >
>
> It seems very weird to mount the same filesystem again
> and to end up in one of its submounts. We should have:
>
> # ls /mnt/virtiofs2
> mnt1 mnt2

Okay, sorry, I understand the problem.  The solution is wrong,
however: the position of the submount on that list is no indication
that it's the right one (it's possible that the root sb will go away
and only a sub-sb will remain).

Even just setting a flag in the root, indicating that it's the root
isn't fully going to solve the problem.

Here's issue in full:

case 1:  no connection for "myfs" exists
    - need to create fuse_conn, sb

case 2: connection for "myfs" exists but only sb for submount
    - only create sb for root, reuse fuse_conn

case 3: connection for "myfs" as well as root sb exists
   - reuse sb

I'll think about how to fix this properly, it's probably going to be
rather more involved...

Thanks,
Miklos
