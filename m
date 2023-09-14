Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C667A0916
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbjINP0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbjINP0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:26:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9551FD4
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 08:26:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81841ef79bso1389800276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694705187; x=1695309987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=szuJNW0JYA8v41wMmDUwFhK5OZ9EO2QBXA4Fv3dKB/g=;
        b=jCvUByImO9mNUNc2G0EjvcxgWKJ5CBhHhoWtl15I6+hJtt2xgRNmUTD2SbqwxVjTtT
         z7Ogp4FwVIFDpaqzmvr9DVDkmXDeKWWJK0Mzuo9KN1XKt8SzjuOheWvd8DaBGEtOsGGA
         D/++5vdmbyd1CfGQ1bhl18gywNLhLFKStnFio0rxSEWSZcBp3ZZhopzEvPq0sJFWYk53
         lov7Xz8PJnfKnlkPEOEbjGyfmZBR6mYZaYQLaHl/s1lR+TC1LzRaMoguTb7nEaUSsqRX
         WDgyf0R9Sq+fimakyr4GMYDgBilENVhfLZz5Kvk6Ihh48xWtI9jK449Ccu5ioWqqtqfG
         snOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694705187; x=1695309987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szuJNW0JYA8v41wMmDUwFhK5OZ9EO2QBXA4Fv3dKB/g=;
        b=hAqr+1/4QeKUGz95+rJG39oNG58wxJKDOkEQD+5gj3nypXv4JD/U9xV6up2AA4h/eE
         P6jpYF3M2Iw7cC4uKC81c6+pKu+RUUY3hODtG9dHk9OG66quiquuOZgnp+ssih80vp+z
         SwNzFoa9pbNhvSMZ/JDBK2TMqdfvfUjEqJvxjl6Op9NZMVrdHGFOl8ABfUr63d1r7JUO
         z7CF6oRDtdrviHJKwsIchyBQKOUox63UmmpsJyK1lru9HmIKbkzse3BETtISejABZ5eP
         PkDrJAaKJUWgW0sWZPdRE8wUky3nvbe05CwgmjPBa/VPYcgHwfqVMbFNxqxi7qZ+Rsu1
         F2Ew==
X-Gm-Message-State: AOJu0YzawRyk+53SGBkaGtIbNe8kQHQNJLjUDeK6gRlXzGfOos09cxyG
        F7qhWKKz/lIJo/VUekqAIeD+3wp4SRE=
X-Google-Smtp-Source: AGHT+IEd5v61XzoVq0A62rwjSzBLodEWtJ0EzGsQ7diWTmRZrqfRIFz5ezY13wh1THs9a+DnBIwa+z8BazU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:405c:ba64:810f:5fee])
 (user=surenb job=sendgmr) by 2002:a25:b45:0:b0:d40:932e:f7b1 with SMTP id
 66-20020a250b45000000b00d40932ef7b1mr128068ybl.7.1694705186976; Thu, 14 Sep
 2023 08:26:26 -0700 (PDT)
Date:   Thu, 14 Sep 2023 08:26:11 -0700
In-Reply-To: <20230914152620.2743033-1-surenb@google.com>
Mime-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914152620.2743033-2-surenb@google.com>
Subject: [PATCH 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

As far as the rmap code is concerned, UFFDIO_REMAP only alters the
page->mapping and page->index. It does it while holding the page
lock. However folio_referenced() is doing rmap walks without taking the
folio lock first, so folio_lock_anon_vma_read() must be updated to
re-check that the folio->mapping didn't change after we obtained the
anon_vma read lock.

UFFDIO_REMAP takes the anon_vma lock for writing before altering the
folio->mapping, so if the folio->mapping is still the same after
obtaining the anon_vma read lock (without the folio lock), the rmap
walks can go ahead safely (and UFFDIO_REMAP will wait the rmap walk to
complete before proceeding).

UFFDIO_REMAP serializes against itself with the folio lock.

All other places taking the anon_vma lock while holding the mmap_lock
for writing, don't need to check if the folio->mapping has changed
after taking the anon_vma lock, regardless of the folio lock, because
UFFDIO_REMAP holds the mmap_lock for reading.

There's one constraint enforced to allow this simplification: the
source pages passed to UFFDIO_REMAP must be mapped only in one vma,
but this constraint is an acceptable tradeoff for UFFDIO_REMAP
users.

The source addresses passed to UFFDIO_REMAP can be set as
VM_DONTCOPY with MADV_DONTFORK to avoid any risk of the mapcount of
the pages increasing if some thread of the process forks() before
UFFDIO_REMAP run.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/rmap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index ec7f8e6c9e48..c1ebbd23fa61 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -542,6 +542,7 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	struct anon_vma *root_anon_vma;
 	unsigned long anon_mapping;
 
+repeat:
 	rcu_read_lock();
 	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
 	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
@@ -586,6 +587,18 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	rcu_read_unlock();
 	anon_vma_lock_read(anon_vma);
 
+	/*
+	 * Check if UFFDIO_REMAP changed the anon_vma. This is needed
+	 * because we don't assume the folio was locked.
+	 */
+	if (unlikely((unsigned long) READ_ONCE(folio->mapping) !=
+		     anon_mapping)) {
+		anon_vma_unlock_read(anon_vma);
+		put_anon_vma(anon_vma);
+		anon_vma = NULL;
+		goto repeat;
+	}
+
 	if (atomic_dec_and_test(&anon_vma->refcount)) {
 		/*
 		 * Oops, we held the last refcount, release the lock
-- 
2.42.0.283.g2d96d420d3-goog

