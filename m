Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843813922CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 00:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhEZWfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 18:35:14 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:44085 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhEZWfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 18:35:13 -0400
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 5D2EDFF806;
        Wed, 26 May 2021 22:33:26 +0000 (UTC)
Date:   Wed, 26 May 2021 15:33:25 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
Message-ID: <YK7MtZz8sklOMPKo@localhost>
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

The initramfs could be as small as one file.
