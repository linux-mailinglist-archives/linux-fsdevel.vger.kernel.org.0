Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C5243C51A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 10:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbhJ0Ib1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 04:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239011AbhJ0IbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635323321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMGoUQINrJqZLuW8/A/XeQKi6E97c5XZh4o9JVjLPFA=;
        b=iGtuLenGldmkyflY+tKrOlQ5FJvt1K8eiSnjS6fCFgfmp1hazOMSmNVhB91FgI4ka5FNn+
        Js6nJuXvusPLEwbyxTAcuaRZOggJp/MmNRuSh/5JK9WjwBB/M6sRYk80tv5kY2t5j1JTtc
        vkmH2xW3A0JHMqWucr7f4JVFgJCo49U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-7-wrdy7rNP2kPMff7y0D8w-1; Wed, 27 Oct 2021 04:28:38 -0400
X-MC-Unique: 7-wrdy7rNP2kPMff7y0D8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F22680A5C3;
        Wed, 27 Oct 2021 08:28:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B192D19D9D;
        Wed, 27 Oct 2021 08:28:05 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 19R8S4eD010949;
        Wed, 27 Oct 2021 04:28:04 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 19R8S3sR010945;
        Wed, 27 Oct 2021 04:28:03 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 27 Oct 2021 04:28:03 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dave Chinner <david@fromorbit.com>
cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] loop: don't print warnings if the underlying filesystem
 doesn't support discard
In-Reply-To: <20211027050249.GC5111@dread.disaster.area>
Message-ID: <alpine.LRH.2.02.2110270421380.10452@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com> <20210924155822.GA10064@lst.de> <alpine.LRH.2.02.2110040851130.30719@file01.intranet.prod.int.rdu2.redhat.com> <20211012062049.GB17407@lst.de>
 <alpine.LRH.2.02.2110121516440.21015@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2110130524220.16882@file01.intranet.prod.int.rdu2.redhat.com> <20211027050249.GC5111@dread.disaster.area>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 27 Oct 2021, Dave Chinner wrote:

> On Wed, Oct 13, 2021 at 05:28:36AM -0400, Mikulas Patocka wrote:
> > Hi
> > 
> > Here I'm sending version 4 of the patch. It adds #include <linux/falloc.h> 
> > to cifs and overlayfs to fix the bugs found out by the kernel test robot.
> > 
> > Mikulas
> > 
> > 
> > 
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > The loop driver checks for the fallocate method and if it is present, it 
> > assumes that the filesystem can do FALLOC_FL_ZERO_RANGE and 
> > FALLOC_FL_PUNCH_HOLE requests. However, some filesystems (such as fat, or 
> > tmpfs) have the fallocate method, but lack the capability to do 
> > FALLOC_FL_ZERO_RANGE and/or FALLOC_FL_PUNCH_HOLE.
> 
> This seems like a loopback driver level problem, not something
> filesystems need to solve. fallocate() is defined to return
> -EOPNOTSUPP if a flag is passed that it does not support and that's
> the mechanism used to inform callers that a fallocate function is
> not supported by the underlying filesystem/storage.
> 
> Indeed, filesystems can support hole punching at the ->fallocate(),
> but then return EOPNOTSUPP because certain dynamic conditions are
> not met e.g. CIFS needs sparse file support on the server to support
> hole punching, but we don't know this until we actually try to 
> sparsify the file. IOWs, this patch doesn't address all the cases
> where EOPNOTSUPP might actually get returned from filesystems and/or
> storage.
> 
> > This results in syslog warnings "blk_update_request: operation not 
> > supported error, dev loop0, sector 0 op 0x9:(WRITE_ZEROES) flags 0x800800 
> > phys_seg 0 prio class 0". The error can be reproduced with this command: 
> > "truncate -s 1GiB /tmp/file; losetup /dev/loop0 /tmp/file; blkdiscard -z 
> > /dev/loop0"
> 
> Which I'm assuming comes from this:
> 
> 	        if (unlikely(error && !blk_rq_is_passthrough(req) &&
>                      !(req->rq_flags & RQF_QUIET)))
>                 print_req_error(req, error, __func__);
> 
> Which means we could supress the error message quite easily in
> lo_fallocate() by doing:
> 
> out:
> 	if (ret == -EOPNOTSUPP)
> 		rq->rq_flags |= RQF_QUIET;
> 	return ret;

I did this (see 
https://lore.kernel.org/all/alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com/ 
) and Christoph Hellwig asked for a flag in the file_operations structure 
( https://lore.kernel.org/all/20210924155822.GA10064@lst.de/ ).

Mikulas

> And then we can also run blk_queue_flag_clear(QUEUE_FLAG_DISCARD)
> (and whatever else is needed to kill discards) to turn off future
> discard attempts on that loopback device. This way the problem is
> just quietly and correctly handled by the loop device and everything
> is good...
> 
> Thoughts?
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

