Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8089459B5D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 20:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiHUSK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 14:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHUSKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:10:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921101F61C;
        Sun, 21 Aug 2022 11:10:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b16so11298643edd.4;
        Sun, 21 Aug 2022 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jYj5mCWvOjlW6xecbhNlhHuS+q5rYaMaftIgTax2JSA=;
        b=gwxheF0L63ElIWReq3YUmOQgIR5oDk9yrM2IxdTf2crJHflaisczuqAld101Dy9z+E
         ygFa3mhHF+BSGtQHEitM4N++r6v0XwS9wIr+HcLldcb2kwcwNMmDhgOez5saqz5l/p3v
         guNfB/qZQ/AK5WWdb07dEbcmBF50+DmF2orUboAerretT9TttojJCS2Psgw6EOzWDkQj
         W/DPy89ESIP0Yx1CaPd/5t5Q+E5N/6UlKInE5h0nZNwiteLnJrFG/U0ZkBgLwl1AuvBL
         MEw+ptmTGSqP2KezZALPrNRAeoPlcjTwWdwWM4GmGPyX7cyh4V8SL3z2CXvbLaJaPh1M
         mNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jYj5mCWvOjlW6xecbhNlhHuS+q5rYaMaftIgTax2JSA=;
        b=jvLBfuXbZV2r6EmfVmtSpAlX0/PNFerPCUSAgfs9hQxhVR3uVHpzVqKbmbm939pTiR
         abQtq6oND9DU44qZU4B2vc3YnRZNzSAVeBfIgx/pEFGT5HVxpGMqM7mRYeEBgMmTXE14
         06k2o9wjkLRQ+monHBtau3pUFXGLdr/kwjb6QQqdbQkAeFL5Rysw0KmyjNKAwLuQmjcW
         JQ7kVL5oymf6R7Qq0yU1Mt4NJ6DYjn+026AjF3PlAvVTGwL6LEaP4KXmqkASmdzEWYfE
         pFJaZCb6mcFcSIne+5C0UMeEonAqYv81X6l0Iwy/q510H+FrLq7bGiUcFeZhhHv5mjf0
         sEtA==
X-Gm-Message-State: ACgBeo0MpTJKMJ7RJgPoqIZ9ALnbETARn6zG5D2fH5AJmGZ+ChOfV4TB
        yxgXgpUujBCfD70C4cCxuxY=
X-Google-Smtp-Source: AA6agR5z2XjUVoKdvWOyMY/zDACnaLsPEY3+Ahzzq7coE6eLa+4SccWoksduivlZnk/t+Gch85cX3w==
X-Received: by 2002:a05:6402:438d:b0:446:a0b4:630d with SMTP id o13-20020a056402438d00b00446a0b4630dmr3126032edc.118.1661105453171;
        Sun, 21 Aug 2022 11:10:53 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id g12-20020a056402114c00b004404e290e7esm6854178edw.77.2022.08.21.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:10:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RESEND PATCH 1/4] hfsplus: Unmap the page in the "fail_page" label
Date:   Sun, 21 Aug 2022 20:10:42 +0200
Message-Id: <20220821181045.8528-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821181045.8528-1-fmdefrancesco@gmail.com>
References: <20220821181045.8528-1-fmdefrancesco@gmail.com>
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

Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfsplus/btree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 66774f4cb4fd..3a917a9a4edd 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -245,6 +245,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	return tree;
 
  fail_page:
+	kunmap(page);
 	put_page(page);
  free_inode:
 	tree->inode->i_mapping->a_ops = &hfsplus_aops;
-- 
2.37.1

