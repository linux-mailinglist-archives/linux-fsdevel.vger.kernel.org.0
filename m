Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB6833F91D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 20:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhCQT0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 15:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhCQT0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:26:03 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F4C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 12:26:03 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id j19so1126136uax.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlA+jYln5RzDTCm9btKJym2tsVjc3VyPFKEv+xmMJFM=;
        b=H8odzmq1dNXM+w1tKOc1T3J2Y8jJOiLwVfPMoR11yBlAU2B6Vj2CwtJ1lkg1FYinxu
         DTQQsYLIOG2Cixb87RGUxhtOgGM+NytvEh+ZM9pFAyW+ivpjfsFaCOl86Zc6F0c+iXQo
         lJY6VGWv5jkB6WX/leh0J+VLzolNWC521jCQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlA+jYln5RzDTCm9btKJym2tsVjc3VyPFKEv+xmMJFM=;
        b=IxA/94iPp+vhLemsK1V7JnCUEomNMmOqAufWGfvHPR6MTpE0F7KYVk8CFJB8bW1gPg
         q5prGpaBD/S/M8u6be6o7qQ33kPiHBkrzyF9U6T7l001d/GXF2xHpegpWAmyo/hh8Ra+
         /D/bmCzksaQg1KiPs+vQP+d9uHM0h3cYJ7Q0vpvQE5SyLWvzve9da98srpapCT/dgLs3
         sOf83hWvXc0+HjyZmBVE2PUE+wz9aP/FeNtq0wJcxXjdr73F/pFHY6sz+aJuLkNmCK8O
         CcsPTyCAjkg7tjEuX+iusOOpPRS34rwQX34esKDVzHHfB8rhte/QQP95Mfxe2SvE7ipD
         sXUA==
X-Gm-Message-State: AOAM5317noDHgFC/s9BW0pUJJOTZIupz1mGl/v0fu/wRDHogclYm5NG0
        i+wFJaIYrMJXk3SWIUaOSncUJIZ1ueUcGLk31Wab2w==
X-Google-Smtp-Source: ABdhPJw+xzynAhKgXVBQl4Gg1T4BW030+Funl/EDMNShz+lXIYTxe7e/+K6+4Ys7rbWS8bHzqitY61E5hFB2rJk6YOM=
X-Received: by 2002:ab0:48ae:: with SMTP id x43mr492168uac.9.1616009162799;
 Wed, 17 Mar 2021 12:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210316160147.289193-1-vgoyal@redhat.com> <20210316160147.289193-2-vgoyal@redhat.com>
 <CAJfpegtD-6Xt3JDtoOtqJLXeDzVgjfaVJhHU8OQ8Lpw9tu2FzA@mail.gmail.com> <20210317170119.GE324911@redhat.com>
In-Reply-To: <20210317170119.GE324911@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Mar 2021 20:25:51 +0100
Message-ID: <CAJfpegvtYtfwsMCi38VjMGanarTStQNEnqveRUFhU1xCJ5EbUQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: send file mode updates using SETATTR
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Luis Henriques <lhenriques@suse.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 6:01 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Mar 17, 2021 at 04:43:35PM +0100, Miklos Szeredi wrote:
> > On Tue, Mar 16, 2021 at 5:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > If ACL changes, it is possible that file mode permission bits change. As of
> > > now fuse client relies on file server to make those changes. But it does
> > > not send enough information to server so that it can decide where SGID
> > > bit should be cleared or not. Server does not know if caller has CAP_FSETID
> > > or not. It also does not know what are caller's group memberships and if any
> > > of the groups match file owner group.
> >
> > Right.  So what about performing the capability and group membership
> > check in the client and sending the result of this check to the
> > server?
>
> Hi Miklos,
>
> But that will still be non-atomic, right? I mean server probably will
> do setxattr first, then check if SGID was cleared or not, and if it
> has not been cleared, then it needs to set the mode.
>
> IOW, we still have two operations (setxattr followed by mode setting).
>
> I had thought about that option. But could not understand what does
> it buy us as opposed to guest sending a SETATTR.

If the non-atomic SETXATTR + SETATTR is done in the client, then the
server has no chance of ever operating correctly.

If the responsibility for clearing sgid is in the server, then it's up
to the server to decide how to best deal with this.  That may be the
racy way, but at least it's not the only possibility.

Not sure if virtiofsd can do this atomically or not.
setgid()/setgroups() require CAP_SETGID, but that's relative to the
user namespace of the daemon, so this might be possible to do, I
haven't put a lot of thought into this.

Thanks,
Miklos
