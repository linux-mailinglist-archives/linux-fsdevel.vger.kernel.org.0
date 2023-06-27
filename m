Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E71C73F34C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjF0EXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjF0EXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:23:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A91D172A
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56938733c13so52688747b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687839816; x=1690431816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bqEyfDb2JHBciJ5X1JfWPHzjf7SmvaClBSwV4xMi6U=;
        b=OvvulEsWmawhmtqOLDyG7NX+8MMLCKyrPheIcVIJBGuloUk350HzepAZTTg9GSNFTq
         Zxyei2vg/f2B5jkrZYoGKPbRxvuLjH35sLV4l1wOBTJafVD0HTbDUzbP6jPQfOdU+KaG
         3gIkRMxtJ9DgS5SW0Kt3bWfeu+sXaplrrhq1B7dNLrmsE2meL4KQdekBOG7sWz0zAe0N
         lkYsG+/en/JT0DT8eW/ip3lW+AyM8tArkN2trbjAuP+aG5gijB434ikFW3ucpom8cFWS
         1HC6TfIWomgbHMNnYthALNU+Ilov/TeO7Y284bIljOOAHiqgvbBCXiM9wMHeW6Wjn6nD
         V8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687839816; x=1690431816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bqEyfDb2JHBciJ5X1JfWPHzjf7SmvaClBSwV4xMi6U=;
        b=B2CBOc+Atiw2/VxurwafPxxYllYYzKjvOdAFqzak236O3pjzplFttDB6gBe8YzW5QF
         tlolO9CIhkg4WMVApAckegekFGn7LXU1Hiz6KoODWzxQob9R8hPu+9cW4B2qCK2pY0uf
         u5cLUz8i5x0mO+EKpmdDhmyWBlESwQoMwg5tgXb7Sb0A+V9NULIjmItqwdNB2OBDvGTO
         3uNTh2Hw1ZwtS+8LxFMcASOAvtytmi4auo+032umTuuCa09wjXGMmf+Wc15nXYClktHM
         wVRWEcoS9tLgUnIimJQyRrs29f9lKdOpyXAGDRqgPHCw6SOUTtucmoPvjq8MWTasU89C
         Gbbw==
X-Gm-Message-State: AC+VfDy4H5OrqfYxR13nYxKV7jpAjd0RqQy4quqg3mLWzBwuGEU8bkQD
        bBqMSkYXeEUHCqaF1IlJqYj7Si6WP0I=
X-Google-Smtp-Source: ACHHUZ6bk8wsxPi2CO6Ry//dDv3J6w7VSpDN0W+ynAgt0XYXbCETpv309cOV7KiQRlvOMURiMuow8VTWjRU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a25:d3c8:0:b0:bac:adb8:a605 with SMTP id
 e191-20020a25d3c8000000b00bacadb8a605mr6458407ybf.2.1687839815785; Mon, 26
 Jun 2023 21:23:35 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:23:18 -0700
In-Reply-To: <20230627042321.1763765-1-surenb@google.com>
Mime-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627042321.1763765-6-surenb@google.com>
Subject: [PATCH v3 5/8] mm: make folio_lock_fault indicate the state of
 mmap_lock upon return
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

folio_lock_fault might drop mmap_lock before returning and to extend it
to work with per-VMA locks, the callers will need to know whether the
lock was dropped or is still held. Introduce new fault_flag to indicate
whether the lock got dropped and store it inside vm_fault flags.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_types.h | 1 +
 mm/filemap.c             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 79765e3dd8f3..6f0dbef7aa1f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1169,6 +1169,7 @@ enum fault_flag {
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
 	FAULT_FLAG_VMA_LOCK =		1 << 12,
+	FAULT_FLAG_LOCK_DROPPED =	1 << 13,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
diff --git a/mm/filemap.c b/mm/filemap.c
index 87b335a93530..8ad06d69895b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1723,6 +1723,7 @@ vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
 			return VM_FAULT_RETRY;
 
 		mmap_read_unlock(mm);
+		vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
 		if (vmf->flags & FAULT_FLAG_KILLABLE)
 			folio_wait_locked_killable(folio);
 		else
@@ -1735,6 +1736,7 @@ vm_fault_t __folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
 		ret = __folio_lock_killable(folio);
 		if (ret) {
 			mmap_read_unlock(mm);
+			vmf->flags |= FAULT_FLAG_LOCK_DROPPED;
 			return VM_FAULT_RETRY;
 		}
 	} else {
-- 
2.41.0.178.g377b9f9a00-goog

