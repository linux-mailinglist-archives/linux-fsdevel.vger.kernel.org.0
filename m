Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC65452E26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 10:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhKPJmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 04:42:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43250 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhKPJmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:42:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 29D87218A4;
        Tue, 16 Nov 2021 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637055549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyoOkrmM4Ugx2tFGn3orFJRtgDuhEZbVLB7WBpXDCRI=;
        b=Td9R8Cpl9hprSCtmF2qOYLllhemJV/VM5LtSFcG6ch6W5tKUr6EsqYiq84CVlxTsBns0SF
        UzTICDbq38Wt+AlB3SOsGQYf1eSgtBne1YAokwEGCUTB3eR/CHNjZSgk7nzP0XADK0C/p0
        22pnnE5JPw3LiB85kDS6bJrX5PFy56s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CE818A3B83;
        Tue, 16 Nov 2021 09:39:08 +0000 (UTC)
Date:   Tue, 16 Nov 2021 10:39:08 +0100
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
Message-ID: <YZN8PCK9kmmYUXSp@dhcp22.suse.cz>
References: <20211111234203.1824138-1-almasrymina@google.com>
 <20211111234203.1824138-3-almasrymina@google.com>
 <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
 <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
 <YY4nm9Kvkt2FJPph@dhcp22.suse.cz>
 <CAHS8izMjfwgiNEoJWGSub6iqgPKyyoMZK5ONrMV2=MeMJsM5sg@mail.gmail.com>
 <YZI9ZbRVdRtE2m70@dhcp22.suse.cz>
 <CAHS8izPcnwOqf8bjfrEd9VFxdA6yX3+a-TeHsxGgpAR+_bRdNA@mail.gmail.com>
 <YZN5tkhHomj6HSb2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZN5tkhHomj6HSb2@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-11-21 10:28:25, Michal Hocko wrote:
> On Mon 15-11-21 16:58:19, Mina Almasry wrote:
[...]
> > To be honest I think this is very workable, as is Shakeel's suggestion
> > of MEMCG_OOM_NO_VICTIM. Since this is an opt-in feature, we can
> > document the behavior and if the userspace doesn't want to get killed
> > they can catch the sigbus and handle it gracefully. If not, the
> > userspace just gets killed if we hit this edge case.
> 
> I am not sure about the MEMCG_OOM_NO_VICTIM approach. It sounds really
> hackish to me. I will get back to Shakeel's email as time permits. The
> primary problem I have with this, though, is that the kernel oom killer
> cannot really do anything sensible if the limit is reached and there
> is nothing reclaimable left in this case. The tmpfs backed memory will
> simply stay around and there are no means to recover without userspace
> intervention.

And just a small clarification. Tmpfs is fundamentally problematic from
the OOM handling POV. The nuance here is that the OOM happens in a
different memcg and thus a different resource domain. If you kill a task
in the target memcg then you effectively DoS that workload. If you kill
the allocating task then it is DoSed by anybody allowed to write to that
shmem. All that without a graceful fallback.

I still have very hard time seeing how that can work reasonably except
for a very special case with a lot of other measures to ensure the
target memcg never hits the hard limit so the OOM simply is not a
problem.

Memory controller has always been used to enforce and balance memory
usage among resource domains and this goes against that principle.
I would be really curious what Johannes thinks about this.
-- 
Michal Hocko
SUSE Labs
