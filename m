Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495411711EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 09:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgB0IHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 03:07:10 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:37965 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726999AbgB0IHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:07:10 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4E1BE3A340D;
        Thu, 27 Feb 2020 19:07:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j7ECF-0007tA-Ly; Thu, 27 Feb 2020 19:07:03 +1100
Date:   Thu, 27 Feb 2020 19:07:03 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Message-ID: <20200227080703.GK10737@dread.disaster.area>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
 <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
 <20200226214507.GE24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226214507.GE24185@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=tZu0WVHQ-7pqTbS7xfgA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:45:07PM -0800, Matthew Wilcox wrote:
> had twice as many entries in it, would that significantly reduce the
> thrash of new entries being created".  In the page cache, we end up
> with a double LRU where once-used entries fall off the list quickly
> but twice-or-more used entries get to stay around for a bit longer.
> Maybe we could do something like that; keep a victim cache for recently
> evicted dentries, and if we get a large hit rate in the victim cache,
> expand the size of the primary cache.

You know, I've been saying exactly the same thing about the inode
LRU in response to people trying to hack behaviour out of the
shrinker that is triggered by the working set getting trashed by
excessive creation of single use inodes (i.e. large scale directory
traversal).

IOWs, both have the same problem with working set retention in the
face of excessive growth pressure.

So, you know, perhaps two caches with the same problem, that use the
same LRU implementation, could solve the same problem by enhancing
the generic LRU code they use to an active/inactive style clocking
LRU like the page LRUs?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
