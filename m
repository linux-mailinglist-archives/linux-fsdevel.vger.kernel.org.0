Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390CD59B5C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 20:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiHUSEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 14:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiHUSEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:04:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7567E1D0C1;
        Sun, 21 Aug 2022 11:04:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gk3so17356523ejb.8;
        Sun, 21 Aug 2022 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0mjH/L/raz2hRtl4JqBX7W5LxbKv7sLJC/x4cvbE6K0=;
        b=guwh8MtqgsYrG8ZtG9JKLklCcQWaZ9SrBAt7+lwVBFS5pasNsy09xERw3oEHDVaz8w
         TLSuxbgvCHoDu6aWElb3eBRVTWi0O7+UWKxRteeFoGuxdPqQ10Qu8OsIHPNzr5GDOFfI
         ZlUDLNKCUoRjKQWwR7B3ecDUn+BWTmJO8kszh+27tpxN9lUYQz+0XoEaASzsBUfbI3BM
         BHBEqL4fgI/RaMYvIPIH4gk/CM64bRb7e8sI0zFNZ3CHVK7+8FDn9dB5ivrwlT3mXzvL
         SB9CkpeihW2+6Xj6TzTNZs+0nncuDc3Bf+2Eo8t5yBmKer8pTOp4sLS5E2H5LCJMKtdx
         GSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0mjH/L/raz2hRtl4JqBX7W5LxbKv7sLJC/x4cvbE6K0=;
        b=q/EdjaH3QHX56alLEJKSBZz49FxR+xtBWxiF5Eg1L4+/aFrDdcVXqfom/6NM3fp6GP
         IEsDL6KR9RxYnyymO/s8+4Bdomxh0OAniLKLZj4y4cWsJ0Pb3OpA+DBChLmbv9TMKcFg
         Gse+0N4ul/thpcJSL4TOjoiKVFb5KWpnma+4038wtq6oPJQZUlGbFThQ+sLN3kF9OztI
         PJ+Fe3o6OdYSfaNY748A2O4jkfkZLuPcmvkZ0AI2hkZBM3aWnGtE3hJn9Ir6OZMaLv5s
         1SS81EYPLAUV+/TGA4HSK7x/ksXOz0MbP68aeyzwJtxlR8BxL0t+WFS+GBECwAbFVxXW
         Xi9Q==
X-Gm-Message-State: ACgBeo2V0U1j2a0KIkThaIiTTMQfYjP5LNo+ME1VeW/38eXNDg7da0Mi
        GQ0yFhEzdQ0YGOZf53ModaM=
X-Google-Smtp-Source: AA6agR4j5HgPZw0Xm3Iw35e/+7axokf6wp3lAH1HS93wbPfYW/tILZO4UyQCBbYHLBJiVdD2ZVSxgg==
X-Received: by 2002:a17:907:2809:b0:73c:9d49:e8dd with SMTP id eb9-20020a170907280900b0073c9d49e8ddmr8583419ejc.306.1661105049042;
        Sun, 21 Aug 2022 11:04:09 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b007317f017e64sm5125916ejg.134.2022.08.21.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:04:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jeff Layton <jlayton@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RESEND PATCH 1/3] hfs: Unmap the page in the "fail_page" label
Date:   Sun, 21 Aug 2022 20:03:58 +0200
Message-Id: <20220821180400.8198-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821180400.8198-1-fmdefrancesco@gmail.com>
References: <20220821180400.8198-1-fmdefrancesco@gmail.com>
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

Several paths within hfs_btree_open() jump to the "fail_page" label
where put_page() is called while the page is still mapped.

Call kunmap() to unmap the page soon before put_page().

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfs/btree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 19017d296173..56c6782436e9 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -124,6 +124,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	return tree;
 
 fail_page:
+	kunmap(page);
 	put_page(page);
 free_inode:
 	tree->inode->i_mapping->a_ops = &hfs_aops;
-- 
2.37.1

