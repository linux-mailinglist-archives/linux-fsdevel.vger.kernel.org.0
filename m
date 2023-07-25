Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1101A761FBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 19:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjGYRDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjGYRDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:03:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C2F1FEC
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 10:03:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so47015635e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690304604; x=1690909404;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4+AkqHfBt+YF57UntWNN2nKkLF9PtsmEtzT5w0gGjw=;
        b=R8+j0MkNrQ9S1wsciu9YPQVqDiyOWBtNFsYYRAYkSldu25nmGXgnlE75BefikcMfLG
         4SEFn3CZL1vNb3HOeviMoFSF3L730rOMzcL7qUFVoRHEREDW0WdcWtOmKbzMVlfae5T5
         TsIDLX6YD4no0mPEHSW/5ZNX+eV/v8ncrX/4CRdwb8j1Joj3YKPEgits7wlA2y7RMXbr
         jqro8ts/A8MQfam9HTsPOhxDN4/coVhxV3a0codjQhF0gulrZn9lj2iVIyNJxYY5YE53
         WihUiIKfhYMgoJPvEnpRc0Q4Ij1WHEf6sE1d2HRjx4+Z8Aytuo5Z79P7R/1zJktYzIMg
         9dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690304604; x=1690909404;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4+AkqHfBt+YF57UntWNN2nKkLF9PtsmEtzT5w0gGjw=;
        b=gFNLPcjaDxwB4rXtHPgyLdS5RLfqEkCkURM3mzDe1sF+jB1HRHhQqXb0KiYnG8bDNT
         S4/nLiabdFKYbSalWf3zti5Jd7dU0XFss56CLnr1Xc/xQ7yFdGlJDP0WEn/W7ucEptkw
         pG9aqHDx0JqcLOv3cQq/sUTZd9PadSxKh1ncIhoMXivy7+NgO8NCTtTb+XJWy7k05/ov
         g+ZO1WqHI6XPURsw9FWjDByzpG4JcZMnA/b0/wbAsIJ535S53539ACtoUL4v0lbZt819
         XHRo1bx9/+L5TcCcFY171QoEbWGoCzS6Zfw4ngpRgD7RHPZBQggrPYOZyVFeHDf9TC2P
         uOXA==
X-Gm-Message-State: ABy/qLbr3yScHi6VOpqO3zU+NCpGSb0CwWmQV9CP6NhWSr8JfkxxRui/
        cnSib4WYmQyfC/m/Z3EeUH0kAw==
X-Google-Smtp-Source: APBJJlGgjQxBjIlV3D6Fz51keIByk9Gjjuex8YMFGkODUlaMAU9GW06ihUuImle6v5gOk1v8OaNujA==
X-Received: by 2002:a1c:7c08:0:b0:3f9:70f:8b99 with SMTP id x8-20020a1c7c08000000b003f9070f8b99mr8493034wmc.7.1690304604300;
        Tue, 25 Jul 2023 10:03:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c1d0500b003fbb1ce274fsm6046067wms.0.2023.07.25.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:03:23 -0700 (PDT)
Date:   Tue, 25 Jul 2023 20:03:16 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] proc/vmcore: fix signedness bug in read_from_oldmem()
Message-ID: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The bug is the error handling:

	if (tmp < nr_bytes) {

"tmp" can hold negative error codes but because "nr_bytes" is type
size_t the negative error codes are treated as very high positive
values (success).  Fix this by changing "nr_bytes" to type ssize_t.  The
"nr_bytes" variable is used to store values between 1 and PAGE_SIZE and
they can fit in ssize_t without any issue.

Fixes: 5d8de293c224 ("vmcore: convert copy_oldmem_page() to take an iov_iter")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cb80a7703d58..1fb213f379a5 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -132,7 +132,7 @@ ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
 			 u64 *ppos, bool encrypted)
 {
 	unsigned long pfn, offset;
-	size_t nr_bytes;
+	ssize_t nr_bytes;
 	ssize_t read = 0, tmp;
 	int idx;
 
-- 
2.39.2

