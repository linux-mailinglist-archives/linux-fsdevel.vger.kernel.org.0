Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF7E2CFC2E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 17:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgLEQvm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 11:51:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgLEQqF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:46:05 -0500
Date:   Sat, 5 Dec 2020 15:10:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607177337;
        bh=P1OAQzjzb92ixjbZ+fh5aSjtOuIA5uuYe7ki0Xt9Smc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=N32DbcbQir7H1bIDpZtsweicTNtvRFyu0xcpE4CND5b8lXSqKUhEvaNF4ZGqzzn9E
         8U88Dm42AX2RSfg5bp+eWBC1e6s6IW/1KOhl4n9lgaEYLc4De1aMO2iXjx5Xqi18ao
         aqGqvJLRTEG2+wW4pXPOUdmYdH6CNzxbEA1Vki0Q=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     rafael@kernel.org, adobriyan@gmail.com, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        hughd@google.com, will@kernel.org, guro@fb.com, rppt@kernel.org,
        tglx@linutronix.de, esyr@redhat.com, peterx@redhat.com,
        krisman@collabora.com, surenb@google.com, avagin@openvz.org,
        elver@google.com, rdunlap@infradead.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 3/9] mm: memcontrol: convert kernel stack account to
 byte-sized
Message-ID: <X8uUv2TJ7CQ/mijD@kroah.com>
References: <20201205130224.81607-1-songmuchun@bytedance.com>
 <20201205130224.81607-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205130224.81607-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 05, 2020 at 09:02:18PM +0800, Muchun Song wrote:
> The kernel stack account is the only one that counts in KiB.
> This patch convert it from KiB to byte.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  drivers/base/node.c    | 2 +-
>  fs/proc/meminfo.c      | 2 +-
>  include/linux/mmzone.h | 2 +-
>  kernel/fork.c          | 8 ++++----
>  mm/memcontrol.c        | 2 +-
>  mm/page_alloc.c        | 2 +-
>  mm/vmstat.c            | 4 ++--
>  7 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 6ffa470e2984..855886a6ba0e 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -446,7 +446,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>  			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
>  			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
>  			     nid, K(i.sharedram),
> -			     nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
> +			     nid, node_page_state(pgdat, NR_KERNEL_STACK_B) / 1024,

Did you just change the units of a userspace-visable file without
updating the documentation?

If not, how is this working?

thanks,

greg k-h
