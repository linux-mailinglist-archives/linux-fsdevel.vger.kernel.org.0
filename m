Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4650AC5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442812AbiDUXvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442778AbiDUXvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:51:42 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4BD43EC5;
        Thu, 21 Apr 2022 16:48:50 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a186so4750158qkc.10;
        Thu, 21 Apr 2022 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJODyF/ajH9xOJK+4CIgokrEBufAgT0uT/ipe+iH5NU=;
        b=iMIgPJ5erku/7c7HhXsIctg1kxrza0LuvC2QEIAcGT7wBu0OauFCACWenk2xffUDR8
         XvSO6KpoUrlwK8MsoRjIvhQGG3zVynFJa5Gw7Fnwvxb3RBVaVSIlGsbNQsUo5Ggj+g2m
         F3zt7/xN30ltoNSguXjheaeHJTLuicb+L99c5ETzfEAHShhj8+y7XTpzRhK1h/NwV1jP
         1RdSjlkCUTKXhQ+pScjWL/hQfIrvKW6R9iBUMiwKnX/QQ4H696tdz7Sf3PD2st3851z7
         hwHwA2cDiSaz5zzTGDVOXyaBFkRTNpPOx/O+/F4tLvIWQswTUThlV4CaqLNTB+5KykNb
         ovFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJODyF/ajH9xOJK+4CIgokrEBufAgT0uT/ipe+iH5NU=;
        b=dT7YDNQAogKLFLm0MaZIsSL/fsSRQRybj8UEbxoyR2g0El5Bf3ztULqTP2gMWHU5Ju
         IyEFFbl75Q+D/FRff2V3i9Bim102XNE3JSVsZ7qbSP9L/a5rfFMKemDEeQtE+94JeNIZ
         WUkeZPBPe62MWe7IUnMAcMHyRpcUqlKPqIvSzMsAZjQt1ccfqmzWCbOT5BVnNkTO0NIR
         5FKl9hcRcEhSQBucBqKTCqUWdPvwqTiwek34KSVjA/JuzTdBXf7FdCCpi5lClmJy5ym1
         pWFsGm2h88DugVG+pzINlh8cTtw4LhHlOGB7b1NrS9qEnvvwiN+KNrn5F7rUQNKkXi4K
         1HfA==
X-Gm-Message-State: AOAM5314cmTiOBDOL8QxjJR2rvAafXPGbulZXOc4UA5SqaYTHMzpbtAG
        /e3eHzKnVoUtghCsXqPm0Ae58YmBJlJt
X-Google-Smtp-Source: ABdhPJxI32XeTa41Ms2HZb8peaWuFEExEtNfe16DFYhZQ/thdpSwM/dy7gUZcuantPPXtVlOJX7YeA==
X-Received: by 2002:a05:620a:4488:b0:69e:bf0f:42be with SMTP id x8-20020a05620a448800b0069ebf0f42bemr1112891qkp.663.1650584929641;
        Thu, 21 Apr 2022 16:48:49 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:48:49 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        roman.gushchin@linux.dev
Subject: [PATCH 4/4] bcachefs: shrinker.to_text() methods
Date:   Thu, 21 Apr 2022 19:48:28 -0400
Message-Id: <20220421234837.3629927-5-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220421234837.3629927-1-kent.overstreet@gmail.com>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/bcachefs/btree_cache.c     | 18 +++++++++++++++---
 fs/bcachefs/btree_key_cache.c | 18 +++++++++++++++---
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
index 72f0587e4d..75ef3b5462 100644
--- a/fs/bcachefs/btree_cache.c
+++ b/fs/bcachefs/btree_cache.c
@@ -394,6 +394,14 @@ static unsigned long bch2_btree_cache_count(struct shrinker *shrink,
 	return btree_cache_can_free(bc);
 }
 
+static void bch2_btree_cache_shrinker_to_text(struct printbuf *out, struct shrinker *shrink)
+{
+	struct bch_fs *c = container_of(shrink, struct bch_fs,
+					btree_cache.shrink);
+
+	bch2_btree_cache_to_text(out, c);
+}
+
 void bch2_fs_btree_cache_exit(struct bch_fs *c)
 {
 	struct btree_cache *bc = &c->btree_cache;
@@ -477,6 +485,7 @@ int bch2_fs_btree_cache_init(struct bch_fs *c)
 
 	bc->shrink.count_objects	= bch2_btree_cache_count;
 	bc->shrink.scan_objects		= bch2_btree_cache_scan;
+	bc->shrink.to_text		= bch2_btree_cache_shrinker_to_text;
 	bc->shrink.seeks		= 4;
 	ret = register_shrinker(&bc->shrink);
 out:
@@ -1147,7 +1156,10 @@ void bch2_btree_node_to_text(struct printbuf *out, struct bch_fs *c,
 
 void bch2_btree_cache_to_text(struct printbuf *out, struct bch_fs *c)
 {
-	pr_buf(out, "nr nodes:\t\t%u\n", c->btree_cache.used);
-	pr_buf(out, "nr dirty:\t\t%u\n", atomic_read(&c->btree_cache.dirty));
-	pr_buf(out, "cannibalize lock:\t%p\n", c->btree_cache.alloc_lock);
+	pr_buf(out, "nr nodes:          %u", c->btree_cache.used);
+	pr_newline(out);
+	pr_buf(out, "nr dirty:          %u", atomic_read(&c->btree_cache.dirty));
+	pr_newline(out);
+	pr_buf(out, "cannibalize lock:  %p", c->btree_cache.alloc_lock);
+	pr_newline(out);
 }
diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
index a575189f35..32b5cb6042 100644
--- a/fs/bcachefs/btree_key_cache.c
+++ b/fs/bcachefs/btree_key_cache.c
@@ -711,6 +711,14 @@ void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
 	INIT_LIST_HEAD(&c->freed);
 }
 
+static void bch2_btree_key_cache_shrinker_to_text(struct printbuf *out, struct shrinker *shrink)
+{
+	struct btree_key_cache *bc =
+		container_of(shrink, struct btree_key_cache, shrink);
+
+	bch2_btree_key_cache_to_text(out, bc);
+}
+
 int bch2_fs_btree_key_cache_init(struct btree_key_cache *c)
 {
 	int ret;
@@ -724,14 +732,18 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *c)
 	c->shrink.seeks			= 1;
 	c->shrink.count_objects		= bch2_btree_key_cache_count;
 	c->shrink.scan_objects		= bch2_btree_key_cache_scan;
+	c->shrink.to_text		= bch2_btree_key_cache_shrinker_to_text;
 	return register_shrinker(&c->shrink);
 }
 
 void bch2_btree_key_cache_to_text(struct printbuf *out, struct btree_key_cache *c)
 {
-	pr_buf(out, "nr_freed:\t%zu\n",	c->nr_freed);
-	pr_buf(out, "nr_keys:\t%lu\n",	atomic_long_read(&c->nr_keys));
-	pr_buf(out, "nr_dirty:\t%lu\n",	atomic_long_read(&c->nr_dirty));
+	pr_buf(out, "nr_freed:  %zu",	c->nr_freed);
+	pr_newline(out);
+	pr_buf(out, "nr_keys:   %zu",	atomic_long_read(&c->nr_keys));
+	pr_newline(out);
+	pr_buf(out, "nr_dirty:  %zu",	atomic_long_read(&c->nr_dirty));
+	pr_newline(out);
 }
 
 void bch2_btree_key_cache_exit(void)
-- 
2.35.2

