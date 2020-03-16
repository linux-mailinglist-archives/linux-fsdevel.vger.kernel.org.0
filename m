Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D3186945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 11:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgCPKkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 06:40:23 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51113 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgCPKkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:40:23 -0400
Received: by mail-pj1-f66.google.com with SMTP id o23so2331440pjp.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2020 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a9gc0XHBJKY89zwnMCJORS3KUqDDhKLq7++ME1/DG/0=;
        b=Fs79amYVExQ3JwoMO+48+QYtAp0yVOdMTC4MWCHDfaomZeTMNgHklFvGZMdKhnBZk7
         XvIdYWieMvFlEoygzK0W+3+i3YqcxIhAbJUn673ek1Bo9sEqvUWB/mGJ6yhZG/fXGZcE
         CLNQa5Zdpi39oRPnTMts9ykBhR2RNRBD/uCdMFvDrtQPI3MNM81kVmuQbFfAMW/43cL8
         k84X+LzRIyIHLOi6MECaF4d1OagLl/LpiiSuMIDDHWSCOIugZsHP6j5RHQex+tTaKdx7
         hhRPg6WN25MgreQ3K1wO1sATdEeb5/huCbGTAOVd8rZxZpmnFYCzdL3POsitpTx5bLo/
         GPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a9gc0XHBJKY89zwnMCJORS3KUqDDhKLq7++ME1/DG/0=;
        b=D7L4aBtxYm/pKtshPVF7LuDvvEBKF0iFL207Hy8Mjsdc2kaUEFRFfKO+UshyZIeMVt
         gcdh5m8NIqHXH2emhlFgib5u7kFstqpHCn+zWgWNTYK4+WMHxk3UNkDo3SfRLNcEoVxi
         eGHMn7IZ70Q2cdMby43JviG6EGWcbi1W6MuVvhewxaIxpsSJ9q9m+s18yoqxR8NlYBJA
         eSCMKHkeEGM0eS7drjH9OeVcS7YWARN/gQr2JYINrivrw/cPJ9My2q2qu2UDI+UnVIuS
         ZsnF197I8anQYXuhjdCGfyWUSrzCpmpxY4E/Smvm2w16o7INPZEYegGQ6B3h40qNQltU
         voxw==
X-Gm-Message-State: ANhLgQ0+M3P58dzWKFUttZbENVz1P72rs23MH6qJYKVjPhDWl+K9Ok/i
        SQVymxT6DAcGxHMWdu0AQg0=
X-Google-Smtp-Source: ADFU+vuHgzgFf4ysXkEpACvb/JyJiEUdrxXesacBq9QLcMooZl9/yrbMISAy+YAphT2lCdW7ecJgzQ==
X-Received: by 2002:a17:90a:950f:: with SMTP id t15mr9236438pjo.133.1584355222000;
        Mon, 16 Mar 2020 03:40:22 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id h2sm19834276pjc.7.2020.03.16.03.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 03:40:21 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 0/3] protect page cache from freeing inode
Date:   Mon, 16 Mar 2020 06:39:55 -0400
Message-Id: <1584355198-10137-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On my server there're some running MEMCGs protected by memory.{min, low},
but I found the usage of these MEMCGs abruptly became very small, which
were far less than the protect limit. It confused me and finally I
found that was because of inode stealing.
Once an inode is freed, all its belonging page caches will be dropped as
well, no matter how may page caches it has. So if we intend to protect the
page caches in a memcg, we must protect their host (the inode) first.
Otherwise the memcg protection can be easily bypassed with freeing inode,
especially if there're big files in this memcg.

The inherent mismatch between memcg and inode is a trouble. One inode can
be shared by different MEMCGs, but it is a very rare case. If an inode is
shared, its belonging page caches may be charged to different MEMCGs.
Currently there's no perfect solution to fix this kind of issue, but the
inode majority-writer ownership switching can help it more or less.

