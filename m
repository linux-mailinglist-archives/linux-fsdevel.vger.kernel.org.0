Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FACE135099
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 01:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgAIAoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 19:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgAIAoC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 19:44:02 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5ABD2070E;
        Thu,  9 Jan 2020 00:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578530642;
        bh=Go188rL5tikNt03I4uWv26oj+FUof0Vk+S7a6HlvT1A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wVjR5/sPmfzWsNjUYs7iAFkDuAiMFnOpPCjdP+oU0s+4tHE0RLgbXYKiXuSJulplY
         WZVBvVyNaV7D1gkAtlMQFENto0ov9x31m3PyRs1uW7fKs78RbYeEqMnDd0yifwYvyL
         QJQ799I/TfvKrDuKHFPYFjkL73uGZt3h28MFnhyU=
Message-ID: <064b5f5318fd433f03242ed234fe7c370899e224.camel@kernel.org>
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
From:   Jeff Layton <jlayton@kernel.org>
To:     Hugh Dickins <hughd@google.com>, Chris Mason <clm@fb.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Date:   Wed, 08 Jan 2020 19:43:52 -0500
In-Reply-To: <alpine.LSU.2.11.2001080259350.1884@eggly.anvils>
References: <cover.1578225806.git.chris@chrisdown.name>
         <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
         <20200107001039.GM23195@dread.disaster.area>
         <20200107001643.GA485121@chrisdown.name>
         <20200107003944.GN23195@dread.disaster.area>
         <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
         <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
         <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com>
         <20200107210715.GQ23195@dread.disaster.area>
         <4E9DF932-C46C-4331-B88D-6928D63B8267@fb.com>
         <alpine.LSU.2.11.2001080259350.1884@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-01-08 at 03:24 -0800, Hugh Dickins wrote:
> On Tue, 7 Jan 2020, Chris Mason wrote:
> > On 7 Jan 2020, at 16:07, Dave Chinner wrote:
> > 
> > > IOWs, there are *lots* of 64bit inode numbers out there on XFS
> > > filesystems....
> > 
> > It's less likely in btrfs but +1 to all of Dave's comments.  I'm happy 
> > to run a scan on machines in the fleet and see how many have 64 bit 
> > inodes (either buttery or x-y), but it's going to be a lot.
> 
> Dave, Amir, Chris, many thanks for the info you've filled in -
> and absolutely no need to run any scan on your fleet for this,
> I think we can be confident that even if fb had some 15-year-old tool
> in use on its fleet of 2GB-file filesystems, it would not be the one
> to insist on a kernel revert of 64-bit tmpfs inos.
> 
> The picture looks clear now: while ChrisD does need to hold on to his
> config option and inode32/inode64 mount option patch, it is much better
> left out of the kernel until (very unlikely) proved necessary.

This approach seems like the best course to me.

FWIW, at the time we capped this at 32-bits (2007), 64-bit machines were
really just becoming widely available, and it was quite common to run
32-bit, non-LFS apps on a 64-bit kernel. Users were hitting spurious
EOVERFLOW errors all over the place so this seemed like the best way to
address it.

The world has changed a lot since then though, and one would hope that
almost everything these days is compiled with FILE_OFFSET_BITS=64.

Fingers crossed!
-- 
Jeff Layton <jlayton@kernel.org>

