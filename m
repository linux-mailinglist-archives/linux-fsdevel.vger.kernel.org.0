Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD3169705
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 10:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgBWJcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 04:32:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34624 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:32:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id j4so3421172pgi.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 01:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M1rhu8g2TsUmdvwz4Fj4mGs/gXjLFCQHg1A5nJXa8n4=;
        b=sCYEsVwjaXQWZOGQAYk12Tp4pCwyu2Ry27gidyYcAxSoJRC2wVK4xatnBHTYLcKtuH
         hUshHrf0/XPa8c/rlG9D3Fgpssw//Dqo/v1SGblbPz+gu1LgC1+IZq3Wt5KgxzUqP0tT
         5SKp9/iYqh7f2kNut2eMRfUqcUiPEj/1T7QtJ8ozRBfRMxFjWywxAkD9Dw96JtA47b6A
         hzNU+3jmuWsXg7jdJ3/+NC67oJR0BO4rfs+EMJzLZuXXHOjB3z7CLectM08iihq6NxUL
         nhrxPDQ+3856mwPw219VQ5Zyzd/OmM7NS2roMoH6aUJ+WmX0YuPJfXVbUiTR4fWohTd3
         8N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M1rhu8g2TsUmdvwz4Fj4mGs/gXjLFCQHg1A5nJXa8n4=;
        b=MlAhKeNgD6eJSLUOn4S+DBCkLOteJwX8KaheFpBf6TW2rbMkeLclnL7B4uozqHxVMJ
         du3CA4P0AZWvogJMY4+yjdjHmo33XRywmQyn2Kj6BlSMOlm+25z14uxfHnmoz6VRLJuK
         xnAd/KQoQYZ8AXiwJtJoq3iLcFQKtBSCPrhU1DrYaOn2Xxq8PDL/jik4Y9SkATu/UFNE
         0mQ+P+Z2V8WH/xfQOXYJzg3sda3HnT8JHMohWR47Z9qHYIsRAzKOniDJiL8JGTpdwzx0
         uuZH8BPHnXYGhcuAZtFT0pDpOwXdW+Ti7NbTkPHcoaFbFzu01HZu+hNdO2IAe6UxaVZC
         DzHw==
X-Gm-Message-State: APjAAAXuK2hmhlrKYndP/kpYUB+z7kzU7HO0TKEWE3cPMBGBifcRNg1Q
        IyMsqRl8/m4Od9ck0+Tci4qZ6dMnpfU=
X-Google-Smtp-Source: APXvYqwb2TMNfB6xJBZkGZEK1J6VD05yqRVMM8h02ltxDFdq29cqYdOnwR6sPOLMOu2WCAnM2X3ITQ==
X-Received: by 2002:aa7:8bda:: with SMTP id s26mr47260232pfd.194.1582450320516;
        Sun, 23 Feb 2020 01:32:00 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id t19sm8346011pgg.23.2020.02.23.01.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2020 01:31:59 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 0/3] protect page cache from freeing inode
Date:   Sun, 23 Feb 2020 04:31:31 -0500
Message-Id: <1582450294-18038-1-git-send-email-laoar.shao@gmail.com>
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
 include/linux/memcontrol.h | 21 +++++++++++++
 include/linux/shrinker.h   |  3 ++
 mm/list_lru.c              | 47 ++++++++++++++++------------
 mm/memcontrol.c            | 15 ---------
 mm/vmscan.c                | 27 +++++++++-------
 6 files changed, 141 insertions(+), 48 deletions(-)

-- 
Yafang Shao

