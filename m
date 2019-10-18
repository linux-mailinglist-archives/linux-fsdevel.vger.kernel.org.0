Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC19DBF2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2019 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394959AbfJRH7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 03:59:44 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47651 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbfJRH7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:59:44 -0400
Received: from dread.disaster.area (pa49-179-0-183.pa.nsw.optusnet.com.au [49.179.0.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6E763363ED4;
        Fri, 18 Oct 2019 18:59:39 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iLNAh-0005qf-8c; Fri, 18 Oct 2019 18:59:39 +1100
Date:   Fri, 18 Oct 2019 18:59:39 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/26] mm: directed shrinker work deferral
Message-ID: <20191018075939.GP16973@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-9-david@fromorbit.com>
 <20191014084604.GA11758@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014084604.GA11758@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=52fyy8O0dbGPTevbDZN8bg==:117 a=52fyy8O0dbGPTevbDZN8bg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=KK2cpZmtYymXl3zhzrcA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 01:46:04AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 09, 2019 at 02:21:06PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Introduce a mechanism for ->count_objects() to indicate to the
> > shrinker infrastructure that the reclaim context will not allow
> > scanning work to be done and so the work it decides is necessary
> > needs to be deferred.
> > 
> > This simplifies the code by separating out the accounting of
> > deferred work from the actual doing of the work, and allows better
> > decisions to be made by the shrinekr control logic on what action it
> > can take.
> 
> I hate all this boilerplate code in the scanners.  Can't we just add
> a a required_gfp_mask field to struct shrinker and lift the pattern
> to common code?

Because the deferral isn't intended to support just deferring work
from GFP_NOFS reclaim context.

e.g. i915_gem_shrinker_scan() stops the shrinker if it can't get a
lock to avoid recursion deadlocks. There's several other shrinkers
that have similar logic that punts work to avoid deadlocks, and so
they could also use deferred work to punt it kswapd....

i.e. while I currently use it for GFP_NOFS deferal, that's no the
only reason for defering work...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
