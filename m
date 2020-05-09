Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390ED1CC569
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 01:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgEIXqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 19:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728775AbgEIXqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F7BC05BD0A;
        Sat,  9 May 2020 16:46:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAN-004iRo-8v; Sat, 09 May 2020 23:45:59 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Wu Hao <hao.wu@intel.com>
Subject: [PATCH 10/20] drivers/fpga/dfl-afu-dma-region.c: get rid of pointless access_ok()
Date:   Sun, 10 May 2020 00:45:47 +0100
Message-Id: <20200509234557.1124086-10-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Address is passed to get_user_pages_fast(), which does access_ok().
NB: this is called only from ->ioctl(), and only under USER_DS.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/fpga/dfl-afu-dma-region.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 62f924489db5..d902acb36d14 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -324,10 +324,6 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 	if (user_addr + length < user_addr)
 		return -EINVAL;
 
-	if (!access_ok((void __user *)(unsigned long)user_addr,
-		       length))
-		return -EINVAL;
-
 	region = kzalloc(sizeof(*region), GFP_KERNEL);
 	if (!region)
 		return -ENOMEM;
-- 
2.11.0

