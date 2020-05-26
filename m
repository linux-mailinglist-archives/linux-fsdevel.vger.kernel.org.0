Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170151E2F70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 21:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbgEZTw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 15:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390240AbgEZTvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 15:51:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD76C03E96D
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k22so9111866pls.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQihCl0dLbHaElgiRrlXkibi9/E8OKsaJ7lF0uUyO/s=;
        b=YKbLOw6LpYloCfEz6cSjXDp7lo/SEH14850NuBSfnHJZqbSNda9ft1KrD9kDTlgX29
         i5p9OTzKmGtxOrMHS+JBQto/yzM9zXGeRvk09gakJOY0/1BHuWAqj05obqvWTcQqZXjM
         tSs3FQLGux7Ieod96lB3tb6zv/Ei+e+rH+jvFEsgFfzk6f2Q6xviMQedqciMUxeS5bww
         YudmGt61FcA28hKFe3zbgPJZzUu27iwTT39ESm3iUzvAQWSmULv85wglM46pdLh9xw2G
         2vQ4GSnPWkUwbN9Hsml5BFWibSXp84PL/jR8cl2CQ0mI7mUEGk1xtvkYObM/1b+lAY5j
         3Wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQihCl0dLbHaElgiRrlXkibi9/E8OKsaJ7lF0uUyO/s=;
        b=BmIhMFSRt9k3gQ6D+8neLcWVqxe78pFEyv/9M/yGmpTXFpwwEIQUoHxN7ZtvVW4Jkm
         LBez7nMQpPDcsGZzuTMr6L2g9DErZdos6RizHgi4V/Bnjh1Lg3H2VH4KLbYPZoIMC9Br
         efkTjYV7w69Dumxrd+0IBy1gfGbAqVsDabhdrOCu+KTQvgJ6B1R68/iqUfWiIBE/XFLX
         uVmdw4UJ4I34V+Av3xhI2Z8XvNXm3ahZ5KoeD0GOx8d0rUgj55tezlkzteqgHek5EvXa
         w/XDAjP3pI1Fn/3Kx2WkhSt0D4cOy2U+E5C+Zy+b7WmVXeGc81PHv2boNIiXdOYZeVui
         jgFg==
X-Gm-Message-State: AOAM533i6blyr4T+PE3Syg0+/U2+azjHAAtrbGeZRiLiYpdXAIHHdrZx
        tc7/i2HgQ+WKUe8qyXoMupk/Tg==
X-Google-Smtp-Source: ABdhPJyeEiZx5SIpedWyfYllR0duff8tGiFVV6KjQ7XygtXqKPG6eKYMQBb6I07aOaSUrZejp48HpQ==
X-Received: by 2002:a17:90a:f283:: with SMTP id fs3mr874913pjb.1.1590522690209;
        Tue, 26 May 2020 12:51:30 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id c184sm313943pfc.57.2020.05.26.12.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:51:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/12] mm: abstract out wake_page_match() from wake_page_function()
Date:   Tue, 26 May 2020 13:51:14 -0600
Message-Id: <20200526195123.29053-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
References: <20200526195123.29053-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No functional changes in this patch, just in preparation for allowing
more callers.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 37 +++++++++++++++++++++++++++++++++++++
 mm/filemap.c            | 35 ++++-------------------------------
 2 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a8f7bd8ea1c6..53d980f2208d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -456,6 +456,43 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 	return pgoff;
 }
 
+/* This has the same layout as wait_bit_key - see fs/cachefiles/rdwr.c */
+struct wait_page_key {
+	struct page *page;
+	int bit_nr;
+	int page_match;
+};
+
+struct wait_page_queue {
+	struct page *page;
+	int bit_nr;
+	wait_queue_entry_t wait;
+};
+
+static inline int wake_page_match(struct wait_page_queue *wait_page,
+				  struct wait_page_key *key)
+{
+	if (wait_page->page != key->page)
+	       return 0;
+	key->page_match = 1;
+
+	if (wait_page->bit_nr != key->bit_nr)
+		return 0;
+
+	/*
+	 * Stop walking if it's locked.
+	 * Is this safe if put_and_wait_on_page_locked() is in use?
+	 * Yes: the waker must hold a reference to this page, and if PG_locked
+	 * has now already been set by another task, that task must also hold
+	 * a reference to the *same usage* of this page; so there is no need
+	 * to walk on to wake even the put_and_wait_on_page_locked() callers.
+	 */
+	if (test_bit(key->bit_nr, &key->page->flags))
+		return -1;
+
+	return 1;
+}
+
 extern void __lock_page(struct page *page);
 extern int __lock_page_killable(struct page *page);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
diff --git a/mm/filemap.c b/mm/filemap.c
index 80747f1377d5..e891b5bee8fd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -990,43 +990,16 @@ void __init pagecache_init(void)
 	page_writeback_init();
 }
 
-/* This has the same layout as wait_bit_key - see fs/cachefiles/rdwr.c */
-struct wait_page_key {
-	struct page *page;
-	int bit_nr;
-	int page_match;
-};
-
-struct wait_page_queue {
-	struct page *page;
-	int bit_nr;
-	wait_queue_entry_t wait;
-};
-
 static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *arg)
 {
 	struct wait_page_key *key = arg;
 	struct wait_page_queue *wait_page
 		= container_of(wait, struct wait_page_queue, wait);
+	int ret;
 
-	if (wait_page->page != key->page)
-	       return 0;
-	key->page_match = 1;
-
-	if (wait_page->bit_nr != key->bit_nr)
-		return 0;
-
-	/*
-	 * Stop walking if it's locked.
-	 * Is this safe if put_and_wait_on_page_locked() is in use?
-	 * Yes: the waker must hold a reference to this page, and if PG_locked
-	 * has now already been set by another task, that task must also hold
-	 * a reference to the *same usage* of this page; so there is no need
-	 * to walk on to wake even the put_and_wait_on_page_locked() callers.
-	 */
-	if (test_bit(key->bit_nr, &key->page->flags))
-		return -1;
-
+	ret = wake_page_match(wait_page, key);
+	if (ret != 1)
+		return ret;
 	return autoremove_wake_function(wait, mode, sync, key);
 }
 
-- 
2.26.2

