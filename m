Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634F71FD9F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 01:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgFQXxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 19:53:40 -0400
Received: from [211.29.132.249] ([211.29.132.249]:57966 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726763AbgFQXxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:53:39 -0400
Received: from dread.disaster.area (unknown [49.180.124.177])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0C75D3A5E73;
        Thu, 18 Jun 2020 09:45:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jlhjV-0001AC-B9; Thu, 18 Jun 2020 09:44:41 +1000
Date:   Thu, 18 Jun 2020 09:44:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200617234441.GE2005@dread.disaster.area>
References: <20200615160244.741244-1-agruenba@redhat.com>
 <20200615233239.GY2040@dread.disaster.area>
 <20200615234437.GX8681@bombadil.infradead.org>
 <20200616003903.GC2005@dread.disaster.area>
 <315900873.34076732.1592309848873.JavaMail.zimbra@redhat.com>
 <20200616132318.GZ8681@bombadil.infradead.org>
 <CAHc6FU7uU8rUMdkspqH+Zv_O5zi2eEyOYF4x4Je-eCNeM+7NHA@mail.gmail.com>
 <20200616162539.GN11245@magnolia>
 <700590041.34131118.1592325518407.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <700590041.34131118.1592325518407.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=bOaRx7NJwwhFHOCuJsgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 12:38:38PM -0400, Bob Peterson wrote:
> ----- Original Message -----
> > So... you found this through code inspection, and not because you
> > actually hit this on gfs2, or any of the other iomap users?
> > 
> > I generally think this looks ok, but I want to know if I should be
> > looking deeper. :)
> > 
> > --D
> 
> Correct. Code-inspection only. I never actually hit the problem.
> If those errors are really so unusual and catastrophic, perhaps
> we should just change them to BUG_ONs or something instead.

We do not panic a machine because a detectable data or filesystem
corruption event has occurred. We have a viable error path to tell
userspace a fatal IO error occurred so that is all the generic
infrastructure should be doing.

If a loud warning needs to be issued, then WARN_ON_ONCE() may be
appropriate, though I suspect even that is overkill for this
situation....

> Why bother unlocking if we're already 1.9 meters underground?

Because then a filesystem that has shutdown because it has
recognised that it is walking dead can be unmounted and the user can
then run an autopsy to find and fix the problem without having to
reboot the machine....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
