Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C414D8873
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 16:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242710AbiCNPrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 11:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbiCNPre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:47:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F303D493;
        Mon, 14 Mar 2022 08:46:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso188385wms.1;
        Mon, 14 Mar 2022 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zFis4A1NtQeLxMnXhGuuPtQ60nrevPLqoS/Xvsr95sg=;
        b=f5gs+TSGJckpSTyUcdUGwz3qLglSdo5mN09lNpCXxHa0XnYj3DWvdDm7wX0sal8OD6
         VCTIqjK3fyL/7vT3gJRyfrBWbRZl9qFTjnuuTDDt8otL/yBRYBOF5Q0H8CyxWPpr9j1+
         2K3R2IZNFMpl/H4UxGr7v2dKnUnQHFvyIx5iV1qEjFF4ncYBU6h31jYsHeipDzZ5qSKD
         DwS0A79SinTg2gUAMMSCVScj6ZMXkxitv/tSuwy3l0V1bsqyLlh7yjKFTDBaMkUkJ5B5
         yp2AfQijsgSUqx1alPpNUNNQfK77qE4kPIEfwtHx7LbVbOzas8jOfutOKrgSzsfwXy5l
         zZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zFis4A1NtQeLxMnXhGuuPtQ60nrevPLqoS/Xvsr95sg=;
        b=C1eteU0YgZWU5s83jjCRPR60oj+1AkBal/HK45VNvL9jkUyjQ+tLY8P1UpiHJtHzDQ
         Mj0f7soeGQYScW4OwCw76SDXmBY5neFyYO3hiZ1Qo/4lFBswt4KwgkIetqOsgVCbMuaI
         WrTY8Lz1Ky2OTO9qpRYepty25w/qX78EwvMVYP3mz9CloY65/iec6/naX0BYNqmMylpC
         rTaWe5Nz9Qw7cf+Fhp84/ecbn3Yxc+VweiH1mRsXLnH8Srjp/Y5P9XPLg7uh6I9xingh
         vLPy7hnv0eMUjgQpplTg36D70idvCA96hvoA0GLHyr1WrtAxL/HEALRTkGc0bLkTUpW1
         kvKQ==
X-Gm-Message-State: AOAM532G5i24SgnrbfVEOZZXyp8AqvYFd86sPpP7uoxGba+LcTTFG4hC
        z5sMIuuog8bq/m96tsmSqHGGNvgp1Zw=
X-Google-Smtp-Source: ABdhPJxjTgxk96MWcEpvJh3cNtenE36+KhpGmm+RrGV601V018GOEGRLsFO4ZsU2pVU/3AWNQnCMIA==
X-Received: by 2002:a7b:c4d8:0:b0:386:69ef:6ca with SMTP id g24-20020a7bc4d8000000b0038669ef06camr18046295wmk.6.1647272782115;
        Mon, 14 Mar 2022 08:46:22 -0700 (PDT)
Received: from felia.fritz.box (200116b82624ff0060a4091d550340a9.dip.versatel-1u1.de. [2001:16b8:2624:ff00:60a4:91d:5503:40a9])
        by smtp.gmail.com with ESMTPSA id r186-20020a1c2bc3000000b0037bdd94a4e5sm15371507wmr.39.2022.03.14.08.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 08:46:21 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] aio: drop needless assignment in aio_read()
Date:   Mon, 14 Mar 2022 16:46:05 +0100
Message-Id: <20220314154605.11498-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 84c4e1f89fef ("aio: simplify - and fix - fget/fput for io_submit()")
refactored aio_read() and some error cases into early return, which made
some intermediate assignment of the return variable needless.

Drop this needless assignment in aio_read().

No functional change. No change in resulting object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
I cc'ed Linus as he is the author of the referred commit, but I expect
that this clean-up just goes the usual way to Al Viro and then in some
git pull to Linus.

 fs/aio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index eb0948bb74f1..7b761d9d774a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1552,7 +1552,6 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	file = req->ki_filp;
 	if (unlikely(!(file->f_mode & FMODE_READ)))
 		return -EBADF;
-	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter))
 		return -EINVAL;
 
-- 
2.17.1

