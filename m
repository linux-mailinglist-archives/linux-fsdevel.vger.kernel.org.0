Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4401A2820A6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgJCCzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJCCzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310E0C0613E3
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/asiVMI0b8scwfx0Ga8SdwXjF5UVIQeRC7tKWlD00ns=; b=RBtce2Yto4vzytWDe+ooPp2lcK
        Nj6pNo/RkqHjj62Zgl3gU/hVh/GUiQ84xg9qBAbVI/KPH8la03D4nW2z6sCAtFWnBem0hZQVk5lNs
        jXXxom6Q+Yav5gmomQNeRemAMjivCQdLX0pbWeZv8RS0A5lJ1FQEA8t82A+A9erlCXIyq/fZLSaYq
        Y1igDsLy1Vn7+Ibbk2BUCw7ZqR5NlqITNMAutoKTYB81Lpq8BbNxWS5gOiZYMNZM5kDDUxEo+s5GF
        h8og/SulqmdZXBU72XLkYmkEeXrYDaQ7Hg9/wS0/IMG+MfFpjnwTwR4eP9UlXhagN+op5xwjYfSuP
        rvXgUXUg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhy-0005Vh-5w; Sat, 03 Oct 2020 02:55:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/13] keys: Pass a NULL pointer to kernel_read and kernel_write
Date:   Sat,  3 Oct 2020 03:55:31 +0100
Message-Id: <20201003025534.21045-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201003025534.21045-1-willy@infradead.org>
References: <20201003025534.21045-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want to start at 0 and do not care about the updated value.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 security/keys/big_key.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 691347dea3c1..ffe70ff84665 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -79,8 +79,6 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 		 * Since the key is random for each file, we can set the nonce
 		 * to zero, provided we never define a ->update() call.
 		 */
-		loff_t pos = 0;
-
 		buf = kvmalloc(enclen, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
@@ -106,7 +104,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 			goto err_enckey;
 		}
 
-		written = kernel_write(file, buf, enclen, &pos);
+		written = kernel_write(file, buf, enclen, NULL);
 		if (written != enclen) {
 			ret = written;
 			if (written >= 0)
@@ -240,7 +238,6 @@ long big_key_read(const struct key *key, char *buffer, size_t buflen)
 		struct file *file;
 		u8 *buf, *enckey = (u8 *)key->payload.data[big_key_data];
 		size_t enclen = datalen + CHACHA20POLY1305_AUTHTAG_SIZE;
-		loff_t pos = 0;
 
 		buf = kvmalloc(enclen, GFP_KERNEL);
 		if (!buf)
@@ -253,7 +250,7 @@ long big_key_read(const struct key *key, char *buffer, size_t buflen)
 		}
 
 		/* read file to kernel and decrypt */
-		ret = kernel_read(file, buf, enclen, &pos);
+		ret = kernel_read(file, buf, enclen, NULL);
 		if (ret != enclen) {
 			if (ret >= 0)
 				ret = -EIO;
-- 
2.28.0

