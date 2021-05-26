Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E95D39134B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 11:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhEZJEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 05:04:52 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:36800 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhEZJEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 05:04:44 -0400
Received: by mail-pl1-f176.google.com with SMTP id a7so291999plh.3;
        Wed, 26 May 2021 02:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfaHo86msd1EgsJw0CluY8kQybsB/BEq62rqhKYqHGg=;
        b=HE7d6v1gxGcHupBLogEwpNG56jVwVarfR4ICrIr+JrTI0a4vJth+fBAIK/IX54QE+6
         725blKc+1U8uhAMZeA3rkSAISwzW5ekhzEmdAIHt5CN+Efniov49I1y8srj22a1SluDi
         fchU7jdaD28lilprVqZxqgK9Xp5sewGfDbR8bX+yk4faTLmDFFSgRbjAMTt2XJ+svk1A
         KKzJQSsBeZKAkdkkRjTcbqCezs2xuBjTvQyd6poSJHV9WUAObiy7/d6sCoDQpcZZiB6/
         mEjyJ4fiDtAEEmgFGjAZaO+4bEPC9WG0HBVxFdl4HhuG7fMREPVxquCsO+lDv0c+CQq3
         v6sw==
X-Gm-Message-State: AOAM5311LoHKBv4BVLY2wuHnfGlTPdZnepCYZ/GrgSw6Zt52/6x0xwOz
        34legj2I10zOIKWDgZ0EQiM=
X-Google-Smtp-Source: ABdhPJzCzlRGDdb9oh59T1rIT1mKuLZYc1+OZySDa6uTw/G4F08G+VegLYCrJe2h9nQXC5lGK3c4Rw==
X-Received: by 2002:a17:902:bf46:b029:ee:b949:bd0 with SMTP id u6-20020a170902bf46b02900eeb9490bd0mr34888223pls.14.1622019792132;
        Wed, 26 May 2021 02:03:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id gg10sm13914062pjb.49.2021.05.26.02.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 02:03:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 27E3840254; Wed, 26 May 2021 09:03:10 +0000 (UTC)
Date:   Wed, 26 May 2021 09:03:10 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, ojeda@kernel.org,
        johan@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        masahiroy@kernel.org, Menglong Dong <dong.menglong@zte.com.cn>,
        joe@perches.com, Jens Axboe <axboe@kernel.dk>, hare@suse.de,
        Jan Kara <jack@suse.cz>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        wangkefeng.wang@huawei.com, Barret Rhoden <brho@google.com>,
        mhiramat@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        vbabka@suse.cz, Alexander Potapenko <glider@google.com>,
        pmladek@suse.com, Chris Down <chris@chrisdown.name>,
        jojing64@gmail.com, terrelln@fb.com, geert@linux-m68k.org,
        mingo@kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, jeyu@kernel.org
Subject: Re: [PATCH v2 2/3] init/do_cmounts.c: introduce 'user_root' for
 initramfs
Message-ID: <20210526090310.GI4332@42.do-not-panic.com>
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
 <20210525141524.3995-3-dong.menglong@zte.com.cn>
 <m18s42odgz.fsf@fess.ebiederm.org>
 <CADxym3a5nsuw2hiDF=ZS51Wpjs-i_VW+OGd-sgGDVrKYw2AiHQ@mail.gmail.com>
 <m11r9umb4y.fsf@fess.ebiederm.org>
 <YK3Pb/OGwWVzvDZM@localhost>
 <CADxym3bznknEWLaa-SgYZAsTGucP_9m+9=JW7oc6=ggrUaBk7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3bznknEWLaa-SgYZAsTGucP_9m+9=JW7oc6=ggrUaBk7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 04:33:00PM +0800, Menglong Dong wrote:
> On Wed, May 26, 2021 at 12:33 PM Josh Triplett <josh@joshtriplett.org> wrote:
> >
> > On Tue, May 25, 2021 at 10:23:09PM -0500, Eric W. Biederman wrote:
> > > If we are going to do this something that is so small and clean it can
> > > be done unconditionally always.
> > [...]
> > > The net request as I understand it: Make the filesystem the initramfs
> > > lives in be an ordinary filesystem so it can just be used as the systems
> > > primary filesystem.
> >
> > Including the ability to pivot_root it away, which seems like the main
> > sticking point.
> >
> > If this can be done without any overhead, that seems fine, but if this
> > involves mounting an extra filesystem, that may add an appreciable
> > amount of boot time for systems trying to boot in milliseconds. (Such
> > systems would not use an initramfs if they're going to go on and boot a
> > separate root filesystem, but they can use an initramfs as their *only*
> > filesystem.)
> 
> Compared to the time the unpacking spent, a mounting seems nothing. In the
> scene above, this change can be disabled by kconfig, if pivot_root
> is not needed in initramfs.

I asked for the kconfig entry. And it would be good to document then
also the worst case expected on boot for what this could do to you. I
mean, we are opening a different evil universe. So that's why the
kconfig exists.  How bad and evil can this be?

I don't think anyone has clarified that yet.

  Luis
