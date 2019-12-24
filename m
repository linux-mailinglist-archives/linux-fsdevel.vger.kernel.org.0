Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62A8129EB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 08:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfLXHzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 02:55:14 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39236 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfLXHzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:55:13 -0500
Received: by mail-pj1-f68.google.com with SMTP id t101so886733pjb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 23:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2+v0d7iT3tOVdHEBeSInAbmod4y43u3/BCaAImk6sv8=;
        b=b2EI3mhwKNVIOshHL94J215WbXmGgocrzV7SjSDvSMJLs1a7MNc6K5aWnHu849eHMU
         ecnXUX91PezOVXaMgrkzX6QcsigrU9gn75ZWtPcADxWoGg/t4I2+cU2zkuvpFAA9ZsOD
         m3krp9CHRQfhb7UBk1uaP5pysi1z0VyG35EFtKzwBVnujfzgLLKTWl3uJxDFhziHrYd2
         i3/Ey2nHw4WcUdzHmPYXUvl7WP9posu0a1p5ZGOx/tmw4Vmp50Dj4G2pONucBeh4GLvh
         3GT9XuTV89Ba8Xesk+bHQTEPB2skJp7Yl2usbmKR3ZSSGrAiMeaINAR3xk0QqXzrnTi9
         7mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2+v0d7iT3tOVdHEBeSInAbmod4y43u3/BCaAImk6sv8=;
        b=rfmEHVtUdxyqw9WP+Qm4yy2jS5f62xPc/+P29hvQ9/E/IhmlZfZd34m78/uHJpV/Sx
         2X+bYytnebqdP4vv9ahNdxVFB4pGafY2LeXtWNtVeQ9T/fY2rP+hrZcWw3s1wyOlVYBW
         e5IrcxEnC26x3LJiHvHeESPcLDHJcUVE01A8/avtoy/6tSkiD14dbmIg0C06Dkc6RgHX
         xRd+LqRTV9zkwBbdYL6Ygev9jzFwBlqDnp7YYl9NLTLbgd7t3yIszB9EQa/EmVaH1bUF
         wcllmk9c+quV/zhsJYCzUKKgKH2tMjL6VvRfRbH/my8p803Dy/qT0puHpbBvic5KcOI5
         kxhA==
X-Gm-Message-State: APjAAAUPpr4QJ7xKwNHvzXLGAUSx7d8L5AG+TOk70OrWaXkiQVmtTF6K
        ee7oDdrksCTvn5CaOko3PTM=
X-Google-Smtp-Source: APXvYqxam6oaRmmA0S2FpYpIaLPXtczqcatLHCZltwpvFqrqE8jDqQlqLvMHatuYfR3BaMkkRo7EWA==
X-Received: by 2002:a17:902:bf47:: with SMTP id u7mr35584424pls.259.1577174113147;
        Mon, 23 Dec 2019 23:55:13 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id c2sm2004064pjq.27.2019.12.23.23.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 23:55:12 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, david@fromorbit.com, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 0/5] protect page cache from freeing inode
Date:   Tue, 24 Dec 2019 02:53:21 -0500
Message-Id: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
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

This patchset contains five patches,
Patches 1-3: Minor opmizations and also the preparation of Patch-5
Patch 4: Preparation of Patch-5
Patch 5: the real issue I want to fix

- Changes against v1:
Use the memcg passed from the shrink_control, instead of getting it from
inode itself, suggested by Dave. That could make the laying better.

Yafang Shao (5):
  mm, memcg: reduce size of struct mem_cgroup by using bit field
  mm, memcg: introduce MEMCG_PROT_SKIP for memcg zero usage case
  mm, memcg: reset memcg's memory.{min, low} for reclaiming itself
  mm: make memcg visible to lru walker isolation function
  memcg, inode: protect page cache from freeing inode

 fs/inode.c                 | 25 ++++++++++++++--
 include/linux/memcontrol.h | 54 ++++++++++++++++++++++++++++-------
 mm/list_lru.c              | 22 +++++++-------
 mm/memcontrol.c            | 71 +++++++++++++++++++++++++++++++++++-----------
 mm/vmscan.c                | 11 +++++++
 5 files changed, 144 insertions(+), 39 deletions(-)

-- 
1.8.3.1

