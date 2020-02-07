Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B9815602C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 21:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgBGUwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 15:52:53 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41763 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726947AbgBGUww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:52:52 -0500
Received: from dread.disaster.area (pa49-181-161-120.pa.nsw.optusnet.com.au [49.181.161.120])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3A7708220F7;
        Sat,  8 Feb 2020 07:52:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j0AcF-0005eN-RY; Sat, 08 Feb 2020 07:52:43 +1100
Date:   Sat, 8 Feb 2020 07:52:43 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        andres@anarazel.de, willy@infradead.org, dhowells@redhat.com,
        hch@infradead.org, jack@suse.cz, akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/3] vfs: have syncfs() return error when there are
 writeback errors
Message-ID: <20200207205243.GP20628@dread.disaster.area>
References: <20200207170423.377931-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207170423.377931-1-jlayton@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=SkgQWeG3jiSQFIjTo4+liA==:117 a=SkgQWeG3jiSQFIjTo4+liA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=9kdqgZibw9NIpUqzm0EA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 12:04:20PM -0500, Jeff Layton wrote:
> You're probably wondering -- Where are v1 and v2 sets?
> 
> I did the first couple of versions of this set back in 2018, and then
> got dragged off to work on other things. I'd like to resurrect this set
> though, as I think it's valuable overall, and I have need of it for some
> other work I'm doing.
> 
> Currently, syncfs does not return errors when one of the inodes fails to
> be written back. It will return errors based on the legacy AS_EIO and
> AS_ENOSPC flags when syncing out the block device fails, but that's not
> particularly helpful for filesystems that aren't backed by a blockdev.
> It's also possible for a stray sync to lose those errors.
> 
> The basic idea is to track writeback errors at the superblock level,
> so that we can quickly and easily check whether something bad happened
> without having to fsync each file individually. syncfs is then changed
> to reliably report writeback errors, and a new ioctl is added to allow
> userland to get at the current errseq_t value w/o having to sync out
> anything.

So what, exactly, can userspace do with this error? It has no idea
at all what file the writeback failure occurred on or even
what files syncfs() even acted on so there's no obvious error
recovery that it could perform on reception of such an error.

> I do have a xfstest for this. I do not yet have manpage patches, but
> I'm happy to roll some once there is consensus on the interface.
> 
> Caveats:
> 
> - Having different behavior for an O_PATH descriptor in syncfs is
>   a bit odd, but it means that we don't have to grow struct file. Is
>   that acceptable from an API standpoint?

It's an ugly wart, IMO. But because we suck at APIs, I'm betting
that we'll decide this is OK or do something even worse...

> - This adds a new generic fs ioctl to allow userland to scrape the
>   current superblock's errseq_t value. It may be best to present this
>   to userland via fsinfo() instead (once that's merged). I'm fine with
>   dropping the last patch for now and reworking it for fsinfo if so.

What, exactly, is this useful for? Why would we consider exposing
an internal implementation detail to userspace like this?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
