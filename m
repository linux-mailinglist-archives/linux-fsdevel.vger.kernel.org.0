Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC44395944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhEaK5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 06:57:33 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:61930 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhEaK5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 06:57:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622458553; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=EVhK5r49yg7auPLn4b4pL/EKvr0CuhIc1/j4Rfrx698=; b=YCRIqK51FUXJyVs4ONZ7L90++lUhzrmBkFRfYsmWYJ/gNIw08TTmkfyGpLOivdDxYURaUdZo
 VAvrF3wWyur6eeFOZpNHijGkKXDJbfI3MyvAWSJsR/2K5fP9ravugwZRlAA9E4wC9LJtMWCh
 DrRPQ4a+PNVVbbcXhPQEhb+yucQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60b4c0af8491191eb3b69c4d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 May 2021 10:55:43
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4166C43147; Mon, 31 May 2021 10:55:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-charante-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AAD91C433D3;
        Mon, 31 May 2021 10:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AAD91C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, vbabka@suse.cz, nigupta@nvidia.com,
        hannes@cmpxchg.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, aarcange@redhat.com,
        cl@linux.com, xi.fengfei@h3c.com, mchehab+huawei@kernel.org,
        andrew.a.klychkov@gmail.com, dave.hansen@linux.intel.com,
        bhe@redhat.com, iamjoonsoo.kim@lge.com, mateusznosek0@gmail.com,
        sh_def@163.com, vinmenon@codeaurora.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH V3 0/2] mm: compaction: proactive compaction trigger by user
Date:   Mon, 31 May 2021 16:24:50 +0530
Message-Id: <cover.1622454385.git.charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches support triggering of proactive compaction by user on write
to the /proc/sys/vm/compaction_proactiveness. 

Changes in V3:
 - Incorporated review comments.
Changes in V2:
 - https://lore.kernel.org/patchwork/patch/1431283/
Changes in V1:
 - https://lore.kernel.org/patchwork/patch/1417064/

Charan Teja Reddy (2):
  mm: compaction: support triggering of proactive compaction by user
  mm: compaction: fix wakeup logic of proactive compaction

 Documentation/admin-guide/sysctl/vm.rst |  3 +-
 include/linux/compaction.h              |  2 ++
 include/linux/mmzone.h                  |  1 +
 kernel/sysctl.c                         |  2 +-
 mm/compaction.c                         | 49 ++++++++++++++++++++++++++++++---
 5 files changed, 51 insertions(+), 6 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

