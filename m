Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090331CC58C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 01:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgEIXqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 19:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728776AbgEIXqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62424C05BD09;
        Sat,  9 May 2020 16:46:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAN-004iRk-1R; Sat, 09 May 2020 23:45:59 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Wu Hao <hao.wu@intel.com>
Subject: [PATCH 09/20] drivers/fpga/dfl-fme-pr.c: get rid of pointless access_ok()
Date:   Sun, 10 May 2020 00:45:46 +0100
Message-Id: <20200509234557.1124086-9-viro@ZenIV.linux.org.uk>
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

followed by copy_from_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/fpga/dfl-fme-pr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index a233a53db708..1194c0e850e0 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -97,10 +97,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 		return -EINVAL;
 	}
 
-	if (!access_ok((void __user *)(unsigned long)port_pr.buffer_address,
-		       port_pr.buffer_size))
-		return -EFAULT;
-
 	/*
 	 * align PR buffer per PR bandwidth, as HW ignores the extra padding
 	 * data automatically.
-- 
2.11.0

