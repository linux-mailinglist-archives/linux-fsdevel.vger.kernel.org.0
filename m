Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE223AD0E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 19:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhFRRGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 13:06:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34876 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhFRRGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:06:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8F91D21B30;
        Fri, 18 Jun 2021 17:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624035840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LHiaEznjsNUF4rAZuGixsJoeW9b4ApvWTouIw4rKRH4=;
        b=tgHGhNEKrHZIfPRywKhTgPlChh7xLffPyPR5uJQIyb2HBLC33ASKcSFidv7iUXQuxGLrdO
        QdOiHPnVfrHBtcaU5QDujIs7RYUaN384TX7ibRbgCaNtSFWkCsF/3uDa9b3b5Fcwl+Y/mS
        XOpL0ncJouDsLGkucN3EQci1LHh56bs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4EB9CA3BCE;
        Fri, 18 Jun 2021 17:04:00 +0000 (UTC)
Date:   Fri, 18 Jun 2021 19:03:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
Message-ID: <YMzR/0QyP9BR7DtN@dhcp22.suse.cz>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
 <20210615113222.edzkaqfvrris4nth@wittgenstein>
 <20210615124715.nzd5we5tl7xc2n2p@example.org>
 <CALvZod7po_fK9JpcUNVrN6PyyP9k=hdcyRfZmHjSVE5r_8Laqw@mail.gmail.com>
 <87zgvpg4wt.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgvpg4wt.fsf@disp2133>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-06-21 11:17:38, Eric W. Biederman wrote:
[...]
> MemAvailable seems to have a good definition.  Roughly the amount of
> memory that can be allocated without triggering swapping.  Updated
> to include not trigger memory cgroup based swapping and I sounds good.

yes this definition is at least understandable but how do you want to
define it in the memcg scope? There are two different source of memory
pressure when dealing with memcgs. Internal one when a limit is hit and
and external when the source of the reclaim comes from higher the
hierarchy (including the global memory pressure). The former one would
be quite easy to mimic with the global semantic but the later will get
much more complex very quickly - a) you would need a snapshot of the
whole cgroup tree and evaluate it against the global memory state b) you
would have to consider memory reclaim protection c) the external memory
pressure is distributed proportionaly to the size most of the time which
is yet another complication. And more other challenges that have been
already discussed.

That being said, this might be possible to implement but I am not really
sure this is viable and I strongly suspect that it will get unreliable
in many situations in context of "how much you can allocate without
swapping".
-- 
Michal Hocko
SUSE Labs
