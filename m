Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9557355A93C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiFYLBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiFYLBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:01:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC533E9A;
        Sat, 25 Jun 2022 04:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D7F0611A5;
        Sat, 25 Jun 2022 11:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5ABC341C7;
        Sat, 25 Jun 2022 11:01:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="I77S1xS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656154904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIjn5iV3Bi5t5Qq6rqpqsdlzBuYh8dn6H7cyAt8zXHg=;
        b=I77S1xS4v2XHnn9FyMjcVXxjym+eFfaamQ8LZuCQIkCYba0T9XUnN7o13ic6FsgUvcbauQ
        a61nI7HIiCULslMTCSnj65QFiXNLfvxbRp+elW7AZANxWra+bX1CMp+QM4tbakO3io35dt
        x8CaNgGTjEXsgam1u3pSIL9o8fU90Ro=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d9056741 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 25 Jun 2022 11:01:44 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v2 8/8] vfio: do not set FMODE_LSEEK flag
Date:   Sat, 25 Jun 2022 13:01:15 +0200
Message-Id: <20220625110115.39956-9-Jason@zx2c4.com>
In-Reply-To: <20220625110115.39956-1-Jason@zx2c4.com>
References: <20220625110115.39956-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This file does not support llseek, so don't set the flag advertising it.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/vfio/vfio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 61e71c1154be..d194dda89542 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1129,7 +1129,7 @@ static struct file *vfio_device_open(struct vfio_device *device)
 	 * Appears to be missing by lack of need rather than
 	 * explicitly prevented.  Now there's need.
 	 */
-	filep->f_mode |= (FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
+	filep->f_mode |= (FMODE_PREAD | FMODE_PWRITE);
 
 	if (device->group->type == VFIO_NO_IOMMU)
 		dev_warn(device->dev, "vfio-noiommu device opened by user "
-- 
2.35.1

