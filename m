Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1A6220E10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 15:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbgGONY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 09:24:57 -0400
Received: from [195.135.220.15] ([195.135.220.15]:50434 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1730868AbgGONY5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:24:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A751EAD1A;
        Wed, 15 Jul 2020 13:24:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2FF411E12C9; Wed, 15 Jul 2020 15:24:55 +0200 (CEST)
Date:   Wed, 15 Jul 2020 15:24:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Francesco Ruggeri <fruggeri@arista.com>
Subject: Re: [PATCH] fanotify: Avoid softlockups when reading many events
Message-ID: <20200715132455.GN23073@quack2.suse.cz>
References: <20200715122921.5995-1-jack@suse.cz>
 <CAOQ4uxjJCKVQU0FaN-gU4RLcE97YnNAZMdg6RRbKeLjOLW7dCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjJCKVQU0FaN-gU4RLcE97YnNAZMdg6RRbKeLjOLW7dCw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-07-20 15:34:48, Amir Goldstein wrote:
> On Wed, Jul 15, 2020 at 3:29 PM Jan Kara <jack@suse.cz> wrote:
> >
> > When user provides large buffer for events and there are lots of events
> > available, we can try to copy them all to userspace without scheduling
> > which can softlockup the kernel (furthermore exacerbated by the
> > contention on notification_lock). Add a scheduling point after copying
> > each event.
> >
> > Note that usually the real underlying problem is the cost of fanotify
> > event merging and the resulting contention on notification_lock but this
> > is a cheap way to somewhat reduce the problem until we can properly
> > address that.
> >
> > Reported-by: Francesco Ruggeri <fruggeri@arista.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > This is a quick mending we can do immediately and is probably a good idea
> > nevertheless... I'll queue it up if Amir agrees.
> >
> 
> Sure. fine by me.
> Maybe add a lore link to the issue report.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks. I've added the link and pushed out the patch to my tree.

									Honza

> 
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 63b5dffdca9e..d7f63aeca992 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -412,6 +412,11 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
> >
> >         add_wait_queue(&group->notification_waitq, &wait);
> >         while (1) {
> > +               /*
> > +                * User can supply arbitrarily large buffer. Avoid softlockups
> > +                * in case there are lots of available events.
> > +                */
> > +               cond_resched();
> >                 event = get_one_event(group, count);
> >                 if (IS_ERR(event)) {
> >                         ret = PTR_ERR(event);
> > --
> > 2.16.4
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
