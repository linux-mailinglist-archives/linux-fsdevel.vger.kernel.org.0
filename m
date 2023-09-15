Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BF77A2B17
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 01:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbjIOXte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 19:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbjIOXtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:49:11 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775092120
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 16:49:05 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34fc2773fa4so3392085ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1694821745; x=1695426545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/dSTX+76FEtG6MhpzQgONbqjypljfk2bXDS5ABkFmY=;
        b=ZB+UYNBsuDDE2gbq+DTNHdAtWBIHJJkSlEHKVgx/pSfIjF4+8Yt1mJJocGh9cIeZhZ
         zh13jeHZqTyhEOMcW3VND7zpa/hRIYZedgzsAvq/VsRrymqVP+4nBX7WpmETc7+WUeU+
         k1a7QiuPsxjMjBHkIfW7GTA2Ds6CWZTpo4lhtMoI/ylLKLjYK19X9WMk5pyqiv1DCjT5
         nd5CnAezfYhPD/t3k5B0ueU5hJ9hjAbxK4vZTYZRVsDgju7iejpg9Hljz3LGSaXr9xmt
         X1VplsUiKXr8WZeebFkDDOJqKQmym+brsZ62cSLus0TTCkbWtMJEpm9Gk/pPPuWiGps1
         cWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694821745; x=1695426545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/dSTX+76FEtG6MhpzQgONbqjypljfk2bXDS5ABkFmY=;
        b=PNQtmwFLyQhpKqJp4B6QHqs1ZYfUO9+FuEAMRjh6JuLs6hW1dL65aDL2JlfekRVnTH
         apcLy4xYLhgjvqWIp8VSprQB8LQhyNEMRit/hDouKCB7khtVTp1VQcS6xbu0Yis2GZ+1
         QRFl7nr1hfEHOLN0wVYTg8VsNvGLvBnuX7FH1Qubr8BCoC7fDjmgcPpNWRcH+vO3HoEI
         CJE+Er1FqM7nz5x8tMS1pupNtjzustB+nDSD0n0ifuDR7XbZpf6TcD0cVKXBb+wTy6Ng
         0puJvBwM+JC9YibnFlgrbHgaod8Sga6Q9Xi+SOz/6TsODQUUVawtsgRdxKv+D26RRCgz
         VmVg==
X-Gm-Message-State: AOJu0Yzq6QfR+oNclKGwYPhuuMD0hVf1P5q4L6IM0scsNsQRnPexTTAe
        1J3FV1IfdDF4RS/FWXNttIhHvg==
X-Google-Smtp-Source: AGHT+IFv+O3cGCJLrw47/BKH+XR/vCTb4TFxkoQNRL81LL3UxntDLAcVPg2Sx5O+1XJZH1Qe4SeNtQ==
X-Received: by 2002:a05:6e02:1c46:b0:34d:ed17:8476 with SMTP id d6-20020a056e021c4600b0034ded178476mr4677605ilg.10.1694821744756;
        Fri, 15 Sep 2023 16:49:04 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:9478:4be::79:1e])
        by smtp.gmail.com with ESMTPSA id q11-20020a056e02106b00b0034a921bc93asm779036ilj.1.2023.09.15.16.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 16:49:04 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     amir73il@gmail.com, mcgrof@kernel.org
Cc:     kdevops@lists.linux.dev, kernel-team@cloudflare.com,
        linux-fsdevel@vger.kernel.org,
        Frederick Lawler <fred@cloudflare.com>
Subject: [RFC PATCH kdevops 1/2] fstests/xfs: copy 6.1.42 baseline for v6.1.53
Date:   Fri, 15 Sep 2023 18:48:56 -0500
Message-Id: <20230915234857.1613994-2-fred@cloudflare.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915234857.1613994-1-fred@cloudflare.com>
References: <20230915234857.1613994-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 .../expunges/6.1.53/btrfs/unassigned/all.txt  | 38 +++++++++++
 .../btrfs/unassigned/btrfs_noraid56.txt       |  2 +
 .../6.1.53/btrfs/unassigned/btrfs_simple.txt  |  2 +
 .../btrfs/unassigned/btrfs_simple_zns.txt     | 65 +++++++++++++++++++
 .../expunges/6.1.53/ext4/unassigned/all.txt   | 21 ++++++
 .../unassigned/ext4_advanced_features.txt     |  1 +
 .../6.1.53/ext4/unassigned/ext4_defaults.txt  |  5 ++
 .../expunges/6.1.53/xfs/unassigned/all.txt    | 40 ++++++++++++
 .../6.1.53/xfs/unassigned/xfs_crc.txt         |  1 +
 .../6.1.53/xfs/unassigned/xfs_logdev.txt      | 10 +++
 .../6.1.53/xfs/unassigned/xfs_nocrc.txt       |  2 +
 .../6.1.53/xfs/unassigned/xfs_nocrc_512.txt   |  7 ++
 .../xfs/unassigned/xfs_reflink_1024.txt       |  1 +
 .../6.1.53/xfs/unassigned/xfs_rtdev.txt       |  1 +
 14 files changed, 196 insertions(+)
 create mode 100644 workflows/fstests/expunges/6.1.53/btrfs/unassigned/all.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_noraid56.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_simple.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_simple_zns.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/ext4/unassigned/all.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/ext4/unassigned/ext4_advanced_features.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/ext4/unassigned/ext4_defaults.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/all.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_crc.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_logdev.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc_512.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_1024.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_rtdev.txt

