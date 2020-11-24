Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3172C1E83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgKXGuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:50:10 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:64084 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729850AbgKXGuK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:50:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606200609; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pb2Z7JiP3zLsmtF+Oew5q4mjjn1yGyxWfKE6Z9aHwJo=; b=R+okDV6KiK0xQPmok9TZMxh5uqepvixZoSFt2v0CMafCLwiqYTvNPHCfk4+b83D9SlI0RYXZ
 s213dVjqb0XTtGt4K0I3J1LcLelYWvf7ffz25T91KZSKXFgZxXwYsU9y54FOcQ2xHjdD1mTV
 zF9q2leqtwFl20RC0uHENH/xQoo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fbcad0ab9b39088ed020642 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 06:49:46
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13FE1C43460; Tue, 24 Nov 2020 06:49:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2AC37C43460;
        Tue, 24 Nov 2020 06:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AC37C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@redhat.com, Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH] Resolve LRU page-pinning issue for file-backed pages 
Date:   Mon, 23 Nov 2020 22:49:37 -0800
Message-Id: <cover.1606194703.git.cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is possible for file-backed pages to end up in a contiguous memory
area (CMA), such that the relevant page must be migrated using the
.migratepage() callback when its backing physical memory is selected
for use in an CMA allocation (through cma_alloc()).  However, if a set
of address space operations (AOPs) for a file-backed page lacks a
migratepage() page call-back, fallback_migrate_page() will be used
instead, which through try_to_release_page() calls
try_to_free_buffers() (which is called directly or through a
try_to_free_buffers() callback.  try_to_free_buffers() in turn calls
drop_buffers().

drop_buffers() itself can fail due to the buffer_head associated with
a page being busy. However, it is possible that the buffer_head is on
an LRU list for a CPU, such that we can try removing the buffer_head
from that list, in order to successfully release the page.  Do this.
For reference ext4_journalled_aops is a set of AOPs that lacks the
migratepage() callback.

Laura Abbott (1):
  fs/buffer.c: Revoke LRU when trying to drop buffers

 fs/buffer.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

