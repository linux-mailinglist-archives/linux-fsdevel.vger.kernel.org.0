Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EC2371F51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 20:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhECSJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhECSJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 14:09:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C0C061351
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 11:07:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v12-20020a25848c0000b02904f30b36aebfso8834967ybk.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DoWXx87b+Num+Reqv5sSHd1wfcUc2x8Dquy/B9+1IoU=;
        b=nvwXd3Q7vwLtpi5zok2xV+bzBipiCzcjLFfLaLjrW3LnM2BxxbcRTwblxJc2oN8Nsj
         k9449XsNR7OXw68xhaizvXpCfBzb5QfIg3A6TRWZi7/5lg9FTL3cHLk3FOvP/X0ZV0Is
         onU3vCJUkeqyL4f/kSilwcEhU95cN5Ud2/M7kRjXHAGJT5zoatWaSYmiRU1dZLLqIrHP
         J3tLvtFtiYW82BuflVjKfw9mtaPXfyBk2ouzNWsdlJj/KkTgLRS+wwn9pU1EnP5nqIry
         hGIYPD3PVyvS3WmKXKbOVxUgXehclcwOqRNYhvSF8K4yp9IUT7EEcH3Dxt/7Jvwdr0g4
         hfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DoWXx87b+Num+Reqv5sSHd1wfcUc2x8Dquy/B9+1IoU=;
        b=CNYnNtZgWHIvZrwe7fQ6SCjAnwRkqwxeUsTHm0GFeCaC7kcQFF4uJUny4d+1qrDlEz
         9UmUHSEUOiAefXuFWv+zB5W18kWvlKAPfXJ7eYvVwwColS6mGeb1uaZjut5FALxuqvCw
         yj0qs8nxYbRrHZNkfCZlI4iCAm1aEbll9bxEE3xAV6waC0FrMLyYEZzoTBowQsIiMD0z
         ZOQzLjdrS6uwPGkW2DTUBdPQKd+zRcR4coA4p/xwvoLb+0jsdMJhelUR6RAtVTUIyWTk
         PPi3SB6+tvDAAg+AqqRTOkLsW9lA6b0fjTb/SLZQFf4DSrm02ulySlrED38P3LmYaTyH
         aCZA==
X-Gm-Message-State: AOAM531HLEESMVMSxqq7Mwpj346gWTBiUbE/jFkdXTCzONKsAOBVFT2w
        NboVddYMKduCIg9j2aIpWVNWvfRtEo3jsZtgmJGK
X-Google-Smtp-Source: ABdhPJwuU013RuhBQO/T92u+GOekQFViLlft8ynCR7Gl8N6K8mV5+xEqVTnMsrhevMFtXctpx6HhHAvJdQpR6qe5zVCL
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:a25:880f:: with SMTP id
 c15mr28912270ybl.373.1620065278099; Mon, 03 May 2021 11:07:58 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:35 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-9-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 08/10] userfaultfd/selftests: create alias mappings in the
 shmem test
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, we just allocated two shm areas: area_src and area_dst. With
this commit, change this so we also allocate area_src_alias, and
area_dst_alias.

area_*_alias and area_* (respectively) point to the same underlying
physical pages, but are different VMAs. In a future commit in this
series, we'll leverage this setup to exercise minor fault handling
support for shmem, just like we do in the hugetlb_shared test.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index fc40831f818f..1f65c4ab7994 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -278,13 +278,29 @@ static void shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
-	unsigned long offset =
-		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+	void *area_alias = NULL;
+	bool is_src = alloc_area == (void **)&area_src;
+	unsigned long offset = is_src ? 0 : nr_pages * page_size;
 
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_SHARED, shm_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
+
+	area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
+			  MAP_SHARED, shm_fd, offset);
+	if (area_alias == MAP_FAILED)
+		err("mmap of memfd alias failed");
+
+	if (is_src)
+		area_src_alias = area_alias;
+	else
+		area_dst_alias = area_alias;
+}
+
+static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+{
+	*start = (unsigned long)area_dst_alias + offset;
 }
 
 struct uffd_test_ops {
@@ -314,7 +330,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
-	.alias_mapping = noop_alias_mapping,
+	.alias_mapping = shmem_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-- 
2.31.1.527.g47e6f16901-goog

