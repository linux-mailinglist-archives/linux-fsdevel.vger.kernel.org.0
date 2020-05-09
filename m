Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94F1CC57A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 01:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgEIXqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 19:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728802AbgEIXqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:02 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECB4C05BD0D;
        Sat,  9 May 2020 16:46:02 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAO-004iSn-NN; Sat, 09 May 2020 23:46:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/4] vmci_host: get rid of pointless access_ok()
Date:   Sun, 10 May 2020 00:45:57 +0100
Message-Id: <20200509234557.1124086-20-viro@ZenIV.linux.org.uk>
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

get_user_pages_fast() doesn't need the caller to check that.
NB: reachable only from ioctl(2) and only under USER_DS

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/misc/vmw_vmci/vmci_host.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index ce16d6b99295..2d8328d928d5 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -233,8 +233,6 @@ static int vmci_host_setup_notify(struct vmci_ctx *context,
 	 * about the size.
 	 */
 	BUILD_BUG_ON(sizeof(bool) != sizeof(u8));
-	if (!access_ok((void __user *)uva, sizeof(u8)))
-		return VMCI_ERROR_GENERIC;
 
 	/*
 	 * Lock physical page backing a given user VA.
-- 
2.11.0

