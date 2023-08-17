Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C92977F873
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351749AbjHQONu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351753AbjHQONr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:13:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6AD2D5F
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so75784055e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692281624; x=1692886424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owUF3NUEAVS5jv0O1CeXNKt3j3CZUNkxw2WpwJ5gxfk=;
        b=VNegfykbQ1G8N1hEIl/2VCFY1GwHccYbzZP9CuyQWg3PvP1SVagib25x42cWzGGWPa
         d8B8ujNYlQXWRYZSj7GgKNAYVffit5jCqqWPTTYbBKlh6t7WrVaiHLS8WKgyhZZSD6s6
         FM2YQt8a8Vvav0fT6fXBwdamQj/yjAEJEdFcJbQfKG3pQKa0A7Pss/9yeOe6Yle1D5wd
         wquzrxNhoDnSvFaXrCYYPy39uooR7gLRg2WhHG054G3h3h2qxuf17DxBMMLC/l9XIrkH
         G21rw6UVHNYoAHvVVwU+N4x2K7NFZoTLlNDsXxVh+HT/PiRRND8jspbWxoMUpQCnNCp8
         fTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281624; x=1692886424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owUF3NUEAVS5jv0O1CeXNKt3j3CZUNkxw2WpwJ5gxfk=;
        b=lrQCleuqyacLz/LIg2XJv3yiLVEFIFOWo2CF8zgwBpYvxcQlhZJmTo9Y790mz4CU9Y
         nYI0osMHkeUEbSXlMHyu8lgeU648cQ7H2oB2VU7VONx5wau2VhYjlFREVY03k5MqUUjg
         VHkSB/t+9uSyv9zXksAzQxgGjgthnxt+y/wOPd9n/ByQbj4Xdml0m+3b8Fgx+VQn9hwC
         XgBvI0oh5UwwvPsFP5yWvucqsc7a3mNjLCwpZ9BJVoIQWkbz8VvwaoCGG75RGn9QJ+jh
         wwPvTv7anQ8VupxPM5TniaWxkEfllNnQ0KPlLlHMQ/SQpRWof3sTjA3LQrsBUfv2zM5U
         v8SA==
X-Gm-Message-State: AOJu0YxuMcdItyaY2aD3T5W6wStyfmHwryhOhtyw6xUsHPKOb9YZ79cJ
        h8anQ8FOA0ULfCAqb8QzzMA=
X-Google-Smtp-Source: AGHT+IEoa0QrX517WHayUaCCcdVuPp0sIIZAl5fIoWiZ4Fnf/36jzg+ivs//w/jesVwKAwWzr1YlSw==
X-Received: by 2002:a7b:ce95:0:b0:3fe:1871:1826 with SMTP id q21-20020a7bce95000000b003fe18711826mr4067020wmj.27.1692281624283;
        Thu, 17 Aug 2023 07:13:44 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bca4c000000b003fe2120ad0bsm3080605wml.41.2023.08.17.07.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:13:43 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/7] fs: add kerneldoc to file_{start,end}_write() helpers
Date:   Thu, 17 Aug 2023 17:13:32 +0300
Message-Id: <20230817141337.1025891-3-amir73il@gmail.com>
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

and use sb_end_write() instead of open coded version.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fs.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b2adee67f9b2..ced388aff51f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2545,6 +2545,13 @@ static inline bool inode_wrong_type(const struct inode *inode, umode_t mode)
 	return (inode->i_mode ^ mode) & S_IFMT;
 }
 
+/**
+ * file_start_write - get write access to a superblock for regular file io
+ * @file: the file we want to write to
+ *
+ * This is a variant of sb_start_write() which is a noop on non-regualr file.
+ * Should be matched with a call to file_end_write().
+ */
 static inline void file_start_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
@@ -2559,11 +2566,17 @@ static inline bool file_start_write_trylock(struct file *file)
 	return sb_start_write_trylock(file_inode(file)->i_sb);
 }
 
+/**
+ * file_end_write - drop write access to a superblock of a regular file
+ * @file: the file we wrote to
+ *
+ * Should be matched with a call to file_start_write().
+ */
 static inline void file_end_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return;
-	__sb_end_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
+	sb_end_write(file_inode(file)->i_sb);
 }
 
 /*
-- 
2.34.1

