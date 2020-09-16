Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E200026C8DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 20:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgIPS6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 14:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgIPS6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:58:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DACDC06174A;
        Wed, 16 Sep 2020 11:58:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so4397948pgd.12;
        Wed, 16 Sep 2020 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHnOyfd11fuaDMHJEA6fIG0O9TIwpb3umMctEKX/Vyg=;
        b=jntgCgVMXGda+8BFGAlrv5AGNNV+QQO8b6bEf34x5C5VztwL6t/++yyRtt8TGIRpVg
         86b0/zRlb0ZZTCNXyrF2M5IvyQ4R3jvGkWJrkr7EGimz+Rmw9XGwoJ6NYFpw1Q7tU3ZJ
         Z4oISOPdku2hodf3uTl2hHJCPh3rpLL06/G9souJroutxnNlCC8i6iA+wdU+8hf5PuYD
         Emag8dE+GpqE+6EZ7lmjkcnTpyD+V1CR8nflGL0GXwO/s9BOrOgXty4eJljvA4TvI+t8
         R4/YJHbQxPgcv2jJKIWX4envYmzl3GhzK/GmSKpfyNZTJRmPeQd2OI97kq+P/Ca2RSG4
         kS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHnOyfd11fuaDMHJEA6fIG0O9TIwpb3umMctEKX/Vyg=;
        b=OTIfh70VBdGmadGBec1V2ppEdWxXiDxIRZNCI1UeUS4mDdSQ6awgivY4WOdpPIdaA7
         cT4azfMuac4zZShhcVsAUM8ji99AgNoRhBr8bu1jTfrMvUofJsngQ1guKmT2sRuo6+Rr
         lKjMVI283cQ81kO9JJQFZZZtTXp7Wrr3iyduQEROW0/HT8EbAdidtwStkZVGMcOS6MIn
         K+HHyx6AW3KcwwXp8EpcI8mM1iplKTFpG0aISEGxKSMuVTEcg11UTUopWFqO+hXL4pm2
         SZOJ34awYTJqcZvm3JW/xqcZoSxCyvEeYStVhbn5QBzh6yIW08tag0PeR19nPcirgO2h
         u27w==
X-Gm-Message-State: AOAM533YcAkp9HUVoMkgcVcOmabzMH6A8qujxLe5S3C5T0WXmKb203NL
        MrFa+Luv/HmJGch/oRjROGYT9s6apKQ=
X-Google-Smtp-Source: ABdhPJyqp7mEXldM+Vzl4EMfrIFN6GkSxZha6QOteU6DVv2b9Vn5CZJwinly18mWEQKG7fBdWdFwWw==
X-Received: by 2002:a63:6246:: with SMTP id w67mr242623pgb.344.1600282719147;
        Wed, 16 Sep 2020 11:58:39 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id fz23sm3453747pjb.36.2020.09.16.11.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:58:37 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     shy828301@gmail.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Remove shrinker's nr_deferred
Date:   Wed, 16 Sep 2020 11:58:21 -0700
Message-Id: <20200916185823.5347-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Recently huge amount one-off slab drop was seen on some vfs metadata heavy workloads,
it turned out there were huge amount accumulated nr_deferred objects seen by the
shrinker.

I managed to reproduce this problem with kernel build workload plus negative dentry
generator.

First step, run the below kernel build test script:

NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`

cd /root/Buildarea/linux-stable

for i in `seq 1500`; do
        cgcreate -g memory:kern_build
        echo 4G > /sys/fs/cgroup/memory/kern_build/memory.limit_in_bytes

        echo 3 > /proc/sys/vm/drop_caches
        cgexec -g memory:kern_build make clean > /dev/null 2>&1
        cgexec -g memory:kern_build make -j$NR_CPUS > /dev/null 2>&1

        cgdelete -g memory:kern_build
done

That would generate huge amount deferred objects due to __GFP_NOFS allocations.

Then run the below negative dentry generator script:

NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`

mkdir /sys/fs/cgroup/memory/test
echo $$ > /sys/fs/cgroup/memory/test/tasks

for i in `seq $NR_CPUS`; do
        while true; do
                FILE=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64`
                cat $FILE 2>/dev/null
        done &
done

Then kswapd will shrink half of dentry cache in just one loop as the below tracing result
showed:

	kswapd0-475   [028] .... 305968.252561: mm_shrink_slab_start: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0
objects to shrink 4994376020 gfp_flags GFP_KERNEL cache items 93689873 delta 45746 total_scan 46844936 priority 12
	kswapd0-475   [021] .... 306013.099399: mm_shrink_slab_end: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0 unused
scan count 4994376020 new scan count 4947576838 total_scan 8 last shrinker return val 46844928

There were huge deferred objects before the shrinker was called, the behavior does match the code
but it might be not desirable from the user's stand of point.

IIUC the deferred objects were used to make balance between slab and page cache, but since commit
9092c71bb724dba2ecba849eae69e5c9d39bd3d2 ("mm: use sc->priority for slab shrink targets") they
were decoupled.  And as that commit stated "these two things have nothing to do with each other".

So why do we have to still keep it around?  I can think of there might be huge slab accumulated
without taking into account deferred objects, but nowadays the most workloads are constrained by
memcg which could limit the usage of kmem (by default now), so it seems maintaining deferred
objects is not that useful anymore.  It seems we could remove it to simplify the shrinker logic
a lot.

I may overlook some other important usecases of nr_deferred, comments are much appreciated.


