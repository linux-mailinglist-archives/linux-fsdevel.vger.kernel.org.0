Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39374066FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 08:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhIJGBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 02:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhIJGBe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:01:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F13D36113E;
        Fri, 10 Sep 2021 06:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631253623;
        bh=+oBAtMoawlHInRv8YIXOyVPI7irf8Xkg/tet/t4c8lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZyJ6ySZWKFHN2JnLx3GxlRZMUgBx7kgGbC9a0TdGLvUn6eAzCKJNLB6FYt8RbhTIC
         tH8uosog7Dpcb5qWhoF/PeWufLF5PH+ltZFt7ZbLniTMVzCu/jASqdCdDf2BnXcPy8
         +hAT0lIPiWbzrj5ofnPY/DVNdlOW0VGKIuXZoflY=
Date:   Fri, 10 Sep 2021 08:00:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "taoyi.ty" <escape@linux.alibaba.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 1/2] add pinned flags for kernfs node
Message-ID: <YTr0YDfLbKTkxy52@kroah.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <e753e449240bfc43fcb7aa26dca196e2f51e0836.1631102579.git.escape@linux.alibaba.com>
 <YTiuBaiVZhe3db9O@kroah.com>
 <3d871bd0-dab5-c9ca-61b9-6aa137fa9fdf@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d871bd0-dab5-c9ca-61b9-6aa137fa9fdf@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:14:28AM +0800, taoyi.ty wrote:
> 
> On 2021/9/8 下午8:35, Greg KH wrote:
> > Why are kernfs changes needed for this?  kernfs creation is not
> > necessarily supposed to be "fast", what benchmark needs this type of
> > change to require the addition of this complexity?
> 
> The implementation of the cgroup pool should have nothing
> 
> to do with kernfs, but during the development process,
> 
> I found that when there is a background cpu load, it takes
> 
> a very significant time for a process to get the mutex from
> 
> being awakened to starting execution.
> 
> To create 400 cgroups concurrently, if there is no background
> 
> cpu load, it takes about 80ms, but if the cpu usage rate is
> 
> 40%, it takes about 700ms. If you reduce
> 
> sched_wakeup_granularity_ns, the time consumption will also
> 
> be reduced. If you change mutex to spinlock, the situation
> 
> will be very much improved.
> 
> So to solve this problem, mutex should not be used. The
> 
> cgroup pool relies on kernfs_rename which uses
> 
> kernfs_mutex, so I need to bypass kernfs_mutex and
> 
> add a pinned flag for this.
> 
> Because the lock mechanism of kernfs_rename has been
> 
> changed, in order to maintain data consistency, the creation
> 
> and deletion of kernfs have also been changed accordingly
> 
> I admit that this is really not a very elegant design, but I don’t
> 
> know how to make it better, so I throw out the problem and
> 
> try to seek help from the community.

Look at the changes to kernfs for 5.15-rc1 where a lot of the lock
contention was removed based on benchmarks where kernfs (through sysfs)
was accessed by lots of processes all at once.

That should help a bit in your case, but remember, the creation of
kernfs files is not the "normal" case, so it is not optimized at all.
We have optimized the access case, which is by far the most common.

good luck!

greg k-h
