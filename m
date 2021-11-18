Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B71D455746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 09:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243291AbhKRIuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 03:50:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55118 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243079AbhKRIuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:50:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 106F91FD35;
        Thu, 18 Nov 2021 08:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637225269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVpxbvqJVQzGe+qqFvlCjjmqBPnBIHY2kdyMMjv1vGs=;
        b=Y/D/oT03gnHxiHxvFiKgyaMMnwYDDxYEue+ZRaR8LqaCuE+sMOwCLLHTIWJyJO6X1/K+ze
        Bzn/NRVOQCTZHyurUKyki6nk39IOOUvKeAao0LQFCKVZwNO5dp/LRm+VrDyuaN2lGj9Rg9
        J7usjyCezBX3RYKInimignX0+Df3cTg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 89EFAA3B83;
        Thu, 18 Nov 2021 08:47:47 +0000 (UTC)
Date:   Thu, 18 Nov 2021 09:47:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm/oom: handle remote ooms
Message-ID: <YZYTMxjItztiTyld@dhcp22.suse.cz>
References: <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
 <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
 <YY4nm9Kvkt2FJPph@dhcp22.suse.cz>
 <CAHS8izMjfwgiNEoJWGSub6iqgPKyyoMZK5ONrMV2=MeMJsM5sg@mail.gmail.com>
 <YZI9ZbRVdRtE2m70@dhcp22.suse.cz>
 <CAHS8izPcnwOqf8bjfrEd9VFxdA6yX3+a-TeHsxGgpAR+_bRdNA@mail.gmail.com>
 <YZN5tkhHomj6HSb2@dhcp22.suse.cz>
 <CAHS8izNTbvhjEEb=ZrH2_4ECkVhxnCLzyd=78uWmHA_02iiA9Q@mail.gmail.com>
 <YZOWD8hP2WpqyXvI@dhcp22.suse.cz>
 <CAHS8izPyCDucFBa9ZKz09g3QVqSWLmAyOmwN+vr=X2y7yZjRQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izPyCDucFBa9ZKz09g3QVqSWLmAyOmwN+vr=X2y7yZjRQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-11-21 13:27:34, Mina Almasry wrote:
> On Tue, Nov 16, 2021 at 3:29 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Can you elaborate some more? How do you enforce that the mount point
> > cannot be accessed by anybody outside of that constraint?
> 
> So if I'm a bad actor that wants to intentionally DoS random memcgs on
> the system I can:
> 
> mount -t tmpfs -o memcg=/sys/fs/cgroup/unified/memcg-to-dos tmpfs /mnt/tmpfs
> cat /dev/random > /mnt/tmpfs

If you can mount tmpfs then you do not need to fiddle with memcgs at
all. You just DoS the whole machine. That is not what I was asking
though.

My question was more towards a difference scenario. How do you
prevent random processes to _write_ to those mount points? User/group
permissions might be just too coarse to describe memcg relation. Without
memcg in place somebody could cause ENOSPC to the mount point users
and that is not great either but that should be recoverable to some
degree. With memcg configuration this would cause the memcg OOM which
would be harder to recover from because it affects all memcg charges in
that cgroup - not just that specific fs access. See what I mean? This is
a completely new failure mode. 

The only reasonable way would be to reduce the visibility of that mount
point. This is certainly possible but it seems rather awkward when it
should be accessible from multiple resource domains.

I cannot really shake off feeling that this is potentially adding more
problems than it solves.
-- 
Michal Hocko
SUSE Labs
