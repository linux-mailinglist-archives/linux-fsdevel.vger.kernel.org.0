Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DE0658674
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Dec 2022 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiL1Tm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Dec 2022 14:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiL1Tm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:42:56 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E22197
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Dec 2022 11:42:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-352e29ff8c2so185571277b3.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Dec 2022 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h66ZlJIW0sPnpY7cABzav3ob2j9zOJpX5LkgC0xA0/8=;
        b=ZmaFVF7jonGinSfOfqJLrvexRkxJcgPqsnKMM2BWGIh/BVHh7PqXo08JdBFt3JvzDT
         MtFcfUdyqDiaFCLySq0/hKOSrDV1GcyYBXtmNsEtbbs0AD5T4KILU972sTh9LBVzvylG
         tQ34yld8u16qX7XcANjKxhlHCij158UtIOUP/9gRAC7H35s/1sJXhDZT3sMLn3/tZhV7
         aWcN73j9+nlL33mr6ie5dvAYJUjVKshl6AviGRMeNglXhoCBBVDSmhZzyQClFEryL6aG
         E8UwArx1nYdxTy3CYrwtb/ObqUZ8XeDEoelJ/4aWBtjKXZWtTcThztS84KOf7idyfQVd
         fSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h66ZlJIW0sPnpY7cABzav3ob2j9zOJpX5LkgC0xA0/8=;
        b=2OXipLrl0ORbONz1b32p7Q8jQ/a3uZ4F6iASYW65cIGfdjtZZ+oE8D2vkOlBRc8R5P
         uc/WHMYGXUgr5H3EUWQNMTPhzhZE3PrwJdZtkTidJrDp7iYnIg/A7BM09wVkF4Z56VPy
         BziGgxPTAdLEbXM1M8CazY9od7J0yAaBXLwFgmHz0GmS6PUz/aiCvuwfZJ4A7kvQs8Wt
         e26g51UhO9mJYmiI9m0dRFtZ/jY5orGqALUN6gyK7/GFCA9/e84vhp4yd3l1t0Xa+BoD
         Sx7YzjCzC8zDAmvUvbub7fo5BVKKDm6gtiE1zm+ebck/40HPA1iCkgIlPZWurtJbKW4K
         680g==
X-Gm-Message-State: AFqh2koF7MKiilLN9CROBqiitd7MCku4Js5iYCcFPmFCgGZpGdsQcgfs
        4buYz4QkIWNDSCjrlgwJuLzc3Ax9WjE=
X-Google-Smtp-Source: AMrXdXvVoybg1IWCnNxBiUrrq4mqKVmvhjCYdrsqR+1uBXDBxNLu6NltWyq75pQsNEPLUw321kk56Lsqvsg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:77b8:ecbc:954d:4461])
 (user=surenb job=sendgmr) by 2002:a25:d496:0:b0:70c:4fa3:2cce with SMTP id
 m144-20020a25d496000000b0070c4fa32ccemr3787363ybf.539.1672256574382; Wed, 28
 Dec 2022 11:42:54 -0800 (PST)
Date:   Wed, 28 Dec 2022 11:42:49 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221228194249.170354-1-surenb@google.com>
Subject: [PATCH 1/1] mm: fix vma->anon_name memory leak for anonymous shmem VMAs
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     hughd@google.com, hannes@cmpxchg.org, david@redhat.com,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, pasha.tatashin@soleen.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@Oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        bagasdotme@gmail.com, suleiman@google.com, steven@liquorix.net,
        heftig@archlinux.org, cuigaosheng1@huawei.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        surenb@google.com,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
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

free_anon_vma_name() is missing a check for anonymous shmem VMA which
leads to a memory leak due to refcount not being dropped. Fix this by
adding the missing check.

Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_inline.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e8ed225d8f7c..d650ca2c5d29 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -413,7 +413,7 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 	 * Not using anon_vma_name because it generates a warning if mmap_lock
 	 * is not held, which might be the case here.
 	 */
-	if (!vma->vm_file)
+	if (!vma->vm_file || vma_is_anon_shmem(vma))
 		anon_vma_name_put(vma->anon_name);
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

