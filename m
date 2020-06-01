Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6499F1EAFC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgFATqY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 1 Jun 2020 15:46:24 -0400
Received: from sainfoin-smtp-out.extra.cea.fr ([132.167.192.228]:49660 "EHLO
        sainfoin-smtp-out.extra.cea.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728182AbgFATqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:46:23 -0400
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
        by sainfoin-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP id 051JkJUG043876
        for <linux-fsdevel@vger.kernel.org>; Mon, 1 Jun 2020 21:46:19 +0200
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id EFE732065B8
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 21:46:18 +0200 (CEST)
Received: from muguet2-smtp-out.intra.cea.fr (muguet2-smtp-out.intra.cea.fr [132.166.192.13])
        by pisaure.intra.cea.fr (Postfix) with ESMTP id E38442065F1
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 21:46:18 +0200 (CEST)
Received: from zia.cdc.esteban.ctsi (out.dam.intra.cea.fr [132.165.76.10])
        by muguet2-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with SMTP id 051JkIbh007027
        for <linux-fsdevel@vger.kernel.org>; Mon, 1 Jun 2020 21:46:18 +0200
Received: (qmail 40712 invoked from network); 1 Jun 2020 19:46:18 -0000
From:   "Quentin.BOUGET@cea.fr" <Quentin.BOUGET@cea.fr>
To:     Amir Goldstein <amir73il@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
CC:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "robinhood-devel@lists.sf.net" <robinhood-devel@lists.sf.net>
Subject: Re: robinhood, fanotify name info events and lustre changelog
Thread-Topic: robinhood, fanotify name info events and lustre changelog
Thread-Index: AQHWNQZxmYe+JbkQvEicZE4uJ2wNW6i/TjU5gAEs1YCAAAjEAIAAdNQAgAM3Z6w=
Date:   Mon, 1 Jun 2020 19:46:15 +0000
Message-ID: <1591040775412.28640@cea.fr>
References: <20200527172143.GB14550@quack2.suse.cz>
 <20200527173937.GA17769@nautica>
 <CAOQ4uxjQXwTo1Ug4jY1X+eBdLj80rEfJ0X3zKRi+L8L_uYSrgQ@mail.gmail.com>
 <20200528125651.GA12279@nautica> <1590777699518.49838@cea.fr>
 <CAOQ4uxgpugScXRLT6jJAAZf_ET+DpmEWoqkSdqCAMEwp+Kezhw@mail.gmail.com>
 <20200530133908.GA5969@nautica>,<CAOQ4uxiE9R4gRGwQQETvWK7SLm4J60SvfrSAOZxYJdRHquAwtA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiE9R4gRGwQQETvWK7SLm4J60SvfrSAOZxYJdRHquAwtA@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > > I am guessing the most interesting bits for this discussion should be found
> > > > here:
> > > > https://github.com/cea-hpc/robinhood/blob/v4/include/robinhood/fsevent.h
> > > >
> > > 
> > > That is a very well documented API and a valuable resource for me.

Thank you!

> > > Notes for API choices that are aligned with current fanotify plans:
> > > - The combination of parent fid + object fid without name is never expected
> > > 
> > > Notes for API choices that are NOT aligned with current fanotify plans:
> > > - LINK/UNLINK events carry the linked/unlinked object fid
> > > - XATTR events for inode (not namespace) do not carry parent fid/name
> > > 
> > > This doesn't mean that fanotify -> rbh_fsevent translation is not going to
> > > be possible.
> > > 
> > > With fanotify FAN_CREATE event, for example, the parent fid + name
> > > information should be used by the rbh adapter code to call
> > > name_to_handle_at(2) and get the created object's file handle.
> > > 
> > > The reason we made this API choice is because fanotify events should
> > > not be perceived as a sequence of changes that can be followed to
> > > describe the current state of the filesystem.
> > > fanotify events should be perceived as a "poll" on the namespace.
> > > Whenever notified of a change, application should read the current state
> > > for the filesystem. fanotify events provide "just enough" information, so
> > > reading the current state of the filesystem is not too expensive.

I am a little worried about objects that would move around constantly and thus
"evade" name_to_handle_at(). A bad actor could try to hide a setuid binary this
way... Of course they could also just copy/delete the file repeatedly and in
this case having the fid becomes useless, but it seems harder to do, and it is
likely it would take more time than a simple rename.

> > > When fanotify event FAN_MODIFY reports a change of file size,
> > > along with parent fid + name, that do not match the parent/name robinhood
> > > knows about (i.e. because the event is received out of order with rename),
> > > you may use that information to create rbh_fsevent_ns_xattr event to
> > > update the path or you may wait for the FAN_MOVE_SELF event that
> > > should arrive later.
> > > Up to you.

This is making me think: if I receive such a FAN_MODIFY event, and an object
is moved at parent_fid + name before I query the FS, how can I know which file
the event was originally meant for?

> > > > So, to be fair, full paths _are_ computed solely from information in the
> > > > changelog records, even though it requires a bit of processing on the side.
> > > > No additional query to the filesystem for that.
> > > 
> > > As I wrote, that fact that robinhood trusts the information in changelog
> > > records doesn't mean that information needs to arrive from the kernel.
> > > The adapter code should use information provided by fanotify events
> > > then use open_by_handle_at(2) for directory fid to finds its current
> > > path in the filesystem then feed that information to a robinhood change
> > > record.
> > 
> > I can agree with that - it's not because for lustre we made the decision
> > to be able to run without querying the filesystem at all that it has to
> > hold true for all type of inputs.

I agree as well. The issue I mention above is a special case. In general, I am
fine with the "just enough information" approach.

> > > May I ask, what is the reason for embarking on the project to decouple
> > > robinhood v4 API from Lustre changelog API?

There is an impedance mismatch between what Lustre emits, and what robinhood
needs for its updates: even with Lustre's changelog, we still need to query
the filesystem to get additional information. I could have extended Lustre's
structures, but then I would have depended on them too much for my taste. It
just seemed cleaner to have a clear separation between the two.

> Looking at robinhood (especially v4), I seems like it could fit
> very well into the vacuum in Linux and act as "fsnotifyd".
> unprivileged applications and services could register to event streams
> and get fed from db, so applications not running will not loose events.
> Events delivered to unprivileged applications need to be filtered by
> subtree those applications, something that fanotify does not do and
> will not likely do and filtered by access permissions of application
> to the path of the reported object.

The plan is to use a dedicated message queue for the streaming part (such as
Kafka or RabbitMQ) and robinhood would only really deal with serializing events
into a standard communication format (the current target is YAML), and dumping
that into the message queues.

From there, it's definitely possible to write a program that will filter
events and route them to unprivileged applications... But it is unlikely I will
write it myself. =)

Cheers,
Quentin
