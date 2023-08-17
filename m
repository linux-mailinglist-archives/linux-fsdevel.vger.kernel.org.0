Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709A777F876
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351760AbjHQONw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351752AbjHQONq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:13:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71FD19A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so71517435e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692281623; x=1692886423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7ICMkH65UcVD55kOKs6w9umxId/+drdtlAdE6skSpA=;
        b=slcYlZLdjA9XF+iZzfvG+CR6zQY8D3ztV85fa5EPHB74LKTQZx9xoEM2/x4h0EWp+H
         9RsRPiVZXgv/xxMYOSMkGKaGLRt2cGCQ4uPWdkfNOEBKuUaD2Fh4VSRaD1J5vqlZtVBY
         w6rSIgmuRVjhRjNWCLR2W30v7vS05gsIyGvfDmxva6fFAiTPx/1Udg0zOfVdgszxhkDa
         2/l/SmMm193wuEYnjoDAyCGtlWr1XP6AYS6rqxzfef+kRIfuR6a2isj1R/oe7bhyO4vA
         ZnTX1cr8dqgfUgfTLJNdgqq8Pfl28o1ODg9EF7RYwXraJXWA2XTqRjsB9Py2mvRLpJWv
         5R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281623; x=1692886423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7ICMkH65UcVD55kOKs6w9umxId/+drdtlAdE6skSpA=;
        b=V5RJjx1Ebgu2vnuGxGCNb6GpdoEMmCQbJ/ksFPE673aBKZd4VJ77Xi3IOOsjMCtb4i
         HeVyAAUQLvy4Q/NPmIJQG9Nmj4YrNCI8n2ND/HIxXsiZB83aRy1GIc0GdS/lp1QmOgfI
         58JOgP+FkdQx90rmDRJ4X8glPnapO9+t/9pqlmwjv6lu5r227Fd+FZaj0/JGsLMEc1n8
         R6vUVBt7Hn5vECulOB5K/LNyZDsXOHc2dZl7LinJH1tCIL3q3H1GgHmiTdJqlIyQcPep
         rB2ZkD+ycv8+rYQAwgMDY0BxqKWjhzxgXnQLDxr7c47mU2nYArZmIrHdxlFzeUnqwrDl
         7nIw==
X-Gm-Message-State: AOJu0YxaT0VrBH+iFJmXL2F3/5Pp14T7479hdclbkghDu35z/ojHJB37
        jYXCtJWYW2+sudcSFT9W+1I=
X-Google-Smtp-Source: AGHT+IG04g8sSgPkc2dhCES3h6fWN/T8KPDqv9aAzvSDT/OoSZh7s3BLgBultkOoNLqmecw+y9fxgA==
X-Received: by 2002:a1c:4b08:0:b0:3fe:2186:e9ad with SMTP id y8-20020a1c4b08000000b003fe2186e9admr4250623wma.6.1692281622888;
        Thu, 17 Aug 2023 07:13:42 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bca4c000000b003fe2120ad0bsm3080605wml.41.2023.08.17.07.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:13:42 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/7] io_uring: rename kiocb_end_write() local helper
Date:   Thu, 17 Aug 2023 17:13:31 +0300
Message-Id: <20230817141337.1025891-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817141337.1025891-1-amir73il@gmail.com>
References: <20230817141337.1025891-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper does not take a kiocb as input and we want to create a
common helper by that name that takes a kiocb as input.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 io_uring/rw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 1bce2208b65c..749ebd565839 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -220,7 +220,7 @@ static bool io_rw_should_reissue(struct io_kiocb *req)
 }
 #endif
 
-static void kiocb_end_write(struct io_kiocb *req)
+static void io_req_end_write(struct io_kiocb *req)
 {
 	/*
 	 * Tell lockdep we inherited freeze protection from submission
@@ -243,7 +243,7 @@ static void io_req_io_end(struct io_kiocb *req)
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 
 	if (rw->kiocb.ki_flags & IOCB_WRITE) {
-		kiocb_end_write(req);
+		io_req_end_write(req);
 		fsnotify_modify(req->file);
 	} else {
 		fsnotify_access(req->file);
@@ -313,7 +313,7 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 	struct io_kiocb *req = cmd_to_io_kiocb(rw);
 
 	if (kiocb->ki_flags & IOCB_WRITE)
-		kiocb_end_write(req);
+		io_req_end_write(req);
 	if (unlikely(res != req->cqe.res)) {
 		if (res == -EAGAIN && io_rw_should_reissue(req)) {
 			req->flags |= REQ_F_REISSUE | REQ_F_PARTIAL_IO;
@@ -961,7 +961,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 				io->bytes_done += ret2;
 
 			if (kiocb->ki_flags & IOCB_WRITE)
-				kiocb_end_write(req);
+				io_req_end_write(req);
 			return ret ? ret : -EAGAIN;
 		}
 done:
@@ -972,7 +972,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		ret = io_setup_async_rw(req, iovec, s, false);
 		if (!ret) {
 			if (kiocb->ki_flags & IOCB_WRITE)
-				kiocb_end_write(req);
+				io_req_end_write(req);
 			return -EAGAIN;
 		}
 		return ret;
-- 
2.34.1

