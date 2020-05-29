Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7071E8815
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 21:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgE2TpP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 15:45:15 -0400
Received: from cirse-smtp-out.extra.cea.fr ([132.167.192.148]:36882 "EHLO
        cirse-smtp-out.extra.cea.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726751AbgE2TpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 15:45:14 -0400
X-Greylist: delayed 3795 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2020 15:45:13 EDT
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
        by cirse-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP id 04TIfucf043207
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 20:41:56 +0200
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 04FEC20B2EA
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 20:41:56 +0200 (CEST)
Received: from muguet1-smtp-out.intra.cea.fr (muguet1-smtp-out.intra.cea.fr [132.166.192.12])
        by pisaure.intra.cea.fr (Postfix) with ESMTP id ED5CC20B2D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 20:41:55 +0200 (CEST)
Received: from zia.cdc.esteban.ctsi (out.dam.intra.cea.fr [132.165.76.10])
        by muguet1-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with SMTP id 04TIftHM016869
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 20:41:55 +0200
Received: (qmail 24940 invoked from network); 29 May 2020 18:41:55 -0000
From:   "Quentin.BOUGET@cea.fr" <Quentin.BOUGET@cea.fr>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Amir Goldstein <amir73il@gmail.com>
CC:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "robinhood-devel@lists.sf.net" <robinhood-devel@lists.sf.net>
Subject: Re: robinhood, fanotify name info events and lustre changelog
Thread-Topic: robinhood, fanotify name info events and lustre changelog
Thread-Index: AQHWNQZxmYe+JbkQvEicZE4uJ2wNW6i/TjU5
Date:   Fri, 29 May 2020 18:41:49 +0000
Message-ID: <1590777699518.49838@cea.fr>
References: <20200527172143.GB14550@quack2.suse.cz>
 <20200527173937.GA17769@nautica>
 <CAOQ4uxjQXwTo1Ug4jY1X+eBdLj80rEfJ0X3zKRi+L8L_uYSrgQ@mail.gmail.com>,<20200528125651.GA12279@nautica>
In-Reply-To: <20200528125651.GA12279@nautica>
Accept-Language: en-US, fr-FR
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Developer of robinhood v4 here,

> > > [1] https://github.com/cea-hpc/robinhood/

The sources for version 4 live in a separate branch:
https://github.com/cea-hpc/robinhood/tree/v4

Any feedback is welcome =)

I am guessing the most interesting bits for this discussion should be found
here:
https://github.com/cea-hpc/robinhood/blob/v4/include/robinhood/fsevent.h

I am not sure it will matter for the rest of the conversation, but just in case:

    RobinHood v4 has a notion of a "namespace" xattr (like an xattr, but for
    a dentry rather than an inode), it is used it to store things that are only
    really tied to the namespace (like the path of an entry). I don't think this
    is really relevant here, you can probably ignore it.

    Also, RobinHood uses file handles to uniquely identify filesystem entries,
    and this is what is stored in a `struct rbh_id`.

> > I couldn't find the documentation for Lustre Changelog format, because
> > the name of the feature is not very Google friendly.

Yes, this is really unfortunate. For the record, user documentation for Lustre
lives at: http://doc.lustre.org/lustre_manual.xhtml

Chapter 12.1 deals with "Lustre Changelogs" (not much more there than
what Dominique already wrote).

> > There is one critical difference between a changelog and fanotify events.
> > fanotify events are delivered a-synchronically and may be delivered out
> > of order, so application must not rely on path information to update
> > internal records without using fstatat(2) to check the actual state of the
> > object in the filesystem.

> lustre changelogs are asynchronous but the order is guaranteed so we
> might rely on that for robinhood v4,

Yes, we do. At least to a certain extent : we at least expect changelog records
for a single filesystem entry to be emitted in the order they happened on the
FS. I have not really given much thought to how things would work in general
if that wasn't true, but I know this is an issue for things that deal with the
namespace : https://jira.whamcloud.com/browse/LU-12574

> but full path is not computed from
> information in the changelogs. Instead the design plan is to have a
> process scrub the database for files that got updated since the last
> path update and fix paths with fstatat, so I think it might work ; but
> that unfortunately hasn't been implemented yet.

Not exactly (I am not sure it really matters, so I'll try to be brief).

The idea to keep paths in sync with what's in the filesystem is to "tag"
entries as we update their name (ie. after a rename). Then a separate
process comes in, queries for entries that have that "tag", and updates
their path by concatenating their parent's path (if the parents themselves
are not "tagged") with the entries' own, up-to-date name. After that, if
the entry was a directory, its children are "tagged". I simplified a bit, but
that's the idea.

So, to be fair, full paths _are_ computed solely from information in the
changelog records, even though it requires a bit of processing on the side.
No additional query to the filesystem for that.

Cheers,
Quentin
