Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD123CD28D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhGSKEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:04:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:44726 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236474AbhGSKEb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=7c123YSCTdMincmxsUMhI0gcAR3i6drsKgalA/feMPM=; b=Te4SOHf97DtWg2mwijW
        kycbL9/Q5a6se3Bg9L+sU/Pb2aR2MgjAzqokiBoQXHL3pOenpYZnUBW8MwUuUz/zga8eXZmOZHSqX
        ma6nC9ez9h3jnvUVyO82NaYkq8EzMY/jdV6Q6wVmZT6Nz8OnGsHfkmCQrrBDymway3fzkmFEc1M=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m5Qlp-004Rg6-Su; Mon, 19 Jul 2021 13:45:09 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v5 08/16] memcg: enable accounting for pollfd and select bits
 arrays
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CALvZod66KF-8xKB1dyY2twizDE=svE8iXT_nqvsrfWg1a92f4A@mail.gmail.com>
 <cover.1626688654.git.vvs@virtuozzo.com>
Message-ID: <4e3cb762-73b4-d4d2-487d-37a414073141@virtuozzo.com>
Date:   Mon, 19 Jul 2021 13:45:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1626688654.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

User can call select/poll system calls with a large number of assigned
file descriptors and force kernel to allocate up to several pages of memory
till end of these sleeping system calls. We have here long-living
unaccounted per-task allocations.

It makes sense to account for these allocations to restrict the host's
memory consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 945896d..e83e563 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -655,7 +655,7 @@ int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 			goto out_nofds;
 
 		alloc_size = 6 * size;
-		bits = kvmalloc(alloc_size, GFP_KERNEL);
+		bits = kvmalloc(alloc_size, GFP_KERNEL_ACCOUNT);
 		if (!bits)
 			goto out_nofds;
 	}
@@ -1000,7 +1000,7 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 
 		len = min(todo, POLLFD_PER_PAGE);
 		walk = walk->next = kmalloc(struct_size(walk, entries, len),
-					    GFP_KERNEL);
+					    GFP_KERNEL_ACCOUNT);
 		if (!walk) {
 			err = -ENOMEM;
 			goto out_fds;
-- 
1.8.3.1

