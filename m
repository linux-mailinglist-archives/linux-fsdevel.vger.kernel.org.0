Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E985398EA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhFBPdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhFBPdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:33:05 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Jun 2021 08:31:22 PDT
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB5FC061574;
        Wed,  2 Jun 2021 08:31:22 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 5A8FF2E157E;
        Wed,  2 Jun 2021 18:29:16 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 3yRf5Welph-TF1Ol7bg;
        Wed, 02 Jun 2021 18:29:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1622647756; bh=2Zn8QKK4xousuCUlCWjAKT/AXeO6YfqAZ4AsRrA38Nc=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=qbOPDswRqqhK4f3ZED91wOgadbf4DEyRvhCD2/VIPKVAe3wNTDri8WsKB9DPVFxyV
         PV6iEt+bt3gCrtOJNWFtbFuT4rvNY0IA4eZ8GTSUaOnO7GoY44MOMIphF1NUK2heWk
         xd1gtkt1uLs9XSHECWGnFJwazvT5nxME3RULoJLI=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 42DbdVHlBw-TFoiEBs6;
        Wed, 02 Jun 2021 18:29:15 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     warwish@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH 01/10] drbd: reduce stack footprint in drbd_report_io_error()
Date:   Wed,  2 Jun 2021 18:28:54 +0300
Message-Id: <20210602152903.910190-2-warwish@yandex-team.ru>
In-Reply-To: <20210602152903.910190-1-warwish@yandex-team.ru>
References: <20210602152903.910190-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./drivers/block/drbd/drbd_req.c drbd_report_io_error    200     72      -128

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 drivers/block/drbd/drbd_req.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 13beb98a7c5a..bd7265edf614 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -510,16 +510,14 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 
 static void drbd_report_io_error(struct drbd_device *device, struct drbd_request *req)
 {
-        char b[BDEVNAME_SIZE];
-
 	if (!__ratelimit(&drbd_ratelimit_state))
 		return;
 
-	drbd_warn(device, "local %s IO error sector %llu+%u on %s\n",
-			(req->rq_state & RQ_WRITE) ? "WRITE" : "READ",
-			(unsigned long long)req->i.sector,
-			req->i.size >> 9,
-			bdevname(device->ldev->backing_bdev, b));
+	drbd_warn(device, "local %s IO error sector %llu+%u on %pg\n",
+		  (req->rq_state & RQ_WRITE) ? "WRITE" : "READ",
+		  (unsigned long long)req->i.sector,
+		  req->i.size >> 9,
+		  device->ldev->backing_bdev);
 }
 
 /* Helper for HANDED_OVER_TO_NETWORK.
-- 
2.25.1

