Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB641E7100
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 01:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437911AbgE1X6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 19:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437807AbgE1X63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 19:58:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1068CC08C5C6;
        Thu, 28 May 2020 16:58:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSPr-00HE7f-GV; Thu, 28 May 2020 23:58:27 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] firewire: switch ioctl_queue_iso to use of copy_from_user()
Date:   Fri, 29 May 2020 00:58:26 +0100
Message-Id: <20200528235827.4105826-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528235752.GU23230@ZenIV.linux.org.uk>
References: <20200528235752.GU23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

no point trying to do access_ok() for all those __copy_from_user()
at once.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/firewire/core-cdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 6e291d8f3a27..c7ea4f2d5ca6 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1081,8 +1081,6 @@ static int ioctl_queue_iso(struct client *client, union ioctl_arg *arg)
 		return -EINVAL;
 
 	p = (struct fw_cdev_iso_packet __user *)u64_to_uptr(a->packets);
-	if (!access_ok(p, a->size))
-		return -EFAULT;
 
 	end = (void __user *)p + a->size;
 	count = 0;
@@ -1120,7 +1118,7 @@ static int ioctl_queue_iso(struct client *client, union ioctl_arg *arg)
 			&p->header[transmit_header_bytes / 4];
 		if (next > end)
 			return -EINVAL;
-		if (__copy_from_user
+		if (copy_from_user
 		    (u.packet.header, p->header, transmit_header_bytes))
 			return -EFAULT;
 		if (u.packet.skip && ctx->type == FW_ISO_CONTEXT_TRANSMIT &&
-- 
2.11.0

