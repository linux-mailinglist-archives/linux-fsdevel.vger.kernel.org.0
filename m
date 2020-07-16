Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC293222ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 01:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGPXNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 19:13:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:42556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgGPXNo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:13:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB76DAB89;
        Thu, 16 Jul 2020 22:34:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 63C751E0E83; Fri, 17 Jul 2020 00:34:41 +0200 (CEST)
Date:   Fri, 17 Jul 2020 00:34:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 15/22] fsnotify: send event with parent/name info to
 sb/mount/non-dir marks
Message-ID: <20200716223441.GA5085@quack2.suse.cz>
References: <20200716084230.30611-1-amir73il@gmail.com>
 <20200716084230.30611-16-amir73il@gmail.com>
 <20200716170133.GJ5022@quack2.suse.cz>
 <CAOQ4uxhuMyOjcs=qct6Hz3OOonYAJ9qhnhCkf-yy4zvZxTgFfw@mail.gmail.com>
 <20200716175709.GM5022@quack2.suse.cz>
 <CAOQ4uxiS2zNkVQZjcErmqq2OSXdfk2_H+gDyRWEAdjzbM+qipg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiS2zNkVQZjcErmqq2OSXdfk2_H+gDyRWEAdjzbM+qipg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-07-20 21:42:20, Amir Goldstein wrote:
> On Thu, Jul 16, 2020 at 8:57 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 16-07-20 20:20:04, Amir Goldstein wrote:
> > > On Thu, Jul 16, 2020 at 8:01 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Thu 16-07-20 11:42:23, Amir Goldstein wrote:
> > > > > Similar to events "on child" to watching directory, send event "on child"
> > > > > with parent/name info if sb/mount/non-dir marks are interested in
> > > > > parent/name info.
> > > > >
> > > > > The FS_EVENT_ON_CHILD flag can be set on sb/mount/non-dir marks to specify
> > > > > interest in parent/name info for events on non-directory inodes.
> > > > >
> > > > > Events on "orphan" children (disconnected dentries) are sent without
> > > > > parent/name info.
> > > > >
> > > > > Events on direcories are send with parent/name info only if the parent
> > > > > directory is watching.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > Hum, doesn't this break ignore mask handling in
> > > > fanotify_group_event_mask()? Because parent's ignore mask will be included
> > > > even though parent is added into the iter only to carry the parent info...
> > > >
> > >
> > > Hmm, break ignore mask handling? or fix it?
> > >
> > > Man page said:
> > > "Having these two types of masks permits a mount point or directory to be
> > >  marked for receiving events, while at the  same time ignoring events for
> > >  specific objects under that mount point or directory."
> >
> > Right, but presumably that speaks of the case of a mark where the parent
> > has FS_EVENT_ON_CHILD set. For case of parent watching events of a child, I
> > agree it makes sense to apply ignore masks of both the parent and the child.
> >
> > > The author did not say what to expect from marking a mount and ignoring
> > > a directory.
> >
> > Yes and I'd expect to apply ignore mask on events for that directory but
> > not for events on files in that directory... Even more so because this will
> > be currently inconsistent wrt whether the child is dir (parent's ignore mask
> > does not apply) or file (parent's ignore mask does apply).
> >
> 
> Indeed. For that I used this trick in my POC:
> 
>         /* Set the mark mask, so fsnotify_parent() will find this mark */
>         ovm->fsn_mark.mask = mask | FS_EVENT_ON_CHILD;
>         ovm->fsn_mark.ignored_mask = mask;
> 
> It's not how users are expected to configure an ignored mask on children
> but we can work the ignored mask information into the object mask, like
> I already did w.r.t FS_MODIFY and get the same result without the hack.

OK, nice trick but for this series, I'd like to keep the original ignore
mask behavior (bug to bug compatibility) or possibly let parent's ignore
mask be applied only for events being sent to the parent due to its
FS_EVENT_ON_CHILD. Can you please fix that up? I won't get to it before I
leave for vacation but once I return, I'd like to just pick the fixed up
commit and push everything to linux-next... Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
