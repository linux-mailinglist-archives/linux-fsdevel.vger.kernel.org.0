Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0718277F87D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351767AbjHQOOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351756AbjHQONv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:13:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173842D5F
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so73292155e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692281628; x=1692886428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01MW54Au9NUwA8e9f7upFmoGRXxdL3zdCS86s3nEDnU=;
        b=pl3HYsZ/H1AAXP+Z3PISt/CfPjLW+BVEZsPu7GPy6ISKwS9b6m6GrvKQdEsYOvrJqn
         eRI7IPC7NGZ45MH5heANojT2y+7xQBKklHqt6mFBx/os0a0OGMbqd0rqjmvVCYAwXDdi
         2uhNKCUdi6pwHa6U+zLI2ZS8X9nX3mT3WrTF3Zuo5xc38yNhAtS61+d6KrQXJNd1lMvo
         4GOcOAwEuhe+oJ4kubtMKTWZgcFOyRtnzD1ojbDBzQmw5dETkG+k6k60el/UPSY9NmpM
         pWGBs1D5NyhMAKoWCm0qyXFygz/zrHGQniAuo/D9qhbCr0ZiDRyELuRVXCxNMZvrR8hF
         MemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281628; x=1692886428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01MW54Au9NUwA8e9f7upFmoGRXxdL3zdCS86s3nEDnU=;
        b=CkCFJWvT4a6FgEgQQoDxdO9GCeKPq5mxkwvxiBBynv4hYb0uOBDVa6rg97DUJ8tmIK
         ZB91OHsaAiDoGQM9wX3J5NzX4JExRPhUGJekcHhHMxDE6fsmLhWs7DvMBH9Qv9MYP7wZ
         g5AMSWTfggINbUjYBbrJ93GVDXHciwXbG+Mnn86PBRLZeqhgeZuz+xc/TeboBili+zBp
         /3Le5vsYiddXgqLYWA5WyfuW57eeUdc9q0eHNSYBjYCnJJJHw+P1mTlM/8TKkTlItf69
         1+T7xi7lc9tSiZi7+TcmOO14wWFHK/tQjayAMVhGPKuVYhJBwbOgL09Qm9MWsSvLT2F6
         iZyw==
X-Gm-Message-State: AOJu0YznBkMUprtlrQKDGWtfZm3lW76OgTQ48HwsyZFUqQj99a7/Nnyu
        +apwJ/HQmkLz45nME+vF56o=
X-Google-Smtp-Source: AGHT+IEJSAGi/LG6w9lmHDGQOkfSrF30o8YbJCLeBMQzPszsX2vhDa41qwbNFT+Sdfy/6qtdxcUwJg==
X-Received: by 2002:a05:600c:b58:b0:3fb:e2af:49f6 with SMTP id k24-20020a05600c0b5800b003fbe2af49f6mr4068123wmr.39.1692281628520;
        Thu, 17 Aug 2023 07:13:48 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bca4c000000b003fe2120ad0bsm3080605wml.41.2023.08.17.07.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:13:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 5/7] aio: use kiocb_{start,end}_write() helpers
Date:   Thu, 17 Aug 2023 17:13:35 +0300
Message-Id: <20230817141337.1025891-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817141337.1025891-1-amir73il@gmail.com>
References: <20230817141337.1025891-1-amir73il@gmail.com>
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

Use helpers instead of the open coded dance to silence lockdep warnings.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/aio.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 77e33619de40..b3174da80ff6 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1447,13 +1447,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
 	if (kiocb->ki_flags & IOCB_WRITE) {
 		struct inode *inode = file_inode(kiocb->ki_filp);
 
-		/*
-		 * Tell lockdep we inherited freeze protection from submission
-		 * thread.
-		 */
 		if (S_ISREG(inode->i_mode))
-			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
-		file_end_write(kiocb->ki_filp);
+			kiocb_end_write(kiocb);
 	}
 
 	iocb->ki_res.res = res;
@@ -1581,17 +1576,8 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret) {
-		/*
-		 * Open-code file_start_write here to grab freeze protection,
-		 * which will be released by another thread in
-		 * aio_complete_rw().  Fool lockdep by telling it the lock got
-		 * released so that it doesn't complain about the held lock when
-		 * we return to userspace.
-		 */
-		if (S_ISREG(file_inode(file)->i_mode)) {
-			sb_start_write(file_inode(file)->i_sb);
-			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
-		}
+		if (S_ISREG(file_inode(file)->i_mode))
+			kiocb_start_write(req);
 		req->ki_flags |= IOCB_WRITE;
 		aio_rw_done(req, call_write_iter(file, req, &iter));
 	}
-- 
2.34.1

