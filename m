Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5535E43B626
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 17:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbhJZP4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 11:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234776AbhJZPzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635263611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rZVCulbOZP1e44gXfA1Bk5ibcEf1Vr4Agh3PF5t9yB4=;
        b=f4BnnMVH/lQFxK2OXqOXGvxTpzOVUOJR5ATBOdi002md6EjmPP0AaGSe7p6MsyjiGwYwNN
        9pqrPrcGY995HgQVEgP/lZJDyO+Gb/XPi8WgaOdf/Yaylm3GWjRn50u6J/iczDhxK0QUhm
        cLxnRTN9er8Af5OLRRfRR+AfawmlCmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-Wp-ws3TBNJG7ZKIx7jSHGQ-1; Tue, 26 Oct 2021 11:53:28 -0400
X-MC-Unique: Wp-ws3TBNJG7ZKIx7jSHGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07C8411295A1;
        Tue, 26 Oct 2021 15:52:47 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF6205C1A1;
        Tue, 26 Oct 2021 15:52:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 412072204A5; Tue, 26 Oct 2021 11:52:46 -0400 (EDT)
Date:   Tue, 26 Oct 2021 11:52:46 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <YXgkTirm5O04xEm5@redhat.com>
References: <20211025204634.2517-1-iangelak@redhat.com>
 <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 06:23:50PM +0300, Amir Goldstein wrote:
> On Mon, Oct 25, 2021 at 11:47 PM Ioannis Angelakopoulos
> <iangelak@redhat.com> wrote:
> >
> > Hello,
> >
> > I am a PhD student currently interning at Red Hat and working on the
> > virtiofs file system. I am trying to add support for the Inotify
> > notification subsystem in virtiofs. I seek your feedback and
> > suggestions on what is the right direction to take.
> >
> 
> Hi Ioannis!
> 
> I am very happy that you have taken on this task.
> People have been requesting this functionality in the past [1]
> Not specifically for FUSE, but FUSE is a very good place to start.
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAH2r5mt1Fy6hR+Rdig0sHsOS8fVQDsKf9HqZjvjORS3R-7=RFw@mail.gmail.com/

Hi Amir,

Aha, good to know that other remote filesystems are looking for similar
functionality. So there can be a common design so that other remote
filesystems can support remote inotify/fanotify events too.

> 
> > Currently, virtiofs does not support the Inotify API and there are
> > applications which look for the Inotify support in virtiofs (e.g., Kata
> > containers).
> >
> > However, all the event notification subsystems (Dnotify/Inotify/Fanotify)
> > are supported by only by local kernel file systems.
> >
> > --Proposed solution
> >
> > With this RFC patch we add the inotify support to the FUSE kernel module
> > so that the remote virtiofs file system (based on FUSE) used by a QEMU
> > guest VM can make use of this feature.
> >
> > Specifically, we enhance FUSE to add/modify/delete watches on the FUSE
> > server and also receive remote inotify events. To achieve this we modify
> > the fsnotify subsystem so that it calls specific hooks in FUSE when a
> > remote watch is added/modified/deleted and FUSE calls into fsnotify when
> > a remote event is received to send the event to user space.
> >
> > In our case the FUSE server is virtiofsd.
> >
> > We also considered an out of band approach for implementing the remote
> > notifications (e.g., FAM, Gamin), however this approach would break
> > applications that are already compatible with inotify, and thus would
> > require an update.
> >
> > These kernel patches depend on the patch series posted by Vivek Goyal:
> > https://lore.kernel.org/linux-fsdevel/20210930143850.1188628-1-vgoyal@redhat.com/
> 
> It would be a shame if remote fsnotify was not added as a generic
> capability to FUSE filesystems and not only virtiofs.
> Is there a way to get rid of this dependency?

Agreed. I think currently he has just added support for virtiofs. But
it should be possible to extend it to other fuse filesystems as well.
All they need to do is send notification and regular fuse already
has support for allowing server to send notifications to fuse client
kernel.

