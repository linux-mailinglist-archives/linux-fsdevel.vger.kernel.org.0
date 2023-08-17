Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67C477F882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351774AbjHQOOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351764AbjHQONy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:13:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D803B2D72
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso78718675e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692281631; x=1692886431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loU71ecSUmvR569PkG5F+KhO5I3El9Dcps9V9L1plyc=;
        b=ZMpibJbyt9JdjnVcgtTKGjgd9X9iogICvmKEEHZ2a7ECsbiC83qaOsdMxpl/hjPfXH
         Vd9bfCTGkO7e1UC1pkbl9uyrg2Kj8hwEIxR8qG3Xe9O04PwzNr99qjtTTX76PlJI/ej3
         3dxf1QwH+cd3LEKdYcJmFQAgkZ0BjExmehIAqDKWvzmue+2AQu/8YYH7Fdtqt8J+VBbI
         XCAHJv5kQwiF7vQs6DCNA7AddsEn/ZP19KfY88tlkStHYilVkPx7REg4VN461qJceEVj
         rIzvQCJQlsfaHXhhA3cXKY1/VORRD9MDsQb4G6heYCazednYhN7td9Qkh+TEY057SFGR
         BfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281631; x=1692886431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loU71ecSUmvR569PkG5F+KhO5I3El9Dcps9V9L1plyc=;
        b=b9K24a/ZYZYneC8bk5i63qLLHEyZSYBZE2cqHCyGQG6+6ZfFezJJzjswxApAAYz/yl
         rJ6jvP/pt86TnJzglq+o/MLZEsZKMgTjTo5bd0nxJ9AmfFvbKvnrA8xkIBm41vdzG963
         7cRQ0E4N73QPSvGKuP8RWd2bN6u833K5EtI8020gAbtUwjX+rkcvs6OaK1s5VVPy5cLy
         shLkYHMPNLfr0ktsSK0HgpgCB9rh4BO90DDMAseyKQ07PoGPRWjvmcQ1JziTKaN9enV1
         2n5/iHh/A8UcMeEDsHI5HHJ9A4t9H/3f4k1l+43+YaYcqX2slefIODBg3acu8f7XXfpR
         Vznw==
X-Gm-Message-State: AOJu0Yw4X6pZiPzYUNOoNn3YoI5/azYAaXsc/ydjBFcbuq0jmXCDusJ0
        yR1lb6DGRr5Q/hsXEzjoOV8=
X-Google-Smtp-Source: AGHT+IFk8Dvu24/0upCDxaOGWe5RtxhdCbzsY0BMU0dCE+1Ypb36en0+2V8y8gn+NBst6dUXoeo5OA==
X-Received: by 2002:a05:600c:220c:b0:3fe:f45:774c with SMTP id z12-20020a05600c220c00b003fe0f45774cmr4209629wml.41.1692281631366;
        Thu, 17 Aug 2023 07:13:51 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bca4c000000b003fe2120ad0bsm3080605wml.41.2023.08.17.07.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:13:50 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 7/7] cachefiles: use kiocb_{start,end}_write() helpers
Date:   Thu, 17 Aug 2023 17:13:37 +0300
Message-Id: <20230817141337.1025891-8-amir73il@gmail.com>
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

Use helpers instead of the open coded dance to silence lockdep warnings.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/cachefiles/io.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 175a25fcade8..009d23cd435b 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -259,9 +259,7 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 
 	_enter("%ld", ret);
 
-	/* Tell lockdep we inherited freeze protection from submission thread */
-	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
-	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
+	kiocb_end_write(iocb);
 
 	if (ret < 0)
 		trace_cachefiles_io_error(object, inode, ret,
@@ -286,7 +284,6 @@ int __cachefiles_write(struct cachefiles_object *object,
 {
 	struct cachefiles_cache *cache;
 	struct cachefiles_kiocb *ki;
-	struct inode *inode;
 	unsigned int old_nofs;
 	ssize_t ret;
 	size_t len = iov_iter_count(iter);
@@ -322,19 +319,12 @@ int __cachefiles_write(struct cachefiles_object *object,
 		ki->iocb.ki_complete = cachefiles_write_complete;
 	atomic_long_add(ki->b_writing, &cache->b_writing);
 
-	/* Open-code file_start_write here to grab freeze protection, which
-	 * will be released by another thread in aio_complete_rw().  Fool
-	 * lockdep by telling it the lock got released so that it doesn't
-	 * complain about the held lock when we return to userspace.
-	 */
-	inode = file_inode(file);
-	__sb_start_write(inode->i_sb, SB_FREEZE_WRITE);
-	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+	kiocb_start_write(&ki->iocb);
 
 	get_file(ki->iocb.ki_filp);
 	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
 
-	trace_cachefiles_write(object, inode, ki->iocb.ki_pos, len);
+	trace_cachefiles_write(object, file_inode(file), ki->iocb.ki_pos, len);
 	old_nofs = memalloc_nofs_save();
 	ret = cachefiles_inject_write_error();
 	if (ret == 0)
-- 
2.34.1

