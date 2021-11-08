Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EB7449DF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 22:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbhKHVXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 16:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240035AbhKHVW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:22:59 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA1BC061746
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Nov 2021 13:20:14 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y124-20020a623282000000b0047a09271e49so11370592pfy.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Nov 2021 13:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=9WU77qiyFJ2kLEsta1yGwcYoFr6WpwZMlTN2QvzNdcQ=;
        b=XoZ7JWwmBewgPmGjnm10qp+RIw/NVsOqlra/8f6lrdUWEv3z88BW5xl/BmGAZkkpVX
         z4V26/l0vtZObekIpNQ9FfYR1y+YMbCt1PFXx5zNa2pn3Yras1kBCHo2liM5OI4tMNeS
         DTeMxphjd6Da/3anBbATiQQCseQmZwrNVBDA7y3+umUoYpuLIvfwNqTR+NH5tPb2JkCw
         MA5Xi0MH83tKnMBDAkMTLh1Ly8kWbBsL0dWZ5d4jGWmF27bPoDNZHLRR9nffqgmAflmV
         79e58VzLJDhg/VKpYqz92xR5sXSmywy2IKW+8FrUBL0lHHTPO3pM0UH/67MUSsX4G/Xa
         Y1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=9WU77qiyFJ2kLEsta1yGwcYoFr6WpwZMlTN2QvzNdcQ=;
        b=fLVcEufKkKkgId3CRV2NM1DNB9SnuYTojQFj4U55y1uD6x4PHJdRUYa+HOBgVVm2Ji
         NKGaZvfat019QuS4XkLwj5zR3taP5F1wCk11t3WSMN0w3CVOfC82hmPAL7IrusHXD70D
         EAisLg8pEtfjdsktABj/dd16/j4GtzwfyTTKWiLBInfZeiwj9qy0sy+mbqRxzUK3SqZO
         3bB4F3cp81FgIemZzKrtiK3YXGKbAFJb/u2lfTAnTO3+o4muITurdYeemcA8pAbIsGAw
         EYVQ5xDMD1JNyyg2t8J4+HRD+V5hkCbtxJPJwIuiZ75nuGqOQT8r6vFaDioPc0wAduCo
         SVHg==
X-Gm-Message-State: AOAM533EFnLHm44vTC3YTSVEaNzmeNbvO2HIjM4ak+/WyT45w1ByaGdM
        E80kZHreh84kCwUQrhp6/GG3zo6CJDMq3ja2eQ==
X-Google-Smtp-Source: ABdhPJyiMnEsbTg2euGguvqj93KbzV4NSrI0GvzmkEHj4Gpa1PgsADOPZu4SL6FQIysaNjHUxKEEy6x0bm2X74pFeg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:8717:7707:fb59:664e])
 (user=almasrymina job=sendgmr) by 2002:a63:82c6:: with SMTP id
 w189mr1873879pgd.469.1636406414317; Mon, 08 Nov 2021 13:20:14 -0800 (PST)
Date:   Mon,  8 Nov 2021 13:19:58 -0800
In-Reply-To: <20211108211959.1750915-1-almasrymina@google.com>
Message-Id: <20211108211959.1750915-5-almasrymina@google.com>
Mime-Version: 1.0
References: <20211108211959.1750915-1-almasrymina@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v1 4/5] mm, shmem: add tmpfs memcg= option documentation
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: Michal Hocko <mhocko@suse.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Thelen <gthelen@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Roman Gushchin <songmuchun@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: riel@surriel.com
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: cgroups@vger.kernel.org

---
 Documentation/filesystems/tmpfs.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 0408c245785e3..1ab04e8fa9222 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -137,6 +137,23 @@ mount options.  It can be added later, when the tmpfs is already mounted
 on MountPoint, by 'mount -o remount,mpol=Policy:NodeList MountPoint'.


+If CONFIG_MEMCG is enabled, tmpfs has a mount option to specify the memory
+cgroup to be charged for page allocations.
+
+memcg=/sys/fs/cgroup/unified/test/: data page allocations are charged to
+cgroup /sys/fs/cgroup/unified/test/.
+
+When charging memory to the remote memcg (memcg specified with memcg=) and
+hitting the limit, the oom-killer will be invoked and will attempt to kill
+a process in the remote memcg. If no such processes are found, the remote
+charging process gets an ENOMEM. If the remote charging process is in the
+pagefault path, it gets killed.
+
+Only processes that have access to /sys/fs/cgroup/unified/test/cgroup.procs can
+mount a tmpfs with memcg=/sys/fs/cgroup/unified/test. Thus, a process is able
+to charge memory to a cgroup only if it itself is able to enter that cgroup.
+
+
 To specify the initial root directory you can use the following mount
 options:

--
2.34.0.rc0.344.g81b53c2807-goog
