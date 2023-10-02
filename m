Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73A7B51D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbjJBLzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbjJBLze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:55:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1092127
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 04:55:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50573e85ee0so2770528e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696247724; x=1696852524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttkA4jzwZY1WFt0tSKaN9VCRLgXvuReAZmOLs490YzA=;
        b=OzSZdZwWyUetaBv7dUE/xlPu0OrLfrUu9rEoXh9naOY+Da5KpgS2+DdayBGZQwsuyk
         alSmtVl2A+DizAzJ1ww5D7gjjdXLtRJHfvxN8wl0VkbyvRIzGMwAg2ZrVIQXp1kKG4hj
         dnJAKSbxFhLkWmPiofCBoDCTRdxd6hymeq0lQzAN9lWeF3215KQZ2qPMwkOJQ9eBy9LE
         iiVeiQII8yPX5mQ1HS+NWFzqzO3vZHWLxH2b1c4Y2yMvKawAk7rnB/h7/Qe9SmlmG/mJ
         y6ZDBSnjWJzXSrNLWyPSF1l616I2NTT8B4UvGtZDp6CekOsfGJ0mGPrUdVzd5WlsCwH+
         l/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696247724; x=1696852524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttkA4jzwZY1WFt0tSKaN9VCRLgXvuReAZmOLs490YzA=;
        b=VkzMUUEGryUIpv6Y0ataTW/OFhrslyfeEo8oqEYC34yKlpVuBjBKsepf7QiuLdxIFJ
         2v56Riv3KMSFl9Tlsgg4ZXM21ouj1wuesPzU3llzVDRUQiMFT4KagA0uFT4UaHGQN/d3
         Xc3yqWwk4AAm7BqJq5ock06HfqZvhLUAokMimAGK/qHiXEFGGXHijDLp18Dk3wwySONR
         bLK+4KnI2C+v+DjvzcyYxvASstuqlFz5UgSyBh8VmOsJvB0QqDYaIPkGZnY0ZBL2oQeF
         jQyLBPACviHFi2f2ePs34rAWAwhvUoeQUDlwxJhSJBBgMj84OC94OsL0H6ER34h7igzP
         ocOA==
X-Gm-Message-State: AOJu0YwJSoOItxy6mbQCAcBcbzBJBpho7NKIOo89AUSfOWMo9mSkNE/u
        XAldqVQTJhDtlhvyEfxRHQ60CCVCeK8=
X-Google-Smtp-Source: AGHT+IFsFZjo9w1X1ske1bJOGVEjt6bo0cBKrWRdaWT0GjdDQ7/K2Db45GVChh0/mVUo9kESgz34QA==
X-Received: by 2002:ac2:4dac:0:b0:503:eac:747 with SMTP id h12-20020ac24dac000000b005030eac0747mr8542525lfe.47.1696247723470;
        Mon, 02 Oct 2023 04:55:23 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id b7-20020a056512024700b005057a5587f0sm957680lfo.52.2023.10.02.04.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 04:55:23 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Gil Lev <contact@levgil.com>
Subject: [PATCH] ovl: fix file reference leak when submitting aio
Date:   Mon,  2 Oct 2023 14:55:17 +0300
Message-Id: <20231002115517.880433-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 724768a39374 ("ovl: fix incorrect fdput() on aio completion")
took a refcount on real file before submitting aio, but forgot to
avoid clearing FDPUT_FPUT from real.flags stack variable.
This can result in a file reference leak.

Fixes: 724768a39374 ("ovl: fix incorrect fdput() on aio completion")
Reported-by: Gil Lev <contact@levgil.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

This is a fix for an unfortunate braino merged to 6.6-rc2.
I will queue it up for 6.6-rc5.

Gil has caught this bug in post mortem review.
Thanks for reporting the bug!

Amir.


 fs/overlayfs/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 693971d20280..8be4dc050d1e 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -341,7 +341,6 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		if (!aio_req)
 			goto out;
 
-		real.flags = 0;
 		aio_req->orig_iocb = iocb;
 		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
@@ -413,7 +412,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		if (!aio_req)
 			goto out;
 
-		real.flags = 0;
 		aio_req->orig_iocb = iocb;
 		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_flags = ifl;
-- 
2.34.1

