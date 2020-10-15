Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F388C28ECF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 08:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgJOGLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 02:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgJOGLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 02:11:16 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16173C061755;
        Wed, 14 Oct 2020 23:11:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l8so2844815ioh.11;
        Wed, 14 Oct 2020 23:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m+83sKGCgi/CRquW7LgTgKy86zFMSdndgLsWjeJAi5Y=;
        b=FqusjKdOWVJdY11YzoObI7InQXVwULrSgy0HcXS054ZZEi/qICjlbVbZ6rLag9naqe
         +EPFIJVAGyGxFuwiRJUXwLEp3OaLKgTBq1mMT7KA5dcV9PaUE4dalfGOnzeMtGW6KI7o
         1uv/xYWS+7lEUoIhcBYO0+XkwwqAEHsyPUKHBRCWoCYFKT8MM3tC1vxCCQXBjdrcDgqg
         KQW6Gav5ohQJW2HxT5EZm+Hj+9cH+NPcclld8rvVivKDQZTPRpnnFRfcT8xrISdSELxm
         GLWsNR8/nX8FsPlOKoB3B/8DBVThvzymW8uSdGTA9mNeZrcHafwSjnkmtGc9oh2P8wo2
         MLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m+83sKGCgi/CRquW7LgTgKy86zFMSdndgLsWjeJAi5Y=;
        b=Gn6nwTS7mUFoCJiqEMDHIJvvjPcXEB3sPeBTfoPhhkdwFdJ2PuIPyaSHgKr79eL8Zi
         8GrflRHTpMWDf/oSi/qwXmbSiQxQl50usAeQZzsDt/DfjG6kbJcotwH4evecmm8/T245
         3iLKR0oYWfXtl+Q+bh3+TIcXG9zDYdJRvNX7r4d9uPIm2LJj7qtVHnINyG0qatyWhpqX
         uQFbbakDbSvRIHJ49GTtmHBRC4kqwHX6nLH2sr7P5jxEKWxu/NVLJSxj4aFRiTqmAaeT
         p1Y0OYGm7UKFUvCAACNZ/Wq9l/xnL1SzH+u0Gqt3bpzT33rnxaHu4I5+Jb2fy0Az7CvZ
         TlmQ==
X-Gm-Message-State: AOAM531P+jIj3D4LFaI4ll1pmNgPCBobE4oCDDQfrMvH3mMLWSaMxWkn
        fjqy2ZFNWkRxeiD8yS/BhhSU5BQsFwI8MvCo/7lxcUvf
X-Google-Smtp-Source: ABdhPJwnjXYJzZ4j43C08yvgS3sqphlOEInXV2Q95Rff+Tv7cRzDvBb118pc6DWJlgstUDEF/Mrk4bF5TVOUIHimJmU=
X-Received: by 2002:a6b:1542:: with SMTP id 63mr2107222iov.64.1602742275365;
 Wed, 14 Oct 2020 23:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201010142355.741645-1-cgxu519@mykernel.net> <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201014161538.GA27613@quack2.suse.cz> <1752a360692.e4f6555543384.3080516622688985279@mykernel.net>
In-Reply-To: <1752a360692.e4f6555543384.3080516622688985279@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 15 Oct 2020 09:11:04 +0300
Message-ID: <CAOQ4uxhOrPfJxhJ1g7eSSdO4=giFJabCCOvJL7dSo1R9VsZozA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 6:03 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-10-15 00:15:38 Jan Kara=
 <jack@suse.cz> =E6=92=B0=E5=86=99 ----
>  > On Sat 10-10-20 22:23:51, Chengguang Xu wrote:
>  > > Currently there is no notification api for kernel about modification
>  > > of vfs inode, in some use cases like overlayfs, this kind of notific=
ation
>  > > will be very helpful to implement containerized syncfs functionality=
.
>  > > As the first attempt, we introduce marking inode dirty notification =
so that
>  > > overlay's inode could mark itself dirty as well and then only sync d=
irty
>  > > overlay inode while syncfs.
>  > >
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  >
>  > So I like how the patch set is elegant however growing struct inode fo=
r
>  > everybody by struct blocking_notifier_head (which is rwsem + pointer) =
is
>  > rather harsh just for this overlayfs functionality... Ideally this sho=
uld
>  > induce no overhead on struct inode if the filesystem is not covered by
>  > overlayfs. So I'd rather place some external structure into the superb=
lock
>  > that would get allocated on the first use that would track dirty notif=
ications
>  > for each inode. I would not generalize the code for more possible
>  > notifications at this point.
>  >
>  > Also now that I'm thinking about it can there be multiple overlayfs in=
odes
>  > for one upper inode? If not, then the mechanism of dirtiness propagati=
on
>
> One upper inode only belongs to one overlayfs inode. However, in practice
> one upper fs may contains hundreds or even thousands of overlayfs instanc=
es.
>
>  > could be much simpler - it seems we could be able to just lookup
>  > corresponding overlayfs inode based on upper inode and then mark it di=
rty
>  > (but this would need to be verified by people more familiar with
>  > overlayfs). So all we'd need to know for this is the superblock of the
>  > overlayfs that's covering given upper filesystem...
>  >
>
> So the difficulty is how we get overlayfs inode efficiently from upper in=
ode,
> it seems if we don't have additional info of upper inode to indicate whic=
h
> overlayfs it belongs to,  then the lookup of corresponding overlayfs inod=
e
> will be quite expensive and probably impact write performance.
>
> Is that possible we extend inotify infrastructure slightly to notify both
> user space and kernel component?
>
>

When I first saw your suggestion, that is what I was thinking.
Add event fsnotify_dirty_inode(), since the pub-sub infrastructure
in struct inode already exists.

But I have to admit this approach seems like a massive overkill to
what you need.

What you implemented, tracks upper inodes that could have
been dirtied under overlayfs, but what you really want is to
track is upper inodes that were dirtied *by* overlayfs.

And for that purpose, as Miklos said several times, it would be best
pursue the overlayfs aops approach, even though it may be much
harder..

Your earlier patches maintained a list of overlayfs to be synced inodes.
Remind me what was wrong with that approach?

Perhaps you can combine that with the shadow overlay sbi approach.
Instead of dirtying overlay inode when underlying is dirtied, you can
"pre-dirty" overlayfs inode in higher level file ops and add them to the
"maybe-dirty" list (e.g. after write).

ovl_sync_fs() can iterate the maybe-dirty list and re-dirty overlay inodes
if the underlying inode is still dirty on the (!wait) pass.

As for memory mapped inodes via overlayfs (which can be dirtied without
notifying overlayfs) I am not sure that is a big problem in practice.

When an inode is writably mapped via ovarlayfs, you can flag the
overlay inode with "maybe-writably-mapped" and then remove
it from the maybe dirty list when the underlying inode is not dirty
AND its i_writecount is 0 (checked on write_inode() and release()).

Actually, there is no reason to treat writably mapped inodes and
other dirty inodes differently - insert to suspect list on open for
write, remove from suspect list on last release() or write_inode()
when inode is no longer dirty and writable.

Did I miss anything?

Amir.
