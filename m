Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E32738452
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 15:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjFUNDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 09:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjFUNDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:03:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB7D10D5;
        Wed, 21 Jun 2023 06:02:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so6754356f8f.0;
        Wed, 21 Jun 2023 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687352578; x=1689944578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p1snc3z/xTJ1VfTgS+xUuvVWJtWsmykCdplUwtlGRSE=;
        b=Lv4pPl5dm1tsCSiRwC/EEKizLn2tjonFfrmr7Oafj5RDquW7/Ldy5JXUJ8F0yhXkc1
         0ci9gANBVnN3QjvRMNMK9oBQ/9ET93rXCqnGxOmfxpUbEcicRtPwyOJ3wQ/wdSb6gIBQ
         VIZykLT714hMtjOr9RyqgpNHJw7xxpKzoL+oWLgPXcewKCg9e3Oz5cFWQ8X/CbUWVoKW
         A3T9SK5CRgsPQe1H5O7agHVTpp9ajp/9calCpm8iEXyCJdXOaGPhQh03ma1uaQ8E65jo
         nyyj9jZlBiIFuaegbONQDlVBg7UK/ZAMu0rXnzJY0Et/1eYjgw3Ur6ejQZbF1B68NfKk
         aYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687352578; x=1689944578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1snc3z/xTJ1VfTgS+xUuvVWJtWsmykCdplUwtlGRSE=;
        b=as8PUm/V44zwteEOxPf3q1D75TMb2JKbOOCAmk5sUvgJlKf+KAP9eK36l1p/iCu7nz
         a/PU/Mhj8HcGCODuJ1/zKrxctsyoUEu1Od0cEIVTI5ffCxwxdJcPSeRQsorr8wTz9UeE
         SNLOyoruMpixcn5WRZAohbcQDEK+lcWBgUVjA3bWFMsfHQ9ymXvebY2NO//LTm6DwxHP
         aou3RwXE2HdVXWFMYnSQSq1PentR+MSfWFc4CAHRDuhn3EG6eyF1KQt/ItDRJudAViEi
         11hF6owvUIAQwoC+LWQQ64G48QfLNKVhHPz2TQZUFB91AdW3YUUke07fMwqDB8L82c0C
         JR2A==
X-Gm-Message-State: AC+VfDzI4iC61evtxWVj994+2TgjcInrmZAbvOpgUEkuwx0FNR5D7jDk
        RA8eseO5gJ0Rz0fnMV6wTKQ=
X-Google-Smtp-Source: ACHHUZ5rBNQwgTcud7BCqacDwmxN/UgQThg2UpRWHJDkiKd0tH6NmS6ySa/0h+ZN+TOtXqP9XTNOpw==
X-Received: by 2002:adf:f30b:0:b0:311:1390:7b55 with SMTP id i11-20020adff30b000000b0031113907b55mr14800141wro.68.1687352577531;
        Wed, 21 Jun 2023 06:02:57 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6812000000b0030ae69920c9sm4413853wru.53.2023.06.21.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:02:56 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fsdax: remove redundant variable 'error'
Date:   Wed, 21 Jun 2023 14:02:56 +0100
Message-Id: <20230621130256.2676126-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable 'error' is being assigned a value that is never read,
the assignment and the variable and redundant and can be removed.
Cleans up clang scan build warning:

fs/dax.c:1880:10: warning: Although the value stored to 'error' is
used in the enclosing expression, the value is never actually read
from 'error' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/dax.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 2ababb89918d..cb36c6746fc4 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1830,7 +1830,6 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 	pgoff_t max_pgoff;
 	void *entry;
-	int error;
 
 	if (vmf->flags & FAULT_FLAG_WRITE)
 		iter.flags |= IOMAP_WRITE;
@@ -1877,7 +1876,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	}
 
 	iter.pos = (loff_t)xas.xa_index << PAGE_SHIFT;
-	while ((error = iomap_iter(&iter, ops)) > 0) {
+	while (iomap_iter(&iter, ops) > 0) {
 		if (iomap_length(&iter) < PMD_SIZE)
 			continue; /* actually breaks out of the loop */
 
-- 
2.39.2

