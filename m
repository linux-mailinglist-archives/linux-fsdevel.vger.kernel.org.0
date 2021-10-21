Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0B435B9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 09:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhJUHZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 03:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUHZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:25:42 -0400
X-Greylist: delayed 559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Oct 2021 00:23:26 PDT
Received: from out10.migadu.com (out10.migadu.com [IPv6:2001:41d0:2:e8e3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E126C06161C;
        Thu, 21 Oct 2021 00:23:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634800447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HEpr9JzEndtAa1pBv+f+c1A9jbIOIDhOKuf+02txAU=;
        b=XGMYIDBOGiAWWEmoFhdiUTPMy48kOGW9fMnjR77hIchg2yycIjwkMj/EEDMKgBWm6/qpGx
        lU6BuA4UY57DOeolCvY6Xb5Uphb/4zFgw8ShUp70j2Ke+U9CAWfQ0e1PTj81fhS1qIXW77
        Nne5gbL4jY7eNak6lbR9u40ZdDUW7RY=
From:   Jackie Liu <liu.yun@linux.dev>
To:     axboe@kernel.dk, hch@lst.de
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        liu.yun@linux.dev
Subject: [PATCH 2/2] scsi: bsg: fix errno when scsi_bsg_register_queue fails
Date:   Thu, 21 Oct 2021 15:13:44 +0800
Message-Id: <20211021071344.1600362-2-liu.yun@linux.dev>
In-Reply-To: <20211021071344.1600362-1-liu.yun@linux.dev>
References: <20211021071344.1600362-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

When the value of error is printed, it will always be 0. Here, we should be
print the correct error code when scsi_bsg_register_queue fails.

Fixes: ead09dd3aed5 ("scsi: bsg: Simplify device registration")
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/scsi/scsi_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 86793259e541..d8789f6cda62 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1379,6 +1379,7 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 			 * We're treating error on bsg register as non-fatal, so
 			 * pretend nothing went wrong.
 			 */
+			error = PTR_ERR(sdev->bsg_dev);
 			sdev_printk(KERN_INFO, sdev,
 				    "Failed to register bsg queue, errno=%d\n",
 				    error);
-- 
2.25.1

