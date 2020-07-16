Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5479A222A89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGPR5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 13:57:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPR5L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:57:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62622ACE3;
        Thu, 16 Jul 2020 17:57:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 224281E0E81; Thu, 16 Jul 2020 19:57:09 +0200 (CEST)
Date:   Thu, 16 Jul 2020 19:57:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 15/22] fsnotify: send event with parent/name info to
 sb/mount/non-dir marks
Message-ID: <20200716175709.GM5022@quack2.suse.cz>
References: <20200716084230.30611-1-amir73il@gmail.com>
 <20200716084230.30611-16-amir73il@gmail.com>
 <20200716170133.GJ5022@quack2.suse.cz>
 <CAOQ4uxhuMyOjcs=qct6Hz3OOonYAJ9qhnhCkf-yy4zvZxTgFfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhuMyOjcs=qct6Hz3OOonYAJ9qhnhCkf-yy4zvZxTgFfw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-07-20 20:20:04, Amir Goldstein wrote:
> On Thu, Jul 16, 2020 at 8:01 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 16-07-20 11:42:23, Amir Goldstein wrote:
> > > Similar to events "on child" to watching directory, send event "on child"
> > > with parent/name info if sb/mount/non-dir marks are interested in
> > > parent/name info.
> > >
> > > The FS_EVENT_ON_CHILD flag can be set on sb/mount/non-dir marks to specify
> > > interest in parent/name info for events on non-directory inodes.
> > >
> > > Events on "orphan" children (disconnected dentries) are sent without
> > > parent/name info.
> > >
> > > Events on direcories are send with parent/name info only if the parent
> > > directory is watching.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Hum, doesn't this break ignore mask handling in
> > fanotify_group_event_mask()? Because parent's ignore mask will be included
> > even though parent is added into the iter only to carry the parent info...
> >
> 
> Hmm, break ignore mask handling? or fix it?
> 
> Man page said:
> "Having these two types of masks permits a mount point or directory to be
>  marked for receiving events, while at the  same time ignoring events for
>  specific objects under that mount point or directory."

Right, but presumably that speaks of the case of a mark where the parent
has FS_EVENT_ON_CHILD set. For case of parent watching events of a child, I
agree it makes sense to apply ignore masks of both the parent and the child.

> The author did not say what to expect from marking a mount and ignoring
> a directory.

Yes and I'd expect to apply ignore mask on events for that directory but
not for events on files in that directory... Even more so because this will
be currently inconsistent wrt whether the child is dir (parent's ignore mask
does not apply) or file (parent's ignore mask does apply).

> As it turns out, I need this exact functionality for my snapshot.
> - sb is watching all (pre) modify events
> - after dir has been marked with a change in snapshot an exclude
>   mark is set on that dir inode
> - further modification events on files inside that dir are ignored
>   without calling event handler

Yes, I can see how the functionality is useful. Maybe with
FS_EVENT_ON_CHILD in the ignore mask, applying the mask to child's events
would make sense... But that's IMO a dispute for a different patch.

> I am sure you are aware that we have been fixing a lot of problems
> in handling combinations of mark masks.

Very well aware :)

> I see the unified event as another step in the direction to fix those
> issues and to get consistent and expected behavior.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
