Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E4C6C4344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 07:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCVGfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 02:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVGfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:35:09 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 23:35:08 PDT
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0426CEC
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 23:35:08 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1679466322; bh=TfBv78fCRxgbAXSigqgNIL6g0fQNYX8sBHXjBPNUfGI=;
        h=From:To:Cc:Subject:Date;
        b=P1Ko30nC72q2ZQB8WvZ+oWtGusg5HPrjefPVvnOoW8kOzQLeqMd9Hr3Rqi4+n7u0N
         IDv0FkiD10yssbXuCo3UzKJuXDfCHk/femI2mb6pW++Cf8eERsHNqOCH4UJugsqdTP
         YxsHtgFK20e5Khib09Tv3KeM9rpERI27xZx24f2A=
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     shepjeng@gmail.com, kernel@cccheng.net,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH] splice: report related fsnotify events
Date:   Wed, 22 Mar 2023 14:25:19 +0800
Message-Id: <20230322062519.409752-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The fsnotify ACCESS and MODIFY event are missing when manipulating a file
with splice(2).

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/splice.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 5969b7a1d353..9cadcaf52a3e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -30,6 +30,7 @@
 #include <linux/export.h>
 #include <linux/syscalls.h>
 #include <linux/uio.h>
+#include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/gfp.h>
 #include <linux/socket.h>
@@ -1074,6 +1075,9 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
+		if (ret > 0)
+			fsnotify_modify(out);
+
 		if (!off_out)
 			out->f_pos = offset;
 		else
@@ -1097,6 +1101,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 			flags |= SPLICE_F_NONBLOCK;
 
 		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
+
+		if (ret > 0)
+			fsnotify_access(in);
+
 		if (!off_in)
 			in->f_pos = offset;
 		else
-- 
2.34.1