> 
> >
> > My PoC Linux kernel patches are here:
> > https://github.com/iangelak/linux/commits/inotify_v1
> >
> > My PoC virtiofsd corresponding patches are here:
> > https://github.com/iangelak/qemu/commits/inotify_v1
> >
> > --Advantages
> >
> > 1) Our approach is compatible with existing applications that rely on
> > Inotify, thus improves portability.
> >
> > 2) Everything is implemented in one place (virtiofs and virtiofsd) and
> > there is no need to run additional processes (daemons) specifically to
> > handle the remote notifications.
> >
> > --Weaknesses
> >
> > 1) Both a local (QEMU guest) and a remote (Host/Virtiofsd) watch on the
> > target inode have to be active at the same time. The local watch
> > guarantees that events are going to be sent to the guest user space while
> > the remote watch captures events occurring on the host (and will be sent
> > to the guest).
> >
> > As a result, when an event occures on a inode within the exported
> > directory by virtiofs, two events will be generated at the same time; a
> > local event (generated by the guest kernel) and a remote event (generated
> > by the host), thus the guest will receive duplicate events.
> >
> > To account for this issue we implemented two modes; one where local events
> > function as expected (when virtiofsd does not support the remote
> > inotify) and one where the local events are suppressed and only the
> > remote events originating from the host side are let through (when
> > virtiofsd supports the remote inotify).
> 
> Dropping events from the local side would be weird.
> Avoiding duplicate events is not a good enough reason IMO
> compared to the problems this could cause.
> I am not convinced this is worth it.

So what should be done? If we don't drop local events, then application
will see both local and remote events. And then we will have to build
this knowledge in API that an event can be either local or remote.
Application should be able to distinguish between these two and act
accordingly. That sounds like a lot. And I am not even sure if application
cares about local events in case of a remote shared filesystem.

I have no experience with inotify/fanotify/fsnotify and what people
expect from inotify/fanotify API. So we are open to all the ideas
w.r.t what will be a good design to support this thing on remote
filesystems. Currently whole infrastructure seems to be written with
local filesystems in mind.

> 
> >
> > 3) The lifetime of the local watch in the guest kernel is very
> > important. Specifically, there is a possibility that the guest does not
> > receive remote events on time, if it removes its local watch on the
> > target or deletes the inode (and thus the guest kernel removes the watch).
> > In these cases the guest kernel removes the local watch before the
> > remote events arrive from the host (virtiofsd) and as such the guest
> > kernel drops all the remote events for the target inode (since the
> > corresponding local watch does not exist anymore). On top of that,
> > virtiofsd keeps an open proc file descriptor for each inode that is not
> > immediately closed on a inode deletion request by the guest. As a result
> > no IN_DELETE_SELF is generated by virtiofsd and sent to the guest kernel
> > in this case.
> >
> > 4) Because virtiofsd implements additional operations during the
> > servicing of a request from the guest, additional inotify events might
> > be generated and sent to the guest other than the ones the guest
> > expects. However, this is not technically a limitation and it is dependent
> > on the implementation of the remote file system server (in this case
> > virtiofsd).
> >
> > 5) The current implementation only supports Inotify, due to its
> > simplicity and not Fanotify. Fanotify's complexity requires support from
> > virtiofsd that is not currently available. One such example is
> > Fsnotify's access permission decision capabilities, which could
> > conflict with virtiofsd's current access permission implementation.
> 
> Good example, bad decision.
> It is perfectly fine for a remote server to provide a "supported event mask"
> and leave permission events out of the game.
> 
> Imagine a remote SMB server, it also does not support all of the events
> that the local application would like to set.
> 
> That should not be a reason to rule out fanotify, only specific
> fanotify events.
> 
> Same goes to FAN_MARK_MOUNT and FAN_MARK_FILESYSTEM
> remote server may or may not support anything other than watching
> inode objects, but it should not be a limit of the "remote fsnotify" API.

Agreed. If limited fanotify functionality is acceptable, then it should
be written in such a way so that one can easily extend it to support
limited fanotify support.

Thanks
Vivek

