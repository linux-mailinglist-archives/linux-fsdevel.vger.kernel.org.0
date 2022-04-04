Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C697D4F1220
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 11:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354446AbiDDJhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 05:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354379AbiDDJhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:37:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F62B2FFE8
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 02:35:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 317B21F383;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649064941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDMC93HcmGE4d4iP45Rmb3DTrhyTD7MhyFklq+M0cvM=;
        b=KHp1rIXTMER3lYVeoocsdbV9mWckr09W5Q16L3i1xwBb+6g6SgcG3io2N3BFZKUQvJ1bVu
        Bry7BjYD6Vmr9hCVqvHW3tT25cMG4VvEmLfYEleE9wd/CgbOqwoJdovWOkSxi+NieBwQgE
        Cf6aXcHU4UJpZ/+nrXbxvC+ADPGqKLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649064941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDMC93HcmGE4d4iP45Rmb3DTrhyTD7MhyFklq+M0cvM=;
        b=X8fmqi4ikZTv5BMO4VjKaqDNCmDCL6uBI54CB9q/DZZseqWQXFQAyDEn0nNHSW1ULSfvz4
        EtCMinKUSWOFctCA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 056F7A3B8A;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v7 2/6] initramfs: make dir_entry.name a flexible array member
Date:   Mon,  4 Apr 2022 11:34:26 +0200
Message-Id: <20220404093429.27570-3-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220404093429.27570-1-ddiss@suse.de>
References: <20220404093429.27570-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dir_entry.name is currently allocated via a separate kstrdup(). Change
it to a flexible array member and allocate it along with struct
dir_entry.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
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
2.34.1

