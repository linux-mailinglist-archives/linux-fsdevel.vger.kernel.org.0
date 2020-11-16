Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0AF2B4904
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgKPPUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgKPPUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:20:17 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67D9C0613CF;
        Mon, 16 Nov 2020 07:20:15 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n12so17787710ioc.2;
        Mon, 16 Nov 2020 07:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3t8dmHQbg6M9c96IOfR4d8Xv5JQ5QzjwGRoLSUkYgE=;
        b=Yb9rOdS+zSUMfC6GJty55YJFizjcQQB9gkqKiASyCVWI5bRbKBoV4x/3I+ebFASWWD
         b+7w1hbeGTyl3VYpiu4IvN1AXjpRzJfOSJI5uDH0g5FdYBp4/zps4zyizBU+78mKb8ML
         g+S7IzKy/RsmmYf76jc9Q8D0s2X6Jg/MPtc5mPsPcSUIXLxLR0XcobiVRRwMF5PzvokL
         g0Fc8jX8Age1vVM75zHx7n/AUiN0kg6zjFyz7Mwqxz0EKyltH1m7Ozs0D0hl/dTgpCve
         kObs7rRPcpfOuQX9J9/tqJ5S/KehmxepfewUzcNs2K+tBK1oWpYH+iZ0Er7L0eod3zjG
         JoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3t8dmHQbg6M9c96IOfR4d8Xv5JQ5QzjwGRoLSUkYgE=;
        b=h5lVtmzFqagqFtVGFCvj6x7o9oa7yTAvGGF4JNem3+PpxhVEmEYSpGbn3JUH2U61qQ
         w3H5C4E1c4+w13w9QAEN+SxBphaY1vx0gx/ZaZsADG5u+KZ2OAfNP7Y5uWOjwA9zXl1S
         0vTa7rHWG/Sfsr1jvNJb063QlilsGxQUeOxhrJ9oWGuMcg0LeXRwfC2xDSpezYTMbLZA
         6+rohT9+4oUgl3cEZu3ZITVjjKLZ4xcbMBZv5EG2mLjjaQbSXzU4EjVL8XDzwHn5RTTc
         axOyReTzkwf9ztU0k3QMJPP1bKfV0XpGR+kHgoU7lIc2fh6pYASnlqzDar5raUd96wE2
         sBIQ==
X-Gm-Message-State: AOAM530B3jFapcJlQKTJ2oHeO7r7TkDzBtVcd/wdsXTnrkbuJquYHQId
        0lAxwnmWC4ZM+xwQhICTaezAuEulT6P85+aOLa8=
X-Google-Smtp-Source: ABdhPJwjG0SICGGvsQ3u7IsuiUv/PVmoK6RbEOX+pyvOW913BTwUcn2Zg5xus+Escd/v0fejugDTs6xKzLCY6FVlytE=
X-Received: by 2002:a02:883:: with SMTP id 125mr1771jac.30.1605540015323; Mon,
 16 Nov 2020 07:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20201116045758.21774-1-sargun@sargun.me> <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com>
In-Reply-To: <20201116144240.GA9190@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Nov 2020 17:20:04 +0200
Message-ID: <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 4:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Sun, Nov 15, 2020 at 08:57:58PM -0800, Sargun Dhillon wrote:
> > Overlayfs added the ability to setup mounts where all syncs could be
> > short-circuted in (2a99ddacee43: ovl: provide a mount option "volatile").
> >
> > A user might want to remount this fs, but we do not let the user because
> > of the "incompat" detection feature. In the case of volatile, it is safe
> > to do something like[1]:
> >
> > $ sync -f /root/upperdir
> > $ rm -rf /root/workdir/incompat/volatile
> >
> > There are two ways to go about this. You can call sync on the underlying
> > filesystem, check the error code, and delete the dirty file if everything
> > is clean. If you're running lots of containers on the same filesystem, or
> > you want to avoid all unnecessary I/O, this may be suboptimal.
> >
>
> Hi Sargun,
>
> I had asked bunch of questions in previous mail thread to be more
> clear on your requirements but never got any response. It would
> have helped understanding your requirements better.
>
> How about following patch set which seems to sync only dirty inodes of
> upper belonging to a particular overlayfs instance.
>
> https://lore.kernel.org/linux-unionfs/20201113065555.147276-1-cgxu519@mykernel.net/
>
> So if could implement a mount option which ignores fsync but upon
> syncfs, only syncs dirty inodes of that overlayfs instance, it will
> make sure we are not syncing whole of the upper fs. And we could
> do this syncing on unmount of overlayfs and remove dirty file upon
> successful sync.
>
> Looks like this will be much simpler method and should be able to
> meet your requirements (As long as you are fine with syncing dirty
> upper inodes of this overlay instance on unmount).
>

Do note that the latest patch set by Chengguang not only syncs dirty
inodes of this overlay instance, but also waits for in-flight writeback on
all the upper fs inodes and I think that with !ovl_should_sync(ofs)
we will not re-dirty the ovl inodes and lose track of the list of dirty
inodes - maybe that can be fixed.

Also, I am not sure anymore that we can safely remove the dirty file after
sync dirty inodes sync_fs and umount. If someone did sync_fs before us
and consumed the error, we may have a copied up file in upper whose
data is not on disk, but when we sync_fs on unmount we won't get an
error? not sure.

I am less concerned about ways to allow re-mount of volatile
overlayfs than I am about turning volatile overlayfs into non-volatile.

Thanks,
Amir.
