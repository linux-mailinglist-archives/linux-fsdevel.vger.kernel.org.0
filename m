Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9343D8979
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 10:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhG1IHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 04:07:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34896 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbhG1IHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:07:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 010DB222D3;
        Wed, 28 Jul 2021 08:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627459662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OXI0uktMkctmL9XFBy07luz+iWONpftBvU1Q3doyNg4=;
        b=S0+UERrIhbNy/3eVuwC5CNnvQYo40sg79taj2C18YlKJGbhMrv+NZbBh2yjGDG9aRkg4a2
        Nt9KvIofEiNJf/WPaTP67+0/xOXx5R8iBaMlYdTnTDfoY5rV7XoEnMooowE+GKxJcmI1rm
        pcHjHOso0fNRzK3khl9u1IEKZjOYfoQ=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DAF0DA3B85;
        Wed, 28 Jul 2021 08:07:40 +0000 (UTC)
Date:   Wed, 28 Jul 2021 10:07:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        joe@perches.com, Jan Kara <jack@suse.cz>, hare@suse.de,
        Jens Axboe <axboe@kernel.dk>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>,
        johannes.berg@intel.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, arnd@arndb.de,
        Chris Down <chris@chrisdown.name>, mingo@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v6 2/2] init/do_mounts.c: create second mount for
 initramfs
Message-ID: <YQEQTO+AwC67BT4u@alley>
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210605034447.92917-3-dong.menglong@zte.com.cn>
 <20210605115019.umjumoasiwrclcks@wittgenstein>
 <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
 <20210607103147.yhniqeulw4pmvjdr@wittgenstein>
 <20210607121524.GB3896@www>
 <20210617035756.GA228302@www>
 <20210617143834.ybxk6cxhpavlf4gg@wittgenstein>
 <CADxym3aLQNJaWjdkMVAjuVk_btopv6jHrVjtP+cKwH8x6R7ojQ@mail.gmail.com>
 <20210727123701.zlcrrf4p2fsmeeas@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727123701.zlcrrf4p2fsmeeas@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-07-27 14:37:01, Christian Brauner wrote:
> On Tue, Jul 27, 2021 at 08:24:03PM +0800, Menglong Dong wrote:
> > Hello Christian,
> > 
> > On Thu, Jun 17, 2021 at 10:38 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > [...]
> > >
> > > Hey Menglong,
> > >
> > > Since we're very close to the next kernel release it's unlikely that
> > > anything will happen before the merge window has closed.
> > > Otherwise I think we're close. I haven't had the time to test yet but if
> > > nothing major comes up I'll pick it up and route it through my tree.
> > > We need to be sure there's no regressions for anyone using this.
> > >
> > 
> > Seems that it has been a month, and is it ok to move a little
> > further? (knock-knock :/)
> 
> Yep, sorry.
> When I tested this early during the merge window it regressed booting a
> regular system for me meaning if I compiled a kernel with this feature
> enabled it complained about not being being able to open an initial
> console and it dropped me right into initramfs instead of successfully
> booting. I haven't looked into what this is caused or how to fix it for
> lack of time.

I guess that you have seen the following message printed by
console_on_rootfs():

      "Warning: unable to open an initial console."

This function is responsible for opening stdin, stdout, stderr
file to be used by the init process.

I am not sure how this is supposed to work with the pivot_root
and initramfs.


Some more details:

console_on_rootfs() tries to open /dev/console. It is created
by tty_init(). The open() callback calls:

  + tty_kopen()
    + tty_lookup_driver()
      + console_device()

, where console_device() iterates over all registered consoles
  and returns the first with tty binding.

There is ttynull_console that might be used as a fallback. But I
am not sure if this is what you want.

Best Regards,
Petr
