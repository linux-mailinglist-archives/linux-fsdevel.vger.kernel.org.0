Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7081E1E710B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437925AbgE2AEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437910AbgE2AEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:04:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B617C08C5C6;
        Thu, 28 May 2020 17:04:21 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSVX-00HELi-LX; Fri, 29 May 2020 00:04:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] esas2r: don't bother with __copy_to_user()
Date:   Fri, 29 May 2020 01:04:18 +0100
Message-Id: <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529000345.GV23230@ZenIV.linux.org.uk>
References: <20200529000345.GV23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

sure, we'd done copy_from_user() on the same range, so we can
skip access_ok()... and it's not worth bothering.  Just use
copy_to_user().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/esas2r/esas2r_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index 442c5e70a7b4..cc620f10eabc 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -1510,7 +1510,7 @@ int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
 	}
 
 	/* Always copy the buffer back, if only to pick up the status */
-	err = __copy_to_user(arg, ioctl, sizeof(struct atto_express_ioctl));
+	err = copy_to_user(arg, ioctl, sizeof(struct atto_express_ioctl));
 	if (err != 0) {
 		esas2r_log(ESAS2R_LOG_WARN,
 			   "ioctl_handler copy_to_user didn't copy everything (err %d, cmd %u)",
-- 
2.11.0

