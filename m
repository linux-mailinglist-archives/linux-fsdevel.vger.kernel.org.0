Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9CB507B09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 22:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357671AbiDSUfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 16:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346295AbiDSUfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:35:01 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EA3C712;
        Tue, 19 Apr 2022 13:32:17 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d19so6594581qko.3;
        Tue, 19 Apr 2022 13:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJODyF/ajH9xOJK+4CIgokrEBufAgT0uT/ipe+iH5NU=;
        b=QAsHvwzDiVLVrGcU+9jbXMpQHWpDKdMfj3bnaE6Fu/OB+mJ3UTI2COzzBz8F3B8PDY
         QR/HlbQYkvX1wLqTHtrj09BO5gbHxfopW1/9ErRgVdLGBXmwB2vh783JIEf1zL6y8m+1
         gOyPOGYrhW7b1BfPzQGL9EWo3jr7z4k0QgYVP2/c2gSoJpNHts8tIk6Y+KfQW/pB83A9
         g6G7mq+Ri4BnZ0etWfdnCF6WkxD2F/lCKxbTpcoRuig61gE97c4evJaj8ypBbSFuTLw/
         kkfwBHq79jHa+vLZ4y9nTlceUZJ9SRnkNEyvY/hJNAx/aS7t2tOy0ZcRWyCVKI+ZBv16
         9bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJODyF/ajH9xOJK+4CIgokrEBufAgT0uT/ipe+iH5NU=;
        b=SGsGv0hsKQxs9OanlhnFHz4gJuIU2dVsKjbXpRjngA8XgDhTPXxwT68SEzswIOZVKE
         Dl+MNWoREFH9plFoPejlPOmi21W0FP5Ijg4K5hZ/cT0muTibqnQnyFRZPOh4CbKe2ZtI
         zNSCSUlSlqo1yJ5k4OYr951qESxEzrrvmfipTVscaeHmL/EKp8oHcRPkrW396i13WMEt
         yN6QCemunGgYujfu2LiQpFLC6gOVh2y8G9i++/73N/Ist1Y1IaRVqrPx7wyy7IoXI5OW
         LJSICkXjcBSF6Zsu6I2DEETwiFx9Huq6wgwisJVBEjBclGQFer34mKMzF29uXHVTUxJ9
         ylBQ==
X-Gm-Message-State: AOAM5302GdNpacyOHHV2jMRIIdewkluixUE/PAcUmX6fNpYU6e00BH8i
        COmE9DRCru05FAGIgpa3mFFmbqVKjkGO
X-Google-Smtp-Source: ABdhPJwglihygmVaHV5xfkCJRJUfFCN+9TSdbuDle94mmw3wMqPZlOg/eMDWhy7vp1WF0tcR+c+hZg==
X-Received: by 2002:a05:620a:4711:b0:67e:6c24:2b2b with SMTP id bs17-20020a05620a471100b0067e6c242b2bmr10987093qkb.588.1650400336592;
        Tue, 19 Apr 2022 13:32:16 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id e9-20020ac84e49000000b002f1fcda1ac7sm611180qtw.82.2022.04.19.13.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:32:15 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        roman.gushchin@linux.dev
Subject: [PATCH 4/4] bcachefs: shrinker.to_text() methods
Date:   Tue, 19 Apr 2022 16:32:02 -0400
Message-Id: <20220419203202.2670193-5-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220419203202.2670193-1-kent.overstreet@gmail.com>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

