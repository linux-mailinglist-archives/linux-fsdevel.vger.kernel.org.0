Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE443BA45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 21:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbhJZTH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 15:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhJZTHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:07:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DFCC061237;
        Tue, 26 Oct 2021 12:04:27 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f9so574756ioo.11;
        Tue, 26 Oct 2021 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epgv4bLCSWiNF0QcmAnrlx7DUUJfK4f2X6c0gIIsznU=;
        b=MU7D8hJtzvP31k/XhtvvRV7DYhSzcZuPP0ADtWsyuegOkQlG6lHXGNnZM7A7aEsA9j
         tjT/4khAInzChJcMUCM3z1L8Mu61dYKWL9kU0khMN7rzlDNC6W6NWRxCt5m740Bo0MPy
         Mnq9RVKh6sEHRqRdTqHW+jlh58eFdzgdeDjx6gZsHMl4rf9BVLJPN2hslBFKG1Dds42G
         51dMXNhlfiNZnkyiPkWxfAD2dLRiLIf6JJGJgyyr0bCtsEg9bjdsuHV+SKlgjbZQlGbt
         ALeYUFoq2lZiuEuGp7DK8q6X4nE6W1yTI95f5bopi9/rec+NFL4ZqmOZMm4YUI/iueM+
         3b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epgv4bLCSWiNF0QcmAnrlx7DUUJfK4f2X6c0gIIsznU=;
        b=SyS350Ky76VB4n4p274Z5lmnzN7UFVLDE0rb3+jottDLn5WEbmvl2OzLbFQZhA/wAh
         VTBHN3Qj9+y/HYatF/4uZkqDBv+Om+jV/o4vuzrhn5iAMokcsdvHuchJSiQFYVqhy9Op
         QhDfFpR/KZCpVR+Q1kOYziFru8D76A0g7UEaoq2z0/rF9/m7ik3uVr3sMwijimD5nAIX
         cIG7KUdP4PpPh0cOFYAP85G8DvDMZ4jdMXFsqwqyCndd1isE/OerBeMG+T+mr2yk9KGx
         mHCi2CZa16Ipdcg1mMqJKdnWfwue5PiDJb22kaCF3W5sOA7vajFDCa6VZsi9z+fc2Fgg
         s7bg==
X-Gm-Message-State: AOAM532hkIMV5QjmpmoMR+tGYUl7xIz/9B+FPWiRnhnZgZ69oAqcb2uv
        O7kNa+z/WlvNpgP6BGuGNOgrdNEhvEYE5Ot4UB0=
X-Google-Smtp-Source: ABdhPJx25Ggl45TCg2rwU3kFp1iBE/ARGjQ+s87LTmaANuGfIAJBFynMb5ve2pt2Cz7rIj9BkXFJi6NSO/M4GrED/uw=
X-Received: by 2002:a05:6602:26d2:: with SMTP id g18mr16099209ioo.70.1635275067074;
 Tue, 26 Oct 2021 12:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211025204634.2517-1-iangelak@redhat.com> <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
 <YXgqRb21hvYyI69D@redhat.com> <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
 <YXhIm3mOvPsueWab@redhat.com>
In-Reply-To: <YXhIm3mOvPsueWab@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 22:04:15 +0300
Message-ID: <CAOQ4uxiYDMXqj2UOVX0Mn5Vp-pSrRNrHn3pnb0UvRF+bcOnqpA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 9:27 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Oct 26, 2021 at 08:59:44PM +0300, Amir Goldstein wrote:
> > On Tue, Oct 26, 2021 at 7:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Tue, Oct 26, 2021 at 06:23:50PM +0300, Amir Goldstein wrote:
> > >
> > > [..]
> > > > > 3) The lifetime of the local watch in the guest kernel is very
> > > > > important. Specifically, there is a possibility that the guest does not
> > > > > receive remote events on time, if it removes its local watch on the
> > > > > target or deletes the inode (and thus the guest kernel removes the watch).
> > > > > In these cases the guest kernel removes the local watch before the
> > > > > remote events arrive from the host (virtiofsd) and as such the guest
> > > > > kernel drops all the remote events for the target inode (since the
> > > > > corresponding local watch does not exist anymore).
> > >
> > > So this is one of the issues which has been haunting us in virtiofs. If
> > > a file is removed, for local events, event is generated first and
> > > then watch is removed. But in case of remote filesystems, it is racy.
> > > It is possible that by the time event arrives, watch is already gone
> > > and application never sees the delete event.
> > >
> > > Not sure how to address this issue.
> >
>
> > Can you take me through the scenario step by step.
> > I am not sure I understand the exact sequence of the race.
>
> Ioannis, please correct me If I get something wrong. You know exact
> details much more than me.
>
> A. Say a guest process unlinks a file.
> B. Fuse sends an unlink request to server (virtiofsd)
> C. File is unlinked on host. Assume there are no other users so inode
>    will be freed as well. And event will be generated on host and watch
>    removed.
> D. Now Fuse server will send a unlink request reply. unlink notification
>    might still be in kernel buffers or still be in virtiofsd or could
>    be in virtiofs virtqueue.
> E. Fuse client will receive unlink reply and remove local watch.
>
> Fuse reply and notification event are now traveling in parallel on
> different virtqueues and there is no connection between these two. And
> it could very well happen that fuse reply comes first, gets processed
> first and local watch is removed. And notification is processed right
> after but by then local watch is gone and filesystem will be forced to
> drop event.
>
> As of now situation is more complicated in virtiofsd. We don't keep
> file handle open for file and keep an O_PATH fd open for each file.
> That means in step D above, inode on host is not freed yet and unlink
> event is not generated yet. When unlink reply reaches fuse client,
> it sends FORGET messages to server, and then server closes O_PATH fd
> and then host generates unlink events. By that time its too late,
> guest has already remove local watches (and triggered removal of
> remote watches too).
>
> This second problem probably can be solved by using file handles, but
> basic race will still continue to be there.
>
> > If it is local file removal that causes watch to be removed,
> > then don't drop local events and you are good to go.
> > Is it something else?
>
> - If remote events are enabled, then idea will be that user space gets
>   and event when file is actually removed from server, right? Now it
>   is possible that another VM has this file open and file has not been
>   yet removed. So local event only tells you that file has been removed
>   in guest VM (or locally) but does not tell anything about the state
>   of file on server. (It has been unlinked on server but inode continues
>   to be alive internall).
>
> - If user receives both local and remote delete event, it will be
>   confusing. I guess if we want to see both the events, then there
>   has to be some sort of info in event which classifies whether event
>   is local or remote. And let application act accordingly.
>

Maybe. Not sure this is the way to go.

There are several options to deal with this situation.
The thing is that applications cannot usually rely on getting
DELETE_SELF events for many different reasons that might
keep the inode reflink elevated also on local filesystems.

Perhaps the only way for FUSE (or any network) client to
know if object on server was really deleted is to issue a lookup
request to the file handle and when getting ESTALE.

It really sounds to me like DELETE_SELF should not be reported
at all for the first implementation.
It is very easy to deal with DELETE_SELF events scenario with
a filesystem watch, so bare that in mind as a possible application level
solution.

Thanks,
Amir.
