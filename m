Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887F930B828
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 08:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhBBG5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 01:57:09 -0500
Received: from so15.mailgun.net ([198.61.254.15]:61186 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232302AbhBBG45 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 01:56:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612248992; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=mPwEiG7lR6/N/+INJTDsDxIcCXE0CuohFiHjM7roeUk=; b=Xfl2CwKabW/q1kTWxWjd/nzI9q9yiSTptzsLLX8psE+xIAAMmY/GvuPqv4ClA1THoIjj9qoZ
 65mF661slZHfSlI+QkhNI/OftdI9Iy7Ux+uWGhHVXblJji8D3MdDFV+jLlyhHyqsTqXyIqSx
 H2zX93n3v6/Nh0eS+iHU9dnIst8=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6018f77c4ee30634ebd2ad1a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Feb 2021 06:55:56
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1A84C433CA; Tue,  2 Feb 2021 06:55:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 013C9C433CA;
        Tue,  2 Feb 2021 06:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 013C9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [RFC]  Invalidate BH LRU during page migration
Date:   Mon,  1 Feb 2021 22:55:46 -0800
Message-Id: <cover.1612248395.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A page containing buffer_heads can be pinned if any of its constituent
buffer_heads belongs to the BH LRU cache [1]. After going through
several iterations of a patch that attempts to solve this by removing
BH entries inside of the drop_buffers() function, which in
the worst-case could be called for each migrated page, Minchan Kim
suggested that we invalidate the entire BH LRU once, just before we
start migrating pages.  Additionally, Matthew Wilcox suggested that
we invalidate the BH LRU inside of lru_add_drain_all(), so as to
benefit functions like other functions that would be impacted by
pinned pages [2].

TODO:
 - It should be possible to remove the initial setting of
   bh_migration_done = false; in migrate_prep by passing this in as a
   parameter to invalidate_bh_lru(), but we'd still need a matching
   bh_migration_done = true; call. 
 - To really benefit other callers of lru_add_drain_all() other than
   __alloc_contig_migrate_range() in the CMA allocaiton path, we'd need
  to add additional calls of bh_migration_done = false;

[1] https://elixir.bootlin.com/linux/latest/source/fs/buffer.c#L1238
[2] https://lore.kernel.org/linux-fsdevel/cover.1611642038.git.cgoldswo@codeaurora.org/


Chris Goldsworthy (1):
  [RFC] mm: fs: Invalidate BH LRU during page migration

 fs/buffer.c                 |  6 ++++++
 include/linux/buffer_head.h |  3 +++
 include/linux/migrate.h     |  2 ++
 mm/migrate.c                | 18 ++++++++++++++++++
 mm/page_alloc.c             |  3 +++
 mm/swap.c                   |  3 +++
 6 files changed, 35 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

