Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B493D7BD00D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 22:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344634AbjJHUXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 16:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344591AbjJHUX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 16:23:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637BCB3;
        Sun,  8 Oct 2023 13:23:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405417465aaso37143845e9.1;
        Sun, 08 Oct 2023 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696796605; x=1697401405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GphpI5imAra4MlTQiZu1du23bwIkT93dz+Vpq/IpRZ4=;
        b=dJeejiTlN2rSU8/13wSBo3lCjs5gBiYvdZ2wK7HBOIaVej5ngX8a9iPP9efRePrr3b
         N3Lps3KuZx2/IZGiFul0a/Vz/6sC53RcmradDR0u65nv0f94EOsQCHAkmpMSfSoQ8hRH
         Q/w57OmODJXsMognI3u4BgEQY2GjvpIwiJmFFpanbznzM09ANdutv3MkMN+3oJuQAnlY
         vHz0cwFFpvDGR16Ude7QdCkAMEiEluBCKcrrtvEmkKxSt/aFPEW0Vmdk8hkeLItZU8U0
         rThfQjujFlHTvi7jGmDnRIvg++pDo4QQdNzSklM9OhvICiOlxDzXaPJHHcblMT6wNqYT
         yotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696796605; x=1697401405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GphpI5imAra4MlTQiZu1du23bwIkT93dz+Vpq/IpRZ4=;
        b=iLhoc0iiFrPDabilk9OKrXYtN4vNId7AYnpnwy4dA46ULCNrIyifZwX/SmjJZV0p88
         mkVVBLnWgbzd0umK5jAzx9QXURk/fS6YAV1O+EYEzdoxEeukGLVQVLLnpbIRGu8D2QV2
         Y5pqoo4nuA74XLZPdDa0tadneb4ejmpYk3f8ecGQfhUD9EzggvL1Lye1plaHL05DW88u
         zQgGI2iMkoEenZZq4OL9t17tnT0KhMoi1co5E1ZJcm7BxC40wNzd4eHNof30/dQItj5e
         n13xe7HFrpHGz9m+crIonPkzNKlE99lUpPJDGWiO0oQdEdFcHLVxtsSvZOqFVs8eAuPb
         vcPQ==
X-Gm-Message-State: AOJu0Yxa0cz7Zw2MGEdwyvc/DjOo1+9vQeHLnV5TZzNW3QNSI/EZupau
        K9zVRite35RZLMyTlFh4774=
X-Google-Smtp-Source: AGHT+IFLzkXje9IEvfeVChyj/N8dc9zcG9gS5hukGXOpPqdRcGECy0kYVxH9DGQPH7cdYFKyB/CDNA==
X-Received: by 2002:a05:600c:204f:b0:3fe:3004:1ffd with SMTP id p15-20020a05600c204f00b003fe30041ffdmr12585263wmg.4.1696796604593;
        Sun, 08 Oct 2023 13:23:24 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id c5-20020a05600c0ac500b0040586360a36sm11474879wmr.17.2023.10.08.13.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 13:23:23 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 3/4] mm: abstract merge for new VMAs into vma_merge_new_vma()
Date:   Sun,  8 Oct 2023 21:23:15 +0100
Message-ID: <f38b4333badbdabdb141d5ecc59518f50e5d3493.1696795837.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696795837.git.lstoakes@gmail.com>
References: <cover.1696795837.git.lstoakes@gmail.com>
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

Only in mmap_region() and copy_vma() do we add VMAs which occupy entirely
new regions of virtual memory.

We can share the logic between these invocations and make it absolutely
explici to reduce confusion around the rather inscrutible parameters
possessed by vma_merge().

This also paves the way for a simplification of the core vma_merge()
implementation, as we seek to make the function entirely an implementation
detail.

Note that on mmap_region(), vma fields are initialised to zero, so we can
simply reference these rather than explicitly specifying NULL.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 58d71f84e917..51be864b876b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2530,6 +2530,22 @@ struct vm_area_struct *vma_modify_uffd(struct vma_iterator *vmi,
 			  vma_policy(vma), new_ctx, anon_vma_name(vma));
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
@@ -2885,10 +2901,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
@@ -3430,9 +3445,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
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

