Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E571A7270
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405267AbgDNETZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:19:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39451 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405229AbgDNETI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:19:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id k18so4199635pll.6;
        Mon, 13 Apr 2020 21:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NmUdDstD3GuaW3cnQoQAeoBXgYPgT0T/dDdxzI7Fmbk=;
        b=LzmablTY1kDvE+nUb5xx4QvGVP+7JaFXK0ZSvAC+5eFkTO5hr4sEq+c0tkSMlJOQBM
         hFDAmE9Msl0jotMUmumN75q12nfDeOc35/jLUOC/G/s0wEtbCah4NQrCSjbizydoWbNE
         ltW92IwA+LYdnWMuOIdLnjg3HtTZmaoIh9GP8OxTtMXtuuNwPTDOkIYjP3Xb0S636Gh5
         +EAugLWzeEg4nNyxVNnnbyG357fBOGU5o5ESxdkheCL2TdRH2AUFBXS1rTOJEyO1Zohq
         m5/AWdkqA+NM4XF02ZB2t6K+OvXpBGfwfgBhiB74rAXD4oNHvkTs0UTGBSSRHfTJtXOk
         SH/g==
X-Gm-Message-State: AGi0PuZ/PE8pM1PAf9fPvfRMcWUc3Vwq+WeG+R+510D/KPrEUHIulUKa
        7zbjIKWAM0n2yjVPWEFizEI=
X-Google-Smtp-Source: APiQypIsVkYIkhxCV56xtOZaGPp9eSaAdDaWC4rfpGfLdLU2ldMd52BYaibw40sfHKHEpTAKk4IcLg==
X-Received: by 2002:a17:90a:82:: with SMTP id a2mr27017334pja.47.1586837947821;
        Mon, 13 Apr 2020 21:19:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j1sm3878077pgk.23.2020.04.13.21.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:19:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0A76D418C0; Tue, 14 Apr 2020 04:19:04 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
Date:   Tue, 14 Apr 2020 04:19:00 +0000
Message-Id: <20200414041902.16769-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200414041902.16769-1-mcgrof@kernel.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that the request_queue is refcounted during its full
ioctl cycle. This avoids possible races against removal, given
blk_get_queue() also checks to ensure the queue is not dying.

This small race is possible if you defer removal of the request_queue
and userspace fires off an ioctl for the device in the meantime.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: yu kuai <yukuai3@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/blktrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 15086227592f..17e144d15779 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -701,6 +701,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	if (!q)
 		return -ENXIO;
 
+	if (!blk_get_queue(q))
+		return -ENXIO;
+
 	mutex_lock(&q->blk_trace_mutex);
 
 	switch (cmd) {
@@ -729,6 +732,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	}
 
 	mutex_unlock(&q->blk_trace_mutex);
+
+	blk_put_queue(q);
+
 	return ret;
 }
 
-- 
2.25.1

