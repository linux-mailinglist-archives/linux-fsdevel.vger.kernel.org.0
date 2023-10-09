Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68ED7BEC12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 22:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378146AbjJIUyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 16:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378131AbjJIUxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:53:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A56DA;
        Mon,  9 Oct 2023 13:53:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405524e6768so48373465e9.2;
        Mon, 09 Oct 2023 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696884819; x=1697489619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peKTa5JCQROacC2rkKD/EMjKt2/PWD6RJuctYYclWYk=;
        b=mfgEsJ+AeOapng4RmufLLmrtrfGoffxSMqILk521+uVLk+EgUUV2gYuK9mRLMGD2if
         9JLL34I53sVmrtRdYpERy5MvOT6Fe+7MMnQpzTOnebBHFtp/iPtUbDkRf6C6ddUL03Nb
         nk0DMLpz/cPxPZqXVG4JWZ8o2Kha7fpPocLEwzG9nmt/7igq/ySf6pXO/oDSBYl2i5Al
         dxNw6a8HaAKFuRpunZ+3frBXSSPfDjbAnxPT/+mtwoO1eqtYVb3MxcJSQ4nMgTs2XGpt
         4/jIk926E2SPZ/lEaKQkeChYfzFtUhOm0sUt0c/CeYyP4BKjAH5F+YyXR6vvxRw3p3eM
         n1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884819; x=1697489619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peKTa5JCQROacC2rkKD/EMjKt2/PWD6RJuctYYclWYk=;
        b=vXznFh2IR2voOis+cJ5IR3hqPUBpjzVYmLaZAPsHg6julclyQeQuf90OxWIPxkeuRn
         z6Ycu40UQrjOBH4z2dn2z8Z9lnG2XVLtUwjdpc/2S6+u4Yy3UGkBqyx77dT7LCpXYb3A
         /9Czid9903he/+ME/jJ4aw3qE6FtDCtZdsYcDAvB8kuYmuCQ3lwnL2O8mSc/7JFOKrLS
         hfIHJwKEAxOy2FRdV2g9kMlRud6U7klOoesJDdmOtXZY6d4gHbiXUxnjtpLr6u3u5vSz
         UTk3xCzTc8QvXCDR3QEXqNOHrfdIA1cVcLf498IHX6p9gPRyw54T8d2u6DoRumE+bQM5
         61Cg==
X-Gm-Message-State: AOJu0YxtAUgoPV13T2y+eBLECIuvDBFnbpUN22RiukCD3MAzQP45Zuic
        FaMbjvJJzb08w49G+NbP+Fg=
X-Google-Smtp-Source: AGHT+IECOr/NuIGQT0xwu1GNnQ3mzgM7UNNwWg6rN1KgZwpIM+meh3t/4/xhAlA92IoCFh4rHNSa8g==
X-Received: by 2002:adf:a4c1:0:b0:32c:a9ac:2bc1 with SMTP id h1-20020adfa4c1000000b0032ca9ac2bc1mr216695wrb.63.1696884818605;
        Mon, 09 Oct 2023 13:53:38 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id l2-20020a5d4802000000b0031fe0576460sm10578130wrq.11.2023.10.09.13.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:53:37 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 4/5] mm: abstract merge for new VMAs into vma_merge_new_vma()
Date:   Mon,  9 Oct 2023 21:53:19 +0100
Message-ID: <8525290591267805ffabf8a31b53f0290a6a4276.1696884493.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696884493.git.lstoakes@gmail.com>
References: <cover.1696884493.git.lstoakes@gmail.com>
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

Only in mmap_region() and copy_vma() do we attempt to merge VMAs which
occupy entirely new regions of virtual memory.

We can abstract this logic and make the intent of this invocations of it
completely explicit, rather than invoking vma_merge() with an inscrutable
wall of parameters.

This also paves the way for a simplification of the core vma_merge()
implementation, as we seek to make it entirely an implementation detail.

Note that on mmap_region(), VMA fields are initialised to zero, so we can
simply reference these rather than explicitly specifying NULL.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 17c0dcfb1527..33aafd23823b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2482,6 +2482,22 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
 	return NULL;
 }
 
+/*
+ * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
+ * must ensure that [start, end) does not overlap any existing VMA.
+ */
+static struct vm_area_struct *vma_merge_new_vma(struct vma_iterator *vmi,
+						struct vm_area_struct *prev,
+						struct vm_area_struct *vma,
+						unsigned long start,
+						unsigned long end,
+						pgoff_t pgoff)
+{
+	return vma_merge(vmi, vma->vm_mm, prev, start, end, vma->vm_flags,
+			 vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
+			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2837,10 +2853,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vma_merge(&vmi, mm, prev, vma->vm_start,
-				    vma->vm_end, vma->vm_flags, NULL,
-				    vma->vm_file, vma->vm_pgoff, NULL,
-				    NULL_VM_UFFD_CTX, NULL);
+			merge = vma_merge_new_vma(&vmi, prev, vma,
+						  vma->vm_start, vma->vm_end,
+						  pgoff);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3382,9 +3397,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
-			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
-- 
2.42.0

