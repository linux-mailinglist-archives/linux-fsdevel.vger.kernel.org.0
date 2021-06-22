Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2583E3B0B43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhFVRSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVRSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:18:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347D3C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 10:16:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so2271250wms.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thinkparq-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=k3zU6Su0h1BSZnCCHgosH8g3/GX+UKcaMqkKsTDFsDs=;
        b=b857j7h+G50Qraklp/VJzDS2GYp1csdXJiAh8sev8TwkFqAWQJQWtz99pR7AzHnsoo
         +wV+ahtkI/ojWxRuDEHJTsge8ZGzrlOZg/WXm+l9r4CvOS+bMoDHKXZhZBdmt+UHGVqR
         ZzSXMlxqaOTH/G5knZRsLPvuj9CnoeT3VGDxKdk4aT5J2u50g+VfHcJeAx5/nLZIERFU
         YDsJ3p660DljuyyNwpboez+hPk4emEY1Ltdx/wxvXKQE7rpK4Kfewd10YJT/uJGT5WU/
         7OcOJZJGiQuYuEN7wyAcUsCcvcmewMmnu0OMAfvRzKoh/oEzhCr0OnJT8Sry4VyHLG+l
         kE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=k3zU6Su0h1BSZnCCHgosH8g3/GX+UKcaMqkKsTDFsDs=;
        b=ir3xLXi597dFlHs+OXkgqOBAadghCEbUcOAwrMesl/tMNZE7MMGI1BqOHieKtajRzc
         yXhUHjPNO5jNmYjSrwhq9vesjusfPBDxeMwLnD1zWHZ5e4UiPq462mTCV4b4Uu3NVGSb
         CrOgXa778l5xK8WGwxnY/UuCQNSJC+/Y6H+vQVLh8BIjBvZ6nZgTBR1eBsczwGnnMbXk
         dM64u7iH23+kvz7ilqsJSZC4wSNxcDAAst00TZjCxpgdbpjv2GaZdI00EjJmXfNF6vVr
         NqGL6t5QIo1dqtj6jkQRmiJtuaWFtnkPwgdBmPr1aTFhgrXA195zPpuAymr3yh3R8Sap
         Rzvg==
X-Gm-Message-State: AOAM533UdEwfW8zrv9tmzdtfx944JtDznCLM71UENG8ECEVEuFilm8G0
        HLsp+Vtnn16IkSyjTLBJfUW66EhocIagyFAL
X-Google-Smtp-Source: ABdhPJy5fjWRLqVzfoiq0rQODpTer9+Sg3yQqjmCcu10Q9+Gq26Q+GeZmBnbF3Y8AcLGKHNUbjNneA==
X-Received: by 2002:a7b:c203:: with SMTP id x3mr5502781wmi.153.1624382161696;
        Tue, 22 Jun 2021 10:16:01 -0700 (PDT)
Received: from xps13 (HSI-KBW-095-208-248-008.hsi5.kabel-badenwuerttemberg.de. [95.208.248.8])
        by smtp.gmail.com with ESMTPSA id o20sm3067575wms.3.2021.06.22.10.16.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 10:16:01 -0700 (PDT)
Date:   Tue, 22 Jun 2021 19:15:58 +0200
From:   Philipp Falk <philipp.falk@thinkparq.com>
To:     linux-fsdevel@vger.kernel.org
Subject: Throughput drop and high CPU load on fast NVMe drives
Message-ID: <YNIaztBNK+I5w44w@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We are facing a performance issue on XFS and other filesystems running on
fast NVMe drives when reading large amounts of data through the page cache
with fio.

Streaming read performance starts off near the NVMe hardware limit until
around the total size of system memory worth of data has been read.
Performance then drops to around half the hardware limit and CPU load
increases significantly. Using perf, we were able to establish that most of
the CPU load is caused by a spin lock in native_queued_spin_lock_slowpath:

-   58,93%    58,92%  fio              [kernel.kallsyms]         [k]
native_queued_spin_lock_slowpath
     45,72% __libc_read
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        ksys_read
        vfs_read
        new_sync_read
        xfs_file_read_iter
        xfs_file_buffered_aio_read
      - generic_file_read_iter
         - 45,72% ondemand_readahead
            - __do_page_cache_readahead
               - 34,64% __alloc_pages_nodemask
                  - 34,34% __alloc_pages_slowpath
                     - 34,33% try_to_free_pages
                          do_try_to_free_pages
                        - shrink_node
                           - 34,33% shrink_lruvec
                              - shrink_inactive_list
                                 - 28,22% shrink_page_list
                                    - 28,10% __remove_mapping
                                       - 28,10% _raw_spin_lock_irqsave
                                            native_queued_spin_lock_slowpath
                                 + 6,10% _raw_spin_lock_irq
               + 11,09% read_pages

When direct I/O is used, hardware level read throughput is sustained during
the entire experiment and CPU load stays low. Threads stay in D state most
of the time.

Very similar results are described around half-way through this article
[1].

Is this a known issue with the page cache and high throughput I/O? Is there
any tuning that can be applied to get around the CPU bottleneck? We have
tried disabling readahead on the drives, which lead to very bad throughput
(~-90%). Various other scheduler related tuning was tried as well but the
results were always similar.

Experiment setup can be found below. I am happy to provide more detail if
required. If this is the wrong place to post this, please kindly let me
know.

Best regards
- Philipp

Experiment setup:

[1] https://tanelpoder.com/posts/11m-iops-with-10-ssds-on-amd-threadripper-pro-workstation/

CPU: 2x Intel(R) Xeon(R) Platinum 8352Y 2.2 GHz, 32c/64t each, 512GB memory
NVMe: 16x 1.6TB, 8 per NUMA node
FS: one XFS per disk, but reproducible on ext4 and ZFS
Kernel: Linux 5.3 (SLES), but reproducible on 5.12 (SUSE Tumbleweed)
NVMe scheduler: both "none" and "mq-deadline", very similar results
fio: 4 threads per NVMe drive, 20GiB of data per thread, ioengine=sync
  Sustained read throughput direct=1: ~52GiB/s (~3.2 GiB/s*disk)
  Sustained read throughput direct=0: ~25GiB/s (~1.5 GiB/s*disk)
