Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2890038DC38
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 May 2021 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhEWRpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 May 2021 13:45:23 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:41256 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231853AbhEWRpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 May 2021 13:45:23 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C8166837F24A;
        Sun, 23 May 2021 17:43:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 2204A1D42F4;
        Sun, 23 May 2021 17:43:55 +0000 (UTC)
Message-ID: <f7c77f29b5c281076230eb902e5f3cb680be585e.camel@perches.com>
Subject: [trivial PATCH] vfs: fs_context: Deduplicate logging calls to
 reduce object size
From:   Joe Perches <joe@perches.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 23 May 2021 10:43:53 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2204A1D42F4
X-Spam-Status: No, score=0.14
X-Stat-Signature: 8d8fgt3xrhk1y9u86ikemufubw4ryaqi
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18BMTREeoJ3ECxEKQqNusDkcqT1ltHmelc=
X-HE-Tag: 1621791835-754072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Deduplicate the logging calls by using a temporary for KERN_<LEVEL>
with miscellaneous source code neatening of the output calls.

$ size fs/fs_context.o* #defconfig x86_64
   text	   data	    bss	    dec	    hex	filename
   6727	    192	      0	   6919	   1b07	fs/fs_context.o.new
   6802	    192	      0	   6994	   1b52	fs/fs_context.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/fs_context.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 2834d1afa6e80..2a6ff20da40f5 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -359,33 +359,40 @@ EXPORT_SYMBOL(vfs_dup_fs_context);
  * @fc: The filesystem context to log to.
  * @fmt: The format of the buffer.
  */
-void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt, ...)
+void logfc(struct fc_log *log, const char *prefix, char level,
+	   const char *fmt, ...)
 {
 	va_list va;
 	struct va_format vaf = {.fmt = fmt, .va = &va};
 
 	va_start(va, fmt);
 	if (!log) {
+		const char *kern_level;
+
 		switch (level) {
 		case 'w':
-			printk(KERN_WARNING "%s%s%pV\n", prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
+			kern_level = KERN_WARNING;
 			break;
 		case 'e':
-			printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
+			kern_level = KERN_ERR;
 			break;
 		default:
-			printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
+			kern_level = KERN_NOTICE;
 			break;
 		}
+		printk("%s%s%s%pV\n",
+		       kern_level,
+		       prefix ? prefix : "",
+		       prefix ? ": " : "",
+		       &vaf);
 	} else {
 		unsigned int logsize = ARRAY_SIZE(log->buffer);
 		u8 index;
-		char *q = kasprintf(GFP_KERNEL, "%c %s%s%pV\n", level,
-						prefix ? prefix : "",
-						prefix ? ": " : "", &vaf);
+		char *q = kasprintf(GFP_KERNEL, "%c %s%s%pV\n",
+				    level,
+				    prefix ? prefix : "",
+				    prefix ? ": " : "",
+				    &vaf);
 
 		index = log->head & (logsize - 1);
 		BUILD_BUG_ON(sizeof(log->head) != sizeof(u8) ||


