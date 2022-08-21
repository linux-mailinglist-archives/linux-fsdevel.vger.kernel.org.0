Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDFC59B5D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiHUSLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 14:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiHUSLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:11:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404AE1F61C;
        Sun, 21 Aug 2022 11:11:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ca13so6099332ejb.9;
        Sun, 21 Aug 2022 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=n3IGQijfwjjT16DNWgVaC6YqoBuwArJBqNAWrQW3JW0=;
        b=MBx7PGIKwgNrozehT8oLgpl0Hr2CUm5Qn9Xm5L7kKZZAlG/yrEjuLXhd/wpkYxLHRi
         SnOF4cgeFKetPPzsaC+JAUkjlZceBHI2FcLvMBS2bWUhshxKn51YBAsVGGVzkZ3/FH4Q
         2vlj7jzWsO4/i/3UcA66X6edvoFqQAaXU+CFgW6/5187576M65W1oQ4VhEJIOsUBlmmh
         Osji80nDWzds+QsmhWghV+ECtlvUhrpqmueUDb6UfLyRjC9O8pDt8Tp9GiMB2fXSpbLx
         buEv+yG09ZgvlYDTeYYodYD34N2CInWpiVQQzu74yPnB5nwPUaFmYqSVEEEuMNbpfUvO
         0RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=n3IGQijfwjjT16DNWgVaC6YqoBuwArJBqNAWrQW3JW0=;
        b=q3qzObKGKpHqTxsb7a6QnpiAGzoifTfMJAFh4oUszPBXSfs4Umpk7puz9kwElbZjuQ
         UPTutnQ/I6Qp588mNXw97OCxtqvsFNVCKlRtMP46BfAgGhQlHe/zIsZNzn4AlawCNRZF
         57d7UVB3B+hIJ5cqg9LHVlaUlYuPgaWAmAey3PJuGqkHNW/0NWc4EheXh6LfPIaygmNu
         wu842/L/c67LiXnb/PVdGicT4THQovXV2PZU/U/XwaY4kMuDSPUPLgakekOR+dqfv1oU
         aBzEhT3DHtyQWJXBNinQqdo3olT7o3v4Md/iWb3xD1ePItulldcbyzNHF+TvjkObXzrb
         RU1A==
X-Gm-Message-State: ACgBeo0pZyOYPrdgQQXAX3kh1uO+6v4dAZEARQbpCMVK0FAA8UMT434s
        VJ2Ag5yoHEwzwUMKZEycboU=
X-Google-Smtp-Source: AA6agR6kC8UmcQw+hQRh8FLUpHWTGdZ4lMCA2WsGsDyDeukQpMtRZ2I+zpLsalXCgeeiTMrL7g20RQ==
X-Received: by 2002:a17:907:842:b0:731:3310:4187 with SMTP id ww2-20020a170907084200b0073133104187mr10130884ejb.578.1661105458775;
        Sun, 21 Aug 2022 11:10:58 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id g12-20020a056402114c00b004404e290e7esm6854178edw.77.2022.08.21.11.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:10:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RESEND PATCH 3/4] hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
Date:   Sun, 21 Aug 2022 20:10:44 +0200
Message-Id: <20220821181045.8528-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821181045.8528-1-fmdefrancesco@gmail.com>
References: <20220821181045.8528-1-fmdefrancesco@gmail.com>
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
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
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

