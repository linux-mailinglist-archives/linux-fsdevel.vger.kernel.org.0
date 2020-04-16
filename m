Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68871AB783
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 07:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407200AbgDPFs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 01:48:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20618 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407168AbgDPFsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587016098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ae5ly7M/OETZeDnJohKJkBFZBczMSVWSQhC8QwiJPZs=;
        b=UYY6p4PwbvHlbEmYxBq7G9uPRiRA0vsLXFOe+sQgilHFf0khVS8zN/INJLzRXGgu0edg0i
        XZF8UXUIhV4E0TvUX4AE1eIR2chxhmUWYwlDlselmr5FnrEn9MxY3X5wDHeBRCnT3mU/vM
        b1fpWeYMIrsfv3ZzFXPEfxPk4fRbQSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-y0juUd9SPm6Dr1B_bF4zJA-1; Thu, 16 Apr 2020 01:48:13 -0400
X-MC-Unique: y0juUd9SPm6Dr1B_bF4zJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09D7B801A09;
        Thu, 16 Apr 2020 05:48:11 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED6405C1C5;
        Thu, 16 Apr 2020 05:47:55 +0000 (UTC)
Date:   Thu, 16 Apr 2020 13:47:50 +0800
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
Message-ID: <20200416054750.GA2723777@T590>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-3-mcgrof@kernel.org>
 <20200416021036.GA2717677@T590>
 <20200416052524.GH11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416052524.GH11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 05:25:24AM +0000, Luis Chamberlain wrote:
> On Thu, Apr 16, 2020 at 10:10:36AM +0800, Ming Lei wrote:
> > In theory, multiple partitions can be traced concurrently, but looks
> > it never works, so it won't cause trouble for multiple partition trace.
> > 
> > One userspace visible change is that blktrace debugfs dir name is switched 
> > to disk name from partition name in case of partition trace, will it
> > break some utilities?
> 
> How is this possible, its not clear to me, we go from:
> 
> -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> -					    blk_debugfs_root);
> 
> To this:
> 
> +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> +					    blk_debugfs_root);
> 
> 
> Maybe I am overlooking something.

Your patch removes the blktrace debugfs dir:

do_blk_trace_setup()

-       dir = debugfs_lookup(buts->name, blk_debugfs_root);
-       if (!dir)
-               bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
-

Then create blktrace attributes under the dir of q->debugfs_dir.

However, buts->name could be one partition device name, but
q->debugfs_dir has to be disk name.

This change is visible to blktrace utilities.

Thanks,
Ming

