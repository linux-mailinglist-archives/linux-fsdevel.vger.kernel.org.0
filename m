Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082D077F87A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351763AbjHQOOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351732AbjHQONu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:13:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144819A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so72112685e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692281627; x=1692886427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94vt/1idaHIvc/YT/I7DKK2AbMu5H/02VlhAjVP/4Ks=;
        b=EdTDYtmKRBu6AdnmmW+K92/EyFLEPRVqRxMRWNZTD3fBp68TJh8DxK3PpJKGk9jUzV
         ghKxAzi1w9R11Km6avxuYGoAtYDTfOQiepoJhpGmu1U5Dj97516zV1NR3TifFGgynwbY
         2fyMF4eSfea++BRv7WyC2m0lM758FPpXWkmDZzgWu1+4uGdEp06IFlcCM5SMnsvZzS31
         +IMOEcVE65br4vCK+nL2COC4QQykbrPqyOwektmqbDHm2SU30NtR1XXspSIQD0uhA8CT
         qYyZlfZHYKU4NYtZFl/eX87oqGdyGaJijrkoEcbKos5dARH/hTpTT3e+VGvZeNKxGmJe
         zoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281627; x=1692886427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94vt/1idaHIvc/YT/I7DKK2AbMu5H/02VlhAjVP/4Ks=;
        b=TF6y9iXM90t5n6CgvJIXeIkABEO39mF9RVMjzsqZGOba5Hg3QMFEsqUpVqKP/ehlY7
         Gf20giFlFoveHCmze5K4VzWBq4ETgZDjltsCFGe/QrSnGXwO2mtDI8nCtVuMOj9pACmF
         X+Zt7QoWg+0ouO9H2o9Yhm2xUEpq4CP08WqP01xSmR1nsVzXU5YRNwZDeR3GgMiNLt7/
         EUQOudTDmztajk0mqUHdgVlNSEkdKHQhCyPPwijYse8w/3wchjqxpqTfcGWfdz9op4Xo
         +EEp4TTR7OuGRgAmTnobGr9ZBRnyl8mljNjrzRVZcRQrexJTu6gqJZPhf15Q13jDd7+W
         sdUQ==
X-Gm-Message-State: AOJu0YyVupGM4uzAIg53mKHLBmJUs09fedDlA55KSKmkQDFsVxWFmboj
        E9aZwiVwgHmKQh6tLewa3Hk=
X-Google-Smtp-Source: AGHT+IH1l/p16clO7Qtzl6MXqNVk//judGaEOxYWWUMd6OygSUY6Vz939pVi4YU+MZzhkGE0WS97jA==
X-Received: by 2002:a5d:458b:0:b0:317:e18e:27bc with SMTP id p11-20020a5d458b000000b00317e18e27bcmr4859641wrq.71.1692281627202;
        Thu, 17 Aug 2023 07:13:47 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bca4c000000b003fe2120ad0bsm3080605wml.41.2023.08.17.07.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:13:46 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/7] io_uring: use kiocb_{start,end}_write() helpers
Date:   Thu, 17 Aug 2023 17:13:34 +0300
Message-Id: <20230817141337.1025891-5-amir73il@gmail.com>
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
 io_uring/rw.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 749ebd565839..9581b90cb459 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -222,15 +222,10 @@ static bool io_rw_should_reissue(struct io_kiocb *req)
 
 static void io_req_end_write(struct io_kiocb *req)
 {
-	/*
-	 * Tell lockdep we inherited freeze protection from submission
-	 * thread.
-	 */
 	if (req->flags & REQ_F_ISREG) {
-		struct super_block *sb = file_inode(req->file)->i_sb;
+		struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 
-		__sb_writers_acquired(sb, SB_FREEZE_WRITE);
-		sb_end_write(sb);
+		kiocb_end_write(&rw->kiocb);
 	}
 }
 
@@ -902,18 +897,8 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		return ret;
 	}
 
-	/*
-	 * Open-code file_start_write here to grab freeze protection,
-	 * which will be released by another thread in
-	 * io_complete_rw().  Fool lockdep by telling it the lock got
-	 * released so that it doesn't complain about the held lock when
-	 * we return to userspace.
-	 */
-	if (req->flags & REQ_F_ISREG) {
-		sb_start_write(file_inode(req->file)->i_sb);
-		__sb_writers_release(file_inode(req->file)->i_sb,
-					SB_FREEZE_WRITE);
-	}
+	if (req->flags & REQ_F_ISREG)
+		kiocb_start_write(kiocb);
 	kiocb->ki_flags |= IOCB_WRITE;
 
 	if (likely(req->file->f_op->write_iter))
-- 
2.34.1

