Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870DC1CC579
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 01:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgEIXqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 19:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728800AbgEIXqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:02 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055AFC05BD0A;
        Sat,  9 May 2020 16:46:02 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAO-004iSK-6U; Sat, 09 May 2020 23:46:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Ivan Hu <ivan.hu@canonical.com>
Subject: [PATCH 16/20] efi_test: get rid of pointless access_ok()
Date:   Sun, 10 May 2020 00:45:53 +0100
Message-Id: <20200509234557.1124086-16-viro@ZenIV.linux.org.uk>
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

really, people - get_user(), copy_from_user(), memdup_user(), etc.
all fail if access_ok() does.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/firmware/efi/test/efi_test.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index 7baf48c01e72..ddf9eae396fe 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -70,9 +70,6 @@ copy_ucs2_from_user_len(efi_char16_t **dst, efi_char16_t __user *src,
 		return 0;
 	}
 
-	if (!access_ok(src, 1))
-		return -EFAULT;
-
 	buf = memdup_user(src, len);
 	if (IS_ERR(buf)) {
 		*dst = NULL;
@@ -91,9 +88,6 @@ copy_ucs2_from_user_len(efi_char16_t **dst, efi_char16_t __user *src,
 static inline int
 get_ucs2_strsize_from_user(efi_char16_t __user *src, size_t *len)
 {
-	if (!access_ok(src, 1))
-		return -EFAULT;
-
 	*len = user_ucs2_strsize(src);
 	if (*len == 0)
 		return -EFAULT;
@@ -118,9 +112,6 @@ copy_ucs2_from_user(efi_char16_t **dst, efi_char16_t __user *src)
 {
 	size_t len;
 
-	if (!access_ok(src, 1))
-		return -EFAULT;
-
 	len = user_ucs2_strsize(src);
 	if (len == 0)
 		return -EFAULT;
@@ -142,9 +133,6 @@ copy_ucs2_to_user_len(efi_char16_t __user *dst, efi_char16_t *src, size_t len)
 	if (!src)
 		return 0;
 
-	if (!access_ok(dst, 1))
-		return -EFAULT;
-
 	return copy_to_user(dst, src, len);
 }
 
-- 
2.11.0

