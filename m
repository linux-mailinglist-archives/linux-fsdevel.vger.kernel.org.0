Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6076F2A75
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 21:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjD3TbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjD3TbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 15:31:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5763171F;
        Sun, 30 Apr 2023 12:31:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115e652eeso22988239b3a.0;
        Sun, 30 Apr 2023 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682883067; x=1685475067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlsJcu/owJRrewoN2aRAwgzKM6GWcL4oq43DrBBCLyg=;
        b=e1gXWRJ+lF5vAfKGBUYK74U9MMM91eT1I3BSLNVRvuY7BZ7sy26hFR6sMBUv1L6e7i
         WfP8oDcKCy/zq/kGN9idkc7TmQT8cYCkppBirtSAaNEvzUen6OsI3Tu8RUd2nVkHllpC
         PGbfj10Lti5yebEYTXfHrbcjSD0olULKbRWPhIDXUUGHadgzKFAjvQ9/8/J/fMTBnZR5
         P/UqnTOcGV/4caKKKQtSQ2efnZqrDTYdA9Ruvvi1LzkVWVKysDMYJXI+D3SOqUL4Zw8f
         LRmPz28XUE3Wmddr7DoPYsg9slogv4PGBnC0OowyQFMZmADMX6NEUQeut3hBpvoMovdr
         gRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682883067; x=1685475067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlsJcu/owJRrewoN2aRAwgzKM6GWcL4oq43DrBBCLyg=;
        b=NqanS2UwSlPb98UgH/zup5fbIFmwpm6jQD0XPu2n7xx5aUjabva9tNe2myvx/gj/FC
         PIkl8PDutkWzE0wUKyh1ro5eUiBHkmNet0hC+Buf4G8UdJqB2s645DWZ2CrGp9ILcaUI
         HI+4mkGSzNJIyzhMtWsk4uFGNBQoZ4Jv0//2C92Q5CpTu2rdiIw+tlsHfDabtkqQJ6fL
         +wvpN6p9PfSBKxrta3vci/aPITnPxhbSoufmZAGO9MBkhCvXy28G2UV925kLhiYAj11j
         cA26IK7XCU3ExSKPg9e5bGIJ1NA7Hs1XO+NSwbSzOSnNH3n81iaTG10rZ4Y4JnJXfke+
         c89w==
X-Gm-Message-State: AC+VfDyGZ+P8CafIDUoQvmDx48DsM9QKtqnLEHP1KwK2/0flpVQXqOlk
        YLo82+JJ7offmVok96diSGjunkbUX6U=
X-Google-Smtp-Source: ACHHUZ6zijDOZL09bSk0eJh4hiiopxGIRuA8zUOXtIQzDFvFXCcnOOAB5ah1wyH9z2wrfsPaz9ojcg==
X-Received: by 2002:a17:90b:f8f:b0:24d:e504:c475 with SMTP id ft15-20020a17090b0f8f00b0024de504c475mr5186813pjb.21.1682883066788;
        Sun, 30 Apr 2023 12:31:06 -0700 (PDT)
Received: from carrot.. (i220-108-176-245.s42.a014.ap.plala.or.jp. [220.108.176.245])
        by smtp.gmail.com with ESMTPSA id c24-20020a17090ad91800b0023d0d50edf2sm17898386pjv.42.2023.04.30.12.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 12:31:05 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+221d75710bde87fa0e97@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] nilfs2: fix infinite loop in nilfs_mdt_get_block()
Date:   Mon,  1 May 2023 04:30:46 +0900
Message-Id: <20230430193046.6769-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKFNMonK2VcZx=KEG8cz61bhwMvChEJ=T+FecxpGg1QiRCcZhA@mail.gmail.com>
References: <CAKFNMonK2VcZx=KEG8cz61bhwMvChEJ=T+FecxpGg1QiRCcZhA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the disk image that nilfs2 mounts is corrupted and a virtual block
address obtained by block lookup for a metadata file is invalid,
nilfs_bmap_lookup_at_level() may return the same internal return code
as -ENOENT, meaning the block does not exist in the metadata file.

This duplication of return codes confuses nilfs_mdt_get_block(), causing
it to read and create a metadata block indefinitely.

In particular, if this happens to the inode metadata file, ifile,
semaphore i_rwsem can be left held, causing task hangs in lock_mount.

Fix this issue by making nilfs_bmap_lookup_at_level() treat virtual
block address translation failures with -ENOENT as metadata corruption
instead of returning the error code.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+221d75710bde87fa0e97@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=221d75710bde87fa0e97
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/bmap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 798a2c1b38c6..7a8f166f2c8d 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -67,20 +67,28 @@ int nilfs_bmap_lookup_at_level(struct nilfs_bmap *bmap, __u64 key, int level,
 
 	down_read(&bmap->b_sem);
 	ret = bmap->b_ops->bop_lookup(bmap, key, level, ptrp);
-	if (ret < 0) {
-		ret = nilfs_bmap_convert_error(bmap, __func__, ret);
+	if (ret < 0)
 		goto out;
-	}
+
 	if (NILFS_BMAP_USE_VBN(bmap)) {
 		ret = nilfs_dat_translate(nilfs_bmap_get_dat(bmap), *ptrp,
 					  &blocknr);
 		if (!ret)
 			*ptrp = blocknr;
+		else if (ret == -ENOENT) {
+			/*
+			 * If there was no valid entry in DAT for the block
+			 * address obtained by b_ops->bop_lookup, then pass
+			 * internal code -EINVAL to nilfs_bmap_convert_error
+			 * to treat it as metadata corruption.
+			 */
+			ret = -EINVAL;
+		}
 	}
 
  out:
 	up_read(&bmap->b_sem);
-	return ret;
+	return nilfs_bmap_convert_error(bmap, __func__, ret);
 }
 
 int nilfs_bmap_lookup_contig(struct nilfs_bmap *bmap, __u64 key, __u64 *ptrp,
-- 
2.34.1

