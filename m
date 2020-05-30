Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DABF1E91C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgE3Njd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 09:39:33 -0400
Received: from nautica.notk.org ([91.121.71.147]:57667 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgE3Njc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 09:39:32 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id BD79DC009; Sat, 30 May 2020 15:39:23 +0200 (CEST)
Date:   Sat, 30 May 2020 15:39:08 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Quentin.BOUGET@cea.fr" <Quentin.BOUGET@cea.fr>,
        Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "robinhood-devel@lists.sf.net" <robinhood-devel@lists.sf.net>
Subject: Re: robinhood, fanotify name info events and lustre changelog
Message-ID: <20200530133908.GA5969@nautica>
References: <20200527172143.GB14550@quack2.suse.cz>
 <20200527173937.GA17769@nautica>
 <CAOQ4uxjQXwTo1Ug4jY1X+eBdLj80rEfJ0X3zKRi+L8L_uYSrgQ@mail.gmail.com>
 <20200528125651.GA12279@nautica>
 <1590777699518.49838@cea.fr>
 <CAOQ4uxgpugScXRLT6jJAAZf_ET+DpmEWoqkSdqCAMEwp+Kezhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgpugScXRLT6jJAAZf_ET+DpmEWoqkSdqCAMEwp+Kezhw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Answering what I can until Quentin chips back in.

Amir Goldstein wrote on Sat, May 30, 2020:
> Nice. thanks for explaining that.
> I suppose you need to store the calculated path attribute for things like
> index queries on the database?

Either querying for a subtree or simply printing the path (rbh-find
would print path by default, like find does)

> > So, to be fair, full paths _are_ computed solely from information in the
> > changelog records, even though it requires a bit of processing on the side.
> > No additional query to the filesystem for that.
> 
> As I wrote, that fact that robinhood trusts the information in changelog
> records doesn't mean that information needs to arrive from the kernel.
> The adapter code should use information provided by fanotify events
> then use open_by_handle_at(2) for directory fid to finds its current
> path in the filesystem then feed that information to a robinhood change
> record.

I can agree with that - it's not because for lustre we made the decision
to be able to run without querying the filesystem at all that it has to
hold true for all type of inputs.

> I would be happy to work with you on a POC for adapting fanotify
> test code with robinhood v4, but before I invest time on that, I would
> need to know there is a good chance that people are going to test and
> use robinhood with Linux vfs.
>
> Do you have actual users requesting to use robinhood with non-Lustre
> fs?

I would run it at home, but that isn't much :D
As I wrote previously we have users for large nfs shares out of lustre,
but I honestly don't think there will be much use for local filesystems
at least in the short term.

Filesystem indexers like tracker[1] or similar would definitely get much
more use for that; from an objective point of view I wouldn't suggest
you spend time on robinhood for this: local filesytems are rarely large
enough to warrant using something like robinhood, and without something
like fanotify we wouldn't be efficient for a local disk with hundreds of
millions of files anyway because of the prohibitive rescan cost - so
it's a bit like chicken and egg maybe, I don't know, but if you want
many users to test different configurations I wouldn't recommend
robinhood (OTOH, we run CI tests so would be happy to add that to the
tests once it's available on vanilla kernels; but that's still not real
users)

[1] https://wiki.gnome.org/Projects/Tracker


> May I ask, what is the reason for embarking on the project to decouple
> robinhood v4 API from Lustre changelog API?
> Is it because you had other fsevent producers in mind?

I've been planning to at least add some recursive-inotifywatch a
subfolder at least (like watchman does) before these new fanotify events
came up, so I might be partly to blame for that.

There also are advantages for lustre though; the point is to be able to
ingest changelogs directly with some daemon (it's only at proof of
concept level for v4 at this point), but also to split the load by
involving multiple lustre clients.
So you would get a pool of lustre clients to read changelogs, a pool of
lustre clients to stat files as required to enrich the fsevents (file
size etc), and a pool of servers to read fsevents and commit changes to
the database (this part is still at the design level afaik)


Hope this all makes sense,
-- 
Dominique
