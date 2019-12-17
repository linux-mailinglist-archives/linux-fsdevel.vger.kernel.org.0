Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA94122A10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 12:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfLQLbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 06:31:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40816 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfLQLbR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:31:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so5512426pgt.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 03:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rRGWPvPKQxDSI3L05y8pg7cfFA9aWltFsnG1oiRzMSI=;
        b=ufvI3gkH+9OKpLMdLevFrRm9lcWeTZUpz+Z/efo5jNWIwgnAPFItIq3jOxJ4XPioGq
         qOeERq1V6dk6xnKz5YgZM1WM1H6mwgJKQq6Ur0+chmVbLaJqUGyyXAx0sEa68XkPii5m
         siNQ4Av1MAij5Pv7I1YJuFhTZTSWemR896uD/vva0uOpLfMIkIJbG/zlroTJpllp1oZ+
         zw0Mqs+vBn1/dbnr2q51oc/vPP1hCXV3+N2bOVpuBobzeHbc4ZulN0Rm2NydmPgFLt2Q
         FbwUAjBeNPTZZRE3pKDP/sDPrbmie8WPHoEwEWFaJZ/wgKPqzUe4s2zohziRq+XuI67a
         /mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rRGWPvPKQxDSI3L05y8pg7cfFA9aWltFsnG1oiRzMSI=;
        b=mwPBE5pJtqy00F9E9ynKcdZbjj2+PBTpPvjxYkjJRAOhTro1NCCTm5bx42hrjGZgmh
         dyxdsA6HAbTWVKypqK4iYB+vj9izZ57w7cacnFQWu7+WhP1D61YnyxnJ4TXDLot0ahL9
         jO0f61zv5nv5+BDkWqW7k8YfPbPcie7JPDN269gnerU/WXEg7XwoI+Hl+iJWNLsDjPzg
         PraCOXSL0FS66U6mQFQUnxXiz+uvbSHnroYjScnZlp8wLeIN3041S5gFMLsyXJ+4ZZa5
         V5RwHHd+SuFFcLEWCS6b9CeawtX4DmX+PqbnGRhaXgMxhiUw4XhxQ3loSE22zQEEPExq
         6iaw==
X-Gm-Message-State: APjAAAVumJbl+k4a0Odf+h355HmMhuzX6q8bbi+XZUPzkzC3cH1dCGQN
        Jk0QxxfEKv+XaspXaDF1R094+gBDJl4=
X-Google-Smtp-Source: APXvYqyp+i9kvmEX2JEjfrmFyef0uS18tCLpW9/UU5KBdoi5qLrph49nr7tHWXdQ3q3bNbFFdYxkzw==
X-Received: by 2002:a62:c583:: with SMTP id j125mr22647932pfg.27.1576582276983;
        Tue, 17 Dec 2019 03:31:16 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q21sm26246460pff.105.2019.12.17.03.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 03:31:16 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
Date:   Tue, 17 Dec 2019 06:29:15 -0500
Message-Id: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
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

This patchset contains four patches, in which patches 1-3 are minor
optimization and also the preparation of patch 4, and patch 4 is the real
issue I want to fix.

Yafang Shao (4):
  mm, memcg: reduce size of struct mem_cgroup by using bit field
  mm, memcg: introduce MEMCG_PROT_SKIP for memcg zero usage case
  mm, memcg: reset memcg's memory.{min, low} for reclaiming itself
  memcg, inode: protect page cache from freeing inode

 fs/inode.c                 |  9 +++++++
 include/linux/memcontrol.h | 37 ++++++++++++++++++++++-------
 mm/memcontrol.c            | 59 ++++++++++++++++++++++++++++++++++++++++++++--
 mm/vmscan.c                | 10 ++++++++
 4 files changed, 104 insertions(+), 11 deletions(-)

-- 
1.8.3.1

