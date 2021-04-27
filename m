Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6336CEF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbhD0Wyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 18:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbhD0Wxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:53:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FB0C061347
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:53:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c8-20020a25a2c80000b02904eda0a22b5dso12516303ybn.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0MvC5tupusYzhdgaolaLRpQ8PyV4lZ/ImbJZgGlOabs=;
        b=UD9B1PD9EF4/Bwq85aduxwK7rowJYh6r/31d4maWYo5P/jjmN0NPvIR56qWNSkcgYZ
         SRRQiyuZiULPRrCrqdwVtCmh1xFyGGmSSnB9MR2SjbBTaK2X/uP9m7mb+ncyj+F93/Bc
         hHZhSwvEzOPWN19Ln+Gy+ck0uEww6TkRxo1d5b3oOyf510VtVuMzmFZOgpixt58g5xTs
         lyYroeYU8goBXIB0bYg6JfXqEhnFgH0Ti+2Ncc97l0dhq3zh5/9s0VjJQqtuTw2GsKjB
         hz5taWikfbWCuRzvH7pUlPsOj+0L6zLSq0ETsBeJqgXig+Uepra47c9ho4nyjIVOFnu7
         ulHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0MvC5tupusYzhdgaolaLRpQ8PyV4lZ/ImbJZgGlOabs=;
        b=KhyG41hyJPIRdoPCxTSgArR/5a5o+R3qT90d0/rYOnFDazC0BmW28yMSgfP+8AYewU
         7Cyr6WMP246Bze98AbxNj8qAmbHiwTCNTz/L7hAPjO6HXacOLjhoD9m+Bar/wrYYfxlb
         eaQiyOYKY55i240+/8bXNfChPYCqSuZdNUZBGD+CTE38Bnfp/NZIa48e7lcHA3ztEUdX
         0uHUpOSBCJmRecpCdjiZKhvWZ8LtobYX1HBeIN0n5RangqrZbBhzAxN/gdqghlZSF5Yx
         9vHnMB0utcc0p5sGxWIbJ2M2pDYcVaqeBwG8u02KzC29YV9lMcc8E62JUQdO6sYbP8fF
         Mw4g==
X-Gm-Message-State: AOAM5311hDCQV0QknROu1TK1vOCNX0N7lJKJtpO1FbG9zpsw+APle4w5
        g7/3cbEiEqr50LuzznKv1KeM5djAs8w2fj34v7BX
X-Google-Smtp-Source: ABdhPJxyeDxtrZNR0i/uwmYsi2L24RU/UpWGHF0s/k7sOiDf4uxXLk9YYpvxrEGEBVr/QNsO1vTdNjkv+W1/l8z/jJ/3
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c423:570b:b823:c33e])
 (user=axelrasmussen job=sendgmr) by 2002:a25:870b:: with SMTP id
 a11mr39561417ybl.498.1619563983153; Tue, 27 Apr 2021 15:53:03 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:52:42 -0700
In-Reply-To: <20210427225244.4326-1-axelrasmussen@google.com>
Message-Id: <20210427225244.4326-9-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 08/10] userfaultfd/selftests: create alias mappings in the
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
2.31.1.498.g6c1eba8ee3d-goog

