Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B36F2B59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 00:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjD3W0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 18:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjD3W0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 18:26:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B36E4F;
        Sun, 30 Apr 2023 15:26:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f87c5b4635so1749710f8f.1;
        Sun, 30 Apr 2023 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682893605; x=1685485605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU5klj4JuCtxBh6JR6WjnJXM2yce7ELIzVSpcWZL9RY=;
        b=VXNNdRhLqJDygRRWBenMw/2sboDt9lMxswc9Klc7vyZ7DUUY8PsRrW4VYJXOKcH18t
         qlCJf2sRfxtVrN7OzpZbclacR5lQtGV6yIVIuJ2NYAMZlpbayLltwRM8D6ieUfN6+jkC
         FjJMWW2TRyK4N4hEBJ0pllZrGFeL40h545zok0J472IxJ/QO7vIlbUB716nHnopqBlYT
         AU9clybB/l7GCTu17p2ip6WlBxT18xR8ZMTJtAAINBnTkPXLceuKXkyumwE13HR/zkw0
         FQBZimSmFtGej5L5shtV9NLrlZgp5R7ELWLyd7VcsucF2yrHASTmMy4DhE48LvmZWGDv
         Hfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682893605; x=1685485605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gU5klj4JuCtxBh6JR6WjnJXM2yce7ELIzVSpcWZL9RY=;
        b=B8N3Ca6449HJNpoeH4LsML0/NC8YO3cGlSHSsb1D55/KOd1LewPQpuXywT5GDqABXS
         tLVq2K0o13EyAYSo3CFr0kvKVQJnS23HWn+jDJ3Brpz+5G0QEROf8zU/CUcp9UgtXV0m
         l5PlY8ZEbXuDgR/FKQsqGDVu/MEIEYnuwmW1tKHOPulm+j2q5FxBsVGQ4iD4OJBHs1Qr
         AhI3YPy8yBqUwTMyL9HvpXNG8/Im/nkTE6+KDJzmEw5sVlsk71TqRFtj+vIZ7WMCTdDc
         i+Ht75zIhS2FS9divxHKnwwUp1ivmeZlk/JcRllBx6F03K8Iks/YDKV8F7Rbcw3a0T2p
         WpoQ==
X-Gm-Message-State: AC+VfDx24mJDWRd0L0racLid7KnSo2bUzhzSrXvB3dsmvb1AlsjudUIZ
        +aGbwZz0h/jX2Czvj1x9qcY=
X-Google-Smtp-Source: ACHHUZ5v8qXYw3hgXK16jHy+ni2ikKLOkyTRyqZ3qFWlrvR4D0x5Vzd2irHeayWjLHt2m0/NfaYC3w==
X-Received: by 2002:adf:db8e:0:b0:2fe:f2d1:dcab with SMTP id u14-20020adfdb8e000000b002fef2d1dcabmr8764207wri.58.1682893605108;
        Sun, 30 Apr 2023 15:26:45 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id g2-20020a5d5402000000b002da75c5e143sm26699865wrv.29.2023.04.30.15.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 15:26:44 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 3/3] mm: perform the mapping_map_writable() check after call_mmap()
Date:   Sun, 30 Apr 2023 23:26:07 +0100
Message-Id: <6f3aea05c9cc46094b029cbd1138d163c1ae7f9d.1682890156.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1682890156.git.lstoakes@gmail.com>
References: <cover.1682890156.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217238
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 646e34e95a37..1608d7f5a293 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2642,17 +2642,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
+				goto close_and_free_vma;
+		}
+
 		/*
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
--
2.40.1
