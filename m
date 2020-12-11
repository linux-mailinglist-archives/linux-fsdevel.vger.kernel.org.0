Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4387A2D742B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 11:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393404AbgLKKr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 05:47:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:53442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393198AbgLKKr4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:47:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41EAFAC10;
        Fri, 11 Dec 2020 10:47:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8B6C21E1352; Fri, 11 Dec 2020 11:47:13 +0100 (CET)
Date:   Fri, 11 Dec 2020 11:47:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-next fsnotify mod breaks tail -f
Message-ID: <20201211104713.GA15413@quack2.suse.cz>
References: <alpine.LSU.2.11.2012101507080.1100@eggly.anvils>
 <CAOQ4uxj6Vvwj84KL4MaECzw1jV+i_Frm6cuqkrk8fT3a4M=FEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj6Vvwj84KL4MaECzw1jV+i_Frm6cuqkrk8fT3a4M=FEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 11-12-20 10:42:16, Amir Goldstein wrote:
> On Fri, Dec 11, 2020 at 1:45 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > Hi Jan, Amir,
> >
> > There's something wrong with linux-next commit ca7fbf0d29ab
> > ("fsnotify: fix events reported to watching parent and child").
> >
> > If I revert that commit, no problem;
> > but here's a one-line script "tailed":
> >
> > for i in 1 2 3 4 5; do date; sleep 1; done &
> >
> > Then if I run that (same result doing ./tailed after chmod a+x):
> >
> > sh tailed >log; tail -f log
> >
> > the "tail -f log" behaves in one of three ways:
> >
> > 1) On a console, before graphical screen, no problem,
> >    it shows the five lines coming from "date" as you would expect.
> > 2) From xterm or another tty, shows just the first line from date,
> >    but after I wait and Ctrl-C out, "cat log" shows all five lines.
> > 3) From xterm or another tty, doesn't even show that first line.
> >
> > The before/after graphical screen thing seems particularly weird:
> > I expect you'll end up with a simpler explanation for what's
> > causing that difference.
> >
> > tailed and log are on ext4, if that's relevant;
> > ah, I just tried on tmpfs, and saw no problem there.
> 
> Nice riddle Hugh :)
> Thanks for this early testing!
> 
> I was able to reproduce this.
> The outcome does not depend on the type of terminal or filesystem
> it depends on the existence of a watch on the parent dir of the log file.
> Running ' inotifywait -m . &' will stop tail from getting notifications:
> 
> echo > log
> tail -f log &
> sleep 1
> echo "can you see this?" >> log
> inotifywait -m . &
> sleep 1
> echo "how about this?" >> log
> kill $(jobs -p)
> 
> I suppose with a graphical screen you have systemd or other services
> in the system watching the logs/home dir in your test env.
> 
> Attached fix patch. I suppose Jan will want to sqhash it.
> 
> We missed a subtle logic change in the switch from inode/child marks
> to parent/inode marks terminology.
> 
> Before the change (!inode_mark && child_mark) meant that name
> was not NULL and should be discarded (which the old code did).
> After the change (!parent_mark && inode_mark) is not enough to
> determine if name should be discarded (it should be discarded only
> for "events on child"), so another check is needed.

Thanks for testing Hugh and for a quick fix Amir! I've folded it into the
original buggy commit.

								Honza

> 
> Thanks,
> Amir.

> From c7ea57c66c8c9f9607928bf7c55fc409eecc3e57 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Fri, 11 Dec 2020 10:19:36 +0200
> Subject: [PATCH] fsnotify: fix for fix events reported to watching parent and
>  child
> 
> The child watch is expecting an event without file name and without
> the ON_CHILD flag.
> 
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fsnotify.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index a0da9e766992..30d422b8c0fc 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -291,13 +291,18 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
>  		}
>  		if (!inode_mark)
>  			return 0;
> +	}
>  
> +	if (mask & FS_EVENT_ON_CHILD) {
>  		/*
>  		 * Some events can be sent on both parent dir and child marks
>  		 * (e.g. FS_ATTRIB).  If both parent dir and child are
>  		 * watching, report the event once to parent dir with name (if
>  		 * interested) and once to child without name (if interested).
> +		 * The child watcher is expecting an event without a file name
> +		 * and without the FS_EVENT_ON_CHILD flag.
>  		 */
> +		mask &= ~FS_EVENT_ON_CHILD;
>  		dir = NULL;
>  		name = NULL;
>  	}
> -- 
> 2.25.1
> 

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
