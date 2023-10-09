Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004D27BD3A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 08:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345315AbjJIGmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 02:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345308AbjJIGmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:42:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15BACA
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 23:42:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8040b2ffso66586907b3.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696833757; x=1697438557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMzA+bY5iQ55icqv7/c58xVjlf8IiONnVGODeN5A6AA=;
        b=bVDwtzWtwc1VM4vQGrACZvNw57uyX10S4ICovNdmKLlGBwAwXVt37DKrZ8fYdL+i6s
         hg/S5stmKoEql8LybZzVlqpG+Pz9UQvORdFX+wTv3OyhcHlW9NQOhkjkHl/iS0EDhb6H
         SZ0UO1RKmg//m24u1crbacIuBCwM3kvDIs2NR73ct6bSeVuTPW1YmQhujjjHuBBWRbXp
         ozrIQXnECsYK0I2maQFKV7syjcTk9GXMjfKYsNNe4Se2e9YdbXQ21H9zkxX7UpKjYAa/
         JKzmQAjBHM13eetlwt1Dz5TWT7ccI94TsKSumlFFdfTLpWG6eQpJqd+QonllWgCYVoOB
         7Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696833757; x=1697438557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMzA+bY5iQ55icqv7/c58xVjlf8IiONnVGODeN5A6AA=;
        b=hr4pdbPqhUKSRq10HfPjHySmLzgg6EhzsjTYPelDANdZWmxzjgKDu2wSt6ykrhB8xt
         FdEor/LEIGt69Yz81orF5p1dR2fHt8HJzDKZOKyAXs4p/p71fmpk8DSZPzQQFml7+Umr
         IrXMuNrpwTInZ1GDlejeNQsaxqfri2Q0Nljn/98YCdKDjFmQ4TGBRmwpx8CQ7ZR8OoE4
         tg9ce5kdYj2xxVckeLHD2+nUpUYcNrAi6rU6KLe10IMbZ6HLztQSzsr3TynEvKM6faiG
         L7J+tq+m04nvbDZLknVzMBvtWecUqG4iu+XDr6zkckQO9Hcc3lrewLkXVONSATLlM+Ns
         cETQ==
X-Gm-Message-State: AOJu0Yy9KXotgUZaSDxac1eKCQ21yziXnAsCpouk4BZJoQBwoVZdJu3m
        RMfQwI6inWyrirXIRjhi5/Cr1Sph+z4=
X-Google-Smtp-Source: AGHT+IFtPbkNFD9Rxrba570q5f/tqYHiGOqoU9c9uHOquBYgh1LiUto5yoJwsPheCUdVazB3Qxt4pauoLww=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3e83:601e:dc42:a455])
 (user=surenb job=sendgmr) by 2002:a81:a809:0:b0:59b:ebe0:9fce with SMTP id
 f9-20020a81a809000000b0059bebe09fcemr261242ywh.5.1696833757037; Sun, 08 Oct
 2023 23:42:37 -0700 (PDT)
Date:   Sun,  8 Oct 2023 23:42:26 -0700
In-Reply-To: <20231009064230.2952396-1-surenb@google.com>
Mime-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231009064230.2952396-2-surenb@google.com>
Subject: [PATCH v3 1/3] mm/rmap: support move to different root anon_vma in folio_move_anon_rmap()
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

For now, folio_move_anon_rmap() was only used to move a folio to a
different anon_vma after fork(), whereby the root anon_vma stayed
unchanged. For that, it was sufficient to hold the folio lock when
calling folio_move_anon_rmap().

However, we want to make use of folio_move_anon_rmap() to move folios
between VMAs that have a different root anon_vma. As folio_referenced()
performs an RMAP walk without holding the folio lock but only holding the
anon_vma in read mode, holding the folio lock is insufficient.

When moving to an anon_vma with a different root anon_vma, we'll have to
hold both, the folio lock and the anon_vma lock in write mode.
Consequently, whenever we succeeded in folio_lock_anon_vma_read() to
read-lock the anon_vma, we have to re-check if the mapping was changed
in the meantime. If that was the case, we have to retry.

Note that folio_move_anon_rmap() must only be called if the anon page is
exclusive to a process, and must not be called on KSM folios.

This is a preparation for UFFDIO_MOVE, which will hold the folio lock,
the anon_vma lock in write mode, and the mmap_lock in read mode.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/rmap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index c1f11c9dbe61..f9ddc50269d2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -542,7 +542,9 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	struct anon_vma *root_anon_vma;
 	unsigned long anon_mapping;
 
+retry:
 	rcu_read_lock();
+retry_under_rcu:
 	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
 	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
 		goto out;
@@ -552,6 +554,16 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
 	root_anon_vma = READ_ONCE(anon_vma->root);
 	if (down_read_trylock(&root_anon_vma->rwsem)) {
+		/*
+		 * folio_move_anon_rmap() might have changed the anon_vma as we
+		 * might not hold the folio lock here.
+		 */
+		if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
+			     anon_mapping)) {
+			up_read(&root_anon_vma->rwsem);
+			goto retry_under_rcu;
+		}
+
 		/*
 		 * If the folio is still mapped, then this anon_vma is still
 		 * its anon_vma, and holding the mutex ensures that it will
@@ -586,6 +598,18 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	rcu_read_unlock();
 	anon_vma_lock_read(anon_vma);
 
+	/*
+	 * folio_move_anon_rmap() might have changed the anon_vma as we might
+	 * not hold the folio lock here.
+	 */
+	if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
+		     anon_mapping)) {
+		anon_vma_unlock_read(anon_vma);
+		put_anon_vma(anon_vma);
+		anon_vma = NULL;
+		goto retry;
+	}
+
 	if (atomic_dec_and_test(&anon_vma->refcount)) {
 		/*
 		 * Oops, we held the last refcount, release the lock
-- 
2.42.0.609.gbb76f46606-goog

