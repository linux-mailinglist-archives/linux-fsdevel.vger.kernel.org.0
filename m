Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC03132CA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgAGRKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:10:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:48916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgAGRKR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:10:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A1DDB15D;
        Tue,  7 Jan 2020 17:10:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2528E1E0B47; Tue,  7 Jan 2020 18:10:14 +0100 (CET)
Date:   Tue, 7 Jan 2020 18:10:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Wez Furlong <wez@fb.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: File monitor problem
Message-ID: <20200107171014.GI25547@quack2.suse.cz>
References: <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
 <20191204190206.GA8331@bombadil.infradead.org>
 <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
 <20191211100604.GL1551@quack2.suse.cz>
 <CAOQ4uxij13z0AazCm7AzrXOSz_eYBSFhs0mo6eZFW=57wOtwew@mail.gmail.com>
 <CAOQ4uxiKzom5uBNbBpZTNCT0XLOrcHmOwYy=3-V-Qcex1mhszw@mail.gmail.com>
 <CAOQ4uxgBcLPGxGVddjFsfWJvcNH4rT+GrN6-YhH8cz5K-q5z2g@mail.gmail.com>
 <20191223181956.GB17813@quack2.suse.cz>
 <CAOQ4uxhUGCLQyq76nqREETT8kBV9uNOKsckr+xmJdR9Xm=cW3Q@mail.gmail.com>
 <CAOQ4uxjwy4_jWitzHc9hSaBJwVZM68xxJTub50ZfrtgFSZFH8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjwy4_jWitzHc9hSaBJwVZM68xxJTub50ZfrtgFSZFH8A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-12-19 05:49:42, Amir Goldstein wrote:
> > > I can see the need for FAN_DIR_MODIFIED_WITH_NAME
> > > (stupid name, I know) - generated when something changed with names in a
> > > particular directory, reported with FID of the directory and the name
> > > inside that directory involved with the change. Directory watching
> > > application needs this to keep track of "names to check". Is the name
> > > useful with any other type of event? _SELF events cannot even sensibly have
> > > it so no discussion there as you mention below. Then we have OPEN, CLOSE,
> > > ACCESS, ATTRIB events. Do we have any use for names with those?
> > >
> >
> > The problem is that unlike dir fid, file fid cannot be reliably resolved
> > to path, that is the reason that I implemented  FAN_WITH_NAME
> > for events "possible on child" (see branch fanotify_name-wip).

Ok, but that seems to be a bit of an abuse, isn't it? Because with parent
fid + name you may reconstruct the path but you won't be able to reliably
identify the object where the operation happened? Even worse users can
mistakenly think that parent fid + name identify the object but that is
racy... This is exactly the kind of confusion I'd like to avoid with the
new API.

OTOH I understand that e.g. a file monitor may want to monitor CLOSE_WRITE
like you mention below just to record directory FID + name as something
that needs resyncing. So I agree that names in events other than directory
events are useful as well. And I also agree that for that usecase what you
propose would be fine.

> > A filesystem monitor typically needs to be notified on name changes and on
> > data/metadata modifications.
> >
> > So maybe add just two new event types:
> > FAN_DIR_MODIFY
> > FAN_CHILD_MODIFY
> >
> > Both those events are reported with name and allowed only with init flag
> > FAN_REPORT_FID_NAME.
> > User cannot filter FAN_DIR_MODIFY by part of create/delete/move.
> > User cannot filter FAN_CHILD_MODIFY by part of attrib/modify/close_write.
> 
> Nah, that won't do. I now remember discussing this with out in-house monitor
> team and they said they needed to filter out FAN_MODIFY because it was too
> noisy and rely on FAN_CLOSE_WRITE. And other may want open/access as
> well.

So for open/close/modify/read/attrib I don't see a need to obfuscate the
event type. They are already abstract enough so I don't see how they could
be easily misinterpretted. With directory events the potential for
"optimizations" that are subtly wrong is IMHO much bigger.

> There is another weird way to obfuscate the event type.
> I am not sure if users will be less confused about it:
> Each event type belongs to a group (i.e. self, dirent, poss_on_child)
> User may set any event type in the mask (e.g. create|delete|open|close)
> When getting an event from event group A (e.g. create), all event types
> of that group will be reported (e.g. create|delete).
> 
> To put it another way:
> #define FAN_DIR_MODIFY (FAN_CREATE | FAN_MOVE | FAN_DELETE)
> 
> For example in fanotify_group_event_mask():
> if (event_with_name) {
>     if (marks_mask & test_mask & FAN_DIR_MODIFY)
>         test_mask |= marks_mask & FAN_DIR_MODIFY
> ...
> 
> Did somebody say over-engineering? ;)
> 
> TBH, I don't see how we can do event type obfuscation
> that is both usable and not confusing, because the concept is
> confusing. I understand the reasoning behind it, but I don't think
> that many users will.
> 
> I'm hoping that you can prove me wrong and find a way to simplify
> the API while retaining fair usability.

I was thinking about this. If I understand the problem right, depending on
the usecase we may need with each event some subset of 'object fid',
'directory fid', 'name in directory'. So what if we provided all these
three things in each event? Events will get somewhat bloated but it may be
bearable.

With this information we could reliably reconstruct (some) path (we always
have directory fid + name), we can reliably identify the object involved in
the change (we always have object fid). I'd still prefer if we obfuscated
directory events, without possibility of filtering based of
CREATE/DELETE/MOVE (i.e., just one FAN_DIR_MODIFY event for this fanotify
group) - actually I have hard time coming with a usecase where application
would care about one type of event and not the other one. The other events
remain as they are. What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