After this patch, it may take extra time to skip these inodes when
workload outside of a memcg protected by memory.min or memory.low is
trying to do page reclaim, especially if there're lots of inodes pinned
by pagecache in this protected memcg. In order to measure the potential
regressions, I constructed bellow test case on my server.
My server is a machine with two nodes, and each of these nodes has 64GB
memory. I created two memcgs, and memory.low of these memcgs are both set
with 1G. Then I generated more than 500 thousand inodes in each of them,
and pagacaches of these inodes are from 4K to 4M. IOW, there're totally
more than 1 million xfs_inode in the memory and the total pagecache of
them are nearly 128GB. Then I run a workload outside of these two
protected memcgs. That workload is usemem in Mel's mmtests with a little
modification to alloc almost all the memory and iterate only once.
Bellow is the compared result of the Amean of elapsed time and sys%.

                               5.6.0-rc4               patched
Amean     syst-4        65.75 (   0.00%)       68.08 *  -3.54%*
Amean     elsp-4        32.14 (   0.00%)       32.63 *  -1.52%*
Amean     syst-7        67.47 (   0.00%)       66.71 *   1.13%*
Amean     elsp-7        19.83 (   0.00%)       18.41 *   7.16%*
Amean     syst-12       98.27 (   0.00%)       99.29 *  -1.04%*
Amean     elsp-12       15.60 (   0.00%)       16.00 *  -2.56%*
Amean     syst-21      174.69 (   0.00%)      172.92 *   1.01%*
Amean     elsp-21       14.63 (   0.00%)       14.75 *  -0.82%*
Amean     syst-30      195.78 (   0.00%)      205.90 *  -5.17%*
Amean     elsp-30       12.42 (   0.00%)       12.73 *  -2.50%*
Amean     syst-40      249.85 (   0.00%)      250.81 *  -0.38%*
Amean     elsp-40       12.19 (   0.00%)       12.25 *  -0.49%*

I did many times. Each time I run this test, I got different result. But
the differece is not too big.

Furthmore, this behavior only occurs when memory.min or memory.low is
set, and the user already knows that memory.{min, low} can protect the
pages at the cost of taking more CPU times, so small extra time is
expected by the user.

While if the workload trying to reclaim these protected inodes is inside of
a protected memcg, then this workload will not be effected at all
because memory.{min, low} doesn't take effect under this condition.

- Changes against v5:
Fix an error pointed by Matthew.

- Changes against v4:
Update with the test result to measure the potential regression.
And rebase this patchset on 5.6.0-rc4.

- Changes against v3:
Fix the possible risk pointed by Johannes in another patchset [1].
Per discussion with Johannes in that mail thread, I found that the issue
Johannes is trying to fix is different with the issue I'm trying to fix.
That's why I update this patchset and post it again. This specific memcg
protection issue should be addressed.

- Changes against v2:
    1. Seperates memcg patches from this patchset, suggested by Roman.
    2. Improves code around the usage of for_each_mem_cgroup(), suggested
       by Dave
    3. Use memcg_low_reclaim passed from scan_control, instead of
       introducing a new member in struct mem_cgroup.
    4. Some other code improvement suggested by Dave.


- Changes against v1:
Use the memcg passed from the shrink_control, instead of getting it from
inode itself, suggested by Dave. That could make the laying better.

[1]. https://lore.kernel.org/linux-mm/20200211175507.178100-1-hannes@cmpxchg.org/


Yafang Shao (3):
  mm, list_lru: make memcg visible to lru walker isolation function
  mm, shrinker: make memcg low reclaim visible to lru walker isolation
    function
  inode: protect page cache from freeing inode

 fs/inode.c                 | 76 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/memcontrol.h | 18 +++++++++++
 include/linux/shrinker.h   |  3 ++
 mm/list_lru.c              | 47 ++++++++++++++++------------
 mm/memcontrol.c            | 15 ---------
 mm/vmscan.c                | 27 +++++++++-------
 6 files changed, 138 insertions(+), 48 deletions(-)

-- 
1.8.3.1

