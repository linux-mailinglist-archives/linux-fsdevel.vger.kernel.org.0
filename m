Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73BC35907D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 01:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhDHXoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhDHXnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:43:55 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5252C0613DD
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 16:43:42 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h19so2318085qkk.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y+JvwE75GgC5IEnxBEL5JZdrd4moWn3oGAIMC9oxZzA=;
        b=b/Wf0aWC0cG4uYtiJ9VGNFi97zqNT9Ig+q0z8hJw5s/xOlRJa684gjh0V8qqomB2hT
         WZjORDQCX/pDQ55Cwv1jH16lar+FcyZ2vaPUk0rh2HvTC7b8YB5MmaF//T3tfeb+x2td
         JMnCPZB4qJdEjs7H2ZkHdPqpk7dnjRmmNhaw+6Ew6iWTJj8i+SIvUDgPZOmKroyePa89
         1NgNFkaKLMIY1jrnTGDVjJe8QDstJmISDtvNakCMHgwf6XY8hHdhFknhKyzHFyDdmLUS
         ypL/ntHQIoQFWGz93HcNIfHYekI5Lx0IpVSxBIjd97QoazXIugagpeCJW95g1Zqq9kuA
         ew7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y+JvwE75GgC5IEnxBEL5JZdrd4moWn3oGAIMC9oxZzA=;
        b=CQENcj/pYAJzi0xJsHf1UUl+SO6q4GPhMiXlu59XbQM895vgyjTgkjoHWlNhsrYiH2
         yDQZFQ8mrBVJ4TMTMZTvFK/erM/03QCzywi0fi/4zRrSkEYM0KRE+Z/a9IRTP4QKkOKu
         KQ32nd4H2c+hNXTk4+TfEh6lexvZXWbXDBAu7xxhDnOe7movIBRiMfm7IZ5b6nWefbJv
         CtO3CwktlQh/lZsPj4lgVHi294ywCerX5/C5EGxAJnPB69GFUw9ljFhgTafuQs25f2Ez
         70Da3A2+SyosBtkmxzjqOy+XdknZY7/JC8hU1ovDxtvJhbxw3iZsghGCnSK0snfSUObD
         Zx5w==
X-Gm-Message-State: AOAM530usODbMrjrvSDUWk3pASGQ3P3EVUuDCzHq1ZeSarqz3IFNa6rL
        A2H/a9YQMRLoNvPsbzqaHE4OzLsF8Lve3DDj5WAC
X-Google-Smtp-Source: ABdhPJxtFO9U8LecU3todxiWF7PRcHx+2Dtw3lc++CgfpcE8LU8WsLyqSI3lld0UepwP7rjyD+Pf92LrC1DzWayxE4DM
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d06:d00f:a626:675a])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:7e4:: with SMTP id
 bp4mr11257020qvb.5.1617925422072; Thu, 08 Apr 2021 16:43:42 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:43:24 -0700
In-Reply-To: <20210408234327.624367-1-axelrasmussen@google.com>
Message-Id: <20210408234327.624367-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 6/9] userfaultfd/selftests: create alias mappings in the shmem test
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
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

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index b0af88b258d7..4b49b2cf9819 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -279,13 +279,29 @@ static void shmem_release_pages(char *rel_area)
 
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
@@ -315,7 +331,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
-	.alias_mapping = noop_alias_mapping,
+	.alias_mapping = shmem_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-- 
2.31.1.295.g9ea45b61b8-goog

