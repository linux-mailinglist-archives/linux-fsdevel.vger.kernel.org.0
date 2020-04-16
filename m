Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7D1AB805
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 08:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408120AbgDPG3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 02:29:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53929 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2408110AbgDPG3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587018561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CROjKRbtqDNxSB0ktwOuky8CijTu7ExjL3TJ8Xjxjqw=;
        b=QiVThoxZjEFzfkK5UOKgTb1yCM0xSEfCg+Raiioa6lhyFcryzqQtaxS0UIh0t+Ru669E4V
        FkQZjc8qZmInKyyuKs4oRHbAOToIzlXrhMTAdiKI8VctoNLDXwpqeeNhxawR7dVMEbSGs/
        FZ1I56cBliRO4raljdBK61XHW0sEVUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-vOMOp-fePw6MlY42ywi5Nw-1; Thu, 16 Apr 2020 02:29:17 -0400
X-MC-Unique: vOMOp-fePw6MlY42ywi5Nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8A30802563;
        Thu, 16 Apr 2020 06:29:13 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8A9312650D;
        Thu, 16 Apr 2020 06:29:01 +0000 (UTC)
Date:   Thu, 16 Apr 2020 14:28:56 +0800
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
Message-ID: <20200416062856.GD2723777@T590>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-3-mcgrof@kernel.org>
 <20200416021036.GA2717677@T590>
 <20200416052524.GH11244@42.do-not-panic.com>
 <20200416054750.GA2723777@T590>
 <20200416062054.GL11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416062054.GL11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 06:20:54AM +0000, Luis Chamberlain wrote:
> On Thu, Apr 16, 2020 at 01:47:50PM +0800, Ming Lei wrote:
> > On Thu, Apr 16, 2020 at 05:25:24AM +0000, Luis Chamberlain wrote:
> > > On Thu, Apr 16, 2020 at 10:10:36AM +0800, Ming Lei wrote:
> > > > In theory, multiple partitions can be traced concurrently, but looks
> > > > it never works, so it won't cause trouble for multiple partition trace.
> > > > 
> > > > One userspace visible change is that blktrace debugfs dir name is switched 
> > > > to disk name from partition name in case of partition trace, will it
> > > > break some utilities?
> > > 
> > > How is this possible, its not clear to me, we go from:
> > > 
> > > -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > -					    blk_debugfs_root);
> > > 
> > > To this:
> > > 
> > > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > +					    blk_debugfs_root);
> > > 
> > > 
> > > Maybe I am overlooking something.
> > 
> > Your patch removes the blktrace debugfs dir:
> > 
> > do_blk_trace_setup()
> > 
> > -       dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > -       if (!dir)
> > -               bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > -
> > 
> > Then create blktrace attributes under the dir of q->debugfs_dir.
> > 
> > However, buts->name could be one partition device name, but
> 
> I can see how buts->name is set to bdevname() which expands to
> disk_name(bdev->bd_disk, bdev->bd_part->partno, buf).
> 
> > q->debugfs_dir has to be disk name.
> 
> I can't see this, can you point me to where it is clear the
> request_queue kobject's parent is sure to be the disk name?

blk_register_queue():
	...
	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
	...
> 
> If it is different, the issue I don't think should be debugfs, but
> the bigger issue would be that blktrace on two different partitions
> would clash.
> 
> Also, the *old* lookup intent on partitions always would fail on mq
> and we'd end up creating a directory.
> 
> I think we'd need to create a directory per partition, even when we
> don't use blktrace. That makes this more complex than I'd hope for.

Anyway, the current ABI can't be broken, also I'd suggest to understand
how the userpace utility uses blktrace syscall interfaces first before
figuring any new approach.

Thanks, 
Ming

