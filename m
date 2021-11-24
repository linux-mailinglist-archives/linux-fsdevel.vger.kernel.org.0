Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5445CD5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 20:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbhKXTjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 14:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbhKXTjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:39:17 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF93C061746
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 11:36:08 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z4-20020a656104000000b00321790921fbso1214416pgu.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 11:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=l9t6ClhMMo4edSjmJdir8QUj58OMyUYJRTb0MJXDOKU=;
        b=i0/Ngz3cNacHmR60ZQrdeEnU5wK465ot7VF/quxdpABPcQ5rReQE4P1dvpSxwpUQ3m
         WJ7qE/WsmjAnexVyI5rsHFc8xD8POs/0ISZbs4ZJkhR+CYum1Q3AFocYRIxWrBtGPYyd
         kpGigPgr0Gy6viXOgyakF3EJmTn3zFz9OVVwTg9lIs9gTEHhaESQjUH4FFP+hPxZ3q3D
         aPs6s2Nsd5VhVbRR2vRo55J4x+AdhEx7XRnb2UkZLKv2t2yG6O4cp3R60tecsUAshY60
         boOQrsQpXPVxDlp5sBkCJxX+Cl7biSAKJg+KC20HTZUp3GnjLr+bKkhdo0e7k5hun9DX
         hd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=l9t6ClhMMo4edSjmJdir8QUj58OMyUYJRTb0MJXDOKU=;
        b=AhT+JooOBCBnJBzenW4CapWusCPE97AwR0OL9KTfgZW2f6aT21c3bqbFRBj+9IpfY0
         MXXVWUD/BpS3Fa85EI74UCX4pBHV3Pxg1ImYtzsRwTBJrJ/tTVRA4voJzVeG/8dV1wqc
         dmHdjmh6uQpPAMaVaW5c7EUlQ9O3MVXeMDiks3I3dbEY34ZQOZemG84FaJVT46ZR9LzW
         EarVGaaFt9PmySVNpcpovPyznKDWMmyM49P/iUfQ32wFff1R+1G1KzvFguqBezgFu6s8
         SVuGSCJ3LNDO26caR0V3MhjTm/O+zs1EASGS0biM5DV6S+LsRersgMhIVF6MlgZMWFSH
         1Dcg==
X-Gm-Message-State: AOAM533iokplY+JgbOVIBVWPVl5JZ0vMOa0cEuLgJcC/ZbBM7t4D3mTG
        rHHeSCCvQoF7ivcA2roqYauOtWA3vy0=
X-Google-Smtp-Source: ABdhPJzIBX9oxqVPB6dAYbBGP63Ursk9otTuOWoAVdTYt8LpHs+DLkFQWjiFWGnpyjXSRzphENtqYSJ9moM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:ecf7:86c0:3b4d:493])
 (user=surenb job=sendgmr) by 2002:a63:914c:: with SMTP id l73mr12197689pge.184.1637782567590;
 Wed, 24 Nov 2021 11:36:07 -0800 (PST)
Date:   Wed, 24 Nov 2021 11:36:04 -0800
Message-Id: <20211124193604.2758863-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 1/1] sysctl: change watermark_scale_factor max limit to 30%
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, hannes@cmpxchg.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        dave.hansen@linux.intel.com, vbabka@suse.cz,
        mgorman@techsingularity.net, corbet@lwn.net, yi.zhang@huawei.com,
        xi.fengfei@h3c.com, rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For embedded systems with low total memory, having to run applications
with relatively large memory requirements, 10% max limitation for
watermark_scale_factor poses an issue of triggering direct reclaim
every time such application is started. This results in slow application
startup times and bad end-user experience.
By increasing watermark_scale_factor max limit we allow vendors more
flexibility to choose the right level of kswapd aggressiveness for
their device and workload requirements.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 2 +-
 kernel/sysctl.c                         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 5e795202111f..f4804ce37c58 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -948,7 +948,7 @@ how much memory needs to be free before kswapd goes back to sleep.
 
 The unit is in fractions of 10,000. The default value of 10 means the
 distances between watermarks are 0.1% of the available memory in the
-node/system. The maximum value is 1000, or 10% of memory.
+node/system. The maximum value is 3000, or 30% of memory.
 
 A high rate of threads entering direct reclaim (allocstall) or kswapd
 going to sleep prematurely (kswapd_low_wmark_hit_quickly) can indicate
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 083be6af29d7..2ab4edb6e450 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -122,6 +122,7 @@ static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
 static int two_hundred = 200;
 static int one_thousand = 1000;
+static int three_thousand = 3000;
 #ifdef CONFIG_PRINTK
 static int ten_thousand = 10000;
 #endif
@@ -2959,7 +2960,7 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= watermark_scale_factor_sysctl_handler,
 		.extra1		= SYSCTL_ONE,
-		.extra2		= &one_thousand,
+		.extra2		= &three_thousand,
 	},
 	{
 		.procname	= "percpu_pagelist_high_fraction",
-- 
2.34.0.rc2.393.gf8c9666880-goog

