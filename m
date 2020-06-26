Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95DD20AF39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFZJuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 05:50:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:57208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgFZJuB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 05:50:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B5A5AF21;
        Fri, 26 Jun 2020 09:49:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2FA6E1E12A8; Fri, 26 Jun 2020 11:49:59 +0200 (CEST)
Date:   Fri, 26 Jun 2020 11:49:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [GIT PULL] fsnotify speedup for 5.8-rc3
Message-ID: <20200626094959.GB26507@quack2.suse.cz>
References: <20200625181948.GF17788@quack2.suse.cz>
 <CAHk-=wj8XGkaPe1+ROAMUPK3Gfcx_tQY+RzUuSwksJepz8pQkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8XGkaPe1+ROAMUPK3Gfcx_tQY+RzUuSwksJepz8pQkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 25-06-20 13:12:34, Linus Torvalds wrote:
> On Thu, Jun 25, 2020 at 11:19 AM Jan Kara <jack@suse.cz> wrote:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.8-rc3
> >
> > to get a performance improvement to reduce impact of fsnotify for inodes
> > where it isn't used.
> 
> Pulled.

Thanks.

> I do note that there's some commonality here with commit ef1548adada5
> ("proc: Use new_inode not new_inode_pseudo") and the discussion there
> around "maybe new_inode_pseudo should disable fsnotify instead".
> 
> See
> 
>     https://lore.kernel.org/lkml/CAHk-=wh7nZNf81QPcgpDh-0jzt2sOF3rdUEB0UcZvYFHDiMNkw@mail.gmail.com/
> 
> and in particular the comment there:
> 
>         I do wonder if we should have kept the new_inode_pseudo(),
>     and instead just make fsnotify say "you can't notify on an inode that
>     isn't on the superblock list"
> 
>  which is kind of similar to this alloc_file_pseudo() change..
> 
> There it wasn't so much about performance, as about an actual bug
> (quoting from that commit):
> 
>     Recently syzbot reported that unmounting proc when there is an ongoing
>     inotify watch on the root directory of proc could result in a use
>     after free when the watch is removed after the unmount of proc
>     when the watcher exits.
> 
> but the fnsotify connection and the "pseudo files/inodes can't be
> notified about" is the same.

Thanks for notification. I think I've seen the original syzbot report but
then lost track of how Eric solved it. Ideally I'd just forbid fsnotify on
every virtual fs (proc, sysfs, sockets, ...) because it is not very useful
and only causes issues - besides current issues, there were also issues in
the past which resulted in 0b3b094ac9a7 "fanotify: Disallow permission
events for proc filesystem". The only events that get reliably generated
for these virtual filesystems are FS_OPEN / FS_CLOSE ones - and that's why
I didn't yet disable fsnotify on the large scale for the virtual
filesystems. Also I'm slightly concerned that someone might be mistakenly
putting notification marks on virtual inodes where they don't generate any
events but if we started to disallow such marks, the app would break
because it doesn't expect error. But maybe we could try doing this a see
whether someone complains...

WRT "you can't notify on an inode that isn't on the superblock list" -
that's certainly a requirement for fsnotify to work reliably but because we
can add notification marks not only for inodes but also for mountpoint or
superblock, I'd rather go for a superblock flag or file_system_type flag
like I did in above mentioned 0b3b094ac9a7 because that seems more robust
and I don't see a need for finer grained control of whether fsnotify makes
sence or not.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
