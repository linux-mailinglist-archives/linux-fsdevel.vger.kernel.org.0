Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE2B58E123
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 22:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbiHIUbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245734AbiHIUb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:31:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F4F14020;
        Tue,  9 Aug 2022 13:31:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q30so15513827wra.11;
        Tue, 09 Aug 2022 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Gvs03Ga9APJZNi2iqAGpqdSPimA6hbWAcXkTH65C7Pk=;
        b=mO1mJxafny7G4BQ4u/+K/78a12MfApBzkNOx/Ba5BbkrQPesz1u8oShoxKWz6PEE/j
         UWsEUEQLxDvj70rZbH/IKOv8wGPvcAEwdQ4lkbQWYVK7ZMlwL+EpI7bnOmZBCaqA98lP
         H1ovlBEMwuyreNaVR4BUNtbaI9JAQfcLN+M9VGv/dif4vYGFhQO0E4tl7DsIYRIuMzzp
         lq3L23yLotKCvkw1GkrJiEqC6NlVrVqxKXUKtL31i6rH8XbheEqBkviXJK5V9zmKNk+n
         L6+xNeWnru+pSCpYEOfpv3QrW+FJk9f+fudrQHuXsV8SmgECObGolOHjbb5C15qFLFaW
         Wa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gvs03Ga9APJZNi2iqAGpqdSPimA6hbWAcXkTH65C7Pk=;
        b=4b+tzNpJrQjPoLqE3jkp54HjmfyY92JncUTwmFuXxdDWciyD54e1SEAK4uXaIJZX18
         QviZNfyYROt9myFZvxvnIBVNFhSP0i0IoObsg+e3+cBv+aCKR8yE+Tin+AeUUt8Le7xe
         ua5FNZjJxI1RTWRvwvykkqBYdzi55byqtShIc7AtjXvVwd2kqEGH/OscODZzDibGwgXa
         wVoo2O+CpjCaA1OlyarZNWvWcbJNFmcljgYHMa4lfMR7sbaHFSFx5isuIFDDgFN0hpdk
         uICP9bQImKDlx2CmF15AlXATdw+qwNBdUTJpIyGqPQCyVsmXp4+K535cBeU/jYDD2Gen
         BOdQ==
X-Gm-Message-State: ACgBeo0QmmVAgJE+dPJafQfBnI0FZaXeyq/crHhXwcpleGP+cO3joQUb
        9wf4DSIN8ap+50nGJzXvY7c=
X-Google-Smtp-Source: AA6agR5upLpWunB9poLDBZ8+EEnSNlIq7rwESwBmeLq+ePjuo/eRYRVTtaYIYUGePQbAEx6jyN9EuQ==
X-Received: by 2002:a5d:60c5:0:b0:220:6780:2701 with SMTP id x5-20020a5d60c5000000b0022067802701mr16091672wrt.450.1660077080762;
        Tue, 09 Aug 2022 13:31:20 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id ck15-20020a5d5e8f000000b002205f0890eesm15085263wrb.77.2022.08.09.13.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:31:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
Date:   Tue,  9 Aug 2022 22:31:04 +0200
Message-Id: <20220809203105.26183-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809203105.26183-1-fmdefrancesco@gmail.com>
References: <20220809203105.26183-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Therefore, replace kmap() with kmap_local_page() in bitmap.c.

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfsplus/bitmap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
index cebce0cfe340..bd8dcea85588 100644
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
@@ -84,7 +84,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 			start = size;
 			goto out;
 		}
-		curr = pptr = kmap(page);
+		curr = pptr = kmap_local_page(page);
 		if ((size ^ offset) / PAGE_CACHE_BITS)
 			end = pptr + PAGE_CACHE_BITS / 32;
 		else
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

