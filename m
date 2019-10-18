Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46EE8DD047
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2019 22:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406535AbfJRU37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 16:29:59 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43686 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404558AbfJRU3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:29:46 -0400
Received: from dread.disaster.area (pa49-179-0-183.pa.nsw.optusnet.com.au [49.179.0.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D87D93638E6;
        Sat, 19 Oct 2019 07:29:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iLYsJ-0002Bf-R3; Sat, 19 Oct 2019 07:29:27 +1100
Date:   Sat, 19 Oct 2019 07:29:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: rework unreferenced inode lookups
Message-ID: <20191018202927.GQ16973@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-26-david@fromorbit.com>
 <20191014130719.GE12380@bfoster>
 <20191017012438.GK16973@dread.disaster.area>
 <20191017075729.GA19442@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017075729.GA19442@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=52fyy8O0dbGPTevbDZN8bg==:117 a=52fyy8O0dbGPTevbDZN8bg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=2sWhKzXocK4_PVnBHZEA:9 a=hOR0AJh8QWLIpmh6:21
        a=lVIhb6QhHtTIAenZ:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 03:57:29AM -0400, Brian Foster wrote:
> On Thu, Oct 17, 2019 at 12:24:38PM +1100, Dave Chinner wrote:
> > It's not a contention issue - there's real bugs if we don't order
> > the locking correctly here.
> > 
> 
> Is this patch fixing real bugs in the existing code or reducing
> contention/blocking in the reclaim codepath?  My understanding was the
> latter, so thus I'm trying to make sure I follow how this blocking can
> actually happen that this patch purports to address. The reasoning in my
> comment above is basically how I followed the existing code as it
> pertains to blocking in reclaim, and that is the scenario I was asking
> about...

Neither. It's a patch that simplifies and formalises the
unreferenced inode lookup alogrithm. Previous patches change the way
we isolate inodes for reclaim, opening up the opportunity to
simplify the lookup/reclaim synchronisation and remove a race
condition that that we've carried a workaround to avoid for 20+
years.

Yes, it has the added bonus of removing a potential blocking point
in reclaim, but hitting that blocking point it is pretty rare so
it's not really a reduction in anything measurable.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
