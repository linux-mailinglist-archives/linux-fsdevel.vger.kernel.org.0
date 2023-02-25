Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500BD6A25FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 01:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBYAtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 19:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYAtE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:49:04 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3172448D
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 16:49:02 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-17235c8dab9so1458746fac.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 16:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fA7wtdxgMmlCRH70KUNVCupF9kohIFf3r73YEl+rhhA=;
        b=xruh3lst8J+Wna62iANguQP4540OOR1VAsDOWMnE0nIvGWuzkWTMo5r5evgBcBxGtZ
         NQ9jdOEgNeoCkMnPxDL0Pk60ZlMCjF7u8C9aUcoIrUG/kf/Ks1FnjILioCTKqVDNcnK2
         b7fDk6V7myJXa21/4Oe5mtQ7M571S7d7eGUNbcR1eK1xqcWlNcFM9usT6jN/hZvsEnG8
         RBjfjUaTkySNLk5vUkGU+L3v5ashzNx6xR+R+hPYvi+uryE6SIelj6bSMydyyfNtjVCv
         fY3nBGHSMaueinz+jpH3VAyu4SXPrg0aSwS1fOi84s3jPjuI7SRDuxEdKkotIB962rQi
         3frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fA7wtdxgMmlCRH70KUNVCupF9kohIFf3r73YEl+rhhA=;
        b=qKJi/i4K7CzlM5yd3XcFmuMRQnG+oUCR6cyimp+pmcvtars0yH9usopMYuFuH2NN3I
         9DBpv6Y2vprqymqbbe9Rus/dyIT13hWAhz1SSOR5x3VEngCOHQ2Cev6joGCaEzlAAy0s
         Gi00rWhNbFXsFnyPo0f26k3WVhV5dcJQ6FwMcMCcTlkjfEpLC3PHqtFE7RJthhT9TDox
         /AE1EFjzcTfu3GNfOjdQgdU5QM04PubjySulxSoTO2dZxiVca9Mfp3OYJ0WLIoxQwyeS
         8KocLceREg7xTY83k0Zej/prcKMQqieERJULbvW6h1VZGmXlmS7spuGQNEA8TwYSJqHK
         SDgQ==
X-Gm-Message-State: AO0yUKVfm95bf/yqsVhacjX3gcVfAMuRv7BEJv9nPiNHnsGa4Kk1KIYp
        9012MOauMX84qHqPWNMSTy3ymQ==
X-Google-Smtp-Source: AK7set/STOR8SSjBctHu2KK4nmvP7KAyKoIAc4ksu+LUs5bZ/JfnHJbPcCX4xIBip4LqMj4gyScIjg==
X-Received: by 2002:a05:6871:110:b0:16d:eea6:e409 with SMTP id y16-20020a056871011000b0016deea6e409mr14048605oab.38.1677286142079;
        Fri, 24 Feb 2023 16:49:02 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id i9-20020a9d6249000000b00684cbd8dd49sm102470otk.79.2023.02.24.16.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:49:01 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, viacheslav.dubeyko@bytedance.com,
        luka.perkov@sartura.hr, bruno.banelli@sartura.hr,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [LSF/MM/BPF TOPIC] SSDFS + ZNS SSD: deterministic architecture decsreasing TCO cost
Date:   Fri, 24 Feb 2023 16:47:50 -0800
Message-Id: <20230225004750.813538-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Nowadays, SSD device is a critical item of any data infrastructure.
Inefficient data storage techniques can significantly decrease SSD
lifetime and increase TCO cost, especially, for the case of QLC
NAND flash. How to achieve a good balance of SSD lifetime
prolongation, strong reliability, and stable performance?

SSD is a sophisticated device capable of managing in-place
updates. However, in-place updates generate significant FTL GC
responsibilities that increase write amplification factor, require
substantial NAND flash overprovisioning, decrease SSD lifetime,
and introduce performance spikes. Log-structured File System (LFS)
approach can introduce a more flash-friendly Copy-On-Write (COW) model.
However, F2FS and NILFS2 issue in-place updates anyway, even by using
the COW policy for main volume area. Also, GC is an inevitable subsystem
of any LFS file system that introduces write amplification, retention
issue, excessive copy operations, and performance degradation for
aged volume. Generally speaking, available file system technologies
have side effects: (1) write amplification issue, (2) significant FTL GC
responsibilities, (3) inevitable FS GC overhead, (4) read disturbance,
(5) retention issue. As a result, SSD lifetime reduction, perfomance
degradation, early SSD failure, and increased TCO cost are reality of
data infrastructure.

