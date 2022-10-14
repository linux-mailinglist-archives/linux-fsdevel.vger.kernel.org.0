Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8608D5FEB07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJNIuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJNItw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:49:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8F521E36;
        Fri, 14 Oct 2022 01:49:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso3069601wmq.2;
        Fri, 14 Oct 2022 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noZwzVYPpBsDl5CECnOrP5rsHRqU5K36GF5tioVqhvo=;
        b=FQxuL83NlA1dTcPa+tFZaBKev/381N92shWjcokB6Cq01pDQV8v3dKmLzskweZmrg7
         Jz6tAKO28qyNZhcKa1omEDpp9WjDAaZzKcErysdgfT7V0um+TyLLNk2Cij8EO/EsRY7j
         mM4PW1pXSuwF/LnXS5kzwEDyOA+AX2w5cE1DhAa9FuWqFFyXvj/NZ+KCCIthXLghAk0u
         a86+6OK4+3IB+C4bjSyDRdPIS9Ojxhjig1vaZtK+KEGWoBJunSCvCvMdY3KFEsTnmGGH
         vhkRbzjwDO4lnOX6LHYeQne4mhhiyroqBB3oVZA+u+phCefTTmPtrCeo3CV7uh6afgQ3
         Zvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noZwzVYPpBsDl5CECnOrP5rsHRqU5K36GF5tioVqhvo=;
        b=NrYTcHyfyF2rCxRI0gZ9j8/v593JThtMk8Wb75cFABf3iEp2qMMRgHa6xnQhYpgBok
         9B81ZfW1GsL4olM2FIbse3pKdtDJytbjmXrWQWSkpXxCUdV/5oXYRux4t4tFIFaJWfQU
         ek68m1cWTYDNEjPi+3HYab98s5UFxWdBU9vLrtcMRlpWc8MZOEaB+GX1G+U3x4in6w//
         vSPQuIR/eQ//NSgJ/BwuLspKmolFxYPEpt0nkIHlfx6XVbxKN7o6Mcm4abqZop4IoycZ
         NNS1lgWyUJG+MkNIzfSDAuuNtn6OFaoQaJ33fNSq1E28mkX1CU7EE2d4P3+N/TduJ8tj
         YkdA==
X-Gm-Message-State: ACrzQf296Zl8SR5ElvHDEUevggqMsiFhOun/La7+sksb3MNAVR/y99oA
        K/0vyj5pbr6ta5Yo+f1kmwo=
X-Google-Smtp-Source: AMsMyM6LLqWRPo+UV+uMhtdyCnYVRTjSPNIcPtvijlT4VjYFItZbopCVgihpcI5ZnJzpKiPc+FN/Aw==
X-Received: by 2002:a05:600c:288:b0:3c6:c44a:1d30 with SMTP id 8-20020a05600c028800b003c6c44a1d30mr9545255wmk.46.1665737388927;
        Fri, 14 Oct 2022 01:49:48 -0700 (PDT)
Received: from hrutvik.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm1547372wmz.34.2022.10.14.01.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:49:48 -0700 (PDT)
From:   Hrutvik Kanabar <hrkanabar@gmail.com>
To:     Hrutvik Kanabar <hrutvik@google.com>
Cc:     Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH RFC 3/7] fs/btrfs: support `DISABLE_FS_CSUM_VERIFICATION` config option
Date:   Fri, 14 Oct 2022 08:48:33 +0000
Message-Id: <20221014084837.1787196-4-hrkanabar@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014084837.1787196-1-hrkanabar@gmail.com>
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
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

From: Hrutvik Kanabar <hrutvik@google.com>

When `DISABLE_FS_CSUM_VERIFICATION` is enabled, bypass checksum
verification.

Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>
---
 fs/btrfs/check-integrity.c  | 3 ++-
 fs/btrfs/disk-io.c          | 6 ++++--
 fs/btrfs/free-space-cache.c | 3 ++-
 fs/btrfs/inode.c            | 3 ++-
 fs/btrfs/scrub.c            | 9 ++++++---
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 98c6e5feab19..eab82593a325 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1671,7 +1671,8 @@ static noinline_for_stack int btrfsic_test_for_metadata(
 		crypto_shash_update(shash, data, sublen);
 	}
 	crypto_shash_final(shash, csum);
-	if (memcmp(csum, h->csum, fs_info->csum_size))
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    memcmp(csum, h->csum, fs_info->csum_size))
 		return 1;
 
 	return 0; /* is metadata */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a2da9313c694..7cd909d44b24 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -184,7 +184,8 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 	crypto_shash_digest(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
 			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
 
-	if (memcmp(disk_sb->csum, result, fs_info->csum_size))
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    memcmp(disk_sb->csum, result, fs_info->csum_size))
 		return 1;
 
 	return 0;
@@ -494,7 +495,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 	header_csum = page_address(eb->pages[0]) +
 		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
 
-	if (memcmp(result, header_csum, csum_size) != 0) {
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    memcmp(result, header_csum, csum_size) != 0) {
 		btrfs_warn_rl(fs_info,
 "checksum verify failed on logical %llu mirror %u wanted " CSUM_FMT " found " CSUM_FMT " level %d",
 			      eb->start, eb->read_mirror,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f4023651dd68..203c8a9076a6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -574,7 +574,8 @@ static int io_ctl_check_crc(struct btrfs_io_ctl *io_ctl, int index)
 	io_ctl_map_page(io_ctl, 0);
 	crc = btrfs_crc32c(crc, io_ctl->orig + offset, PAGE_SIZE - offset);
 	btrfs_crc32c_final(crc, (u8 *)&crc);
-	if (val != crc) {
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    val != crc) {
 		btrfs_err_rl(io_ctl->fs_info,
 			"csum mismatch on free space cache");
 		io_ctl_unmap_page(io_ctl);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b0807c59e321..1a49d897b5c1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3434,7 +3434,8 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
 	kunmap_local(kaddr);
 
-	if (memcmp(csum, csum_expected, fs_info->csum_size))
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    memcmp(csum, csum_expected, fs_info->csum_size))
 		return -EIO;
 	return 0;
 }
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f260c53829e5..a7607b492f47 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1997,7 +1997,8 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 
 	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
 
-	if (memcmp(csum, sector->csum, fs_info->csum_size))
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    memcmp(csum, sector->csum, fs_info->csum_size))
 		sblock->checksum_error = 1;
 	return sblock->checksum_error;
 }
@@ -2062,7 +2063,8 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	}
 
 	crypto_shash_final(shash, calculated_csum);
-	if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))
 		sblock->checksum_error = 1;
 
 	return sblock->header_error || sblock->checksum_error;
@@ -2099,7 +2101,8 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	crypto_shash_digest(shash, kaddr + BTRFS_CSUM_SIZE,
 			BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, calculated_csum);
 
-	if (memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
 		++fail_cor;
 
 	return fail_cor + fail_gen;
-- 
2.38.0.413.g74048e4d9e-goog

