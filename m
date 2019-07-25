Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D3275B51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfGYXkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 19:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfGYXkC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:40:02 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2BA21951;
        Thu, 25 Jul 2019 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564098000;
        bh=iy1BW35mJIm+u1ndRp7gqExlXuNpjLDRAzH09BcEAsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vLjb1KeectGNjzRx+6eWqeYw0tAHPetlrJyW2cFRrGjB2oFd3tgLcRcumIgiMgdTZ
         TMAykIuGqE3toftxZvn8UfWrN2Z1iib1K/EY1Kshp3irJMUwfFbRe3ciH4nWGJQxGr
         D55fhfKMXurpk7OHLvUawEz9kGaz+yJdOp67nph8=
Date:   Thu, 25 Jul 2019 16:39:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Chris Down <chris@chrisdown.name>
Subject: Re: mmotm 2019-07-24-21-39 uploaded (mm/memcontrol)
Message-Id: <20190725163959.3d759a7f37ba40bb7f75244e@linux-foundation.org>
In-Reply-To: <4831a203-8853-27d7-1996-280d34ea824f@infradead.org>
References: <20190725044010.4tE0dhrji%akpm@linux-foundation.org>
        <4831a203-8853-27d7-1996-280d34ea824f@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 25 Jul 2019 15:02:59 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 7/24/19 9:40 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2019-07-24-21-39 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> 
> on i386:
> 
> ld: mm/memcontrol.o: in function `mem_cgroup_handle_over_high':
> memcontrol.c:(.text+0x6235): undefined reference to `__udivdi3'

Thanks.  This?

--- a/mm/memcontrol.c~mm-throttle-allocators-when-failing-reclaim-over-memoryhigh-fix-fix
+++ a/mm/memcontrol.c
@@ -2414,8 +2414,9 @@ void mem_cgroup_handle_over_high(void)
 	 */
 	clamped_high = max(high, 1UL);
 
-	overage = ((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT)
-		/ clamped_high;
+	overage = (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
+	do_div(overage, clamped_high);
+
 	penalty_jiffies = ((u64)overage * overage * HZ)
 		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
 
_

