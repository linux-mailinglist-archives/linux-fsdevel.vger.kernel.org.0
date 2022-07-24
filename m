Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287C757F730
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Jul 2022 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiGXVZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jul 2022 17:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGXVZb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jul 2022 17:25:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69FB60E2;
        Sun, 24 Jul 2022 14:25:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t3so11812224edd.0;
        Sun, 24 Jul 2022 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lC6itZO6h011tufGF0rKTSSMKGZuI2C2c6Vn9aRdYFg=;
        b=Bh/Ij1mQwBqdj2pO9eQbj85IlSlZpmaQsCeCvxi76zd1z94ilOCMJYj6powy1+Uk7R
         0A8cEzDopSPNSY7sYzCiug80nVV1N1OEQnk9za0t5rFBB5y1/nJllI/vbr/5fh38MDao
         xFJnm6kTIVWW2VXDlJsa8GRU7Xfon2JTc3CVbCZbr7SOVbR8w+tR7Ryhjpmg/b4CbVur
         ifJwaNZnhCsR+qv2GD00JBomeyh6tEbp1G4nTSVkHsrpoyHiKb7ZQ2R8+IA+b7551Wak
         VnBSbqqSS3+b+LTf8bHFVznXiidoDAO8SwqqOWOchJL7zeeIt3LOkILzvlnW3TauEROG
         saXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lC6itZO6h011tufGF0rKTSSMKGZuI2C2c6Vn9aRdYFg=;
        b=kUjMGXG9vGjIcTOeFj3Gt2jbXVmkZ7XFT33B+D4vRQ5xzdN8vicTyk+79s+hZX70xD
         z28I91KNl0UaeD5dEfBqQR+kfoy09Jo6c3dPsITiA3pAByraDC1nKn7zAOdCF++qbIVg
         czzpBLVgBsCNoda2rnjCWIeX3Wnvzl+tgytpRCB9w9Hlp0xbSQjD1IpBmGewCef9v/r6
         OO3IjY/vkyEotmHntYW1elYJgkXsRJfRMVnhEZwsVTrAcgjBBFpj6cSfqf6TNOYrs4+3
         65TDoZ+8/nuJR0SQ+4gLf3Uh2lNiLMScprZh7yKLpDeG5oc/sgRmcIPQ1ERnlL5oV+3q
         Xw6A==
X-Gm-Message-State: AJIora+gCScIRo4wSmUYKidRL6xS6sT97QM4OG91IgwC67ZZnsKg/20k
        jMWBvJt5KULYsew7rgb6VOzbcEU7GmM=
X-Google-Smtp-Source: AGRyM1uzMuqoSLsvWfhyGg9dK8pXT/P4aDk/xiw2TzDnM870HsPlUWlN/kA2pLsQ8GW563x3j52gog==
X-Received: by 2002:a05:6402:16:b0:43a:f435:5d07 with SMTP id d22-20020a056402001600b0043af4355d07mr10321597edu.420.1658697929362;
        Sun, 24 Jul 2022 14:25:29 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id ev6-20020a056402540600b0043af8007e7fsm6117001edb.3.2022.07.24.14.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 14:25:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2] fs: Call kmap_local_page() in copy_string_kernel()
Date:   Sun, 24 Jul 2022 23:25:23 +0200
Message-Id: <20220724212523.13317-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
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

The use of kmap_atomic() is being deprecated in favor of kmap_local_page().

With kmap_local_page(), the mappings are per thread, CPU local and not
globally visible. Furthermore, the mappings can be acquired from any
context (including interrupts).

Therefore, replace kmap_atomic() with kmap_local_page() in
copy_string_kernel(). Instead of open-coding local mapping + memcpy(),
use memcpy_to_page(). Delete a redundant call to flush_dcache_page().

Tested with xfstests on a QEMU/ KVM x86_32 VM, 6GB RAM, booting a kernel
with HIGHMEM64GB enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Instead of open-coding a local mapping + memcpy(), use
memcpy_to_page() (thanks to Ira Weiny for his comment on v1).

 fs/exec.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d20cb09476f3..eed899188333 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -630,7 +630,6 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 		unsigned int bytes_to_copy = min_t(unsigned int, len,
 				min_not_zero(offset_in_page(pos), PAGE_SIZE));
 		struct page *page;
-		char *kaddr;
 
 		pos -= bytes_to_copy;
 		arg -= bytes_to_copy;
@@ -639,11 +638,8 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 		page = get_arg_page(bprm, pos, 1);
 		if (!page)
 			return -E2BIG;
-		kaddr = kmap_atomic(page);
 		flush_arg_page(bprm, pos & PAGE_MASK, page);
-		memcpy(kaddr + offset_in_page(pos), arg, bytes_to_copy);
-		flush_dcache_page(page);
-		kunmap_atomic(kaddr);
+		memcpy_to_page(page, offset_in_page(pos), arg, bytes_to_copy);
 		put_arg_page(page);
 	}
 
-- 
2.37.1

