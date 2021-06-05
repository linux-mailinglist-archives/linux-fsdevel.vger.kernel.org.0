Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C57C39CB45
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 23:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFEVjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Jun 2021 17:39:44 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:42516 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFEVjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Jun 2021 17:39:43 -0400
Received: by mail-il1-f180.google.com with SMTP id a8so11300949ilv.9;
        Sat, 05 Jun 2021 14:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f0JYFWLbU1K2WU+3KcY+euQ65dBHJZ+TcnqUBRn+Ixw=;
        b=rYrH/iCtcdSFI9Wp5XTB6rFjWGy65dCezviNROeFN5cdB0KuU3jaMkNAp0pDyCoq54
         KgM2DUOGWR77jZBGQD9hinqSyumCsRmLJjPL7R6tUyVmPJLLI0eEmWbq/Pm9181ZafLV
         A2BG6OKnk6daBcrFcYP3eYwc9hUx43esDCNL7F+71MaauBn7g//3eA5hs0UfG9wColS3
         DnBKqTZ3hXekmtn2C2/O2V9evrvH5YogK92Vao0LPpfCqiyQotPy9RH35sbV6dNEZ0CO
         nK1un+b/bx/r3Hgu5mUnilxldWv9NsZEhFVNcD+cXYCMQY3n/+hLPqUmxDtnrUgpb0V0
         svBA==
X-Gm-Message-State: AOAM5326Inj7PmUlImMzAgbReo2Wbl2tupkCgO9yfref3yByoW3Bq+0Z
        4c8xY2luC6mrZJCpDsPETzU=
X-Google-Smtp-Source: ABdhPJwMLOVVfaiNYKItkPtUrVqfpfgw6YBhzHcDjMO92/yapMMAIYYVBoDqFzfAUq9CFL3+jjmLaA==
X-Received: by 2002:a92:c611:: with SMTP id p17mr8862502ilm.166.1622929059076;
        Sat, 05 Jun 2021 14:37:39 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id 15sm3666647ilt.66.2021.06.05.14.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 14:37:38 -0700 (PDT)
Date:   Sat, 5 Jun 2021 21:37:37 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v7 0/6] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <YLvuofB0xMuz/wz9@google.com>
References: <20210604013159.3126180-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604013159.3126180-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Thu, Jun 03, 2021 at 06:31:53PM -0700, Roman Gushchin wrote:
> When an inode is getting dirty for the first time it's associated
> with a wb structure (see __inode_attach_wb()). It can later be
> switched to another wb (if e.g. some other cgroup is writing a lot of
> data to the same inode), but otherwise stays attached to the original
> wb until being reclaimed.
> 
> The problem is that the wb structure holds a reference to the original
> memory and blkcg cgroups. So if an inode has been dirty once and later
> is actively used in read-only mode, it has a good chance to pin down
> the original memory and blkcg cgroups forewer. This is often the case with
> services bringing data for other services, e.g. updating some rpm
> packages.
> 
> In the real life it becomes a problem due to a large size of the memcg
> structure, which can easily be 1000x larger than an inode. Also a
> really large number of dying cgroups can raise different scalability
> issues, e.g. making the memory reclaim costly and less effective.
> 
> To solve the problem inodes should be eventually detached from the
> corresponding writeback structure. It's inefficient to do it after
> every writeback completion. Instead it can be done whenever the
> original memory cgroup is offlined and writeback structure is getting
> killed. Scanning over a (potentially long) list of inodes and detach
> them from the writeback structure can take quite some time. To avoid
> scanning all inodes, attached inodes are kept on a new list (b_attached).
> To make it less noticeable to a user, the scanning and switching is performed
> from a work context.
> 
> Big thanks to Jan Kara, Dennis Zhou and Hillf Danton for their ideas and
> contribution to this patchset.
> 
> v7:
>   - shared locking for multiple inode switching
>   - introduced inode_prepare_wbs_switch() helper
>   - extended the pre-switch inode check for I_WILL_FREE
>   - added comments here and there
> 
> v6:
>   - extended and reused wbs switching functionality to switch inodes
>     on cgwb cleanup
>   - fixed offline_list handling
>   - switched to the unbound_wq
>   - other minor fixes
> 
> v5:
>   - switch inodes to bdi->wb instead of zeroing inode->i_wb
>   - split the single patch into two
>   - only cgwbs maintain lists of attached inodes
>   - added cond_resched()
>   - fixed !CONFIG_CGROUP_WRITEBACK handling
>   - extended list of prohibited inodes flag
>   - other small fixes
> 
> 
> Roman Gushchin (6):
>   writeback, cgroup: do not switch inodes with I_WILL_FREE flag
>   writeback, cgroup: switch to rcu_work API in inode_switch_wbs()
>   writeback, cgroup: keep list of inodes attached to bdi_writeback
>   writeback, cgroup: split out the functional part of
>     inode_switch_wbs_work_fn()
>   writeback, cgroup: support switching multiple inodes at once
>   writeback, cgroup: release dying cgwbs by switching attached inodes
> 
>  fs/fs-writeback.c                | 302 +++++++++++++++++++++----------
>  include/linux/backing-dev-defs.h |  20 +-
>  include/linux/writeback.h        |   1 +
>  mm/backing-dev.c                 |  69 ++++++-
>  4 files changed, 293 insertions(+), 99 deletions(-)
> 
> -- 
> 2.31.1
> 

I too am a bit late to the party. Feel free to add mine as well to the
series.

Acked-by: Dennis Zhou <dennis@kernel.org>

I left my one comment on the last patch regarding a possible future
extension.

Thanks,
Dennis
