Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43B8133DC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 10:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgAHJEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 04:04:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:46786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgAHJEh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:04:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8020FAED8;
        Wed,  8 Jan 2020 09:04:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 234FA1E0B47; Wed,  8 Jan 2020 10:04:34 +0100 (CET)
Date:   Wed, 8 Jan 2020 10:04:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Wez Furlong <wez@fb.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: File monitor problem
Message-ID: <20200108090434.GA20521@quack2.suse.cz>
References: <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
 <20191211100604.GL1551@quack2.suse.cz>
 <CAOQ4uxij13z0AazCm7AzrXOSz_eYBSFhs0mo6eZFW=57wOtwew@mail.gmail.com>
 <CAOQ4uxiKzom5uBNbBpZTNCT0XLOrcHmOwYy=3-V-Qcex1mhszw@mail.gmail.com>
 <CAOQ4uxgBcLPGxGVddjFsfWJvcNH4rT+GrN6-YhH8cz5K-q5z2g@mail.gmail.com>
 <20191223181956.GB17813@quack2.suse.cz>
 <CAOQ4uxhUGCLQyq76nqREETT8kBV9uNOKsckr+xmJdR9Xm=cW3Q@mail.gmail.com>
 <CAOQ4uxjwy4_jWitzHc9hSaBJwVZM68xxJTub50ZfrtgFSZFH8A@mail.gmail.com>
 <20200107171014.GI25547@quack2.suse.cz>
 <CAOQ4uxjx_n3f44yu9_2dGxtBGy3WssG0xfZykwjQ+n=Wcii2-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjx_n3f44yu9_2dGxtBGy3WssG0xfZykwjQ+n=Wcii2-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 07-01-20 20:56:20, Amir Goldstein wrote:
> On Tue, Jan 7, 2020 at 7:10 PM Jan Kara <jack@suse.cz> wrote:
> > > There is another weird way to obfuscate the event type.
> > > I am not sure if users will be less confused about it:
> > > Each event type belongs to a group (i.e. self, dirent, poss_on_child)
> > > User may set any event type in the mask (e.g. create|delete|open|close)
> > > When getting an event from event group A (e.g. create), all event types
> > > of that group will be reported (e.g. create|delete).
> > >
> > > To put it another way:
> > > #define FAN_DIR_MODIFY (FAN_CREATE | FAN_MOVE | FAN_DELETE)
> > >
> > > For example in fanotify_group_event_mask():
> > > if (event_with_name) {
> > >     if (marks_mask & test_mask & FAN_DIR_MODIFY)
> > >         test_mask |= marks_mask & FAN_DIR_MODIFY
> > > ...
> > >
> > > Did somebody say over-engineering? ;)
> > >
> > > TBH, I don't see how we can do event type obfuscation
> > > that is both usable and not confusing, because the concept is
> > > confusing. I understand the reasoning behind it, but I don't think
> > > that many users will.
> > >
> > > I'm hoping that you can prove me wrong and find a way to simplify
> > > the API while retaining fair usability.
> >
> > I was thinking about this. If I understand the problem right, depending on
> > the usecase we may need with each event some subset of 'object fid',
> > 'directory fid', 'name in directory'. So what if we provided all these
> > three things in each event? Events will get somewhat bloated but it may be
> > bearable.
> >
> 
> I agree.
> 
> What I like about the fact that users don't need to choose between
> 'parent fid' and 'object fid' is that it makes some hard questions go away:
> 1. How are "self" events reported? simple - just with 'object id'
> 2. How are events on disconnected dentries reported? simple - just
> with 'object id'
> 3. How are events on the root of the watch reported? same answer
> 
> Did you write 'directory fid' as opposed to 'parent fid' for a reason?
> Was it your intention to imply that events on directories (e.g.
> open/close/attrib) are
> never reported with 'parent fid' , 'name in directory'?

Yes, that was what I thought.
 
> I see no functional problem with making that distinction between directory and
> non-directory, but I have a feeling that 'parent fid', 'name in
> directory', 'object id',
> regardless of dir/non-dir is going to be easier to document and less confusing
> for users to understand, so this is my preference.

Understood. The reason why I decided like this is that for a directory,
the parent may be actually on a different filesystem (so generating fid
will be more difficult) and also that what you get from dentry->d_parent
need not be the dir through which you actually reached the directory (think
of bind mounts) which could be a bit confusing. So I have no problem with
always providing 'parent fid' if we can give good answers to these
questions...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
