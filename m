Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285F04C4618
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 14:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbiBYNYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 08:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241226AbiBYNYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:24:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A45061FEFB5
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 05:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645795406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=boXp0pW3ArSR6Ihb5w3zcdZgV6ZZxz/MMyr6B2nMaXo=;
        b=ErjDreVYwrdQN9gJDcwDkxmsTVm1zy29cjLEAPxaoC9DlRnu78uE+3jSk4s0N08QsVq67l
        S9NPpDuW/iP8n5fP3K8w5z20NAOyiek9Q6W7pop/uuTWPjPtJ7NZ5tnyfUy+624bKwrKsW
        MtPZ1+tS1gnhNd7ABEehTkDUYT41CdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-P3wiQ-llMim114EKshK8mg-1; Fri, 25 Feb 2022 08:23:23 -0500
X-MC-Unique: P3wiQ-llMim114EKshK8mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBFC21854E21;
        Fri, 25 Feb 2022 13:23:21 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FAC17B8D2;
        Fri, 25 Feb 2022 13:23:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E66862237E9; Fri, 25 Feb 2022 08:23:20 -0500 (EST)
Date:   Fri, 25 Feb 2022 08:23:20 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ioannis Angelakopoulos <jaggel@bu.edu>
Subject: Re: [LSF/MM/BPF TOPIC] Enabling change notification for network and
 cluster fs
Message-ID: <YhjYSMIE2NBZ/dGr@redhat.com>
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
 <Yhf+FemcQQToB5x+@redhat.com>
 <CAH2r5mt6Sh7qorfCHWnZzc6LUDd-s_NzGB=sa-UDM2-ivzpmAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mt6Sh7qorfCHWnZzc6LUDd-s_NzGB=sa-UDM2-ivzpmAQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:55:42PM -0600, Steve French wrote:
> >  With this proposal, you are trying to move away from cifs specific ioctl?
> 
> Yes - since there are some applications that already use inotify
> (although presumably less common than the similar API on Macs and
> Windows), just fixing inotify to call into the fs to register events
> is a good first step.  See inotify(7) - Linux manual page e.g.

Ok. Fixing one first makes it little simpler. But ultimately we probably
would like to get to fixing boty inotify and fanotify.

> 
> For the case of SMB3.1.1 the wire protocol should be fine for this
> (although perhaps could be a few flags added to inotify to better
> match what servers support) See
> https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/598f395a-e7a2-4cc8-afb3-ccb30dd2df7c
> 

I see that "completion_filter" allows one to specify what kind of event
client is interested in.

Some of the events can probably mapped to existing inotify/fanotify events
but others don't seem to have 1:1 mapping. For example,
FILE_NOTIFY_CHANGE_SECURITY or FILE_NOTIFY_CHANGE_EA.

I guess this will be a generic problem. Remote filesystem protocol might
support a set of notifications which don't have any 1:1 mapping with
what inotify/fanotiy support. For the case of virtiofs we are initially
thinking of running linux host and server can use inoitfy/fanotify on
host and then lot of events can have 1:1 mapping. But if we were to
run virtiofsd on some other platform macOS or windows, then set of
events supported might be very different. So mapping events will
be a challege there as well.

I guess client will have to keep a list of events it can support and
if application tries to monitor for an event which remote fs can't
support, just deny putting that watch. For example, I did not see in
SMB, what's the equivalent of IN_CLOSE_WRITE or IN_OPEN.

This will be a challege for applications though because while a set of event
works on one filesystem it will not work on other fs and life will be hard
for application writers.

What about local events. I am assuming you want to supress local events
and only deliver remote events. Because having both local and remote
events delivered at the same time will be just confusing at best.

Thanks
Vivek

> But there may be other APIs other than inotify that could be mapped to
> what is already supported on the wire (with minor changes to the vfs)

> 
> On Thu, Feb 24, 2022 at 3:52 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Feb 23, 2022 at 11:16:33PM -0600, Steve French wrote:
> > > Currently only local events can be waited on with the current notify
> > > kernel API since the requests to wait on these events is not passed to
> > > the filesystem.   Especially for network and cluster filesystems it is
> > > important that they be told that applications want to be notified of
> > > these file or directory change events.
> > >
> > > A few years ago, discussions began on the changes needed to enable
> > > support for this.   Would be timely to finish those discussions, as
> > > waiting on file and directory change events to network mounts is very
> > > common for other OS, and would be valuable for Linux to fix.
> > >
> >
> > This sounds like which might have some overlap with what we are trying
> > to do.
> >
> > Currently inotify/fanotify only work for local filesystems. We were
> > thinking is it possible to extend it for remote filesystems as well. My
> > interest primarily was to make notifications work on virtiofs. So I
> > asked Ioannis (an intern with us) to try to prototype it and see what are
> > the challenges and roadblocks.
> >
> > He posted one version of patches just as proof of concept and only tried
> > to make remote inotify work. One primary feedback from Amir was that
> > this is too specific to inotify and if you are extending fsnotify, then
> > it should have some support for fanotify as well. There is bunch of
> > other feedback too. So Ioannis is trying to rework his patches now.
> >
> > https://lore.kernel.org/linux-fsdevel/20211025204634.2517-1-iangelak@redhat.com/
> >
> > Anyway, you had pointed to following commit.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/cifs/ioctl.c?id=d26c2ddd33569667e3eeb577c4c1d966ca9192e2
> >
> > So looks like application calls this cifs specific ioctl and blocks and
> > unblocks when notifications comes, IIUC.
> >
> > I don't know about SMB and what kind of other notifications does it
> > support. With this proposal, you are trying to move away from cifs
> > specific ioctl? What will user use to either block or poll for the
> > said notification.
> >
> > Sorry, I might be just completely off the mark. Just trying to find out
> > if there is any overlap in what you are looking for and what we are
> > trying to do.
> >
> > Thanks
> > Vivek
> >
> > > --
> > > Thanks,
> > >
> > > Steve
> > >
> >
> 
> 
> -- 
> Thanks,
> 
> Steve
> 

