Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6033DB4D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhG3ID4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbhG3IDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:03:36 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B234C0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 01:03:20 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id t66so8702470qkb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MGzbYcDH1nDg768HY0nxSbDVEpHf6CaY6eKAkj1Bcno=;
        b=o9CkvmfR1TcmeOk6LOKvzvte8hfyZYPrZSw2A7Wzr6ScvLcANBE/Yoki51+w9yX2f6
         LVZpGnEbwEkqt7Hnt4+bRy/6x7vHr//wG299GJtb3ki0DosAuUEDfoNE2XtI+uUhKWo8
         JHPPLfpx8KtKArXuCe/nuOYN+WbhwkFd6C/is1BOTenZhPT2ltWUzirXBxTvUZUS+Eth
         QpoRVlzDTTDqPnJEkTWpSHqLZy5XfvU0CnPupILljD14KkG6MGijbWyMZkjws6psWPKu
         It373FYdIqlePn1A4XbdCWvefbcGFvZ9tg5krXyxfwhlI9Zg4rXj4U19/DZ057wpLO/T
         RdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=MGzbYcDH1nDg768HY0nxSbDVEpHf6CaY6eKAkj1Bcno=;
        b=hoI5ul8DMsHyKIw1K37854Mdt4EHwrkq0saTQrLTYisu6qZtNbg2+Eu0abOz7AhgHQ
         0MAFVujfIPj8B2Q4Mgzlfda6AYSpv6gkyc+Q1T2p/uHdXeXROJU0kp2RPZ64Eae//9Pu
         fwODBwAq5nGcmczM2t6btoY93MU7nq93hN5Bq4cq3Hxop3B3/gji6qIDhgtF95f1EoIt
         OqlBwoIFsKEDmmApCqPy+3S9RSodnnZRzHjKqQd++V1sf+f/+j97gSjdR+9/rvOJ/0Y6
         +TUqdK109urGYhHzbPQ/hcj0EzJpDqVbqs70pXzpZJlEEDzJu5w3Z4/GVsVfuQygk385
         kQNQ==
X-Gm-Message-State: AOAM530n9YgXL+yW4e8Dh5NHYO3qx4DpSgykIofLn7pBSmXg7QyFh6h2
        FrQJQ5jASj8O4gMtdVpsmpud6Q==
X-Google-Smtp-Source: ABdhPJykYS4oamptTpmIT6dFsy8t5YJDFW4VgtJtNRS/my2z80sEMhOQ8L7GnOEOo0Fymj/Aya18fA==
X-Received: by 2002:a37:4042:: with SMTP id n63mr1074442qka.425.1627632199330;
        Fri, 30 Jul 2021 01:03:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y9sm316166qtw.51.2021.07.30.01.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 01:03:18 -0700 (PDT)
Date:   Fri, 30 Jul 2021 01:03:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 13/16] mm: bool user_shm_lock(loff_t size, struct ucounts
 *)
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <dd2669c8-dcbe-c3d3-5ddb-11b84aa5b81@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

user_shm_lock()'s size_t size was big enough for SysV SHM locking, but
not quite big enough for O_LARGEFILE on 32-bit: change to loff_t size.
And while changing the prototype, let's use bool rather than int here.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm.h |  4 ++--
 mm/mlock.c         | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..f1be2221512b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1713,8 +1713,8 @@ extern bool can_do_mlock(void);
 #else
 static inline bool can_do_mlock(void) { return false; }
 #endif
-extern int user_shm_lock(size_t, struct ucounts *);
-extern void user_shm_unlock(size_t, struct ucounts *);
+extern bool user_shm_lock(loff_t size, struct ucounts *ucounts);
+extern void user_shm_unlock(loff_t size, struct ucounts *ucounts);
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
diff --git a/mm/mlock.c b/mm/mlock.c
index 16d2ee160d43..7df88fce0fc9 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -813,21 +813,21 @@ SYSCALL_DEFINE0(munlockall)
 }
 
 /*
- * Objects with different lifetime than processes (SHM_LOCK and SHM_HUGETLB
- * shm segments) get accounted against the user_struct instead.
+ * Objects with different lifetime than processes (SHM_LOCK and SHM_HUGETLB shm
+ * segments and F_MEM_LOCK tmpfs) get accounted to the user_namespace instead.
  */
 static DEFINE_SPINLOCK(shmlock_user_lock);
 
-int user_shm_lock(size_t size, struct ucounts *ucounts)
+bool user_shm_lock(loff_t size, struct ucounts *ucounts)
 {
 	unsigned long lock_limit, locked;
 	long memlock;
-	int allowed = 0;
+	bool allowed = false;
 
 	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
 	if (lock_limit == RLIM_INFINITY)
-		allowed = 1;
+		allowed = true;
 	lock_limit >>= PAGE_SHIFT;
 	spin_lock(&shmlock_user_lock);
 	memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
@@ -840,13 +840,13 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
 		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 		goto out;
 	}
-	allowed = 1;
+	allowed = true;
 out:
 	spin_unlock(&shmlock_user_lock);
 	return allowed;
 }
 
-void user_shm_unlock(size_t size, struct ucounts *ucounts)
+void user_shm_unlock(loff_t size, struct ucounts *ucounts)
 {
 	spin_lock(&shmlock_user_lock);
 	dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, (size + PAGE_SIZE - 1) >> PAGE_SHIFT);
-- 
2.26.2

