Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792D7391268
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 10:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhEZIer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 04:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhEZIeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 04:34:46 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFCEC061574;
        Wed, 26 May 2021 01:33:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e2so563621ljk.4;
        Wed, 26 May 2021 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RIDZ06jndbCoInmR0ANM92ad6K9XlyXkeP1SRnmZcmc=;
        b=oBl3rccG9MRxe9Y2RMnwifVlE7e965esj7+OeoKb4ak7uHSjLuBUquJIK8FpygeQQX
         nLMu8a4BEtIsURdDzThku8WxA1K11y3H4cXP0OBA6UXxhcJfj/VZHLfNtE/ultIbWc6Y
         2Y9pnRBtpit+AtiNpcbpI/Awhtd0NH//0/FyJa+wIHQIoAbEOBd7X+YUpzi87f6CQQWz
         wwZvNI/ah20BSau+sQzjIgyrNBtRd4bJpurLXv7uoIQq6lqt0uoEYzAAHQyT1OjjPF3X
         tutl2pEAaLJ3wlLsyHOiFggXHlhPSV6l78oH46L57GN450dgK1oH9Wa4IY2avPgYoKzw
         j10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIDZ06jndbCoInmR0ANM92ad6K9XlyXkeP1SRnmZcmc=;
        b=VRJXGyGxE31DObt9fyggL+5deSvMUYUNHoBw4mmQ8joYaRctkvz/MYXLUAWJMlfFsV
         b54X4HrEgM7SHrQx7CBt9Si9fnbSQTgWBK53uZqzULMUuTfuey6LXGSB+nd0jemr1NiU
         fLvaPEFNyab7e//WURjMQxnJzrPmqJRdAq9hLJaZnmVkn1K88Ap/EkuiVuFH8Ot2GAtd
         i0eAuYDF8OGguIr8UBaMRdr79CEz7zju+oebEByrB6ECqhCPO/RY2HKWAoamJYqHvaYI
         XMg7MRe/iJzJlV+WWM1uPa3iWDVKGEOZCCDppBsygNApoWIDM3bwd5Uy5Mwd0jKVym/E
         a0sQ==
X-Gm-Message-State: AOAM533tSawriDd39RqR1AekmHfZ6WiAWtRh9zU5FZwsPaYgJg72SMhI
        TWCX8wS/9rwt9BgGCBVrpzDww/63JtDnpGs8edI=
X-Google-Smtp-Source: ABdhPJz1Y4k0QbOkkq7w1NmO1s9FVTULUKFaD2KGPyhRBK9Tko7lVnITZKV4YKgY2Gav1lequ3jqhsjwWfDSj4vxLLs=
X-Received: by 2002:a2e:7a06:: with SMTP id v6mr1327638ljc.219.1622017992692;
 Wed, 26 May 2021 01:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
 <20210525141524.3995-3-dong.menglong@zte.com.cn> <m18s42odgz.fsf@fess.ebiederm.org>
 <CADxym3a5nsuw2hiDF=ZS51Wpjs-i_VW+OGd-sgGDVrKYw2AiHQ@mail.gmail.com>
 <m11r9umb4y.fsf@fess.ebiederm.org> <YK3Pb/OGwWVzvDZM@localhost>
In-Reply-To: <YK3Pb/OGwWVzvDZM@localhost>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Wed, 26 May 2021 16:33:00 +0800
Message-ID: <CADxym3bznknEWLaa-SgYZAsTGucP_9m+9=JW7oc6=ggrUaBk7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] init/do_cmounts.c: introduce 'user_root' for initramfs
To:     Josh Triplett <josh@joshtriplett.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 12:33 PM Josh Triplett <josh@joshtriplett.org> wrote:
>
> On Tue, May 25, 2021 at 10:23:09PM -0500, Eric W. Biederman wrote:
> > If we are going to do this something that is so small and clean it can
> > be done unconditionally always.
> [...]
> > The net request as I understand it: Make the filesystem the initramfs
> > lives in be an ordinary filesystem so it can just be used as the systems
> > primary filesystem.
>
> Including the ability to pivot_root it away, which seems like the main
> sticking point.
>
> If this can be done without any overhead, that seems fine, but if this
> involves mounting an extra filesystem, that may add an appreciable
> amount of boot time for systems trying to boot in milliseconds. (Such
> systems would not use an initramfs if they're going to go on and boot a
> separate root filesystem, but they can use an initramfs as their *only*
> filesystem.)

Compared to the time the unpacking spent, a mounting seems nothing. In the
scene above, this change can be disabled by kconfig, if pivot_root
is not needed in initramfs.

Thanks!
Menglong Dong
