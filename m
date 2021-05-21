Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A870038C1B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhEUIZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhEUIZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:25:22 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB0DC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 01:23:59 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id c6so5867628uat.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2Yr50BYJU/SZ0Vl8VXunqJwvs9CbxD4iLGD7Ur9faE=;
        b=oYxq7lybSyekzx5UKNcYJQmHIzn5CtgBTPN8lrpzcb5zWZ0SnQeuIYxp56u/5DPupU
         EuaXc/H+qQETT5Z8crVwhjTbt20vCWbLWNTW/tTMiUfxPI1fiHYaoJzXvdzJ5fOxlP8m
         8RWhkrwEIlfB+TcgNGR+6cj9wV6l2OiKJBKos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2Yr50BYJU/SZ0Vl8VXunqJwvs9CbxD4iLGD7Ur9faE=;
        b=e8d1bfMOV8NUffKRKjs8bdQV+mcls2eJwAtICvKe0jHa6uipoajzHBqYu9UHKGBRkn
         V6VWGRAdhu+MWCf6DbtwdZpt9X70MTeW3b59qkmqZnnvqGZXXNVjMayHLG63o2Lebj+I
         FzgjthhwVicuAQC1cLkuN1eWFg8q+DBM6bNLy1ioE7UK9zTwbJshZDzK6ye61jZ1+0c0
         V5Jf1LtZMJigSttAkFVYoC0R6oZT/2lPif3cyLulwnIBTR24Y1yfJCkzCV2trj0rjEdz
         ws5PhzDGM1iu6JO6oIw6WV/6UbPJ5i0dCS9PyH+RXmuuVT3gv+VDfhhetXfakMgrd5h0
         XTCA==
X-Gm-Message-State: AOAM5324Ejq4+jUDtncF7619sVDoq1ZHQsCUwKhVM10SO8w/cYQZnJUi
        nuc9blYS+Zx+czT3eIW7iGTfMBFWzfVu078JkcMLKg==
X-Google-Smtp-Source: ABdhPJzG3Kds4iA86PMJ9Guob8EEfcQ6yIocoDa8h42Of1c3IqeZ7+jjIj681zBzrv1pMSCio+Dk1zfQ96NWNsCehPM=
X-Received: by 2002:ab0:596f:: with SMTP id o44mr9157215uad.8.1621585438503;
 Fri, 21 May 2021 01:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154654.1791183-1-groug@kaod.org> <20210520154654.1791183-2-groug@kaod.org>
 <YKa8SZ8s6QeKZ4XP@zeniv-ca.linux.org.uk> <CAJfpegvFUasy_8djyvo-fpyboOLGwRV9k_CL-e1nqxcXHkvzOg@mail.gmail.com>
 <20210521101523.4f276dac@bahia.lan>
In-Reply-To: <20210521101523.4f276dac@bahia.lan>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 May 2021 10:23:47 +0200
Message-ID: <CAJfpegt8JS-9LsRhmw9W2VMNG+tc+gGNsSwy1ULLoSFeYpHueA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] fuse: Fix leak in fuse_dentry_automount() error path
To:     Greg Kurz <groug@kaod.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 May 2021 at 10:15, Greg Kurz <groug@kaod.org> wrote:
>
> On Fri, 21 May 2021 09:54:19 +0200
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > On Thu, 20 May 2021 at 21:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Thu, May 20, 2021 at 05:46:50PM +0200, Greg Kurz wrote:
> > > > Some rollback was forgotten during the addition of crossmounts.
> > >
> > > Have you actually tested that?  Because I strongly suspect that
> > > by that point the ownership of fc and fm is with sb and those
> > > should be taken care of by deactivate_locked_super().
> >
> > Not quite.  Patch looks correct because destruction of fm is done in
> > fuse_put_super(), which only gets called if the sb initialization gets
> > as far as setting up sb->s_root, which only happens after the
> > successful fuse_fill_super_submount() call in this case.
> >
> > Doing the destruction from the various ->kill_sb() instances instead
> > of from ->put_super() would also fix this, but I'm not quite sure that
> > that would be any cleaner.
> >
>
> As saying in the answer I've just posted, a failure in
> fuse_fill_super_submount() causes an actual crash because
> fuse_mount_remove() logically assumes fm to already be in
> fc->mounts, which isn't the case at this point.
>
> In the root mount case, this is handled by taking back
> the ownership on fm, i.e. do the rollback *and* clear
> sb->s_fs_info. It seems that the same should be done
> for submounts.

Agreed.  Thanks for verifying.

Miklos
