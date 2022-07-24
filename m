Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57D657F71A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Jul 2022 22:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiGXUuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jul 2022 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiGXUuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jul 2022 16:50:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C505F5F57;
        Sun, 24 Jul 2022 13:50:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mf4so17255294ejc.3;
        Sun, 24 Jul 2022 13:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEW8reYFks3BjA/uei7OODsQG86/Vm+hOYTY1ZJoEOk=;
        b=c3Ao8e/TEx56EyUI0FO1HArfhBpFRs59DjER07oLuTdMCLYiXptWYn/2O+4hW97B9X
         jIMZ2Iln15Sf8hBNOF9ZmJJFe6ai+PhZIEo1Aix6sP3e7CFaKpdvq1VK28/irXuaviyk
         4yyBifleGMsbJDnxj8EenNcRPif+6zAyciIemRGb3Ep1qAUq3XD1FHyBHDgikVzmu/zR
         LRbLZ1Rn+E2REVYyssH9sb9+TaJ3OXOF2Zn2XIHQ8gqqm+blg2u+y9dyyXBOs8rnWgQu
         zUy6TL+Na2eRrOHZWAYNJneXdxgsQNGFeDhFRf9LtIV//L2ClrshyuN53JrsYwSK98Hg
         sUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEW8reYFks3BjA/uei7OODsQG86/Vm+hOYTY1ZJoEOk=;
        b=e7A5nxpMADKUxApfaIO8GmNvtShpzrOzpB7koe0KUoGHvlSGMq1vmXYSE5fRhCIgxW
         oi07h+Rxgsk9KCIMjBKsXreLuaG5U6LdHVEmHYgoaArxxVYIYEB9OnONjcbf2t+w/dii
         IR0JZeM2QoC7CdFzSN64L0FHABs6SD1eR2UDA1Dlco9kMg22IKDP7wp6c9y4j8xnsv4S
         1+yZ/dBcytqhwDzLkFFcUM/tVDPI2aEhBZyu1XvPOe60/x35DOf418tC49qx6jRVxklD
         Zs/ju32I/yTlrK+q93mA39VecCjtHt6v+2kUmieAMsIl8b515tto0ncFaQuUAGb7uIRS
         0rgA==
X-Gm-Message-State: AJIora+5HLisxGzoth3aN2+L8xNZmyOpvTnyBhw9AlDZKuLIU+UImFgi
        K9YfCf0yQZgAxDBRjP0UBo9ISi6xlR8=
X-Google-Smtp-Source: AGRyM1s0SewZx182qQ3t2/M8rzYZodr6tnk+hUmXtx/ogJrGtLtWdap98/hWyzCQ/y1R6sVlhxe++w==
X-Received: by 2002:a17:907:2d88:b0:72f:5bb:1ee0 with SMTP id gt8-20020a1709072d8800b0072f05bb1ee0mr7448099ejc.641.1658695813539;
        Sun, 24 Jul 2022 13:50:13 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906314200b0072b3406e9c2sm4542204eje.95.2022.07.24.13.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 13:50:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
Date:   Sun, 24 Jul 2022 22:50:07 +0200
Message-Id: <20220724205007.11765-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

Since its use in bitmap.c is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in bnode.c.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfsplus/bitmap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
index cebce0cfe340..0848b053b365 100644
--- a/fs/hfsplus/bitmap.c
+++ b/fs/hfsplus/bitmap.c
@@ -39,7 +39,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 		start = size;
 		goto out;
 	}
-	pptr = kmap(page);
+	pptr = kmap_local_page(page);
 	curr = pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
 	i = offset % 32;
 	offset &= ~(PAGE_CACHE_BITS - 1);
@@ -74,7 +74,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 			}
 			curr++;
 		}
-		kunmap(page);
+		kunmap_local(pptr);
 		offset += PAGE_CACHE_BITS;
 		if (offset >= size)
 			break;
@@ -127,7 +127,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 			len -= 32;
 		}
 		set_page_dirty(page);
-		kunmap(page);
+		kunmap_local(pptr);
 		offset += PAGE_CACHE_BITS;
 		page = read_mapping_page(mapping, offset / PAGE_CACHE_BITS,
 					 NULL);
@@ -135,7 +135,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 			start = size;
 			goto out;
 		}
-		pptr = kmap(page);
+		pptr = kmap_local_page(page);
 		curr = pptr;
 		end = pptr + PAGE_CACHE_BITS / 32;
 	}
@@ -151,7 +151,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 done:
 	*curr = cpu_to_be32(n);
 	set_page_dirty(page);
-	kunmap(page);
+	kunmap_local(pptr);
 	*max = offset + (curr - pptr) * 32 + i - start;
 	sbi->free_blocks -= *max;
 	hfsplus_mark_mdb_dirty(sb);
@@ -185,7 +185,7 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 	page = read_mapping_page(mapping, pnr, NULL);
 	if (IS_ERR(page))
 		goto kaboom;
-	pptr = kmap(page);
+	pptr = kmap_local_page(page);
 	curr = pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
 	end = pptr + PAGE_CACHE_BITS / 32;
 	len = count;
@@ -215,11 +215,11 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 		if (!count)
 			break;
 		set_page_dirty(page);
-		kunmap(page);
+		kunmap_local(pptr);
 		page = read_mapping_page(mapping, ++pnr, NULL);
 		if (IS_ERR(page))
 			goto kaboom;
-		pptr = kmap(page);
+		pptr = kmap_local_page(page);
 		curr = pptr;
 		end = pptr + PAGE_CACHE_BITS / 32;
 	}
@@ -231,7 +231,7 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 	}
 out:
 	set_page_dirty(page);
-	kunmap(page);
+	kunmap_local(pptr);
 	sbi->free_blocks += len;
 	hfsplus_mark_mdb_dirty(sb);
 	mutex_unlock(&sbi->alloc_mutex);
-- 
2.37.1

