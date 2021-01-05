Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CAC2EA5B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 08:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbhAEHGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 02:06:45 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:18505 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAEHGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:06:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609830386; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2RibZ3quCogr3Bv7+yL4XndtnXP1rZOfy3IGjqSqr84=; b=mQwi1KN7gfxHva0iXsSMR4G8Pes0eiO7pFahNJt/HpQmBSHn/mrEkUvWx9FD8hZWnY1MFUTe
 SF/8JnKfXGodyRxa/z2xOf6C6DOw0ME8xoV9qmD1igtxvsWnaw5iGvMrX0Njmeh0DnUtAKW4
 9Zd7rVlnFzzy/iCTc7b3TnF67ug=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ff40fc5f7aeb83bf1a57de5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Jan 2021 07:05:41
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72B82C43461; Tue,  5 Jan 2021 07:05:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62A6BC433C6;
        Tue,  5 Jan 2021 07:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62A6BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH v2] Resolve LRU page-pinning issue for file-backed pages 
Date:   Mon,  4 Jan 2021 23:05:32 -0800
Message-Id: <cover.1609829465.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is possible for file-backed pages to end up in a contiguous memory area
(CMA), such that the relevant page must be migrated using the .migratepage()
callback when its backing physical memory is selected for use in an CMA
allocation (through cma_alloc()).  However, if a set of address space
operations (AOPs) for a file-backed page lacks a migratepage() page call-back,
fallback_migrate_page() will be used instead, which through
try_to_release_page() calls try_to_free_buffers() (which is called directly or
through a try_to_free_buffers() callback.  try_to_free_buffers() in turn calls
drop_buffers()

drop_buffers() itself can fail due to the buffer_head associated with a page
being busy. However, it is possible that the buffer_head is on an LRU list for
a CPU, such that we can try removing the buffer_head from that list, in order
to successfully release the page.  Do this.

v1: https://lore.kernel.org/lkml/cover.1606194703.git.cgoldswo@codeaurora.org/T/#m3a44b5745054206665455625ccaf27379df8a190
Original version of the patch (with updates to make to account for changes in
on_each_cpu_cond()).

v2: Follow Matthew Wilcox's suggestion of reducing the number of calls to
on_each_cpu_cond(), by iterating over a page's busy buffer_heads inside of
on_each_cpu_cond(). To copy from his e-mail, we go from:

for_each_buffer
	for_each_cpu
		for_each_lru_entry

to:

for_each_cpu
	for_each_buffer
		for_each_lru_entry

This is done using xarrays, which I found to be the cleanest data structure to
use, though a pre-allocated array of page_size(page) / bh->b_size elements might
be more performant.

Laura Abbott (1):
  fs/buffer.c: Revoke LRU when trying to drop buffers

 fs/buffer.c   | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/internal.h |  5 ++++
 2 files changed, 85 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

