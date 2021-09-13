Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E516440965C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346018AbhIMOvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 10:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346615AbhIMOrm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 10:47:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F22EF604D1;
        Mon, 13 Sep 2021 14:21:01 +0000 (UTC)
Date:   Mon, 13 Sep 2021 16:20:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     "taoyi.ty" <escape@linux.alibaba.com>,
        Greg KH <gregkh@linuxfoundation.org>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 0/2] support cgroup pool in v1
Message-ID: <20210913142059.qbypd4vfq6wdzqfw@wittgenstein>
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <YTiugxO0cDge47x6@kroah.com>
 <a0c67d71-8045-d8b6-40c2-39f2603ec7c1@linux.alibaba.com>
 <YTuMl+cC6FyA/Hsv@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTuMl+cC6FyA/Hsv@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 06:49:27AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Sep 10, 2021 at 10:11:53AM +0800, taoyi.ty wrote:
> > The scenario is the function computing of the public
> > cloud. Each instance of function computing will be
> > allocated about 0.1 core cpu and 100M memory. On
> > a high-end server, for example, 104 cores and 384G,
> > it is normal to create hundreds of containers at the
> > same time if burst of requests comes.
> 
> This type of use case isn't something cgroup is good at, at least not
> currently. The problem is that trying to scale management operations like
> creating and destroying cgroups has implications on how each controller is
> implemented - we want the hot paths which get used while cgroups are running
> actively to be as efficient and scalable as possible even if that requires a
> lot of extra preparation and lazy cleanup operations. We don't really want
> to push for cgroup creation / destruction efficiency at the cost of hot path
> overhead.
> 
> This has implications for use cases like you describe. Even if the kernel
> pre-prepare cgroups to low latency for cgroup creation, it means that the
> system would be doing a *lot* of managerial extra work creating and
> destroying cgroups constantly for not much actual work.
> 
> Usually, the right solution for this sort of situations is pooling cgroups
> from the userspace which usually has a lot better insight into which cgroups
> can be recycled and can also adjust the cgroup hierarchy to better fit the
> use case (e.g. some rapid-cycling cgroups can benefit from higher-level
> resource configurations).

I had the same reaction and I wanted to do something like this before,
i.e. maintain a pool of pre-allocated cgroups in userspace. But there
were some problems.

Afaict, there is currently now way to prevent the deletion of empty
cgroups, especially newly created ones. So for example, if I have a
cgroup manager that prunes the cgroup tree whenever they detect empty
cgroups they can delete cgroups that were pre-allocated. This is
something we have run into before.

A related problem is a crashed or killed container manager 
(segfault, sigkill, etc.). It might not have had the chance to cleanup
cgroups it allocated for the container. If the container manager is
restarted it can't reuse the existing cgroup it found because it has no
way of guaranteeing whether in between the time it crashed and got
restarted another program has just created a cgroup with the same name.
We usually solve this by just creating another cgroup with an index
appended until we we find an unallocated one setting an arbitrary cut
off point until we require manual intervention by the user (e.g. 1000).

Right now iirc, one can rmdir() an empty cgroup while someone still
holds a file descriptor open for it. This can lead to situation where a
cgroup got created but before moving into the cgroup (via clone3() or
write()) someone else has deleted it. What would already be helpful is
if one had a way to prevent the deletion of cgroups when someone still
has an open reference to it. This would allow a pool of cgroups to be
created that can't simply be deleted.

Christian
