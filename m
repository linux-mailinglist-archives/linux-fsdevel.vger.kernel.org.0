Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C54653C13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 07:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiLVGOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 01:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbiLVGN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:13:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EAD1A3BB
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 22:13:56 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-45dd4fb5580so11196357b3.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 22:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXO+2cqQ2jD3iajPKrzJ7z5yUSuuXzzA/96bixg+F2U=;
        b=RBzamxSflqz2dnljq8hzGh3K+g7vkV1vpSKFgX6w0JKOg9dUn+Y/WaXJu3DhtVpjuo
         ALtRZuX1WGVCUNKcpQ3ANWhiGUz73vxYXlmH6StTQnmI8CrYeQDhkLQrIhhy4L47n2hZ
         X4GN5QLqu301t7NXd8ZZpuBpYYhdqKGubvs5RiZsiQomDETrdTXahMnqZnQFGRqYlgNu
         im+/kRLg+lX53aiiY4oJwMmfNcEVi2vRTWLGHxJsAwH1UG3k0W10/QMGtsfXREIzH0wH
         htZIoSXJwK1BlJe4S7NeMCg4ED/HaIuuROna1LPz5R7n+77MkBDwjj6lUVA4LWn//7xl
         EAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXO+2cqQ2jD3iajPKrzJ7z5yUSuuXzzA/96bixg+F2U=;
        b=PKav5hecEBLspLBruEl15Et8zmZvtFnfULIa6bxOxbWh2qXvNa7SDKLo4Eddz8p3xj
         To8IGUSWV4Qmpj14/c3qfqXgouQrI0nujp2tIO1dAmygzaAYH+tewmuq60bljyP/ZTQo
         4+MaC4vsE34VpWT8p3xda6Saim6zEHsEWrr6zCQwOevbqhoJX9tM/giV4pm5zftjxc2K
         dlUXq1LiMhmSW9/ABAt2m7PuUP+65ern+N10jjG/XQ8D9VU1jrQ+6zvikuLIVnQiVvuL
         eFDF5ABCKKzyBN0D4deLf4m/CdlHPx+Iz2WAPoEik7ju4wdf5tMi82ZNVD1juc1Tr0XO
         HDeA==
X-Gm-Message-State: AFqh2krq2fg7p28jBFrkROUpnvgrJeubefzQwyRcbPaROMk+9OA8J1uB
        UmA3P6MuoZPMdgWzB8Zl1cRlAGLY814C
X-Google-Smtp-Source: AMrXdXubpzMCVNxT2q9xbikXo1M/LUPkX3kF0KVqtXoPwmraEpRHv+a8w7/K7YmvnJDVJVUEAX/Ko3eLEoOT
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2d4:203:bd6e:5c67:5831:adad])
 (user=yuanchu job=sendgmr) by 2002:a25:6d56:0:b0:6fa:c7e7:a572 with SMTP id
 i83-20020a256d56000000b006fac7e7a572mr479654ybc.456.1671689635274; Wed, 21
 Dec 2022 22:13:55 -0800 (PST)
Date:   Wed, 21 Dec 2022 22:13:41 -0800
In-Reply-To: <20221222061341.381903-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20221222061341.381903-1-yuanchu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222061341.381903-2-yuanchu@google.com>
Subject: [PATCH 2/2] mm: support POSIX_FADV_NOREUSE for generic fadvise handler
From:   Yuanchu Xie <yuanchu@google.com>
To:     Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yu Zhao <yuzhao@google.com>

POSIX_FADV_NOREUSE allows an application to specify that accesses to
file data does not follow LRU and is used only once. Since 2.6.18 this
is a no-op. We add FMODE_NOREUSE, checked in vma_has_locality to prevent
LRU activation.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/fs.h        | 2 ++
 include/linux/mm_inline.h | 3 +++
 mm/fadvise.c              | 5 ++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 066555ad1bf8..5660ed0edf1a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -166,6 +166,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports DIRECT IO */
 #define	FMODE_CAN_ODIRECT	((__force fmode_t)0x400000)
 
+#define	FMODE_NOREUSE		((__force fmode_t)0x800000)
+
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 80c0f6901ead..024f834d952d 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -583,6 +583,9 @@ static inline bool vma_has_locality(struct vm_area_struct *vma)
 	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
 		return false;
 
+	if (vma->vm_file && (vma->vm_file->f_mode & FMODE_NOREUSE))
+		return false;
+
 	return true;
 }
 
diff --git a/mm/fadvise.c b/mm/fadvise.c
index bf04fec87f35..fb7c5f43fd2a 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -80,7 +80,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 	case POSIX_FADV_NORMAL:
 		file->f_ra.ra_pages = bdi->ra_pages;
 		spin_lock(&file->f_lock);
-		file->f_mode &= ~FMODE_RANDOM;
+		file->f_mode &= ~(FMODE_RANDOM | FMODE_NOREUSE);
 		spin_unlock(&file->f_lock);
 		break;
 	case POSIX_FADV_RANDOM:
@@ -107,6 +107,9 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		force_page_cache_readahead(mapping, file, start_index, nrpages);
 		break;
 	case POSIX_FADV_NOREUSE:
+		spin_lock(&file->f_lock);
+		file->f_mode |= FMODE_NOREUSE;
+		spin_unlock(&file->f_lock);
 		break;
 	case POSIX_FADV_DONTNEED:
 		__filemap_fdatawrite_range(mapping, offset, endbyte,
-- 
2.39.0.314.g84b9a713c41-goog

