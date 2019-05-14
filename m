Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6C1C5FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfENJZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 05:25:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:53398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbfENJZU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 05:25:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83CE3AD5C;
        Tue, 14 May 2019 09:25:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 361A11E3C55; Tue, 14 May 2019 11:25:19 +0200 (CEST)
Date:   Tue, 14 May 2019 11:25:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Olivier Chapelliere <olivier.chapelliere@alcmeon.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: stuck in inotify_release
Message-ID: <20190514092519.GA20782@quack2.suse.cz>
References: <CANp+0hhbsegocrx-MK0DS=Qx4DfivB27nSKHrukiFAY6x6cJQA@mail.gmail.com>
 <20190328095207.GD22915@quack2.suse.cz>
 <CANp+0hhdCeP4R=MJFkk2z=v5Q5z1K0gjVCWRz_T6mwzsYtx36g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp+0hhdCeP4R=MJFkk2z=v5Q5z1K0gjVCWRz_T6mwzsYtx36g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Mon 06-05-19 20:54:24, Olivier Chapelliere wrote:
> It finally took a month to happen again : python processes watching a
> directory are stuck in inotify_release.
> I ran the sysrq commands as you requested and attached the result.

Thanks. I was looking into these traces but the situation is the same as
before. Everyone is blocked waiting for inotify group to shut down. That is
blocked waiting for worker to finish destroying notification marks and the
worker is blocked in synchronize_srcu() waiting for SRCU grace period to
end. Now I didn't find any process that would be holding the SRCU lock so
it seems that someone exited the SRCU locked section without releasing the
lock. I've checked 4.15 your Ubuntu kernel is based on and I don't see how
that would be possible. It it possible though, that the problem is
introduced by some Ubuntu specific backports. Would it be possible for you
to run some vanilla kernel (i.e., without Ubuntu modifications)?

								Honza

> On Thu, Mar 28, 2019 at 10:52 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello,
> >
> > On Thu 28-03-19 09:26:45, Olivier Chapelliere wrote:
> > > According to what I read on internet you seem to be the right person to get
> > > in touch with when one has problems with inotify.
> >
> > Yes, there's also linux-fsdevel@vger.kernel.org mailing list which we use
> > (added to CC).
> >
> > > We are monitoring several directories in python processes through inotify.
> > > But after few days all processes are stuck in a call to inotify_release.
> > > Once I detected the problem, I dumped info to dmesg with sysrq-trigger
> > > (dmesg content attached):
> > > echo w > /proc/sysrq-trigger
> >
> > Looking through the stack traces, all of them wait in fput() ->
> > inotify_release() -> ... -> fsnotify_wait_marks_destroyed() ->
> > flush_delayed_work(&reaper_work). So they wait for worker process to
> > destroy all marks for the group. However that worker (kworker/u8:4) is
> > stuck in:
> >
> > fsnotify_mark_destroy_workfn() -> synchronize_srcu(&fsnotify_mark_srcu)
> >
> > So the question is who is holding fsnotify_mark_srcu so that SRCU cannot
> > declare new grace period. I don't see any such process among the processes
> > you've shown in the dump (but it should be there) so it's a bit of a
> > mystery.
> >
> > > Our production env is ubuntu 18.04 kernel 4.15 fs ext4
> > > This problem appears on a weekly basis so I will be able to run additional
> > > commands to track down the issue if needed.
> >
> > So when this happens again, try grabbing output of sysrq-l and sysrq-t if
> > we can find the task holding fsnotify_mark_srcu.
> >
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> 
> 
> -- 
> Olivier Chapelliere


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