ZNS SSD is a good vehicle that can help to manage a subset of known
issues by means of introducing a strict append-only mode of operations.
However, for example, F2FS has an in-place update metadata area that
can be placed into conventional zone and, anyway, introduces FTL GC
responsibilities even for ZNS SSD case. Also, limited number of
open/active zones (for example, 14 open/active zones) creates really
complicated requirements that not every file system architecure can
satisfy. It means that architecture of multiple file systems has
peculiarities compromising the ZNS SSD model. Moreover, FS GC overhead is
still a critical problem for LFS file systems (F2FS, NILFS2, for example),
even for the case of ZNS SSD.

Generally speaking, it will be good to see an LFS file system architecture
that is capable:
(1) eliminate FS GC overhead,
(2) decrease/eliminate FTL GC responsibilities,
(3) decrease write amplification factor,
(4) introduce native architectural support of ZNS SSD + SMR HDD,
(5) increase compression ratio by using delta-encoding and deduplication,
(6) introduce smart management of "cold" data and efficient TRIM policy,
(7) employ parallelism of multiple NAND dies/channels,
(8) prolong SSD lifetime and decrease TCO cost,
(9) guarantee strong reliability and capability to reconstruct heavily
    corrupted file system volume,
(10) guarantee stable performance.

I would like to discuss:
(1) Which file system architecture can be good for ZNS SSD, conventional
    SSD, and SMR HDD at the same time?
(2) How it is possible to prolong SSD lifetime and decrease TCO cost
    by means of employing LFS architecture?
(3) How it is possible to exclude the necessity to have GC activity for
    LFS file system?
(4) How to achieve a good balance of delta-encoding and low read
    disturbance?
(5) How to introduce small payload even by proividing snapshots?
(6) How to decrease retention issue by efficient TRIM/erase policy?

I would like to base this discussion on SSDFS file system architecture.
SSDFS is an open-source, kernel-space LFS file system designed:
(1) eliminate GC overhead, (2) prolong SSD lifetime, (3) natively support
a strict append-only mode (ZNS SSD + SMR HDD compatible), (4) guarantee
strong reliability, (5) guarantee stable performance.

Benchmarking results show that SSDFS is capable:
(1) generate smaller amount of write I/O requests compared with:
    1.4x - 116x (ext4),
    14x - 42x (xfs),
    6.2x - 9.8x (btrfs),
    1.5x - 41x (f2fs),
    0.6x - 22x (nilfs2);
(2) create smaller payload compared with:
    0.3x - 300x (ext4),
    0.3x - 190x (xfs),
    0.7x - 400x (btrfs),
    1.2x - 400x (f2fs),
    0.9x - 190x (nilfs2);
(3) decrease the write amplification factor compared with:
    1.3x - 116x (ext4),
    14x - 42x (xfs),
    6x - 9x (btrfs),
    1.5x - 50x (f2fs),
    1.2x - 20x (nilfs2);
(4) prolong SSD lifetime compared with:
    1.4x - 7.8x (ext4),
    15x - 60x (xfs),
    6x - 12x (btrfs),
    1.5x - 7x (f2fs),
    1x - 4.6x (nilfs2).

SSDFS code still has bugs and is not fully stable yet:
(1) ZNS support is not fully stable;
(2) b-tree operations have issues for some use-cases;
(3) Support of 8K, 16K, 32K logical blocks has critical bugs;
(4) Support of multiple PEBs in segment is not stable yet;
(5) Delta-encoding support is not stable;
(6) The fsck and recoverfs tools are not fully implemented yet;
(7) Currently, offset translation table functionality introduces
    performance degradation for read I/O patch (patch with the fix is
    under testing).

[REFERENCES]
[1] SSDFS tools: https://github.com/dubeyko/ssdfs-tools.git
[2] SSDFS driver: https://github.com/dubeyko/ssdfs-driver.git
[3] Linux kernel with SSDFS support: https://github.com/dubeyko/linux.git
[4] SSDFS (paper): https://arxiv.org/abs/1907.11825
[5] Linux Plumbers 2022: https://www.youtube.com/watch?v=sBGddJBHsIo
