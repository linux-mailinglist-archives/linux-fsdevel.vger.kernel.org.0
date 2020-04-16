Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3EF1AB7BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 08:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407782AbgDPGJx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 02:09:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25984 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407719AbgDPGJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587017386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSD44ootEBXyzkzNcdpXGbzlmx+BBRKBSaXWnZtwryM=;
        b=dY6dFxT4bgRH6o/sjVHFXRwgls1j1MT4G+kwW1upN2P9hN0bp5o7+kmQn8fFgBNp5vsi3P
        UJ8+/uiXZoEzLeli6mcxs/aPkGTdpuL8rcOB/N27XdtlPYG/PXJnP+Z5oRFFakCTbM/15g
        RwhAuZXwxqmJ2VM7S/VsksbqE52Ni8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-KtHJpBBfOye0jlhWDKwoow-1; Thu, 16 Apr 2020 02:09:41 -0400
X-MC-Unique: KtHJpBBfOye0jlhWDKwoow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECF3313F9;
        Thu, 16 Apr 2020 06:09:38 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7C2699E03;
        Thu, 16 Apr 2020 06:09:26 +0000 (UTC)
Date:   Thu, 16 Apr 2020 14:09:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/5] blktrace: fix debugfs use after free
Message-ID: <20200416060921.GB2723777@T590>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-3-mcgrof@kernel.org>
 <20200416021036.GA2717677@T590>
 <20200416052524.GH11244@42.do-not-panic.com>
 <20200416054750.GA2723777@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416054750.GA2723777@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 01:47:50PM +0800, Ming Lei wrote:
> On Thu, Apr 16, 2020 at 05:25:24AM +0000, Luis Chamberlain wrote:
> > On Thu, Apr 16, 2020 at 10:10:36AM +0800, Ming Lei wrote:
> > > In theory, multiple partitions can be traced concurrently, but looks
> > > it never works, so it won't cause trouble for multiple partition trace.
> > > 
> > > One userspace visible change is that blktrace debugfs dir name is switched 
> > > to disk name from partition name in case of partition trace, will it
> > > break some utilities?
> > 
> > How is this possible, its not clear to me, we go from:
> > 
> > -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > -					    blk_debugfs_root);
> > 
> > To this:
> > 
> > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > +					    blk_debugfs_root);
> > 
> > 
> > Maybe I am overlooking something.
> 
> Your patch removes the blktrace debugfs dir:
> 
> do_blk_trace_setup()
> 
> -       dir = debugfs_lookup(buts->name, blk_debugfs_root);
> -       if (!dir)
> -               bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> -
> 
> Then create blktrace attributes under the dir of q->debugfs_dir.
> 
> However, buts->name could be one partition device name, but
> q->debugfs_dir has to be disk name.
> 
> This change is visible to blktrace utilities.

Just test the 1st two patches via "blktrace /dev/sda2", follows the
result, so this way can't be accepted.

[root@ktest-01 ~]# blktrace /dev/sda2
Thread 0 failed open /sys/kernel/debug/block/sda2/trace0: 2/No such file or directory
Thread 4 failed open /sys/kernel/debug/block/sda2/trace4: 2/No such file or directory
Thread 1 failed open /sys/kernel/debug/block/sda2/trace1: 2/No such file or directory
Thread 2 failed open /sys/kernel/debug/block/sda2/trace2: 2/No such file or directory
Thread 5 failed open /sys/kernel/debug/block/sda2/trace5: 2/No such file or directory
Thread 3 failed open /sys/kernel/debug/block/sda2/trace3: 2/No such file or directory
Thread 6 failed open /sys/kernel/debug/block/sda2/trace6: 2/No such file or directory
Thread 7 failed open /sys/kernel/debug/block/sda2/trace7: 2/No such file or directory
FAILED to start thread on CPU 0: 1/Operation not permitted
FAILED to start thread on CPU 1: 1/Operation not permitted
FAILED to start thread on CPU 2: 1/Operation not permitted
FAILED to start thread on CPU 3: 1/Operation not permitted
FAILED to start thread on CPU 4: 1/Operation not permitted
FAILED to start thread on CPU 5: 1/Operation not permitted
FAILED to start thread on CPU 6: 1/Operation not permitted
FAILED to start thread on CPU 7: 1/Operation not permitted



Thanks, 
Ming