diff --git a/workflows/fstests/expunges/6.1.53/btrfs/unassigned/all.txt b/workflows/fstests/expunges/6.1.53/btrfs/unassigned/all.txt
new file mode 100644
index 000000000000..10aeaff40275
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/btrfs/unassigned/all.txt
@@ -0,0 +1,38 @@
+btrfs/011 # crash on raid6_avx5121_gen_syndrome https://gist.github.com/mcgrof/4f4d59a6d6057d2147949cbc49a41b13
+btrfs/029 # lazy baseline - failure found in at least two sections
+btrfs/080 # fails on section btrfs_simple but we expect this to fail for others https://gist.github.com/mcgrof/7ae85812aeacd62ab221eda2fab4552e
+btrfs/099
+btrfs/131 # lazy baseline - failure found in at least two sections
+btrfs/175
+btrfs/176
+btrfs/194
+btrfs/197
+btrfs/216
+btrfs/219
+btrfs/220
+btrfs/223
+btrfs/225
+btrfs/232 # kernel warning btrfs_noraid56 WARNING: CPU: 5 PID: 823784 at fs/btrfs/space-info.h:110 btrfs_free_reserved_data_space+0x179/0x190 https://gist.github.com/mcgrof/041f78010f8094a75cfa9a3a7bcb7d02
+btrfs/238
+btrfs/249
+btrfs/254 # lazy baseline - failure found in at least two sections
+btrfs/258 # lazy baseline - failure found in at least two sections
+btrfs/263 # lazy baseline - failure found in at least two sections
+generic/208 # lazy baseline - dmesg failure rate is about 1/60 try with zswap pressure on the host https://gist.github.com/mcgrof/8296499615800048d658abbadb7ebe22
+generic/224 # fails with a hang on btrfs_raid56 section but let's skip for all sections for now
+generic/226 # lazy baseline - failure found in at least two sections - failure rate 1/20 requires a fix in btrfs-progs I have queued https://gist.github.com/mcgrof/81771a86ef0b90152e142e597d5f4147
+generic/241
+generic/260
+generic/300 # fails on btrfs_simple so chances are other sections should fail too - failure rate is about 1/10 hung task on btrfs_wait_ordered_extents() https://gist.github.com/mcgrof/2696e71d3322becfe3811260fbe1ec3a
+generic/371 # found to have taken once 10 times the amount it took to run the first run so 305s vs 26s for 1173% difference on btrfs_simple, this variablity should be looked into
+generic/373 # lazy baseline - failure found in at least two sections
+generic/374 # lazy baseline - failure found in at least two sections
+generic/471 # broken test
+generic/509 # low-hanging-fruit: device-mapper reload ioctl on flakey-test device or resource busy #  https://gist.github.com/mcgrof/05be5f0b6b9c669bef9481ace6299529
+generic/633
+generic/644
+generic/645
+generic/648 # fails on btrfs_noraid56 section but the error seems generic so skip for now see that section for details - failure rate is about 1/50 https://gist.github.com/mcgrof/c3f6dae20800da6f1bda607d0c0275b3
+generic/673 # lazy baseline - failure found in at least two sections - failure rate 1/4
+generic/679 # lazy baseline - failure found in at least two sections
+shared/298
diff --git a/workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_noraid56.txt b/workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_noraid56.txt
new file mode 100644
index 000000000000..991297edae0b
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_noraid56.txt
@@ -0,0 +1,2 @@
+btrfs/270
+generic/118 # failure rate is about 1/15
diff --git a/workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_simple.txt b/workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_simple.txt
new file mode 100644
index 000000000000..97b689365c66
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_simple.txt
@@ -0,0 +1,2 @@
+btrfs/049 # fails with a low failure rate of about 1/70 https://gist.github.com/mcgrof/ad2d0752f17bc64dacef47dc639e949b
+btrfs/270
diff --git a/workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_simple_zns.txt b/workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_simple_zns.txt
new file mode 100644
index 000000000000..1fb24b6c77b1
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/btrfs/unassigned/btrfs_simple_zns.txt
@@ -0,0 +1,65 @@
+btrfs/003
+btrfs/006
+btrfs/011
+btrfs/038
+btrfs/060
+btrfs/061
+btrfs/062
+btrfs/063
+btrfs/064
+btrfs/065
+btrfs/066
+btrfs/067
+btrfs/068
+btrfs/069
+btrfs/070
+btrfs/071
+btrfs/072
+btrfs/073
+btrfs/074
+btrfs/076
+btrfs/090
+btrfs/132
+btrfs/141
+btrfs/150
+btrfs/151
+btrfs/161
+btrfs/162
+btrfs/163
+btrfs/164
+btrfs/167
+btrfs/184
+btrfs/207
+btrfs/218
+btrfs/233
+btrfs/236
+btrfs/237
+btrfs/239
+btrfs/242
+btrfs/248
+btrfs/271
+generic/015
+generic/027 # hangs forever
+generic/066 # Fails in loop 14
+generic/083
+generic/102
+generic/113
+generic/171
+generic/173
+generic/174
+generic/204 # hangs forever
+generic/269
+generic/273
+generic/275
+generic/297
+generic/298
+generic/301
+generic/320
+generic/333 # stuff just hangs in this
+generic/334 # ran for 3607 seconds then hang detected, failure rate 1/2 - https://gist.github.com/mcgrof/2442b9b7fc015eb8551c018f388beb53
+generic/387
+generic/416
+generic/427
+generic/492
+generic/520
+generic/626 # failure rate 1/3 hung task https://gist.github.com/mcgrof/d4b349e3298fd3b889e790b825a96c77
diff --git a/workflows/fstests/expunges/6.1.53/ext4/unassigned/all.txt b/workflows/fstests/expunges/6.1.53/ext4/unassigned/all.txt
new file mode 100644
index 000000000000..9841c2233b0b
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/ext4/unassigned/all.txt
@@ -0,0 +1,21 @@
+ext4/025 # lazy baseline - failure found in at least two sections
+ext4/034 # lazy baseline - failure found in at least two sections
+generic/050 # lazy baseline - failure found in at least two sections https://gist.github.com/mcgrof/e598053099af6b5eb83c3f318d38bab5
+generic/082 # lazy baseline - failure found in at least two sections
+generic/219 # lazy baseline - failure found in at least two sections
+generic/230 # lazy baseline - failure found in at least two sections
+generic/231 # lazy baseline - failure found in at least two sections
+generic/232 # lazy baseline - failure found in at least two sections
+generic/233 # lazy baseline - failure found in at least two sections
+generic/235 # lazy baseline - failure found in at least two sections
+generic/241 # lazy baseline - failure found in at least two sections
+generic/270 # lazy baseline - failure found in at least two sections
+generic/382 # lazy baseline - failure found in at least two sections
+generic/388 # lazy baseline - failure rate 1/30 failure only appears on xunit file no *.bad file https://gist.github.com/mcgrof/3ec6a4603548d240e5d33a2831a55683
+generic/398 # lazy baseline - failure found in at least two sections
+generic/471 # broken test
+generic/566 # lazy baseline - failure found in at least two sections
+generic/587 # lazy baseline - failure found in at least two sections
+generic/600 # lazy baseline - failure found in at least two sections
+generic/601 # lazy baseline - failure found in at least two sections
+generic/607 # lazy baseline - failure found in at least two sections
diff --git a/workflows/fstests/expunges/6.1.53/ext4/unassigned/ext4_advanced_features.txt b/workflows/fstests/expunges/6.1.53/ext4/unassigned/ext4_advanced_features.txt
new file mode 100644
index 000000000000..4723bde6329f
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/ext4/unassigned/ext4_advanced_features.txt
@@ -0,0 +1 @@
+generic/477 # always fails and never fails with the defaults section after 300 runs https://gist.github.com/mcgrof/8ca888e9f41553573c22ea61b36aa165
diff --git a/workflows/fstests/expunges/6.1.53/ext4/unassigned/ext4_defaults.txt b/workflows/fstests/expunges/6.1.53/ext4/unassigned/ext4_defaults.txt
new file mode 100644
index 000000000000..f79db6016660
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/ext4/unassigned/ext4_defaults.txt
@@ -0,0 +1,5 @@
+generic/127 # sometimes may take about 10 times more than it typically takes (336 seconds)
+generic/459 # failure rate 1/20 https://gist.github.com/mcgrof/58818ec26ca195b22a3cfe8da5e40a7a
+generic/476 # seems to run for over 3603 seconds..
+generic/581 # failure rate is 1/20
+generic/622 # failure rate 1/10
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/all.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/all.txt
new file mode 100644
index 000000000000..a9bfe501e0f5
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/all.txt
@@ -0,0 +1,40 @@
+generic/050 # lazy baseline - failure found in at least two sections
+generic/054 # lazy baseline - failure found in at least two sections
+generic/055 # lazy baseline - failure found in at least two sections
+generic/081 # lazy baseline - failure found in at least two sections
+generic/108 # lazy baseline - failure found in at least two sections
+generic/175 # buggy test uses uninitialized variable i as input argument to truncate
+generic/204 # lazy baseline - failure found in at least two sections
+generic/223 # lazy baseline - failure found in at least two sections
+generic/241
+generic/273 # lazy baseline - failure found in at least two sections
+generic/297 # buggy test uses uninitialized variable i as input argument to truncate
+generic/298 # buggy test uses uninitialized variable i as input argument to truncate
+generic/361 # lazy baseline - failure found in at least two sections
+generic/455 # fails on two sections already
+generic/459 # fails on multiple sections maybe xfsprogs version?
+generic/459 # lazy baseline - failure found in at least two sections
+generic/471 # broken test
+generic/475 # flaky test
+generic/482 # flaky test - failure rate is about 1/15 https://gist.github.com/mcgrof/048243ac4435ee055d7a0e38a2c082da
+generic/530 # lazy baseline - failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
+generic/604 # buggy test
+shared/298 # lazy baseline - failure found in at least two sections
+xfs/005 # lazy baseline - failure found in at least two sections
+xfs/008 # unreliable test - fails because "holes has value of 44 holes is NOT in range 45 .. 55" - this is a _within_tolerance test - not an reliable check
+xfs/009 # fails on multiple sections already
+xfs/016 # unreliable test - fails on multiple sections already because of non deterministic calculation of log size
+xfs/059 # fails on multiple sections already
+xfs/060 # fails on multiple sections already
+xfs/154 # lazy baseline - failure found in at least two sections
+xfs/155 # xfs_repair fails (possibly after reducing RAM size to 3GB)
+xfs/157 # lazy baseline - failure found in at least two sections
+xfs/158 # lazy baseline - failure found in at least two sections
+xfs/168 # lazy baseline - failure found in at least two sections
+xfs/199 # lazy baseline - failure found in at least two sections
+xfs/216 # fails on multiple sections maybe xfsprogs version change?
+xfs/294 # lazy baseline - failure found in at least two sections
+xfs/301 # fails on multiple sections already
+xfs/495 # lazy baseline - failure found in at least two sections
+xfs/506
+xfs/598
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_crc.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_crc.txt
new file mode 100644
index 000000000000..51f9ff242061
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_crc.txt
@@ -0,0 +1 @@
+generic/299
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_logdev.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_logdev.txt
new file mode 100644
index 000000000000..db5f60dcf5bf
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_logdev.txt
@@ -0,0 +1,10 @@
+generic/042
+generic/704
+generic/730
+generic/731
+xfs/017
+xfs/045
+xfs/160
+xfs/161
+xfs/273
+xfs/438
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc.txt
new file mode 100644
index 000000000000..5a4c1ed3368b
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc.txt
@@ -0,0 +1,2 @@
+generic/589 # failure rate is 1/10
+xfs/195
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc_512.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc_512.txt
new file mode 100644
index 000000000000..eba91e9ba338
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc_512.txt
@@ -0,0 +1,7 @@
+generic/388 # failure only appears on xunit file no *.bad file
+generic/618
+generic/681
+generic/682
+xfs/071
+xfs/220
+xfs/295 # failure rate is about 1/30 xfs_logprint: unknown log operation type (0) Bad data in log
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_1024.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_1024.txt
new file mode 100644
index 000000000000..4e222f35568a
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_1024.txt
@@ -0,0 +1 @@
+xfs/014 # failure rate is about 1/20
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_rtdev.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_rtdev.txt
new file mode 100644
index 000000000000..a27042912692
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_rtdev.txt
@@ -0,0 +1 @@
+xfs/002 # xfs_growfs: log growth not supported yet
-- 
2.34.1

