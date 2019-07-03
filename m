Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89205E6DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGCOhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 10:37:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:50812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726430AbfGCOhE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:37:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11175AF60;
        Wed,  3 Jul 2019 14:37:03 +0000 (UTC)
Date:   Wed, 3 Jul 2019 16:37:01 +0200
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
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
Message-ID: <20190703143701.GR978@dhcp22.suse.cz>
References: <20190702183730.14461-1-longman@redhat.com>
 <20190703065628.GK978@dhcp22.suse.cz>
 <9ade5859-b937-c1ac-9881-2289d734441d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ade5859-b937-c1ac-9881-2289d734441d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 03-07-19 09:12:13, Waiman Long wrote:
> On 7/3/19 2:56 AM, Michal Hocko wrote:
> > On Tue 02-07-19 14:37:30, Waiman Long wrote:
> >> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
> >> file to shrink the slab by flushing all the per-cpu slabs and free
> >> slabs in partial lists. This applies only to the root caches, though.
> >>
> >> Extends this capability by shrinking all the child memcg caches and
> >> the root cache when a value of '2' is written to the shrink sysfs file.
> > Why do we need a new value for this functionality? I would tend to think
> > that skipping memcg caches is a bug/incomplete implementation. Or is it
> > a deliberate decision to cover root caches only?
> 
> It is just that I don't want to change the existing behavior of the
> current code. It will definitely take longer to shrink both the root
> cache and the memcg caches.

Does that matter? To whom and why? I do not expect this interface to be
used heavily.

> If we all agree that the only sensible
> operation is to shrink root cache and the memcg caches together. I am
> fine just adding memcg shrink without changing the sysfs interface
> definition and be done with it.

The existing documentation is really modest on the actual semantic:
Description:
                The shrink file is written when memory should be reclaimed from
                a cache.  Empty partial slabs are freed and the partial list is
                sorted so the slabs with the fewest available objects are used
                first.

which to me sounds like all slabs are free and nobody should be really
thinking of memcgs. This is simply drop_caches kinda thing. We surely do
not want to drop caches only for the root memcg for /proc/sys/vm/drop_caches
right?

-- 
Michal Hocko
SUSE Labs
