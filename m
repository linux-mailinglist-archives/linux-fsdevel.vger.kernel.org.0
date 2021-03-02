Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C155A32A4F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349960AbhCBLoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbhCBADT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:03:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C4DC06121D
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 16:01:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o9so20514685yba.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 16:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ga+3+HU/1O4PWNGcBy73JW1dDRIoBKvdkJlksQhtYJk=;
        b=uZhxFptRedsgKaKz9OLDGSC/FW+v3PDlF/1VW4uc6WxsSJPdzbOnoaHonj62Tpf2Rp
         9djnZP2FZSRaquC1Z35N7BlgMdnQY+YTOj3lSji670HF0XsnEilodOWgZ3y0Yvz7azqc
         eIHFdcTK0ubG29dgJPKjYXW95boO5NDDIZNy3ZMda6PAMjQisn6LfG1k0JI/gvy0ieab
         aMZ7kckpt2US41i92QXtYfdDShOJJt9G65y9cAbQsCU72ljS2chnl690UVfwkIad3wzM
         G3ENscyoG3eNGlEckLNaECjJMKHGCwPlGDY56IqtzEaKnYAi//P0StXf2J3gu3PcFcnW
         /S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ga+3+HU/1O4PWNGcBy73JW1dDRIoBKvdkJlksQhtYJk=;
        b=NYfUIVSWhbnrarvQNNl0BFLGLlk958CWy15SKAvmdbSKH8qmFP2rRJwQme+nBXDLQe
         uOFnK5rz+h70C8/ekjydObDjty0nOZrWeTy5nV3oXeJK11+gmGiFSjb2q2nCyo5f+vif
         QPJPpYfFZzhhPxBcd0V5CwHDt8BHXQIRzpTj0vXQJMEJsP2/MbgTvfDc4cXy6o22+mfc
         ymnSWbRl5mReh4mX5HlB47gZG9h9hWrIBw62MFb3Wm3XijQnvMoDk0Pt4pZ0B92xHWZA
         IxP4YHVOrztO7s3jChgthyxMkMLHlPWtY06TjYZWwdbWLxeINVlvMfBWcCcqVe4FzQvT
         TSTg==
X-Gm-Message-State: AOAM531Y7Ysgu4UpJeHsIA3LrqR+LNiVbprJtKrwLu2IU9ivOQvuengN
        Z6+eFAZ8kzmaxUiknq8nZ7z+yWDVRcktkU/2Sqxj
X-Google-Smtp-Source: ABdhPJy2fJwEaq8pxSZCQdXMcW7Yms/ycMK7J/aYvRmsWqsh5YosxRt/wHxAvNdhN8dxc4qvYBp3ldGNeoeAhoFzj5wb
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:1998:8165:ca50:ab8d])
 (user=axelrasmussen job=sendgmr) by 2002:a25:aae2:: with SMTP id
 t89mr29309195ybi.63.1614643303192; Mon, 01 Mar 2021 16:01:43 -0800 (PST)
Date:   Mon,  1 Mar 2021 16:01:31 -0800
In-Reply-To: <20210302000133.272579-1-axelrasmussen@google.com>
Message-Id: <20210302000133.272579-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210302000133.272579-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 3/5] userfaultfd/selftests: create alias mappings in the
 shmem test
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
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
 tools/testing/selftests/vm/userfaultfd.c | 29 +++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 859398efb4fe..4a18590fe0f8 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -298,8 +298,9 @@ static int shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
-	unsigned long offset =
-		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+	void *area_alias = NULL;
+	bool is_src = alloc_area == (void **)&area_src;
+	unsigned long offset = is_src ? 0 : nr_pages * page_size;
 
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_SHARED, shm_fd, offset);
@@ -308,12 +309,34 @@ static void shmem_allocate_area(void **alloc_area)
 		goto fail;
 	}
 
+	area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
+			  MAP_SHARED, shm_fd, offset);
+	if (area_alias == MAP_FAILED) {
+		perror("mmap of memfd alias failed");
+		goto fail_munmap;
+	}
+
+	if (is_src)
+		area_src_alias = area_alias;
+	else
+		area_dst_alias = area_alias;
+
 	return;
 
+fail_munmap:
+	if (munmap(*alloc_area, nr_pages * page_size) < 0) {
+		perror("munmap of memfd failed\n");
+		exit(1);
+	}
 fail:
 	*alloc_area = NULL;
 }
 
+static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+{
+	*start = (unsigned long)area_dst_alias + offset;
+}
+
 struct uffd_test_ops {
 	unsigned long expected_ioctls;
 	void (*allocate_area)(void **alloc_area);
@@ -341,7 +364,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
-	.alias_mapping = noop_alias_mapping,
+	.alias_mapping = shmem_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-- 
2.30.1.766.gb4fecdf3b7-goog

