Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD99F7BC9DF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbjJGUvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 16:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344180AbjJGUvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:51:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE893;
        Sat,  7 Oct 2023 13:51:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32003aae100so2663451f8f.0;
        Sat, 07 Oct 2023 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696711873; x=1697316673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R/SPrp+9X8K4zqdkQ2nu1IGtJt6e/ubH1aV+LRG8uo=;
        b=cZfbV49/owq2IZis6MxULDn/VPdCTmrw6fvoNcQwk9O6jniLVimzHHp5rf2k0h9qI6
         +37ciYjDill9y9n+PFryG9O5PJ9MqxUpVJz0kOFjB9/POOuXqFiO1iQBbVPiiWNqrgMd
         RkeDDTnAQE4BMT2TRwEfHS7QgvCGrNddiHHtoCzoIOu2Lddcx362S5xn4RP2PQ/6c6k0
         pqAblOpX3xDWbsv01txeebfO+dhr8mg2EegTUKaVhpwp0RiSQazhBIZ8rJBtRgP6t5Jh
         YlGMb9CaebZlBQUktQ8Rqzt50uFuov8LcMfRA0lE1S0j/zmMVMuRnrLWPKDykrcccfZP
         GwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696711873; x=1697316673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R/SPrp+9X8K4zqdkQ2nu1IGtJt6e/ubH1aV+LRG8uo=;
        b=uWKhNqdnKRzLDiV5j+1a+chbm0WJmYTUhBTVHDQsbWWle6V/8Bs+Xac/QEz5RrKzxC
         E7F21Imo2ra+LBW4k9nZVZp6TEUtBSbxPEOlra3kwz/7mZ7f7ANPcczZT10+bxWIcHzQ
         o1VXetFsULFgPb8nXW+zXBF5nOLpd0SsYhx6GvuNYlnWU6d/XMJWMlt/aDn/s/7Y4cCO
         EfTSYqMzccXXo5OYbZrAEzrfb1qKrjtvW+//p1Q/Rg88MHpQFcY9V/8yljJU+BI8msUc
         YgBrYDG58HiAlJ4v6ZpfBZVzL0Hqa00Rchzz8ihnwjkRQKO4yUkHyB63I79CkCP0M8Zj
         YW3g==
X-Gm-Message-State: AOJu0Yy8tSHdS/Py9vIxau+EVfpKIvthFFjj2RkZBXaGAZAaDdwg60GE
        y6hIWGe+Y+vyn/TuQYHa3UQ=
X-Google-Smtp-Source: AGHT+IEgDkt6GkwlLJ9aqmEH7QCFmGhtBxHyfp4ayq2b9oWhbpAMnmJ+7jpgidaqVh/T1j6p5PGJPg==
X-Received: by 2002:a5d:4805:0:b0:314:3369:df57 with SMTP id l5-20020a5d4805000000b003143369df57mr6970810wrq.5.1696711872784;
        Sat, 07 Oct 2023 13:51:12 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id g7-20020adfe407000000b003232d122dbfsm5120550wrm.66.2023.10.07.13.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 13:51:11 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 3/3] mm: enforce the mapping_map_writable() check after call_mmap()
Date:   Sat,  7 Oct 2023 21:51:01 +0100
Message-ID: <d2748bc4077b53c60bcb06fccaf976cb2afee345.1696709413.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696709413.git.lstoakes@gmail.com>
References: <cover.1696709413.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order for an F_SEAL_WRITE sealed memfd mapping to have an opportunity to
clear VM_MAYWRITE in seal_check_write() we must be able to invoke either
the shmem_mmap() or hugetlbfs_file_mmap() f_ops->mmap() handler to do so.

We would otherwise fail the mapping_map_writable() check before we had
the opportunity to clear VM_MAYWRITE.

However, the existing logic in mmap_region() performs this check BEFORE
calling call_mmap() (which invokes file->f_ops->mmap()). We must enforce
this check AFTER the function call.

In order to avoid any risk of breaking call_mmap() handlers which assume
this will have been done first, we continue to mark the file writable
first, simply deferring enforcement of it failing until afterwards.

This enables mmap(..., PROT_READ, MAP_SHARED, fd, 0) mappings for memfd's
sealed via F_SEAL_WRITE to succeed, whereas previously they were not
permitted.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217238
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6f6856b3267a..9fbee92aaaee 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2767,17 +2767,25 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
-		if (is_shared_maywrite(vm_flags)) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
+		int writable_error = 0;
+
+		if (vma_is_shared_maywrite(vma))
+			writable_error = mapping_map_writable(file->f_mapping);
 
 		vma->vm_file = get_file(file);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
+		/*
+		 * call_mmap() may have changed VMA flags, so retry this check
+		 * if it failed before.
+		 */
+		if (writable_error && vma_is_shared_maywrite(vma)) {
+			error = writable_error;
+			goto close_and_free_vma;
+		}
+
 		/*
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
-- 
2.42.0

