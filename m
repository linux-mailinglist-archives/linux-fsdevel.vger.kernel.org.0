Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9657A2B16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 01:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbjIOXtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 19:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbjIOXtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:49:10 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D301211E
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 16:49:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7926de0478eso93265739f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 16:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1694821743; x=1695426543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aj42cNzRR9SjGNw0IyMbtwEb10WuREq5IBnZ/MpPZeU=;
        b=H+TTojZx+TaqNzBrKljjGo1fNid5q0seGWQrxP+SW0l2O0MzB/FtAqE5wAgyQJUEZ/
         e2KvqTksE/BHNBME7TsRyU9bEdhUay37hp06JxS1DCW3paEnhvyCwMyvmrJTsb1+QvQU
         alL4JsP0bTscea70XS2isdH2b2jcB6YyNrXUXURpp+WQBY0HpvPpNwrRJCccWODvxX6W
         mUwq2Jpm2RIt7Y77gzmfa0ZjkIKagrRl5o2ZseU4DDJw59/47kgAVvNKhjvAHY5ChhGK
         3Yt/WlCRa3Zxvr2XFxshJ7+vfZNrt+7H5+9fFBPfqZF3OgvWGgMEzIa9wdmNiS2uXCkn
         ufDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694821743; x=1695426543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj42cNzRR9SjGNw0IyMbtwEb10WuREq5IBnZ/MpPZeU=;
        b=MMGVav5xzTcx3NrmXOB53NBanxJ+/fBGpz41EcWSS6aTp3HloDwtBw6IAF2EOiGYbp
         YgfLHhcwXcxwbN+6pLKhrPEWRRAMfscQripHk1gfYa37mXx4az31CrHvhqPm4JajIKfW
         HLbdc118NuSYWIPXctjf9AWU5+ThHjAnrBcW+NqA4Y2oj+X1Ner45XGb9lSIbaU99j8K
         Y3LLkHF4IOTqFym70t0xN3JtcwBan+e15tdJSCsBOXo4OTGSz8WBrxdDOzf0wNdi0smN
         SdT2P57B5ICE54JFqWR5QcbtKURjcwM1CsDpySujcN3y4szB59R66CgytCiNXpoPvlsP
         ErNw==
X-Gm-Message-State: AOJu0YxI6AjGPI6gxdZNObrpSRMWekT3B6qPzytnaInWEClZ0UuaTUy6
        lO8qGCqJiDFzBEH3mmc8bWr/vw==
X-Google-Smtp-Source: AGHT+IGXDzpbuectpsi/O+OEAcE56rpLgzsV6foq4LFyCbrV2Dl3GhE7a7tseizfmKjnvWkxHCsEAA==
X-Received: by 2002:a05:6e02:12c1:b0:349:8ea:9bd1 with SMTP id i1-20020a056e0212c100b0034908ea9bd1mr3711223ilm.7.1694821743530;
        Fri, 15 Sep 2023 16:49:03 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:9478:4be::79:1e])
        by smtp.gmail.com with ESMTPSA id q11-20020a056e02106b00b0034a921bc93asm779036ilj.1.2023.09.15.16.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 16:49:03 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     amir73il@gmail.com, mcgrof@kernel.org
Cc:     kdevops@lists.linux.dev, kernel-team@cloudflare.com,
        linux-fsdevel@vger.kernel.org,
        Frederick Lawler <fred@cloudflare.com>
Subject: [RFC PATCH kdevops 0/2] augment expunge list for v6.1.53
Date:   Fri, 15 Sep 2023 18:48:55 -0500
Message-Id: <20230915234857.1613994-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.34.1
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

In an effort to test and prepare patches from XFS to stable 6.1.y [1], I needed 
to make a baseline for v6.1.53 to verify that the backported patches do not 
introduce regressions (if any). However, after a 'make fstests-baseline', we 
observed that compared to v6.1.42, v6.1.53 introduced more than expected 
expunges to XFS. This RFC is an attempt to put some eyes to this and open up a 
discussion.

