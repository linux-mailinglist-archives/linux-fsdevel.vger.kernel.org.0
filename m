Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E472C3184F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 06:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhBKFgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 00:36:40 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:18834 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhBKFgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:36:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613021779; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zBgnLWzyaqyNaAbtH+PNF19ZuNN+iKocqvFQdPi0B/M=; b=aGN02ks9zGPhZVWsfS5+rMUvoyYrBnslw7FIuV0Y5wasfskV5ry2xhxWpINqvWpksVDDdgEU
 GmePjyx4KzzM3PRdY7ZQZbenAeHNBql3p/7wAqX4bGupBGrMLmC1c93w00mYjrBv1yd6g+/j
 0MndSExSu9+x0FpSru9YR+/cDZY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6024c239e4842e912811d08d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 05:35:53
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6C4DC43464; Thu, 11 Feb 2021 05:35:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CDA3C433CA;
        Thu, 11 Feb 2021 05:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CDA3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH v2] [RFC]  Invalidate BH LRU during page migration
Date:   Wed, 10 Feb 2021 21:35:39 -0800
Message-Id: <cover.1613020616.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A page containing buffer_heads can be pinned if any of its constituent
buffer_heads belongs to the BH LRU cache [1], which can prevent that
page from being migrated. After going through several iterations of a
patch that attempts to solve this by removing BH entries inside of the
drop_buffers() function, which in the worst-case could be called for
each migrated page, Minchan Kim suggested that we invalidate the
entire BH LRU once, just before we start migrating pages.
Additionally, Matthew Wilcox suggested that we invalidate the BH LRU
inside of lru_add_drain_all(), so as to benefit functions like other
functions that would be impacted by pinned pages [2].

V2: Respond to feedback provided by Andrew, Minchan and Matthew in [3].
As suggested by Minchan, we're now doing the invalidate of the LRUs
in a fashion similar to how the pagevecs are drained in
lru_add_drain_all() 


[1] https://elixir.bootlin.com/linux/latest/source/fs/buffer.c#L1238
[2] https://lore.kernel.org/linux-fsdevel/cover.1611642038.git.cgoldswo@codeaurora.org/
[3] https://lkml.org/lkml/2021/2/2/68

Chris Goldsworthy (1):
  [RFC] mm: fs: Invalidate BH LRU during page migration

 fs/buffer.c                 | 54 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/buffer_head.h |  8 +++++++
 include/linux/migrate.h     |  2 ++
 mm/migrate.c                | 19 ++++++++++++++++
 mm/page_alloc.c             |  3 +++
 mm/swap.c                   |  7 +++++-
 6 files changed, 90 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

