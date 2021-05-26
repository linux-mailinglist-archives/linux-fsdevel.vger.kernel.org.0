Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B399D390FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 06:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhEZEej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 00:34:39 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52735 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhEZEeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 00:34:36 -0400
X-Greylist: delayed 99047 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 00:34:35 EDT
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1326BC0003;
        Wed, 26 May 2021 04:32:49 +0000 (UTC)
Date:   Tue, 25 May 2021 21:32:47 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
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
Message-ID: <YK3Pb/OGwWVzvDZM@localhost>
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
 <20210525141524.3995-3-dong.menglong@zte.com.cn>
 <m18s42odgz.fsf@fess.ebiederm.org>
 <CADxym3a5nsuw2hiDF=ZS51Wpjs-i_VW+OGd-sgGDVrKYw2AiHQ@mail.gmail.com>
 <m11r9umb4y.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11r9umb4y.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 10:23:09PM -0500, Eric W. Biederman wrote:
> If we are going to do this something that is so small and clean it can
> be done unconditionally always.
[...]
> The net request as I understand it: Make the filesystem the initramfs
> lives in be an ordinary filesystem so it can just be used as the systems
> primary filesystem.

Including the ability to pivot_root it away, which seems like the main
sticking point.

If this can be done without any overhead, that seems fine, but if this
involves mounting an extra filesystem, that may add an appreciable
amount of boot time for systems trying to boot in milliseconds. (Such
systems would not use an initramfs if they're going to go on and boot a
separate root filesystem, but they can use an initramfs as their *only*
filesystem.)
