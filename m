Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8191E7101
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 01:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437957AbgE1X6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 19:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437857AbgE1X63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 19:58:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2546DC08C5C7;
        Thu, 28 May 2020 16:58:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSPr-00HE7k-Lz; Thu, 28 May 2020 23:58:27 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] pstore: switch to copy_from_user()
Date:   Fri, 29 May 2020 00:58:27 +0100
Message-Id: <20200528235827.4105826-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528235827.4105826-1-viro@ZenIV.linux.org.uk>
References: <20200528235752.GU23230@ZenIV.linux.org.uk>
 <20200528235827.4105826-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

don't bother trying to do bulk access_ok()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pstore/ram_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index c917c191e78c..aa8e0b65ff1a 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -283,7 +283,7 @@ static int notrace persistent_ram_update_user(struct persistent_ram_zone *prz,
 	const void __user *s, unsigned int start, unsigned int count)
 {
 	struct persistent_ram_buffer *buffer = prz->buffer;
-	int ret = unlikely(__copy_from_user(buffer->data + start, s, count)) ?
+	int ret = unlikely(copy_from_user(buffer->data + start, s, count)) ?
 		-EFAULT : 0;
 	persistent_ram_update_ecc(prz, start, count);
 	return ret;
@@ -348,8 +348,6 @@ int notrace persistent_ram_write_user(struct persistent_ram_zone *prz,
 	int rem, ret = 0, c = count;
 	size_t start;
 
-	if (unlikely(!access_ok(s, count)))
-		return -EFAULT;
 	if (unlikely(c > prz->buffer_size)) {
 		s += c - prz->buffer_size;
 		c = prz->buffer_size;
-- 
2.11.0

