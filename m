Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D484C56E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiBZQpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 11:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiBZQpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 11:45:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB3E5B2D70
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Feb 2022 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645893894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lwMysCu29wz4OMNuwMpG+mGhMkT1ZhFO9Qcz0+0ggms=;
        b=JJ5P7jWSf0w7vM/8+LmNsNdq59qZH/Fzw9l9SghGbK1fz2rwDl6ojbPMhHcPvQk56M9ty0
        uknvV5Wx7YLuYUsGtUEG+ywVERQH7Hp6R2QyttQVHNQLThXxEryLqvbKXWAF8EeFjc+tFU
        BR5tE9M7Pg9fRay+ejyyB73OuTNsjAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-Ua6DDJrUNHWzFxBM7yQ-4g-1; Sat, 26 Feb 2022 11:44:51 -0500
X-MC-Unique: Ua6DDJrUNHWzFxBM7yQ-4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38DAB180A08B;
        Sat, 26 Feb 2022 16:44:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D387C6A4B9;
        Sat, 26 Feb 2022 16:44:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D890C2237E9; Sat, 26 Feb 2022 11:44:47 -0500 (EST)
Date:   Sat, 26 Feb 2022 11:44:47 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ioannis Angelakopoulos <jaggel@bu.edu>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Subject: Re: [LSF/MM/BPF TOPIC] Enabling change notification for network and
 cluster fs
Message-ID: <YhpY/zZe3UA2u3fj@redhat.com>
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
 <Yhf+FemcQQToB5x+@redhat.com>
 <CAH2r5mt6Sh7qorfCHWnZzc6LUDd-s_NzGB=sa-UDM2-ivzpmAQ@mail.gmail.com>
 <YhjYSMIE2NBZ/dGr@redhat.com>
 <YhjeX0HvXbED65IM@casper.infradead.org>
 <CAH2r5mt9EtTEJCKsHkvRctfhMv7LnT6XT_JEvAb7ji6-oYnTPg@mail.gmail.com>
 <YhkFZE8wUWhycwX2@redhat.com>
 <CAH2r5msPz1JZK4OWX_=+2HTzKTZE07ACxbEv3xM-1T0HTnVWMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msPz1JZK4OWX_=+2HTzKTZE07ACxbEv3xM-1T0HTnVWMw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 01:11:10PM -0500, Steve French wrote:
> > IOW, in general disable all local events and let filesystems decide which
> local events to generate? And locally cached write is one such example?
> 
> The fs doesn't see cached writes so probably best to still use the common
> existing code for notification on local writes

Filesystems could provide a hook/function which local notifications could
call and then filesystem could take a decision whether to allow that
particular local event. 

For example, Ioannis implemented inode operation ->fsnotify_event()

https://lore.kernel.org/linux-fsdevel/20211025204634.2517-6-iangelak@redhat.com/

This gives local event to fuse. And now fuse can decide whether to
dispatch the event to user space by calling __fsnotify() or drop it
on the floor.

As of now we drop everything on the floor if remote notifications are
enabled. But I realize that cache=writeback mode can cache writes, so
fs could selectively allow some local events.

I guess for virtiofs, we could allow all local events. Supress remote
events if event is triggered due to the action of same client. If we
use fanotify on server, then it will report PID of process that caused
the event. And if PID belongs to this virtiofsd instance, it probably
could supress remote event. 

That way an application running inside the guest will see all local
events + remote events triggered by other clients. (But should not
see duplicate events).

Thanks
Vivek

> 
> On Fri, Feb 25, 2022, 11:35 Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > On Fri, Feb 25, 2022 at 09:27:55AM -0600, Steve French wrote:
> > > On Fri, Feb 25, 2022 at 7:49 AM Matthew Wilcox <willy@infradead.org>
> > wrote:
> > > >
> > > > On Fri, Feb 25, 2022 at 08:23:20AM -0500, Vivek Goyal wrote:
> > > > > What about local events. I am assuming you want to supress local
> > events
> > > > > and only deliver remote events. Because having both local and remote
> > > > > events delivered at the same time will be just confusing at best.
> > > >
> > > > This paragraph confuses me.  If I'm writing, for example, a file
> > manager
> > > > and I want it to update its display automatically when another task
> > alters
> > > > the contents of a directory, I don't care whether the modification was
> > > > done locally or remotely.
> > > >
> > > > If I understand the SMB protocol correctly, it allows the client to
> > take
> > > > out a lease on a directory and not send its modifications back to the
> > > > server until the client chooses to (or the server breaks the lease).
> > > > So you wouldn't get any remote notifications because the client hasn't
> > > > told the server.
> > >
> > > Directory leases would be broken by file create so the more important
> > > question is what happens when client 1 has a change notification on
> > writes
> > > to files in a directory then client 2 opens a file in the same directory
> > and is
> > > granted a file lease and starts writing to the file (which means the
> > > writes could get cached).   This is probably a minor point because when
> > > writes get flushed from client 2, client 1 (and any others with
> > notifications
> > > requested) will get notified of the event (changes to files in a
> > directory
> > > that they are watching).
> > >
> > > Local applications watching a file on a network or cluster mount in Linux
> > > (just as is the case with Windows, Macs etc.) should be able to be
> > notified of
> > > local (cached) writes to a remote file or remote writes to the file from
> > another
> > > client.  I don't think the change is large, and there was an earlier
> > version of
> > > a patch circulated for this
> >
> > So local notifications are generated by filesystem code as needed?
> >
> > IOW, in general disable all local events and let filesystems decide which
> > local events to generate? And locally cached write is one such example?
> >
> > Thanks
> > Vivek
> >
> >

