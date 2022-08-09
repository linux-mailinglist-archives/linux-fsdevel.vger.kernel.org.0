Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A365A58E120
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 22:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245497AbiHIUb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 16:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245467AbiHIUbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:31:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7F3A47B;
        Tue,  9 Aug 2022 13:31:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso953706wmq.1;
        Tue, 09 Aug 2022 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=C6jMsEHD+9BE7cLO107IUMZV7EzYBxJicgZ/uXZruiM=;
        b=XgDuAtfv8nBWmTgVXog7nsDRSVeu7p7fp3NgRdOFPutP8eWHd1OuydtngJTqqMaMRr
         aAyxF7uNGyLwI3Buymg8FKY0fPYc+X4bkq3P99yya2s/2E7uaebfIH6VuiSpRRkmqOWN
         +bHMxQFoBokh8og4st/uG2AfIXmEv2BPyMF0ahvPaO+fcuULgUgsL5QsUAg3P+fvjarb
         VFdzhUahrE7LtVKnRAHo/jz24wjsNsEVqxdY5aOjfHhIAaaVud5bvGhOal0FlCB9DA4T
         WbP14fdYcb2gXq2+KLGbp/q9anwSYAGC4fq90GYq6t50/X7JjjDbm81IeAugOWi6gajs
         XqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6jMsEHD+9BE7cLO107IUMZV7EzYBxJicgZ/uXZruiM=;
        b=UcDSx58KU62OcVkK90u0LuIKUi7OvhA3Ay5xczXnvN4M7OTTAD0QDLHdObZDsKk+Xg
         INYO7pOUA3qNUcOUlVvWwAcEApHkG+JH5Agp7b+wFFDEmr9NzRg9oHYvia6s9cHDLZCu
         x56Rxm75VliBf9PKbwo4RGO/TUVTJEvTStZX6TfL9/xmXAHkQi2mqo8RTQRhf9wE2SVc
         PEDDBVPFC7rUO/VyrOhq25V3lDKEWgV3KdRkhwIaGtAk2qAhl42ftbk3U8eqM3VTa0MU
         JxmRGEKTmw7p0EYcNXjsV9TP5DKpIFVFL5N/0F1RSqTV55knlCbUzAdXx9KGLVTgehOF
         qDDg==
X-Gm-Message-State: ACgBeo12GBYbT9nu4nf18tu0LtAM/vYYx8wFo8VD6GFwF8XOQfokgzPd
        7gIieEGdHHPeh+9suTjyaVE=
X-Google-Smtp-Source: AA6agR4j76MuyV0kEK/jsRIquQ+3LfBPUcjWL3AXkbc3CFMbxHrY2VGM0+iVNFypopBYZxB01BO0RQ==
X-Received: by 2002:a05:600c:501e:b0:3a3:4a04:fdb5 with SMTP id n30-20020a05600c501e00b003a34a04fdb5mr133630wmr.168.1660077075174;
        Tue, 09 Aug 2022 13:31:15 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id ck15-20020a5d5e8f000000b002205f0890eesm15085263wrb.77.2022.08.09.13.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:31:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] hfsplus: Unmap the page in the "fail_page" label
Date:   Tue,  9 Aug 2022 22:31:02 +0200
Message-Id: <20220809203105.26183-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809203105.26183-1-fmdefrancesco@gmail.com>
References: <20220809203105.26183-1-fmdefrancesco@gmail.com>
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

