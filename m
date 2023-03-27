Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CFD6C9B85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 08:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjC0GsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 02:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC0GsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:48:14 -0400
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BDB119;
        Sun, 26 Mar 2023 23:48:09 -0700 (PDT)
X-QQ-mid: bizesmtp73t1679899669tqnj2i5m
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 27 Mar 2023 14:47:48 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: ttAhR/+4RmncgsHGNgkyNUEpZqS4kttyQePjpsP+5dvxuIFK6xliOvM2+01tV
        w7nC1i5C7P0XF6u/iQMsG9Sl2dQTxAdl8dQbCUBduzAYC1eXuJOV9tFKU0JoPc55vd49fpu
        g2uHhORoJb7ApSXxDwKapOo4UixI4BLcFsBoM+9awID5XYTSVr7BHCpVr171n/J1Gf6ZTPr
        cofAQtXWkpZ/yt1k9odM5Re9vJx/3c7qMc7VsF6eUbzZg23kl5qnPE3duLtJ8r2vAxwFqtI
        BRcH1LMWc0kxcwbDLvQcNFNc0kPAN9FIEOgULhX9y96Y+5vOFeA2y5vKREIYLGguCAsBo8z
        XEN/6Mxo10hLXjHsLvHnASpGPIyPhGXvlmVGhVgtB8pLw6mThCJ5C6cDGDk12BHVhO59HJ6
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17916466195834041282
From:   gouhao@uniontech.com
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/kernel_read_file: set the correct 'buf_size' after allocating 'buf'
Date:   Mon, 27 Mar 2023 14:47:46 +0800
Message-Id: <20230327064746.20441-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gou Hao <gouhao@uniontech.com>

According to the comments of the kernel_read_file():
'if @buf is NULL, a buffer will be allocated, and
@buf_size will be ignored'.

But if i pass 'buf=NULL, buf_size=0' to kernel_read_file(),
0 is returned, it means that has not read the content.

The root cause is that 'buf_size' is not set correctly after
allocating memory, which does not match 'copied < buf_size',
so 0 is returned.

So we should set 'buf_size' to 'i_size' after allocating memory.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/kernel_read_file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 5d826274570c..77d400f5951d 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -63,12 +63,14 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
 		goto out;
 	}
 	/* The entire file cannot be read in one buffer. */
-	if (!file_size && offset == 0 && i_size > buf_size) {
+	if (!file_size && offset == 0 &&
+		(buf_size && i_size > buf_size)) {
 		ret = -EFBIG;
 		goto out;
 	}
 
-	whole_file = (offset == 0 && i_size <= buf_size);
+	whole_file = (offset == 0 &&
+		(!buf_size || i_size <= buf_size));
 	ret = security_kernel_read_file(file, id, whole_file);
 	if (ret)
 		goto out;
@@ -76,8 +78,11 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
 	if (file_size)
 		*file_size = i_size;
 
-	if (!*buf)
+	if (!*buf) {
 		*buf = allocated = vmalloc(i_size);
+		buf_size = i_size;
+	}
+
 	if (!*buf) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.20.1

