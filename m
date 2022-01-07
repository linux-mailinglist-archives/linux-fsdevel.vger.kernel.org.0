Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1BA48784C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiAGNiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 08:38:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50240 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiAGNiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:38:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 67D2821126;
        Fri,  7 Jan 2022 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641562703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AS/16BCZa/oBRlH7qsbsbsMGtE7/cqCGGMo4B/o4Rjs=;
        b=iidlWejSJpecSonRfzBkps0u0zdcuoqQxbbfjtLVyHWTtbIwg15E6yRi6c1xWWthjHmK8b
        tuap/m7majxp504aD92T7AoU7bB5QVWMMwU/J/EzkNfYE84CINfVtxCjmWRi/3DsTRpxeU
        oFBc8EWM4ZyBcGPtzZiOPrHEssxuS1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641562703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AS/16BCZa/oBRlH7qsbsbsMGtE7/cqCGGMo4B/o4Rjs=;
        b=saUCHHPOKPXFvSGn+i6JIX6N1IoOJ87k/ZBceYsZKzRv6kbut24OK2UYtVZn6FBjajT8lc
        ZPytU7CXJaGbhyBQ==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3CF6EA3B8B;
        Fri,  7 Jan 2022 13:38:23 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v6 2/6] initramfs: make dir_entry.name a flexible array member
Date:   Fri,  7 Jan 2022 14:38:10 +0100
Message-Id: <20220107133814.32655-3-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107133814.32655-1-ddiss@suse.de>
References: <20220107133814.32655-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dir_entry.name is currently allocated via a separate kstrdup(). Change
it to a flexible array member and allocate it along with struct
dir_entry.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 2f79b3ec0b40..656d2d71349f 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -130,17 +130,20 @@ static long __init do_utime(char *filename, time64_t mtime)
 static __initdata LIST_HEAD(dir_list);
 struct dir_entry {
 	struct list_head list;
-	char *name;
 	time64_t mtime;
+	char name[];
 };
 
 static void __init dir_add(const char *name, time64_t mtime)
 {
-	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
+	size_t nlen = strlen(name) + 1;
+	struct dir_entry *de;
+
+	de = kmalloc(sizeof(struct dir_entry) + nlen, GFP_KERNEL);
 	if (!de)
 		panic_show_mem("can't allocate dir_entry buffer");
 	INIT_LIST_HEAD(&de->list);
-	de->name = kstrdup(name, GFP_KERNEL);
+	strscpy(de->name, name, nlen);
 	de->mtime = mtime;
 	list_add(&de->list, &dir_list);
 }
@@ -151,7 +154,6 @@ static void __init dir_utime(void)
 	list_for_each_entry_safe(de, tmp, &dir_list, list) {
 		list_del(&de->list);
 		do_utime(de->name, de->mtime);
-		kfree(de->name);
 		kfree(de);
 	}
 }
-- 
2.31.1

