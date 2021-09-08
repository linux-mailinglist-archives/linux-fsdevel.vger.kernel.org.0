Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12EB4039FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 14:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349353AbhIHMhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 08:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241128AbhIHMhG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:37:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76C216069E;
        Wed,  8 Sep 2021 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631104558;
        bh=IeEnqVOQ4/mgD07WFn13/gOR/som678mwOUAhNFnUrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xpJKSosNTteuQ/VVdeadIgG4tjl+qcTdHD4iyKneWU+L1j4w3oaSUDd1o2Fz98GB3
         PPw9uyyWv5GZp0vWFP1YTYyVNxjQrYEkgJhV5dlCubxCpwKnA/9fujGQ57M0kZgV4o
         STO7zQXsQfWUcgLRELcTHek7B+140EXCnajiPEMM=
Date:   Wed, 8 Sep 2021 14:35:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Tao <escape@linux.alibaba.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 2/2] support cgroup pool in v1
Message-ID: <YTiuLES5qd086qRu@kroah.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <03e2b37678c9b2aef4f5dee303b3fb87a565d56b.1631102579.git.escape@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e2b37678c9b2aef4f5dee303b3fb87a565d56b.1631102579.git.escape@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 08, 2021 at 08:15:13PM +0800, Yi Tao wrote:
> Add pool_size interface and delay_time interface. When the user writes
> pool_size, a cgroup pool will be created, and then when the user needs
> to create a cgroup, it will take the fast path protected by spinlock to
> obtain it from the resource pool. Performance is improved by the
> following aspects:
> 	1.reduce the critical area for creating cgroups
> 	2.reduce the scheduling time of sleep
> 	3.avoid competition with other cgroup behaviors which protected
> 	  by cgroup_mutex
> 
> The essence of obtaining resources from the pool is kernfs rename. With
> the help of the previous pinned kernfs node function, when the pool is
> enabled, these cgroups will be in the pinned state, and the protection
> of the kernfs data structure will be protected by the specified
> spinlock, thus getting rid of the cgroup_mutex and kernfs_rwsem.
> 
> In order to avoid random operations by users, the kernfs nodes of the
> cgroups in the pool will be placed under a hidden kernfs tree, and users
> can not directly touch them. When a user creates a cgroup, it will take
> the fast path, select a node from the hidden tree, and move it to the
> correct position.
> 
> As users continue to obtain resources from the pool, the number of
> cgroups in the pool will gradually decrease. When the number is less
> than a certain value, it will be supplemented. In order to avoid
> competition with the currently created cgroup, you can delay this by
> setting delay_time process
> 
> Suggested-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Signed-off-by: Yi Tao <escape@linux.alibaba.com>
> ---
>  include/linux/cgroup-defs.h |  16 +++++
>  include/linux/cgroup.h      |   2 +
>  kernel/cgroup/cgroup-v1.c   | 139 ++++++++++++++++++++++++++++++++++++++++++++

I thought cgroup v1 was "obsolete" and not getting new features added to
it.  What is wrong with just using cgroups 2 instead if you have a
problem with the v1 interface?

thanks,

greg k-h
