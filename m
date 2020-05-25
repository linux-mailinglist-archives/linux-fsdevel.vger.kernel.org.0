Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6821E07EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 09:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbgEYHXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 03:23:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:54524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388951AbgEYHXY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 03:23:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B5900AF0F;
        Mon, 25 May 2020 07:23:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BC1911E1270; Mon, 25 May 2020 09:23:22 +0200 (CEST)
Date:   Mon, 25 May 2020 09:23:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Ignore mask handling in fanotify_group_event_mask()
Message-ID: <20200525072322.GG14199@quack2.suse.cz>
References: <20200521162443.GA26052@quack2.suse.cz>
 <CAOQ4uxirUfcpOdxFG9TAHUFSz+A5FMJdT=y4UKwpFUVov43nSA@mail.gmail.com>
 <CAOQ4uxgBGTAnZUedY3dEwR9V=hdrr_4PH_snj9E=sz-_UuVzTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgBGTAnZUedY3dEwR9V=hdrr_4PH_snj9E=sz-_UuVzTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 23-05-20 20:14:58, Amir Goldstein wrote:
> On Thu, May 21, 2020 at 9:10 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, May 21, 2020 at 7:24 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hello Amir!
> > >
> > > I was looking into backporting of commit 55bf882c7f13dd "fanotify: fix
> > > merging marks masks with FAN_ONDIR" and realized one oddity in
> > > fanotify_group_event_mask(). The thing is: Even if the mark mask is such
> > > that current event shouldn't trigger on the mark, we still have to take
> > > mark's ignore mask into account.
> > >
> > > The most realistic example that would demonstrate the issue that comes to my
> > > mind is:
> > >
> > > mount mark watching for FAN_OPEN | FAN_ONDIR.
> > > inode mark on a directory with mask == 0 and ignore_mask == FAN_OPEN.
> > >
> > > I'd expect the group will not get any event for opening the dir but the
> > > code in fanotify_group_event_mask() would not prevent event generation. Now
> > > as I've tested the event currently actually does not get generated because
> > > there is a rough test in send_to_group() that actually finds out that there
> > > shouldn't be anything to report and so fanotify handler is actually never
> > > called in such case. But I don't think it's good to have an inconsistent
> > > test in fanotify_group_event_mask(). What do you think?
> > >
> >
> > I agree this is not perfect.
> > I think that moving the marks_ignored_mask line
> > To the top of the foreach loop should fix the broken logic.
> > It will not make the code any less complicated to follow though.
> > Perhaps with a comment along the lines of:
> >
> >              /* Ignore mask is applied regardless of ISDIR and ON_CHILD flags */
> >              marks_ignored_mask |= mark->ignored_mask;
> >
> > Now is there a real bug here?
> > Probably not because send_to_group() always applied an ignore mask
> > that is greater or equal to that of fanotify_group_event_mask().
> >
> 
> That's a wrong statement of course.
> We do need to re-apply the ignore mask when narrowing the event mask.
> 
> Exposing the bug requires a "compound" event.
> 
> The only case of compound event I could think of is this:
> 
> mount mark with mask == 0 and ignore_mask == FAN_OPEN. inode mark
> on a directory with mask == FAN_EXEC | FAN_EVENT_ON_CHILD.
> 
> The event: FAN_OPEN | FAN_EXEC | FAN_EVENT_ON_CHILD
> would be reported to group with the FAN_OPEN flag despite the
> fact that FAN_OPEN is in ignore mask of mount mark because
> the mark iteration loop skips over non-inode marks for events
> on child.
> 
> I'll try to work that case into the relevant LTP test to prove it and
> post a fix.

Ha, that's clever. But FAN_EXEC does not exist in current fanotify. We only
have FAN_OPEN_EXEC... And I don't think we have any compound events. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