At Cloudflare, the Linux team does not have an easy way to obtain dedicated and
easily configurable server infrastructure to execute kdevops filesystem testing, 
but we do have an easily-configurable kubernetes infrastructure. I prepared a 
POC to spin up virtual machines [2] in kubernetes to emulate what terraform 
may do for OpenStack, Azure, AWS, etc... to perform this test. Therefore, the 
configuration option is set to SKIP_BRINGUP=y

In this baseline, I spun up XFS workflow nodes for:
- xfs_crc
- xfs_logdev
- xfs_nocrc
- xfs_nocrc_512
- xfs_reflink
- xfs_reflink_1024
- xfs_reflink_normapbt
- xfs_rtdev

Each node is running a vanilla-stable 6.1.y (6.1.53), and the image is based on 
latest Debian SID [3]. Each node also has its own dedicated /data and /media
partitions to store Linux, fstests, etc... and sparse-images respectfully.

In v6.1.42, we don't currently have expunges for xfs_reflink_normapbt, and 
xfs_reflink. So those are _new_. The rest had significant additions. However, 
not all nodes finished their testing after >12hrs of run time. Some appeared to 
be stuck, in particular xfs_rtdev, and never finished (reason unknown). 
I CTRL+C and ran 'make fstests-results'.

I prepared a fork [4] where the results 6.1.53.xz can be found.

These patches are based on top of commit 0ec98182f4a9 ("bootlinux/fstests: 
remove odd hplip user")

Links:
1: https://lore.kernel.org/all/CAOQ4uxgvawD4=4g8BaRiNvyvKN1oreuov_ie6sK6arq3bf8fxw@mail.gmail.com/
2: https://kubevirt.io/api-reference/v1.0.0/definitions.html#_v1_virtualmachine
3: https://cloud.debian.org/images/cloud/sid/daily/latest/ (debian-sid-genericcloud-amd64-daily.qcow2)
4: https://github.com/fredlawl/kdevops/commit/afcb8fe7c4498d2be5386e191db3534f651a3730#diff-0677846133ad9128bf752f674b3c8da437c12ce28f48d8890b9f66d0dcb3717c

Frederick Lawler (2):
  fstests/xfs: copy 6.1.42 baseline for v6.1.53
  xfs: merge common expunge lists for v6.1.53

 .../expunges/6.1.53/btrfs/unassigned/all.txt  | 38 +++++++++++
 .../btrfs/unassigned/btrfs_noraid56.txt       |  2 +
 .../6.1.53/btrfs/unassigned/btrfs_simple.txt  |  2 +
 .../btrfs/unassigned/btrfs_simple_zns.txt     | 65 +++++++++++++++++++
 .../expunges/6.1.53/ext4/unassigned/all.txt   | 21 ++++++
 .../unassigned/ext4_advanced_features.txt     |  1 +
 .../6.1.53/ext4/unassigned/ext4_defaults.txt  |  5 ++
 .../expunges/6.1.53/xfs/unassigned/all.txt    | 40 ++++++++++++
 .../6.1.53/xfs/unassigned/xfs_crc.txt         |  7 ++
 .../6.1.53/xfs/unassigned/xfs_logdev.txt      | 26 ++++++++
 .../6.1.53/xfs/unassigned/xfs_nocrc.txt       |  7 ++
 .../6.1.53/xfs/unassigned/xfs_nocrc_512.txt   | 12 ++++
 .../6.1.53/xfs/unassigned/xfs_reflink.txt     |  5 ++
 .../xfs/unassigned/xfs_reflink_1024.txt       | 12 ++++
 .../xfs/unassigned/xfs_reflink_normapbt.txt   | 10 +++
 .../6.1.53/xfs/unassigned/xfs_rtdev.txt       | 49 ++++++++++++++
 16 files changed, 302 insertions(+)
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
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_1024.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_normapbt.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_rtdev.txt

-- 
2.34.1

