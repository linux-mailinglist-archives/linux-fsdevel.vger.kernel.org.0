Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32F41EB2FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 03:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgFBBbE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 1 Jun 2020 21:31:04 -0400
Received: from sainfoin-smtp-out.extra.cea.fr ([132.167.192.228]:40588 "EHLO
        sainfoin-smtp-out.extra.cea.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgFBBbE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 21:31:04 -0400
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
        by sainfoin-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP id 0521V0IV031925
        for <linux-fsdevel@vger.kernel.org>; Tue, 2 Jun 2020 03:31:00 +0200
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id CD3D1200D00
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2020 03:31:00 +0200 (CEST)
Received: from muguet1-smtp-out.intra.cea.fr (muguet1-smtp-out.intra.cea.fr [132.166.192.12])
        by pisaure.intra.cea.fr (Postfix) with ESMTP id C0E18201151
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2020 03:31:00 +0200 (CEST)
Received: from zia.cdc.esteban.ctsi (out.dam.intra.cea.fr [132.165.76.10])
        by muguet1-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with SMTP id 0521UvNI015546
        for <linux-fsdevel@vger.kernel.org>; Tue, 2 Jun 2020 03:30:57 +0200
Received: (qmail 38592 invoked from network); 2 Jun 2020 01:30:57 -0000
From:   "Quentin.BOUGET@cea.fr" <Quentin.BOUGET@cea.fr>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Dominique Martinet <asmadeus@codewreck.org>,
        Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "robinhood-devel@lists.sf.net" <robinhood-devel@lists.sf.net>
Subject: Re: robinhood, fanotify name info events and lustre changelog
Thread-Topic: robinhood, fanotify name info events and lustre changelog
Thread-Index: AQHWNQZxmYe+JbkQvEicZE4uJ2wNW6i/TjU5gAEs1YCAAAjEAIAAdNQAgAM3Z6z//+h1gIAAdyxu
Date:   Tue, 2 Jun 2020 01:30:50 +0000
Message-ID: <1591061450058.86690@cea.fr>
References: <20200527172143.GB14550@quack2.suse.cz>
 <20200527173937.GA17769@nautica>
 <CAOQ4uxjQXwTo1Ug4jY1X+eBdLj80rEfJ0X3zKRi+L8L_uYSrgQ@mail.gmail.com>
 <20200528125651.GA12279@nautica> <1590777699518.49838@cea.fr>
 <CAOQ4uxgpugScXRLT6jJAAZf_ET+DpmEWoqkSdqCAMEwp+Kezhw@mail.gmail.com>
 <20200530133908.GA5969@nautica>
 <CAOQ4uxiE9R4gRGwQQETvWK7SLm4J60SvfrSAOZxYJdRHquAwtA@mail.gmail.com>
 <1591040775412.28640@cea.fr>,<CAOQ4uxjdPVWnK8807XzPv_DLa6zqyeMzX6Ezm1r_680DziXxYw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjdPVWnK8807XzPv_DLa6zqyeMzX6Ezm1r_680DziXxYw@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > > > With fanotify FAN_CREATE event, for example, the parent fid + name
> > > > > information should be used by the rbh adapter code to call
> > > > > name_to_handle_at(2) and get the created object's file handle.
> > > > >
> > > > > The reason we made this API choice is because fanotify events should
> > > > > not be perceived as a sequence of changes that can be followed to
> > > > > describe the current state of the filesystem.
> > > > > fanotify events should be perceived as a "poll" on the namespace.
> > > > > Whenever notified of a change, application should read the current state
> > > > > for the filesystem. fanotify events provide "just enough" information, so
> > > > > reading the current state of the filesystem is not too expensive.
> >
> > I am a little worried about objects that would move around constantly and thus
> > "evade" name_to_handle_at(). A bad actor could try to hide a setuid binary this
> > way... Of course they could also just copy/delete the file repeatedly and in
> > this case having the fid becomes useless, but it seems harder to do, and it is
> > likely it would take more time than a simple rename.
> >
> 
> I am not following. This threat model sounds bogus, but I am not a security
> expert, and fanotify async events shouldn't have anything to do with security.
> 
> If you can write a concrete use case and explain how your application
> wants to handle it and why it cannot without the missing object fid information
> I get give a serious answer.

A few weeks ago, attacks on supercomputers were reported:
https://www.bbc.com/news/technology-52709660.

I am not privy to the mitigations/detection mechanisms put in place, but it is
my understanding that one thing people have been looking for are setuid/setgid
binaries. If robinhood can be trusted to "see" (and stat) every file
created/modified on a filesystem, then it can be used for a rapid
filesystem-wide scan.

EDIT: That's my bad, I should have tried fanotify first. Now that I have, I can
see that FAN_CREATE is not the only event that is emitted when a file is created
and so, even if robinhood does not see the "right" file at parent_fid + name, it
will still see the created file's fid later on as it receives the associated
FAN_OPEN event.

Sorry.

> > > > > When fanotify event FAN_MODIFY reports a change of file size,
> > > > > along with parent fid + name, that do not match the parent/name robinhood
> > > > > knows about (i.e. because the event is received out of order with rename),
> > > > > you may use that information to create rbh_fsevent_ns_xattr event to
> > > > > update the path or you may wait for the FAN_MOVE_SELF event that
> > > > > should arrive later.
> > > > > Up to you.
> >
> > This is making me think: if I receive such a FAN_MODIFY event, and an object
> > is moved at parent_fid + name before I query the FS, how can I know which file
> > the event was originally meant for?
> >
> 
> FAN_MODIFY/FAN_ACCESS/FAN_ATTRIB events do have the object_fid in
> addition to parent_fid + name.
> FAN_CREATE/FAN_DELETE/FAN_MOVE do NOT have the object_fid,
> FAN_DELETE_SELF/FAN_MOVE_SELF do have the object_fid
> FAN_DELETE_SELF does NOT have parent_fid + name
> FAN_MOVE_SELF does have parent_fid + name (new parent/name)
>
> Is there anything missing in your opnion for robinhood to be able to
> perform any of its missions?

No, I don't think so anymore.

Thanks,
Quentin
