Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93726D54C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 00:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjDCW25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 18:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjDCW2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:28:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7B130F5;
        Mon,  3 Apr 2023 15:28:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso20730041wms.1;
        Mon, 03 Apr 2023 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680560925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D59V0g1YvYLKaUmx+LEoYjgFSrxRUczBZA1IoL7nlYU=;
        b=ETUrq2dY/Th4/JHEziKKqYHg+tGm411FZ0fvvHq7s2C38in0y6R3FaxLNn9Kj4sfr5
         hMJgMJxsbvF+BQgibzC+VXG3bGSBAb1bW4IvDlePIroB7DzmvbD6AWL2l9Z+RxPcY2WH
         e3sRnk04MJf9JH+FTi70FLSupZ6xGpBWo6zhyM9EZJ3bUjmIhDmWb96l+t7TFGW18cS4
         XhCagKRR19FhXNYIQfhhdh3fFJuSMOK5zHlYLX6Y/ZnRF/FdaP4FCYLzfxbyA7ummcqS
         lt4TjRqAoKPJLEu67p5KRYcTNockAGGP5JK2eJ2/xlawuQsKJgzPEOO4uoLNh7wk8jwv
         q2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680560925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D59V0g1YvYLKaUmx+LEoYjgFSrxRUczBZA1IoL7nlYU=;
        b=UIOGUYrI5cptsyBsVxcEDel0+U9d7fDepWhniWn/D2I04MIXfGYsH1vsKugXnJY33x
         aiWfasUTSRsAIKtHsJiqj97xsYD+PuU534JUpqoAZQevDHq35qFH9e4rMUqRh7COEGyD
         sPYzjbU5fwST190Z4pBnfKZa7aWGkV2yab7RECsoFQ7HGEY3EwZtkbzOq9zWdp6yJE4C
         5wIXV0tlP6owbBtWVI/AztI0aS7vO4wpMeodfwp96ycsX3lykM/oB3VLxtKCtKmC47bf
         qJNqspofckPKIEhjxJhftsKlXPUFS4bIUwAl4l9TVh5hp0ffM3RviAWldIFQkmqRLHah
         y6rw==
X-Gm-Message-State: AAQBX9dTRWt/OJ7StJXg7zTIQ1H4xi4T9EpofWusQ9fT9e4U+ff3KNnL
        ctEeJe1er3IRrh3mshaqTGoDMDtpwLI=
X-Google-Smtp-Source: AKy350ZVfZY+bYiGepG6A9AZTHxDk2DIr9A7q/H3Bvhr9tEy2Ebxbza9JcTDslpZpvZNO6szjA4rCA==
X-Received: by 2002:a1c:6a19:0:b0:3ed:2ae9:6c75 with SMTP id f25-20020a1c6a19000000b003ed2ae96c75mr593443wmc.37.1680560925406;
        Mon, 03 Apr 2023 15:28:45 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id u17-20020a05600c19d100b003dd1bd0b915sm20731309wmq.22.2023.04.03.15.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:28:44 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH 3/3] mm: perform the mapping_map_writable() check after call_mmap()
Date:   Mon,  3 Apr 2023 23:28:32 +0100
Message-Id: <c814a3694f09896e4ec85cbca74069ea6174ebb6.1680560277.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680560277.git.lstoakes@gmail.com>
References: <cover.1680560277.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order for a F_SEAL_WRITE sealed memfd mapping to have an opportunity to
clear VM_MAYWRITE, we must be able to invoke the appropriate vm_ops->mmap()
handler to do so. We would otherwise fail the mapping_map_writable() check
before we had the opportunity to avoid it.

This patch moves this check after the call_mmap() invocation. Only memfd
actively denies write access causing a potential failure here (in
memfd_add_seals()), so there should be no impact on non-memfd cases.

This patch makes the userland-visible change that MAP_SHARED, PROT_READ
mappings of an F_SEAL_WRITE sealed memfd mapping will now succeed.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c96dcce90772..a166e9f3c474 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2596,17 +2596,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
-		if (is_shared_maywrite(vm_flags)) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
 		vma->vm_file = get_file(file);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
+		if (vma_is_shared_maywrite(vma)) {
+			error = mapping_map_writable(file->f_mapping);
+			if (error)
+				goto unmap_and_free_vma;
+		}
+
 		/*
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
-- 
2.40.0

