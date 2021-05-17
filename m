Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDF13827D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhEQJKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 05:10:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:33454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235861AbhEQJKq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89A08AFCF;
        Mon, 17 May 2021 09:09:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0CE231F2CA4; Mon, 17 May 2021 11:09:28 +0200 (CEST)
Date:   Mon, 17 May 2021 11:09:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20210517090928.GA31755@quack2.suse.cz>
References: <20210503165315.GE2994@quack2.suse.cz>
 <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz>
 <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz>
 <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
 <20210512152625.i72ct7tbmojhuoyn@wittgenstein>
 <20210513105526.GG2734@quack2.suse.cz>
 <20210514135632.d53v3pwrh56pnc4d@wittgenstein>
 <CAOQ4uxgngZjBseOC_qYtxjZ_J4Rc50_Y7G+CSSpJznKBXvSU5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgngZjBseOC_qYtxjZ_J4Rc50_Y7G+CSSpJznKBXvSU5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 15-05-21 17:28:27, Amir Goldstein wrote:
> On Fri, May 14, 2021 at 4:56 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > > for changes with idmap-filtered mark, then it won't see notification for
> > > those changes because A presumably runs in a different namespace than B, am
> > > I imagining this right? So mark which filters events based on namespace of
> > > the originating process won't be usable for such usecase AFAICT.
> >
> > Idmap filtered marks won't cover that use-case as envisioned now. Though
> > I'm not sure they really need to as the semantics are related to mount
> > marks.
> 
> We really need to refer to those as filesystem marks. They are definitely
> NOT mount marks. We are trying to design a better API that will not share
> as many flaws with mount marks...

I agree. I was pondering about this usecase exactly because the problem with
changes done through mount A and visible through mount B which didn't get
a notification were source of complaints about fanotify in the past and the
reason why you came up with filesystem marks.

> > A mount mark would allow you to receive events based on the
> > originating mount. If two mounts A and B are separate but expose the
> > same files you wouldn't see events caused by B if you're watching A.
> > Similarly you would only see events from mounts that have been delegated
> > to you through the idmapped userns. I find this acceptable especially if
> > clearly documented.
> >
> 
> The way I see it, we should delegate all the decisions over to userspace,
> but I agree that the current "simple" proposal may not provide a good
> enough answer to the case of a subtree that is shared with the host.
> 
> IMO, it should be a container manager decision whether changes done by
> the host are:
> a) Not visible to containerized application
> b) Watched in host via recursive inode watches
> c) Watched in host by filesystem mark filtered in userspace
> d) Watched in host by an "noop" idmapped mount in host, through
>      which all relevant apps in host access the shared folder
> 
> We can later provide the option of "subtree filtered filesystem mark"
> which can be choice (e). It will incur performance overhead on the system
> that is higher than option (d) but lower than option (c).

But won't b) and c) require the container manager to inject events into the
event stream observed by the containerized fanotify user? Because in both
these cases the manager needs to consume generated events and decide what
to do with them.

> In the end, it all depends on the individual use case.
> 
> The way forward as I see it is:
> 1. Need to write a proposal where FAN_MARK_IDMAPPED is the
>     first step towards a wider API that also includes subtree marks -
>     whether we end up implementing subtree mark or not
> 2. Need to make sure that setting up N idmapped marks
>     does not have O(N) performance overhead on the system
> 3. Need to make sure that the idmapped marks proposal is deemed
>     desired by concrete container manager project and use cases
> 
> If there are no objections to this roadmap, I will prepare the
> proposal on my next context switch.

OK, sounds good.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
