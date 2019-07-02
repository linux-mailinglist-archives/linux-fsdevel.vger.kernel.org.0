Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595905D9C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 02:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfGCAxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 20:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfGCAxF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:53:05 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662352184C;
        Tue,  2 Jul 2019 20:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562097799;
        bh=kyfxYTDfXVVYVh+jLp8SPqoH6e+/on1CISn5rmKjOZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tiln9LxMX1fNAo2/Ddp+J6EQL7IwtJ9uvLaA5tNsAMv7HWx786TfZZ+Zg2iwEa3zy
         7DBc6NmB8eX7vXDjNIm9YVca7qmERe9+BWTzyahQE+3k8jNzrBotulWcBmvPHIX2uk
         qZiUwdYXD/LKMhpngm7ibkztyOQiF7ErCvRr6OuA=
Date:   Tue, 2 Jul 2019 13:03:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
Message-Id: <20190702130318.39d187dc27dbdd9267788165@linux-foundation.org>
In-Reply-To: <20190702183730.14461-1-longman@redhat.com>
References: <20190702183730.14461-1-longman@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue,  2 Jul 2019 14:37:30 -0400 Waiman Long <longman@redhat.com> wrote:

> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
> file to shrink the slab by flushing all the per-cpu slabs and free
> slabs in partial lists. This applies only to the root caches, though.
> 
> Extends this capability by shrinking all the child memcg caches and
> the root cache when a value of '2' is written to the shrink sysfs file.

Why?

Please fully describe the value of the proposed feature to or users. 
Always.

> 
> ...
>
> --- a/Documentation/ABI/testing/sysfs-kernel-slab
> +++ b/Documentation/ABI/testing/sysfs-kernel-slab
> @@ -429,10 +429,12 @@ KernelVersion:	2.6.22
>  Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
>  		Christoph Lameter <cl@linux-foundation.org>
>  Description:
> -		The shrink file is written when memory should be reclaimed from
> -		a cache.  Empty partial slabs are freed and the partial list is
> -		sorted so the slabs with the fewest available objects are used
> -		first.
> +		A value of '1' is written to the shrink file when memory should
> +		be reclaimed from a cache.  Empty partial slabs are freed and
> +		the partial list is sorted so the slabs with the fewest
> +		available objects are used first.  When a value of '2' is
> +		written, all the corresponding child memory cgroup caches
> +		should be shrunk as well.  All other values are invalid.

One would expect this to be a bitfield, like /proc/sys/vm/drop_caches. 
So writing 3 does both forms of shrinking.

Yes, it happens to be the case that 2 is a superset of 1, but what
about if we add "4"?

