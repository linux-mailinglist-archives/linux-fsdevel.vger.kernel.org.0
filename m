Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61056589244
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 20:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbiHCS3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 14:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiHCS3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:29:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902A3DF17;
        Wed,  3 Aug 2022 11:29:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n185so9104607wmn.4;
        Wed, 03 Aug 2022 11:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oJmOeTx06Lwu2fiuMzcG5dIKwqxwvQUWSEnoeJ++UWc=;
        b=JmYucQwk2UfoYXlb90FNHzTAHQvr9D2+kHxYT4XYngWqkCCo6RtGwUz21B785dhdnX
         HkOhgATfzaOWyr+haRcQpS3WeyVQuREVxWKzs6tbeX1P0XFo7iT1knUcUPeFeZXhxeIa
         dzjREPw6h/c4pQ8yu0R+vWm89jUE/h3QPVOFLzIzas+nhl+SzRRSRnhZq1Cqk9XUYXFK
         u1KWIqJ/t2fHBBHO07LINKBod4uH1YWiM2YxtS02l2hJb+lI69QBW9hbdDo/Pr1ZTrdK
         NKSg97XHPHVoSi7xj00wGu4sDNgaAFVS7KhVqm8IlwlM/paEm1YO3bDQjgXF3PgtecRl
         nmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oJmOeTx06Lwu2fiuMzcG5dIKwqxwvQUWSEnoeJ++UWc=;
        b=zCseoWTXrhpQjdDEv8JDVfO7Q+vFwpWV6F+UbKggGBTKv3St8/sFRzqPBNnFPfM92i
         SXOvKovT3MSiEp0YaHRaNBhX/S0f3NJGkcv5thNDguj2mMDVJjGf4KGOxXuqfHCWE2ki
         PWtDJFmu1obF/UPwOjUkqLwoF935gY73Di3wB71RAP/qTBxWpayTWIrYE9L00wEhOiEx
         VMO15Hu7g+lgcqyI28i9KWQrxO7j6Zar/fzYN/pcS5T5bgCuMNgS1igJJ3R47h6s/cWj
         V0KNnET50s3oI1gHAKspVjQpakmmcelthl50E17pUfVhNyvkev3n/U/6QwgbTTGC+k/I
         4Qyg==
X-Gm-Message-State: ACgBeo300MTyEfuFiTckbcDeddAQ/QigUX3frL7Yl6MAH5ffSLPjrLLq
        cniuMZhSGCTa/B1udljNzKs=
X-Google-Smtp-Source: AA6agR5h2y2OSTJgWl3pVSJ+3Bg46IOFmOdhF2GtED5TKoijJMNG+N/aw/qjBuuNyHTQX2nQXHDtQA==
X-Received: by 2002:a7b:ca48:0:b0:3a3:365d:1089 with SMTP id m8-20020a7bca48000000b003a3365d1089mr3853699wml.153.1659551342790;
        Wed, 03 Aug 2022 11:29:02 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b003a3200bc788sm3491904wmq.33.2022.08.03.11.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:29:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2] fs: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Wed,  3 Aug 2022 20:28:56 +0200
Message-Id: <20220803182856.28246-1-fmdefrancesco@gmail.com>
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

The use of kmap() and kmap_atomic() are being deprecated in favor of
kmap_local_page().

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

Since the use of kmap_local_page() in exec.c is safe, it should be
preferred everywhere in exec.c.

As said, since kmap_local_page() can be also called from atomic context,
and since remove_arg_zero() doesn't (and shouldn't ever) rely on an
implicit preempt_disable(), this function can also safely replace
kmap_atomic().

Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
fs/exec.c.

Tested with xfstests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
with HIGHMEM64GB enabled.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Added more information to the commit log to address some
objections expressed by Eric W. Biederman[1] in reply to v1. No changes
have been made to the code. Forwarded a tag from Ira Weiny (thanks!).

[1] https://lore.kernel.org/lkml/8735fmqcfz.fsf@email.froward.int.ebiederm.org/

 fs/exec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 5fd73915c62c..b51dd14e7388 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -584,11 +584,11 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 
 				if (kmapped_page) {
 					flush_dcache_page(kmapped_page);
-					kunmap(kmapped_page);
+					kunmap_local(kaddr);
 					put_arg_page(kmapped_page);
 				}
 				kmapped_page = page;
-				kaddr = kmap(kmapped_page);
+				kaddr = kmap_local_page(kmapped_page);
 				kpos = pos & PAGE_MASK;
 				flush_arg_page(bprm, kpos, kmapped_page);
 			}
@@ -602,7 +602,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 out:
 	if (kmapped_page) {
 		flush_dcache_page(kmapped_page);
-		kunmap(kmapped_page);
+		kunmap_local(kaddr);
 		put_arg_page(kmapped_page);
 	}
 	return ret;
@@ -880,11 +880,11 @@ int transfer_args_to_stack(struct linux_binprm *bprm,
 
 	for (index = MAX_ARG_PAGES - 1; index >= stop; index--) {
 		unsigned int offset = index == stop ? bprm->p & ~PAGE_MASK : 0;
-		char *src = kmap(bprm->page[index]) + offset;
+		char *src = kmap_local_page(bprm->page[index]) + offset;
 		sp -= PAGE_SIZE - offset;
 		if (copy_to_user((void *) sp, src, PAGE_SIZE - offset) != 0)
 			ret = -EFAULT;
-		kunmap(bprm->page[index]);
+		kunmap_local(src);
 		if (ret)
 			goto out;
 	}
@@ -1683,13 +1683,13 @@ int remove_arg_zero(struct linux_binprm *bprm)
 			ret = -EFAULT;
 			goto out;
 		}
-		kaddr = kmap_atomic(page);
+		kaddr = kmap_local_page(page);
 
 		for (; offset < PAGE_SIZE && kaddr[offset];
 				offset++, bprm->p++)
 			;
 
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		put_arg_page(page);
 	} while (offset == PAGE_SIZE);
 
-- 
2.37.1

