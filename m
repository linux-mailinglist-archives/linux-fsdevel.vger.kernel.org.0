Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E27AEA4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 12:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjIZKZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 06:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjIZKZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:25:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB8BF3;
        Tue, 26 Sep 2023 03:25:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-274c05edb69so5135408a91.2;
        Tue, 26 Sep 2023 03:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695723900; x=1696328700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=belzVqUXupbj+p/ftaInrev5zFhyd2pVAAHE2DEJScA=;
        b=IiZsP55AfxbNyD0Zc7Zw/UOvQnHpKbPK0IeIcg1H3JWVtJ9JzQYPtz90g8c9mq4NYk
         IubZebWtTh0aCHlxH/rFHBKRGHFrX2Mf9BSsDIeun3vabomYkMYymDsXm+s00cCuZL6G
         mv8lISHgV1hOsbCoD8P3Ndt7PYHOgkDfxC+mqDmARuXEkvFAV16lSUGBndkVPfTXzhG9
         iJWJZ8lhVqMYOqqEesAMc0J14iJglSdWQymIwPePQt2pe/qhA3WwF/UvM2It1oRS+DOP
         YGoB55YycIlPQGmrb/CYi9rskIToKUQ71E20NawX74EUpgeLwjIIjZUhnl1J1NF/p43l
         4fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695723900; x=1696328700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=belzVqUXupbj+p/ftaInrev5zFhyd2pVAAHE2DEJScA=;
        b=HE3lF+deH7tbGqEOe+0FgDxiwJA/Ks30WqdcSaQVF7Fe/4bXzDQ+uUj9obHVUbfN3b
         /Fgm7TsSaF5qG26ICuzo+J8juyyGEYGjLTHNefQnkArhiAWW4aaj4ZAkZZfght+WJZUf
         2j3z9Dwm5LZnf8KTXGAErg5Q2iM7FU+KBVfHNr0+cLeOnhSiTVmYqL9PGPMC80FoRpAr
         63/nWUfhK7fbCK1MsZnFSgbRPbSQHd1uIa5fnMSx/WvSTz51ph/LDMEXnseWRz3z5dKI
         S571RMTJl4utnwjCDuuqTyIVp0a06or8oelTAl2uh5e5910dOeLS1+Df72l1qR4hCvd2
         70gg==
X-Gm-Message-State: AOJu0YzT12HmdJUh4e7s7eDXmtUQV6ugqAIaIukM+ImohFg8lxi99yb7
        nme96K9mmta2/ouLXJL4VQ8=
X-Google-Smtp-Source: AGHT+IE4bRabF4Tz8fVRFjoJCKeKdherUx2wMHpu1l6uFKHg1l6krNDijIoGangTlLVTiq+Cdp2VaA==
X-Received: by 2002:a17:90a:f298:b0:269:6c5:11a7 with SMTP id fs24-20020a17090af29800b0026906c511a7mr6883549pjb.17.1695723900206;
        Tue, 26 Sep 2023 03:25:00 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id gk15-20020a17090b118f00b00274b9dd8519sm9623829pjb.35.2023.09.26.03.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:24:59 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     syzbot+4a2376bc62e59406c414@syzkaller.appspotmail.com
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs/hfsplus: expand s_vhdr_buf size to avoid slab oob
Date:   Tue, 26 Sep 2023 18:24:55 +0800
Message-ID: <20230926102454.992535-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000820e380606161640@google.com>
References: <000000000000820e380606161640@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The memory allocated to s_vhdr_buf in the function hfsplus-read_wrapper is 
too small, resulting in a slab out of bounds issue when copying data with 
copy_page_from_iter_atomic.

When allocating memory to s_vhdr_buf, take the maximum value between 
hfsplus_min_io_size(sb) and PAGE_SIZE to avoid similar issues.

Reported-and-tested-by: syzbot+4a2376bc62e59406c414@syzkaller.appspotmail.com
Signed-off-by: Edward AD <twuufnxlz@gmail.com>
---
 fs/hfsplus/wrapper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 0b791adf02e5..56bee8dbe532 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -163,7 +163,7 @@ int hfsplus_read_wrapper(struct super_block *sb)
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct hfsplus_wd wd;
 	sector_t part_start, part_size;
-	u32 blocksize;
+	u32 blocksize, bufsize;
 	int error = 0;
 
 	error = -EINVAL;
@@ -175,10 +175,11 @@ int hfsplus_read_wrapper(struct super_block *sb)
 		goto out;
 
 	error = -ENOMEM;
-	sbi->s_vhdr_buf = kmalloc(hfsplus_min_io_size(sb), GFP_KERNEL);
+	bufsize = max_t(u32, hfsplus_min_io_size(sb), PAGE_SIZE);
+	sbi->s_vhdr_buf = kmalloc(bufsize, GFP_KERNEL);
 	if (!sbi->s_vhdr_buf)
 		goto out;
-	sbi->s_backup_vhdr_buf = kmalloc(hfsplus_min_io_size(sb), GFP_KERNEL);
+	sbi->s_backup_vhdr_buf = kmalloc(bufsize, GFP_KERNEL);
 	if (!sbi->s_backup_vhdr_buf)
 		goto out_free_vhdr;
 
-- 
2.25.1

