Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C161E8C28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgE2Xka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2Xka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:40:30 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B73C03E969;
        Fri, 29 May 2020 16:40:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoc0-000C4f-Bf; Fri, 29 May 2020 23:40:28 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Don Brace <don.brace@microsemi.com>, linux-scsi@vger.kernel.org
Subject: [PATCH 2/4] hpsa: don't bother with vmalloc for BIG_IOCTL_Command_struct
Date:   Sat, 30 May 2020 00:40:26 +0100
Message-Id: <20200529234028.46373-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529234028.46373-1-viro@ZenIV.linux.org.uk>
References: <20200529233923.GL23230@ZenIV.linux.org.uk>
 <20200529234028.46373-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

"BIG" in the name refers to the amount of data being transferred,
_not_ the size of structure itself; it's 140 or 144 bytes (for
32bit and 64bit hosts resp.).  IOCTL_Command_struct is 136 or
144 bytes large...

No point whatsoever turning that into dynamic allocation, let
alone vmalloc one.  Just keep it as local variable...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/hpsa.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 3344a06c938e..64fd97272109 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6619,21 +6619,17 @@ static int hpsa_ioctl(struct scsi_device *dev, unsigned int cmd,
 		return rc;
 	}
 	case CCISS_BIG_PASSTHRU: {
-		BIG_IOCTL_Command_struct *ioc;
+		BIG_IOCTL_Command_struct ioc;
 		if (!argp)
 			return -EINVAL;
+		if (copy_from_user(&ioc, argp, sizeof(ioc)))
+			return -EFAULT;
 		if (atomic_dec_if_positive(&h->passthru_cmds_avail) < 0)
 			return -EAGAIN;
-		ioc = vmemdup_user(argp, sizeof(*ioc));
-		if (IS_ERR(ioc)) {
-			atomic_inc(&h->passthru_cmds_avail);
-			return PTR_ERR(ioc);
-		}
-		rc = hpsa_big_passthru_ioctl(h, ioc);
+		rc = hpsa_big_passthru_ioctl(h, &ioc);
 		atomic_inc(&h->passthru_cmds_avail);
-		if (!rc && copy_to_user(argp, ioc, sizeof(*ioc)))
+		if (!rc && copy_to_user(argp, &ioc, sizeof(ioc)))
 			rc = -EFAULT;
-		kvfree(ioc);
 		return rc;
 	}
 	default:
-- 
2.11.0

