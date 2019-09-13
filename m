Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226D9B1713
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 03:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfIMBux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 21:50:53 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45439 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfIMBux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 21:50:53 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B6C1643ECC3;
        Fri, 13 Sep 2019 11:50:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1i8ajT-0000Fl-KL; Fri, 13 Sep 2019 11:50:43 +1000
Date:   Fri, 13 Sep 2019 11:50:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 0/5] hugetlbfs: Disable PMD sharing for large systems
Message-ID: <20190913015043.GF27547@dread.disaster.area>
References: <20190911150537.19527-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911150537.19527-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=7-415B0cAAAA:8 a=n3o9mYiGlt67Pqr9hHAA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 04:05:32PM +0100, Waiman Long wrote:
> A customer with large SMP systems (up to 16 sockets) with application
> that uses large amount of static hugepages (~500-1500GB) are experiencing
> random multisecond delays. These delays was caused by the long time it
> took to scan the VMA interval tree with mmap_sem held.
> 
> To fix this problem while perserving existing behavior as much as
> possible, we need to allow timeout in down_write() and disabling PMD
> sharing when it is taking too long to do so. Since a transaction can
> involving touching multiple huge pages, timing out for each of the huge
> page interactions does not completely solve the problem. So a threshold
> is set to completely disable PMD sharing if too many timeouts happen.
> 
> The first 4 patches of this 5-patch series adds a new
> down_write_timedlock() API which accepts a timeout argument and return
> true is locking is successful or false otherwise. It works more or less
> than a down_write_trylock() but the calling thread may sleep.

Just on general principle, this is a non-starter. If a lock is being
held too long, then whatever the lock is protecting needs fixing.
Adding timeouts to locks and sysctls to tune them is not a viable
solution to address latencies caused by algorithm scalability
issues.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
