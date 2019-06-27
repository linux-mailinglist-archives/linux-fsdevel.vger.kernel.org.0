Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18F75855B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 17:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfF0PPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 11:15:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:43548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbfF0PPK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:15:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A290BABC4;
        Thu, 27 Jun 2019 15:15:08 +0000 (UTC)
Date:   Thu, 27 Jun 2019 17:15:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
Message-ID: <20190627151506.GE5303@dhcp22.suse.cz>
References: <20190624174219.25513-1-longman@redhat.com>
 <20190624174219.25513-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624174219.25513-3-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 24-06-19 13:42:19, Waiman Long wrote:
> With the slub memory allocator, the numbers of active slab objects
> reported in /proc/slabinfo are not real because they include objects
> that are held by the per-cpu slab structures whether they are actually
> used or not.  The problem gets worse the more CPUs a system have. For
> instance, looking at the reported number of active task_struct objects,
> one will wonder where all the missing tasks gone.
> 
> I know it is hard and costly to get a real count of active objects.

What exactly is expensive? Why cannot slabinfo reduce the number of
active objects by per-cpu cached objects?

> So
> I am not advocating for that. Instead, this patch extends the
> /proc/sys/vm/drop_caches sysctl parameter by using a new bit (bit 3)
> to shrink all the kmem slabs which will flush out all the slabs in the
> per-cpu structures and give a more accurate view of how much memory are
> really used up by the active slab objects. This is a costly operation,
> of course, but it gives a way to have a clearer picture of the actual
> number of slab objects used, if the need arises.

drop_caches is a terrible interface. It destroys all the caching and
people are just too easy in using it to solve any kind of problem they
think they might have and cause others they might not see immediately.
I am strongly discouraging anybody - except for some tests which really
do want to see reproducible results without cache effects - from using
this interface and therefore I am not really happy to paper over
something that might be a real problem with yet another mode. If SLUB
indeed caches too aggressively on large machines then this should be
fixed.

-- 
Michal Hocko
SUSE Labs
