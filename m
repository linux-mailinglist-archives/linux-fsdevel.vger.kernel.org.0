Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2D827FDF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbgJALBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 07:01:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:48578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731913AbgJALBA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:01:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 940A1B2DF;
        Thu,  1 Oct 2020 11:00:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3B7321E12EF; Thu,  1 Oct 2020 13:00:58 +0200 (CEST)
Date:   Thu, 1 Oct 2020 13:00:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Weiping Zhang <zhangweiping@didiglobal.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [RFC PATCH] inotify: add support watch open exec event
Message-ID: <20201001110058.GG17860@quack2.suse.cz>
References: <20200914172737.GA5011@192.168.3.9>
 <20200915070841.GF4863@quack2.suse.cz>
 <CAOQ4uxjxNmem7dwSMcqefGt5qaxwtHTYQ-k_kxuoMX_vJeTGOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjxNmem7dwSMcqefGt5qaxwtHTYQ-k_kxuoMX_vJeTGOg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm sorry for late reply on this one...

On Tue 15-09-20 11:33:41, Amir Goldstein wrote:
> On Tue, Sep 15, 2020 at 10:08 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 15-09-20 01:27:43, Weiping Zhang wrote:
> > > Now the IN_OPEN event can report all open events for a file, but it can
> > > not distinguish if the file was opened for execute or read/write.
> > > This patch add a new event IN_OPEN_EXEC to support that. If user only
> > > want to monitor a file was opened for execute, they can pass a more
> > > precise event IN_OPEN_EXEC to inotify_add_watch.
> > >
> > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> >
> > Thanks for the patch but what I'm missing is a justification for it. Is
> > there any application that cannot use fanotify that needs to distinguish
> > IN_OPEN and IN_OPEN_EXEC? The OPEN_EXEC notification is for rather
> > specialized purposes (e.g. audit) which are generally priviledged and need
> > to use fanotify anyway so I don't see this as an interesting feature for
> > inotify...
> 
> That would be my queue to re- bring up FAN_UNPRIVILEGED [1].
> Last time this was discussed [2], FAN_UNPRIVILEGED did not have
> feature parity with inotify, but now it mostly does, short of (AFAIK):
> 1. Rename cookie (*)
> 2. System tunables for limits
> 
> The question is - should I pursue it?

So I think that at this point some form less priviledged fanotify use
starts to make sense. So let's discuss how it would look like... What comes
to my mind:

1) We'd need to make max_user_instances, max_user_watches, and
max_queued_events configurable similarly as for inotify. The first two
using ucounts so that the configuration is actually per-namespace as for
inotify.

2) I don't quite like the FAN_UNPRIVILEDGED flag. I'd rather see the checks
being done based on functionality requested in fanotify_init() /
fanotify_mark(). E.g. FAN_UNLIMITED_QUEUE or permission events will require
CAP_SYS_ADMIN, mount/sb marks will require CAP_DAC_READ_SEARCH, etc.
We should also consider which capability checks should be system-global and
which can be just user-namespace ones...

> You asked about incentive to use feature parity fanotify and not intotify.
> One answer is the ignored mask. It may be a useful feature to some.
> 
> But mostly, using the same interface for both priv and unpriv is convenient
> for developers and it is convenient for kernel maintainers.

I agree about userspace developers, for kernel I think that allowing
unpriviledged fanotify has actually additional maintenance cost - all that
additional code with limits & capability checks, larger attack surface
available for unpriviledged tasks so more security scrutiny & CVE handling,
etc. And we have to maintain inotify exactly as much as previously at least
for the following decade, likely even longer.

> I'd like to be able to make the statement that inotify code is maintained in
> bug fixes only mode, which has mostly been the reality for a long time.

Yes, I agree that inotify is in maintenance only mode.

> But in order to be able to say "no reason to add IN_OPEN_EXEC", we
> do need to stand behind the feature parity with intotify.
> 
> So I apologize to Weiping for hijacking his thread, but I think we should
> get our plans declared before deciding on IN_OPEN_EXEC, because
> whether there is a valid use case for non-priv user who needs IN_OPEN_EXEC
> event is not the main issue IMO. Even if there isn't, we need an answer for
> the next proposed inotify feature that does have a non-priv user use case.

Here I disagree. How I see it is that *if* there's real serious user for
IN_OPEN_EXEC which cannot currently use FAN_OPEN_EXEC, we should either
make FAN_OPEN_EXEC available to it or bite the bullet, do exception, and
extend inotify. But the "if" part isn't currently true so I don't see
IN_OPEN_EXEC query force us either way...

> [1] https://github.com/amir73il/linux/commits/fanotify_unpriv
> [2] https://lore.kernel.org/linux-fsdevel/20181114135744.GB20704@quack2.suse.cz/
> 
> (*) I got an internal complaint about missing the rename cookie with
> FAN_REPORT_NAME, so I had to carry a small patch internally.
> The problem is not that the rename cookie is really needed, but that without
> the rename cookie, events can be re-ordered across renames and that can
> generate some non-deterministic event sequences.
> 
> So I am thinking of keeping the rename cookie in the kernel event just for
> no-merge indication and then userspace can use object fid to match
> MOVED_FROM/MOVED_TO events.

Well, the event sequences are always non-deterministic due to event
merging. So I'm somewhat surprised that rename events particularly matter.
I suspect the code relying on "determinism" is buggy, it just perhaps
doesn't manifest in practice for other event types...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
