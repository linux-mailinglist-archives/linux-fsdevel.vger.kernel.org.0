Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1986594FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 09:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF1Hbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 03:31:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:32908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbfF1Hbd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:31:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3DF7B167;
        Fri, 28 Jun 2019 07:31:30 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:31:28 +0200
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
Message-ID: <20190628073128.GC2751@dhcp22.suse.cz>
References: <20190624174219.25513-1-longman@redhat.com>
 <20190624174219.25513-3-longman@redhat.com>
 <20190627151506.GE5303@dhcp22.suse.cz>
 <5cb05d2c-39a7-f138-b0b9-4b03d6008999@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb05d2c-39a7-f138-b0b9-4b03d6008999@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 27-06-19 17:16:04, Waiman Long wrote:
> On 6/27/19 11:15 AM, Michal Hocko wrote:
> > On Mon 24-06-19 13:42:19, Waiman Long wrote:
> >> With the slub memory allocator, the numbers of active slab objects
> >> reported in /proc/slabinfo are not real because they include objects
> >> that are held by the per-cpu slab structures whether they are actually
> >> used or not.  The problem gets worse the more CPUs a system have. For
> >> instance, looking at the reported number of active task_struct objects,
> >> one will wonder where all the missing tasks gone.
> >>
> >> I know it is hard and costly to get a real count of active objects.
> > What exactly is expensive? Why cannot slabinfo reduce the number of
> > active objects by per-cpu cached objects?
> >
> The number of cachelines that needs to be accessed in order to get an
> accurate count will be much higher if we need to iterate through all the
> per-cpu structures. In addition, accessing the per-cpu partial list will
> be racy.

Why is all that a problem for a root only interface that should be used
quite rarely (it is not something that you should be reading hundreds
time per second, right)?
-- 
Michal Hocko
SUSE Labs
