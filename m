Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506FE77F87E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351772AbjHQOOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351752AbjHQONx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:13:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7252D62
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so6760565e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692281630; x=1692886430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hPKs0GOoVg3cqCYGl2vRlZGuMORn2bJcknZXohZPAk=;
        b=YsKiFGzpQnVXuvaWOR3QG+6o98q7Oax/35zGMCTPHqJFKz7omFQxLtE/ylGM499Wmv
         pK096XPF8u/sTjs3uRJTYHaDvoL+qPHGLCYz2ZVR+PRE9NQfTd5Zv5k/ffSiCJ7DyLvm
         lt/tf3jMFkkyIl6FDzXQFFlhnF1+GaRc3Q15prwCyZ9AggUNXNrMUAFEYrSlaLkPm3K7
         N/S20sggUn43vOaaNZhaxjmU0adqKmFNITagmF5w+JqsOW9dVYiZ6pNR+zcJRZnSfuXm
         h4i+vbs6MTIN3+cFSwTNkoUxmSUOrvV6yFLwBJ/8nING27MDgvyDnhTkCogzux1OBP3n
         uHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281630; x=1692886430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hPKs0GOoVg3cqCYGl2vRlZGuMORn2bJcknZXohZPAk=;
        b=Pv/p7pE/HS31fdCwlq0TgHpq0JrDGtr/5oQoS+DG93tvo0jqhIIq9iVR+Sw8r+TZm2
         AyCIqv2TZYnC4L+IDwT/MnUt0Z8QveL6ZQlgyj2OBAc7k792b4c7IN9S4vfxQ+eAqO1s
         wNJBWVWPDemc5GPphNmduM8wWev4zcNMN/J/WhNo0CEcr7v0V6pIPWZoyw5CaMdNINJU
         Kqa0Peq6d7eKPfAV1tJ/ZN+0eykQl9hYi4lI260Py9lehRiUskpONOkwb7Sv8qV6zl/v
         QMHmZGi7dj4pKkpfDSSEyFqGQx0f6kQ6EuVTk8P7baFhFhs5+BUKh22yzfPyXqCkGC5V
         nmAQ==
X-Gm-Message-State: AOJu0YyGyIS2j6uXuUt+vGqdG9l9xcpJVivKkcPYx14wJwBjMXG8WwA6
        P+Rt7+fsssNMqmrLubeqXAo=
X-Google-Smtp-Source: AGHT+IEwzGJ5dFx0eATPhnyazDW1z8qfbo/3I7KH0Kyv5gSl7pcvqE/6fv6TAkrAuSQ9k7Hm5S0/cg==
X-Received: by 2002:a05:600c:201:b0:3fa:aeac:e978 with SMTP id 1-20020a05600c020100b003faaeace978mr2446679wmi.0.1692281629841;
        Thu, 17 Aug 2023 07:13:49 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bca4c000000b003fe2120ad0bsm3080605wml.41.2023.08.17.07.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:13:49 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 6/7] ovl: use kiocb_{start,end}_write() helpers
Date:   Thu, 17 Aug 2023 17:13:36 +0300
Message-Id: <20230817141337.1025891-7-amir73il@gmail.com>
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
 fs/overlayfs/file.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 21245b00722a..e4cc401d334d 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -290,10 +290,7 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	if (iocb->ki_flags & IOCB_WRITE) {
 		struct inode *inode = file_inode(orig_iocb->ki_filp);
 
-		/* Actually acquired in ovl_write_iter() */
-		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
-				      SB_FREEZE_WRITE);
-		file_end_write(iocb->ki_filp);
+		kiocb_end_write(iocb);
 		ovl_copyattr(inode);
 	}
 
@@ -409,10 +406,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		if (!aio_req)
 			goto out;
 
-		file_start_write(real.file);
-		/* Pacify lockdep, same trick as done in aio_write() */
-		__sb_writers_release(file_inode(real.file)->i_sb,
-				     SB_FREEZE_WRITE);
 		aio_req->fd = real;
 		real.flags = 0;
 		aio_req->orig_iocb = iocb;
@@ -420,6 +413,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
 		refcount_set(&aio_req->ref, 2);
+		kiocb_start_write(&aio_req->iocb);
 		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
 		ovl_aio_put(aio_req);
 		if (ret != -EIOCBQUEUED)
-- 
2.34.1

