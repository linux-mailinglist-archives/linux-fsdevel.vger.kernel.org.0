Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8686E439AEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhJYP7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:59:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57588 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhJYP7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:59:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 85FB2218EE;
        Mon, 25 Oct 2021 15:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635177435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sjc87XfL1WuZPJro7Vq4FUjnrPJgaAca3TEnfkMGFQU=;
        b=y+29YJzTI+Rj/0CN58+POSX0QZMcdtrzVssxi1+pXRJEvRbzvgZEtiHiQ3jaquq723xt8C
        k/H5xZnWppnhLMNizOAdON59mxMq2zGrNCHH54Q+u4D3DpmByuMgc+SuhohDLyr5v7U1Js
        qejVkRfxMaK2fOMj+whbhnLafQUNqmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635177435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sjc87XfL1WuZPJro7Vq4FUjnrPJgaAca3TEnfkMGFQU=;
        b=wOcxGJuaXT3sNaVtUIfhYyh03F6r5p1HMOOR1lzQKSSCONe4CHh16zsLVdXfJyqM5oq5sz
        LeYRw1LmZ1nqLLAA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 6DBA7A3B81;
        Mon, 25 Oct 2021 15:57:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 45D681E0A2B; Mon, 25 Oct 2021 17:57:13 +0200 (CEST)
Date:   Mon, 25 Oct 2021 17:57:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhengyuan Liu <liuzhengyuang521@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org,
        =?utf-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Subject: Re: Problem with direct IO
Message-ID: <20211025155713.GD12157@quack2.suse.cz>
References: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
 <20211020173729.GF16460@quack2.suse.cz>
 <CAOOPZo43cwh5ujm3n-r9Bih=7gS7Oav0B=J_8AepWDgdeBRkYA@mail.gmail.com>
 <20211021080304.GB5784@quack2.suse.cz>
 <CAOOPZo7DfbwO5tmpbpNw7T9AgN7ALDc2S8N+0TsDnvEqMZzMmg@mail.gmail.com>
 <20211022093120.GG1026@quack2.suse.cz>
 <CAOOPZo7E8uw3s0d+XwQnKsq1CC4SuLe6hxEDD-v=cDThwmsMww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOOPZo7E8uw3s0d+XwQnKsq1CC4SuLe6hxEDD-v=cDThwmsMww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 23-10-21 10:06:24, Zhengyuan Liu wrote:
> On Fri, Oct 22, 2021 at 5:31 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > Can you post output of "dumpe2fs -h <device>" for the filesystem where the
> > > > > > problem happens? Thanks!
> > > > >
> > > > > Sure, the output is:
> > > > >
> > > > > # dumpe2fs -h /dev/sda3
> > > > > dumpe2fs 1.45.3 (14-Jul-2019)
> > > > > Filesystem volume name:   <none>
> > > > > Last mounted on:          /data
> > > > > Filesystem UUID:          09a51146-b325-48bb-be63-c9df539a90a1
> > > > > Filesystem magic number:  0xEF53
> > > > > Filesystem revision #:    1 (dynamic)
> > > > > Filesystem features:      has_journal ext_attr resize_inode dir_index
> > > > > filetype needs_recovery sparse_super large_file
> > > >
> > > > Thanks for the data. OK, a filesystem without extents. Does your test by
> > > > any chance try to do direct IO to a hole in a file? Because that is not
> > > > (and never was) supported without extents. Also the fact that you don't see
> > > > the problem with ext4 (which means extents support) would be pointing in
> > > > that direction.
> > >
> > > I am not sure if it trys to do direct IO to a hole or not, is there any
> > > way to check?  If you have a simple test to reproduce please let me know,
> > > we are glad to try.
> >
> > Can you enable following tracing?
> 
> Sure, but let's confirm before doing that, it seems Ext4 doesn't
> support iomap in
> V4.19 which could also reproduce the problem, so if it is necessary to
> do the following
> tracing? or should we modify the tracing if under V4.19?

Well, iomap is just a different generic framework for doing direct IO. The
fact that you can observe the problem both with iomap and the old direct IO
framework is one of the reasons why I think the problem is actually that
the file has holes (unallocated space in the middle).
 
> > echo 1 >/sys/kernel/debug/tracing/events/ext4/ext4_ind_map_blocks_exit/enable
> > echo iomap_dio_rw >/sys/kernel/debug/tracing/set_ftrace_filter
> > echo "function_graph" >/sys/kernel/debug/tracing/current_tracer

If you want to trace a kernel were ext4 direct IO path is not yet
converted to iomap framework you need to replace tracing of iomap_dio_rw
with:

echo __blockdev_direct_IO >/sys/kernel/debug/tracing/set_ftrace_filter

> > And then gather output from /sys/kernel/debug/tracing/trace_pipe. Once the
> > problem reproduces, you can gather the problematic file name from dmesg, find
> > inode number from "stat <filename>" and provide that all to me? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
