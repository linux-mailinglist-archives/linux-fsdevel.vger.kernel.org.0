Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724BB4039F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349362AbhIHMga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 08:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234005AbhIHMg1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69C5861139;
        Wed,  8 Sep 2021 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631104519;
        bh=COdmmMC2NhlKWVFj31C7uZM1YgxY0x3WYgYnuLq4PgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/A4aDcK8Fv+z1kk7N/+S/Z3baBZOHsGdy10qq5md1XsQ8bUS8wIj5okQG8vTNMFm
         nrcXld76SdV+JI9/tX8X+Si84zT+7egkmC/KeX4GEkZMK8VO8av1RBW8ccmj/CCS9n
         NEZkkAMiJJXg1gdlLDAxIH1S14J5bZCRHo4duD3c=
Date:   Wed, 8 Sep 2021 14:35:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Tao <escape@linux.alibaba.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 1/2] add pinned flags for kernfs node
Message-ID: <YTiuBaiVZhe3db9O@kroah.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <e753e449240bfc43fcb7aa26dca196e2f51e0836.1631102579.git.escape@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e753e449240bfc43fcb7aa26dca196e2f51e0836.1631102579.git.escape@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 08, 2021 at 08:15:12PM +0800, Yi Tao wrote:
> This patch is preparing for the implementation of cgroup pool. If a
> kernfs node is set to pinned. the data of this node will no longer be
> protected by kernfs internally. When it performs the following actions,
> the area protected by kernfs_rwsem will be protected by the specific
> spinlock:
> 	1.rename this node
> 	2.remove this node
> 	3.create child node
> 
> Suggested-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Signed-off-by: Yi Tao <escape@linux.alibaba.com>
> ---
>  fs/kernfs/dir.c        | 74 ++++++++++++++++++++++++++++++++++++--------------
>  include/linux/kernfs.h | 14 ++++++++++
>  2 files changed, 68 insertions(+), 20 deletions(-)

Ugh, this is going to get messy fast.

Why are kernfs changes needed for this?  kernfs creation is not
necessarily supposed to be "fast", what benchmark needs this type of
change to require the addition of this complexity?

And how are we going to audit things to ensure the "pinning" is working
properly?

thanks,

greg k-h
