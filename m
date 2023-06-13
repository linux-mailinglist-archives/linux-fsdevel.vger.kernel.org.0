Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7977372E7EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 18:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbjFMQKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 12:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbjFMQKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:10:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 875401981;
        Tue, 13 Jun 2023 09:10:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F24661FB;
        Tue, 13 Jun 2023 09:10:46 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAA7D3F5A1;
        Tue, 13 Jun 2023 09:10:00 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/2] Report on physically contiguous memory in smaps
Date:   Tue, 13 Jun 2023 17:09:48 +0100
Message-Id: <20230613160950.3554675-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

I thought I would try my luck with this pair of patches...

This series adds new entries to /proc/pid/smaps[_rollup] to report on physically
contiguous runs of memory. The first patch reports on the sizes of the runs by
binning into power-of-2 blocks and reporting how much memory is in which bin.
The second patch reports on how much of the memory is contpte-mapped in the page
table (this is a hint that arm64 supports to tell the HW that a range of ptes
map physically contiguous memory).

With filesystems now supporting large folios in the page cache, this provides a
useful way to see what sizes are actually getting mapped. And with the prospect
of large folios for anonymous memory and contpte mapping for conformant large
folios on the horizon, this reporting will become useful to aid application
performance optimization.

Perhaps I should really be submitting these patches as part of my large anon
folios and contpte sets (which I plan to post soon), but given this touches
the user ABI, I thought it was sensible to post it early and separately to get
feedback.

It would specifically be good to get feedback on:

  - The exact set of new fields depend on the system that its being run on. Does
    this cause problem for compat? (specifically the bins are determined based
    on PAGE_SIZE and PMD_SIZE).
  - The ContPTEMapped field is effectively arm64-specific. What is the preferred
    way to handle arch-specific values if not here?

The patches are based on mm-unstable (dd69ce3382a2). Some minor conflicts will
need to be resolved if rebasing to Linus's tree. I have a branch at [1]. I've
tested on Ampere Altra (arm64) only.

[1] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/folio_smap-lkml_v1

Thanks,
Ryan

Ryan Roberts (2):
  mm: /proc/pid/smaps: Report large folio mappings
  mm: /proc/pid/smaps: Report contpte mappings

 Documentation/filesystems/proc.rst |  31 +++++++
 fs/proc/task_mmu.c                 | 134 ++++++++++++++++++++++++++++-
 2 files changed, 161 insertions(+), 4 deletions(-)

--
2.25.1

