Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEDE5FEB20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJNIuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJNIty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:49:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F10275D1;
        Fri, 14 Oct 2022 01:49:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w18so6502418wro.7;
        Fri, 14 Oct 2022 01:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSLibGjWy/nIs1Cd+IM0NiQuRQgBV8RHoXsPr1HGgA4=;
        b=jUVoj/7b6E4+o16YX/zkS7mGl1/zWyDsJt9qivb9kCg2BhWvw2bMcttep9H3CV3YBJ
         ZjdSShNRgKcSC+Zk87vJh8JBMp8k2uWWSPXubm+PHqQyF1hqELTu4EtXfa6Lqj6SpsVp
         9g2nh60gWPaU4054v3HwSy7DbEKSebYdF2n63JxmbBM9l0cnT4BXQqNVgGqeFBH6oz7e
         r9um5udVerI7dyDwk7asIA2BKGEpG0dam2OwGNjSZ1t09gZfumg1EtSPwIKRA4vbClpA
         5cTAxCqbYjGbvCCEAaVDLZCLqw8UCb06c7MOK1zgpzkC1fe577/DvfmcLc1yH4yXX9EQ
         +Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSLibGjWy/nIs1Cd+IM0NiQuRQgBV8RHoXsPr1HGgA4=;
        b=jEjseO5pRkZWo05TSwEOz55LYzl3RST2zEf9VNhzbeTF9O1c3wpP0wKEHPiRQoVQWg
         s8gA2zjmJt/QmsoEvbcZ6K08sZL6kJzwAA5nA3OGcmlrR8zbVAdyKChNe7ZTzYu42PNH
         aJfYKyaHHyr2kjVateIW8JljsI5GrFiqacnMaje/R1lq+gsGCbjfBO3ts6vXB9niWkSL
         3II26Ogadz5ShUAUHT1wfOVxcD+8UviX4MvW+OgGQd0VXmxOhpLOPdBY6FQ1TXV5hXgR
         vw28/etNpFzkZSD+lHKvh19IhP+hglBRycefoCrJr/ZL3lvoBciBGJkQdfjGH8vz6e0g
         iwEw==
X-Gm-Message-State: ACrzQf1uMHDYfbEcj3v/FNptvNHWCHJJFH5J9YbkD7fUwfE7ojIWwcrN
        YR9Tboh3IFcaa2/BMgNp2O0=
X-Google-Smtp-Source: AMsMyM6RtssP0X8/PiYsddX84eZi5SsoPD+IvXeUhq3mBprDDszRzfOLZv3kstlVcvUswotyaxBNOQ==
X-Received: by 2002:a5d:5b1f:0:b0:22e:51b0:2837 with SMTP id bx31-20020a5d5b1f000000b0022e51b02837mr2605593wrb.132.1665737390355;
        Fri, 14 Oct 2022 01:49:50 -0700 (PDT)
Received: from hrutvik.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm1547372wmz.34.2022.10.14.01.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:49:50 -0700 (PDT)
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
Subject: [PATCH RFC 4/7] fs/exfat: support `DISABLE_FS_CSUM_VERIFICATION` config option
Date:   Fri, 14 Oct 2022 08:48:34 +0000
Message-Id: <20221014084837.1787196-5-hrkanabar@gmail.com>
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
 fs/exfat/nls.c   | 3 ++-
 fs/exfat/super.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 705710f93e2d..f0f92eaf6ccc 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -696,7 +696,8 @@ static int exfat_load_upcase_table(struct super_block *sb,
 		brelse(bh);
 	}
 
-	if (index >= 0xFFFF && utbl_checksum == chksum)
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) ||
+	    (index >= 0xFFFF && utbl_checksum == chksum))
 		return 0;
 
 	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 35f0305cd493..7418858792b3 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -564,6 +564,9 @@ static int exfat_verify_boot_region(struct super_block *sb)
 	if (!bh)
 		return -EIO;
 
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION))
+		return 0;
+
 	for (i = 0; i < sb->s_blocksize; i += sizeof(u32)) {
 		p_chksum = (__le32 *)&bh->b_data[i];
 		if (le32_to_cpu(*p_chksum) != chksum) {
-- 
2.38.0.413.g74048e4d9e-goog

