Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2FD3ACE8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 17:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhFRPV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 11:21:57 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54191 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbhFRPVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624029576; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=J9yXQ6oRlJ+lpMcEvlTUhkm+Zl/MViuXSRM8imLm6O4=; b=Y2Vp2p+wmIq1+d1dkeQkDrmtHHOC5p0G2xy8cEWpB855rueG2nmXhhWcMt5NBr5kWJAvn7+e
 JWirZzMmJFsY2odgXMDGnvjBDsaRnkAfgT5hmxBreIz4BLqNzXqd7YDIFQBhXz9VX0Ihxv9b
 Dhdit3TQ6iZg+BkDfzuUhWcmXyc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60ccb979e27c0cc77f914614 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 15:19:21
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67E5BC4323A; Fri, 18 Jun 2021 15:19:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-charante-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8E01C4360C;
        Fri, 18 Jun 2021 15:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8E01C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, vbabka@suse.cz, corbet@lwn.net,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, rientjes@google.com, mchehab+huawei@kernel.org,
        lokeshgidra@google.com, andrew.a.klychkov@gmail.com,
        xi.fengfei@h3c.com, nigupta@nvidia.com,
        dave.hansen@linux.intel.com, famzheng@amazon.com,
        mateusznosek0@gmail.com, oleksandr@redhat.com, sh_def@163.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH V4,0/3] mm: compaction: proactive compaction trigger by user
Date:   Fri, 18 Jun 2021 20:48:52 +0530
Message-Id: <cover.1624028025.git.charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches support triggering of proactive compaction by user on write
to the /proc/sys/vm/compaction_proactiveness.

Changes in V4:
  -- Changed the code as the 'proactive_defer' counter is removed.
  -- No changes in the logic of triggering the proactive compaction.
  -- Removed the 'proactive_defer' counter.

Changes in V3:
  -- Fixed review comments from Vlastimil and others.
  -- Fixed wake up logic when compaction_proactiveness is zero.
  -- https://lore.kernel.org/patchwork/patch/1438211/

Changes in V2:
  -- remove /proc/../proactive_compact_memory interface trigger for proactive compaction
  -- Intention is same that add a way to trigger proactive compaction by user.
  -- https://lore.kernel.org/patchwork/patch/1431283/

Changes in V1:
  -- Created the new /proc/sys/vm/proactive_compact_memory in
     interface to trigger proactive compaction from user 
  -- https://lore.kernel.org/lkml/1619098678-8501-1-git-send-email-charante@codeaurora.org/


Charan Teja Reddy (3):
  mm: compaction:  optimize proactive compaction deferrals
  mm: compaction: support triggering of proactive compaction by user
  mm: compaction: fix wakeup logic of proactive compaction

 Documentation/admin-guide/sysctl/vm.rst |  3 +-
 include/linux/compaction.h              |  2 ++
 include/linux/mmzone.h                  |  1 +
 kernel/sysctl.c                         |  2 +-
 mm/compaction.c                         | 61 +++++++++++++++++++++++++++------
 5 files changed, 56 insertions(+), 13 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

