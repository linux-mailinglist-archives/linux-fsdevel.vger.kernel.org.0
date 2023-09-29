Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24FF7B2A7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 05:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjI2DY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 23:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2DYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:24:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4091AE
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2774aa96947so8199145a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695957881; x=1696562681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wPEhWpvRY896Xnw5Ev1/y00zI5fAQGyVN5RsYugNn8=;
        b=QIPJhQmPgqMaezjOXQu9ufOmTKlnJYeYRBnC/L59my/pZbXCnc0RWylCjiZ3ymcOkJ
         LWZpFCY0T/PBct+kWcmVACzEjG/mtT3nN/shP/UZlrbjlVLQlJMukDG5/54WFFl1FZDM
         XxJBi9w42no+IBnHSdFzxtp2hu5/Yd+gnBi8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695957881; x=1696562681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wPEhWpvRY896Xnw5Ev1/y00zI5fAQGyVN5RsYugNn8=;
        b=n7m6+UJI5JayVCv+IuK39pc5qjcYzEBOIcXzHRyGN5kOwyKLxGempgYhsdXkB9l4GS
         etgULREr8pxv2kpCn6GI7AtWIGbTnzwBmM8lrTYx135/sM+nn8luCHe1IY+wjGIg75JP
         BN336SWIIqhdF/7IlkRC75YSTQs5B+mQUtThLclq2eGCsH3PGuu98OlnG+fw7XrAgToo
         uRE5c5R4DynesFpJUafqUM4/iSZZLEc21sRzWvuwNgnOADrJU1m5kZ6QVxtoa7fo8Awc
         yAR1Lr/flMpWCnT/soADpLgXY1E0DmdTc6YtJA4MgpffL7TXJiTHw2DLalC/3E3vYiIT
         dgSQ==
X-Gm-Message-State: AOJu0YxfiYIqgN/GkSC2JaH8IfTDe6Jqbs1/zly3PVNE94yMEc9MWbXY
        Y9ZG/eolK28dCOPvC+r3Om8rdw==
X-Google-Smtp-Source: AGHT+IGrJvdYK0UubFjOkgcsulZp4Iwd9Tt7tIAbT+bREXfQrb6kahqghubh3CtXHQN6f3Ye2DXCOA==
X-Received: by 2002:a17:90a:ba92:b0:267:ffcf:e9e3 with SMTP id t18-20020a17090aba9200b00267ffcfe9e3mr3087478pjr.46.1695957881706;
        Thu, 28 Sep 2023 20:24:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a530f00b0027654d389casm297683pjh.54.2023.09.28.20.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:24:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v4 6/6] mm: Remove unused vm_brk()
Date:   Thu, 28 Sep 2023 20:24:34 -0700
Message-Id: <20230929032435.2391507-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929031716.it.155-kees@kernel.org>
References: <20230929031716.it.155-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050; i=keescook@chromium.org;
 h=from:subject; bh=qQgWJ2LfzVKqVSy79Ld0II87Ub3I62svbZlMXS8eqNU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFkNyozNMKFDP2i80754Px/+ZY/Cx7wBo4sXmZ
 GfAFEgqokWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRZDcgAKCRCJcvTf3G3A
 JvugEAC1X9CtGDjUrVOsqG0t9TTnzkbAODtZErc43R+VjV7tM+wgC1YoBq1uGKg3kk/39J5ROiJ
 rUkABHj3UilMN33EplFoDi9bG/ErY91MQttOzzjtGtjVqWIrEJ/Vl9Txp0Lfb8zYFy9NsK/6FUL
 MtgFp5sk40k0qU96E6p96fB7SzEc44a33CLYYExFKVE2M08Bylw2aJ9Ee0dsno2XN3kwHuLByFf
 wcJ9XIEkkKA6ek8B7IuLsRGmbigeQnoNgTo87K5bPOqAGNyvV5AaKea9aX90W7XTFl3Mg767UDU
 QBSQvaLWv+t6WEIH+DBweDTKSOHJsyAOniUBtf5ZYA37xZuqPVJdtHMHNT5eperaA7H3rjw+UUz
 Jlq6iSEPSQzB/ur6ucWrK0s4O62amvSspv633OZXBOo6liFA9krixvk0n9DDIpK4izJk9sqIro1
 JU8Wshi103umj8FDzYRXujBj+g//VNypVJAxw30ltepS01lpNn33UpY/bazcxEBWtzAI6WzksOn
 OioMLo/fYEk9tr3WtHRgTsp7V0afPDYJ6aOpeBzZjAdyfqtuIfngMDD8ITow2mnQdSypEQ39K9p
 Rr6tuk/SEYKG3c/cQmyk7L+/cRTRAgeeYxAnZFNKbHqj7DeGYfmOdb6oTSlHNHgU9S+L8PRk5BL FEozwXjpMVEPE4w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With fs/binfmt_elf.c fully refactored to use the new elf_load() helper,
there are no more users of vm_brk(), so remove it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mm.h | 3 +--
 mm/mmap.c          | 6 ------
 mm/nommu.c         | 5 -----
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..216dd0c6dcf8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3308,8 +3308,7 @@ static inline void mm_populate(unsigned long addr, unsigned long len)
 static inline void mm_populate(unsigned long addr, unsigned long len) {}
 #endif
 
-/* These take the mm semaphore themselves */
-extern int __must_check vm_brk(unsigned long, unsigned long);
+/* This takes the mm semaphore itself */
 extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
 extern int vm_munmap(unsigned long, size_t);
 extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
diff --git a/mm/mmap.c b/mm/mmap.c
index b56a7f0c9f85..34d2337ace59 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3174,12 +3174,6 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 }
 EXPORT_SYMBOL(vm_brk_flags);
 
-int vm_brk(unsigned long addr, unsigned long len)
-{
-	return vm_brk_flags(addr, len, 0);
-}
-EXPORT_SYMBOL(vm_brk);
-
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
diff --git a/mm/nommu.c b/mm/nommu.c
index 7f9e9e5a0e12..23c43c208f2b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1531,11 +1531,6 @@ void exit_mmap(struct mm_struct *mm)
 	mmap_write_unlock(mm);
 }
 
-int vm_brk(unsigned long addr, unsigned long len)
-{
-	return -ENOMEM;
-}
-
 /*
  * expand (or shrink) an existing mapping, potentially moving it at the same
  * time (controlled by the MREMAP_MAYMOVE flag and available VM space)
-- 
2.34.1

