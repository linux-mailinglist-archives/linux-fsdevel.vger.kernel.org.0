Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C798C65A5F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 18:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiLaRmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 12:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLaRmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:42:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0851CF52;
        Sat, 31 Dec 2022 09:42:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so20976439wma.1;
        Sat, 31 Dec 2022 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDxzoBipuwgJ9nXmM8IIPQyqkbvF/xMtt7DwxtCT5D8=;
        b=pBKkIKnyLK8+/jEPZDupGUVaRyZrdOvlC2089EskdKymkUwbjENKm+zuo8Pldcfb53
         zm2DVZjMwulgcyUrlgkoIfVSVnolqaWfE1We1P8mk7guvoWifd+1otzRUXghhWu6eQkq
         O6VFCIwEwe9FS0fwxmAg2F73QY7mMgxTiD9zqItf1ellgexmGsKeXAqxEyx1jZ0yHOwG
         Z4w+i663b/hCn2reqN3dWZCXO6khUNEdsO0qnOlWAGRUZH6j1pyRFbtulgMByMdfHQoM
         PHVU8Rlzhj6d5D2gXdArBnS/7aAZBWi/KM6FkuAPutCxVW4tqbLVM6BVw1fg4H8D4YO3
         q90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDxzoBipuwgJ9nXmM8IIPQyqkbvF/xMtt7DwxtCT5D8=;
        b=5iKaP4Z7bfI20ia5UpbGHVq6wu1qVk9FshKtRNBqxsQzqf/vN37xnu2a2mtubCAfmE
         /ifuv6u4V8gJ4SiII6ZCC35AuQeSES180EDZpJMElY/xklH/K8RqxQOvaUFb3kBK7yI3
         adkMtGOz5U4XxH6s4R0h8SlWfU55RKk14nFug+frZ1uWpdAdAlNh9OB22yyaRfn+ILSk
         2EuWJCSXmP6G86wAVOBNWGUhbdWo2uJElRuszqLQEF57NSDa9OqJlWP/2IpgZnKhDn+y
         TMhec1m+JyPRsKGNN5VbtbXuSlTDyzY0QNeeDKPj3asd0NO3aGMUMH0N8u+7tC7+yfnO
         rQ9Q==
X-Gm-Message-State: AFqh2kpwrzAs7kJCKDXIPtuNCRUVCwbKCqfqoKuvsn4D1QwEw3Bm3vx1
        YUpMN5VIZpOzy7lJGLksgMM=
X-Google-Smtp-Source: AMrXdXvk9EdwSr2x+fYJ7G9WETsrhAGHJ30UHMcjghwfjLAuQ/oegP9lJa6m74KhxqF3Q08xJ1LmlQ==
X-Received: by 2002:a05:600c:1c90:b0:3cf:75a8:ecf4 with SMTP id k16-20020a05600c1c9000b003cf75a8ecf4mr25553418wms.24.1672508530472;
        Sat, 31 Dec 2022 09:42:10 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id bi14-20020a05600c3d8e00b003d9ad6783b1sm2032817wmb.6.2022.12.31.09.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 09:42:09 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] fs/ext2: Replace kmap_atomic() with kmap_local_page()
Date:   Sat, 31 Dec 2022 18:42:05 +0100
Message-Id: <20221231174205.8492-1-fmdefrancesco@gmail.com>
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

However, the code within the mapping and un-mapping in ext2_make_empty()
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

 fs/ext2/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index e5cbc27ba459..0f144c5c7861 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -646,7 +646,7 @@ int ext2_make_empty(struct inode *inode, struct inode *parent)
 		unlock_page(page);
 		goto fail;
 	}
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	memset(kaddr, 0, chunk_size);
 	de = (struct ext2_dir_entry_2 *)kaddr;
 	de->name_len = 1;
@@ -661,7 +661,7 @@ int ext2_make_empty(struct inode *inode, struct inode *parent)
 	de->inode = cpu_to_le32(parent->i_ino);
 	memcpy (de->name, "..\0", 4);
 	ext2_set_de_type (de, inode);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	ext2_commit_chunk(page, 0, chunk_size);
 	err = ext2_handle_dirsync(inode);
 fail:
-- 
2.39.0

