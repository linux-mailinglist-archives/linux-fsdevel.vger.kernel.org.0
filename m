Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0247665A5F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 18:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiLaRot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 12:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLaRor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:44:47 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ADD644A;
        Sat, 31 Dec 2022 09:44:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso15691624wmb.3;
        Sat, 31 Dec 2022 09:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKGVwmg5J1Ql+fiJXPb+1gyrIp6pIUsxPUQhpeTa7cE=;
        b=kVcjcnjVuAmiqvP8lYg9PmM0y1+l+1Uyott5Q46/0z+HvG+a+/ZbMLczaNiOfWRafr
         U3ClLxdkF1sn468QqPW33lhOcize+mIP0EBhRJJITsiv8M591bqe4n+myFSlFnhZHESA
         3XPgZio1FVG+seF0x49fzeIKSDQHl76+ZIPZtYkbb4fn1f4gIsZnfuc6s8tTww/FdjHP
         WJyRA+KKdqoDNBUWp6HWIrcphEe8cBAA+ALUdNqYK+Cz7Ch43N5fHX/Z1Qn3BhnnNIFL
         QdWszvr3DtkPYvr2J70t/rapTdrnq54Yz5FU/XNVBIQVL+QWgg9hHMgN/y1Lu8UBnYC6
         0RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKGVwmg5J1Ql+fiJXPb+1gyrIp6pIUsxPUQhpeTa7cE=;
        b=Kvu9c8BtrBrKSW7G0PDpUQLwyYGsJHurBkNfXNbrkNl+HQx3dRuftAxPgx5YrYeVsY
         CH8lqwKQawNh+PzhlEM4bIkF/wKrjTH0DNiEbpzpOGs6Dfaia0y8GdsWtQU9ASVgNh36
         tV+ikOoabiWFA9lWTr1em132Tp2bSPvjX4QQ2HHgiIxbwjiR1yhMIFBnugtvydbH5fGC
         iM1GEPbbWnL/4ect7mpr0RQzkFrwEtrPyZBacwFruJdi6q7HrnGXt83lqIPGaIvqv/UO
         FXrmO/uxFhlRgeR+U/9dPsOwfPCGaTqMX/V2H/o8GPgCpQ58qhZKz1BHzewx98tIl0Eo
         R9MQ==
X-Gm-Message-State: AFqh2krX4bbZdIm6v4DH0kmiMilt+zYdoxrtd+8A1gtXjcLuqNf5tN/S
        8OtCOA2/wTftFP15mf9iTeTPOnxlkAc=
X-Google-Smtp-Source: AMrXdXtOafM5UGHzLjN1Yn1s92x0yr1m0tQKluSwnvIJXRy3QMgYLJu9vPM4iCuysf6kS5kZjL2J+w==
X-Received: by 2002:a7b:c414:0:b0:3d6:ecc4:6279 with SMTP id k20-20020a7bc414000000b003d6ecc46279mr25627186wmi.27.1672508683777;
        Sat, 31 Dec 2022 09:44:43 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003d9862ec435sm19206066wmb.20.2022.12.31.09.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 09:44:43 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] fs/ext4: Replace kmap_atomic() with kmap_local_page()
Date:   Sat, 31 Dec 2022 18:44:39 +0100
Message-Id: <20221231174439.8557-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
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

kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
replace kmap_atomic() with kmap_local_page().

kmap_atomic() is implemented like a kmap_local_page() which also disables
page-faults and preemption (the latter only for !PREEMPT_RT kernels).

However, the code within the mappings and un-mappings in ext4/inline.c
does not depend on the above-mentioned side effects.

Therefore, a mere replacement of the old API with the new one is all it
is required (i.e., there is no need to explicitly add any calls to
pagefault_disable() and/or preempt_disable()).

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I tried my best to understand the code within mapping and un-mapping.
However, I'm not an expert. Therefore, although I'm pretty confident, I
cannot be 100% sure that the code between the mapping and the un-mapping
does not depend on pagefault_disable() and/or preempt_disable().

Unfortunately, I cannot currently test this changes to check the
above-mentioned assumptions. However, if I'm required to do the tests
with (x)fstests, I have no problems with doing them in the next days.

If so, I'll test in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

I'd like to hear whether or not the maintainers require these tests
and/or other tests.

 fs/ext4/inline.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2b42ececa46d..bfb044425d8a 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -490,10 +490,10 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
 		goto out;
 
 	len = min_t(size_t, ext4_get_inline_size(inode), i_size_read(inode));
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
 	flush_dcache_page(page);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	zero_user_segment(page, len, PAGE_SIZE);
 	SetPageUptodate(page);
 	brelse(iloc.bh);
@@ -763,9 +763,9 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 		 */
 		(void) ext4_find_inline_data_nolock(inode);
 
-		kaddr = kmap_atomic(page);
+		kaddr = kmap_local_page(page);
 		ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		SetPageUptodate(page);
 		/* clear page dirty so that writepages wouldn't work for us. */
 		ClearPageDirty(page);
@@ -831,9 +831,9 @@ ext4_journalled_write_inline_data(struct inode *inode,
 	}
 
 	ext4_write_lock_xattr(inode, &no_expand);
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	ext4_write_inline_data(inode, &iloc, kaddr, 0, len);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	ext4_write_unlock_xattr(inode, &no_expand);
 
 	return iloc.bh;
-- 
2.39.0

