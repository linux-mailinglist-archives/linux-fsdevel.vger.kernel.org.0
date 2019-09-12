Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB58DB09FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfILIOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 04:14:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35797 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfILIOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:14:23 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so51756679ion.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 01:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nq9/DS8ZAkk6yGZQDvDoemz16SUFh0W3pARCnI2rYv8=;
        b=gBPv97WiIsJNEVOZTmAMABWXLytZ3qsF9OH0lw2dMtOUnbzAKiFjSvrOlTQS5TXujp
         uZFGqRUDOklLF0o6zZGhThUZSYix/Bxtl+uwkOlA/z8ZBk116lonY4Ac0aUui9vi2J8y
         7HoPzNmr12yEuR940DWBrdXLk23333EirKTZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nq9/DS8ZAkk6yGZQDvDoemz16SUFh0W3pARCnI2rYv8=;
        b=L27ygUeI6jWPzYgZAmq0vhYZmG9rfJGC7rHoJYzIbZkRaqYDShIRP57JIDPKIiWDWM
         C37nmxzmUk3z5+Do9lnx8gAjV+OZj8uWjMNv6GzTgIXZHtWDYOzmYhQvzrTi6IIUuTZ+
         taymDOgRlCxmeZcu1HGjP9oYqXQYLTj3Lv4cq5NMa9e7R3JW+ny19rMQXt0ydr9JmklB
         HMRoiGWO8oXkpEWwA3Z3986nyXgfsQzjKGQcz7jTFh0iOI4Z9MiGimJ9JnOHIXGioEKd
         FGmIPgv2dOO9cDf6EcVMWhNLzWXWbRAX2wC8PEC1YKPrrbTkD7rDkTmg259pZRjPZ8Yv
         5txQ==
X-Gm-Message-State: APjAAAU6LJpIHIIwbWhvr841lSYKdoL/dviyg+iFludfOfMKLBovrezB
        lPmgMKuTnA5icBwgUlQaUgEnX7+F6MB2R4RmHWndwQ==
X-Google-Smtp-Source: APXvYqxxjlj3oUz8nkos6HZEeJYB3JDpAsf5iFlG4IbXXAq77CHvFWDCDXVCrCXMBAIgSySeNevqBWU+A/RnUx8wFrI=
X-Received: by 2002:a05:6602:21cb:: with SMTP id c11mr2851573ioc.25.1568276062494;
 Thu, 12 Sep 2019 01:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151206.4671-1-mszeredi@redhat.com> <20190911155208.GA20527@stefanha-x1.localdomain>
In-Reply-To: <20190911155208.GA20527@stefanha-x1.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 12 Sep 2019 10:14:11 +0200
Message-ID: <CAJfpegsorJKWoqRyThCfgLUyXiK7TLjSwmh5DqC8cytYRE4TLw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] virtio-fs: shared file system for virtual machines
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 5:54 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Sep 10, 2019 at 05:12:02PM +0200, Miklos Szeredi wrote:
> > I've folded the series from Vivek and fixed a couple of TODO comments
> > myself.  AFAICS two issues remain that need to be resolved in the short
> > term, one way or the other: freeze/restore and full virtqueue.
>
> I have researched freeze/restore and come to the conclusion that it
> needs to be a future feature.  It will probably come together with live
> migration support for reasons mentioned below.
>
> Most virtio devices have fairly simply power management freeze/restore
> functions that shut down the device and bring it back to the state held
> in memory, respectively.  virtio-fs, as well as virtio-9p and
> virtio-gpu, are different because they contain session state.  It is not
> easily possible to bring back the state held in memory after the device
> has been reset.
>
> The following areas of the FUSE protocol are stateful and need special
> attention:
>
>  * FUSE_INIT - this is pretty easy, we must re-negotiate the same
>    settings as before.
>
>  * FUSE_LOOKUP -> fuse_inode (inode_map)
>
>    The session contains a set of inode numbers that have been looked up
>    using FUSE_LOOKUP.  They are ephemeral in the current virtiofsd
>    implementation and vary across device reset.  Therefore we are unable
>    to restore the same inode numbers upon restore.
>
>    The solution is persistent inode numbers in virtiofsd.  This is also
>    needed to make open_by_handle_at(2) work and probably for live
>    migration.
>
>  * FUSE_OPEN -> fh (fd_map)
>
>    The session contains FUSE file handles for open files.  There is
>    currently no way of re-opening a file so that a specific fh is
>    returned.  A mechanism to do so probably isn't necessary if the
>    driver can update the fh to the new one produced by the device for
>    all open files instead.
>
>  * FUSE_OPENDIR -> fh (dirp_map)
>
>    Same story as for FUSE_OPEN but for open directories.
>
>  * FUSE_GETLK/SETLK/SETLKW -> (inode->posix_locks and fcntl(F_OFD_GET/SETLK))
>
>    The session contains file locks.  The driver must reacquire them upon
>    restore.  It's unclear what to do when locking fails.
>
> Live migration has the same problem since the FUSE session will be moved
> to a new virtio-fs device instance.  It makes sense to tackle both
> features together.  This is something that can be implemented in the
> next year, but it's not a quick fix.

Right.   The question for now is: should the freeze silently succeed
(as it seems to do now) or should it fail instead?

I guess normally freezing should be okay, as long as the virtiofsd
remains connected while the system is frozen.

I tried to test this with "echo -n mem > /sys/power/state", which
indeed resulted in the virtio_fs_freeze() callback being called.
However, I couldn't find a way to wake up the system...

Thanks,
Miklos
