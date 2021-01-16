Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD62F8FA0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jan 2021 23:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbhAPWKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jan 2021 17:10:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbhAPWKo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jan 2021 17:10:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96DB522D50;
        Sat, 16 Jan 2021 22:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610835003;
        bh=ZM9RrtzLRKzwaWEhbjEC+aZrIGFn8rS+lb5Kg5wzD5k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aNa388ZmkJBWebnaFoJqzGhL+W7KWdFFrNiB9B2c8VHue2QBmnAMAJTNQ/1cyMGEv
         r5DTPIWM9qdDUmNffZ0vdoL8Kb2R8DnIG/NohUUcdCEGOUsDZBO3cTDUyVpoF+S7uc
         BPPVohrVHAy1QY5AmXuY5wuDr8+6GvZvIRDoS4emYGbTPvGRiAfAd3UuWuvZUTE4yC
         2WhRCLOb6ZYWSsa32hAM4jTks0tynt51KVIjkT+mmmGYNEIYSwP75ovB+CIddafCp9
         xDhAMfukwVZ2LO65rYE+LbXV/PznXZpT8jjYd07XQe10AKp9QaTqKIp3M4ILXGmACC
         3MnObnEtXy3zw==
From:   Timur Tabi <timur@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] [v2] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for unhashed addresses
Date:   Sat, 16 Jan 2021 16:09:49 -0600
Message-Id: <20210116220950.47078-2-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210116220950.47078-1-timur@kernel.org>
References: <20210116220950.47078-1-timur@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hashed addresses are useless in hexdumps unless you're comparing
with other hashed addresses, which is unlikely.  However, there's
no need to break existing code, so introduce a new prefix type
that prints unhashed addresses.

Signed-off-by: Timur Tabi <timur@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Roman Fietze <roman.fietze@magna.com>
---
 fs/seq_file.c          | 3 +++
 include/linux/printk.h | 8 +++++---
 lib/hexdump.c          | 9 +++++++--
 lib/seq_buf.c          | 9 +++++++--
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 03a369ccd28c..b5b49a855894 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -864,6 +864,9 @@ void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
 		remaining -= rowsize;
 
 		switch (prefix_type) {
+		case DUMP_PREFIX_UNHASHED:
+			seq_printf(m, "%s%px: ", prefix_str, ptr + i);
+			break;
 		case DUMP_PREFIX_ADDRESS:
 			seq_printf(m, "%s%p: ", prefix_str, ptr + i);
 			break;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe7eb2351610..d3c08095a9a3 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -567,7 +567,8 @@ extern const struct file_operations kmsg_fops;
 enum {
 	DUMP_PREFIX_NONE,
 	DUMP_PREFIX_ADDRESS,
-	DUMP_PREFIX_OFFSET
+	DUMP_PREFIX_OFFSET,
+	DUMP_PREFIX_UNHASHED,
 };
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 			      int groupsize, char *linebuf, size_t linebuflen,
@@ -612,8 +613,9 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
  * print_hex_dump_bytes - shorthand form of print_hex_dump() with default params
  * @prefix_str: string to prefix each line with;
  *  caller supplies trailing spaces for alignment if desired
- * @prefix_type: controls whether prefix of an offset, address, or none
- *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
+ * @prefix_type: controls whether prefix of an offset, hashed address,
+ *  unhashed address, or none is printed (%DUMP_PREFIX_OFFSET,
+ *  %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_UNHASHED, %DUMP_PREFIX_NONE)
  * @buf: data blob to dump
  * @len: number of bytes in the @buf
  *
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 9301578f98e8..b5acfc4168a8 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -211,8 +211,9 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  * @level: kernel log level (e.g. KERN_DEBUG)
  * @prefix_str: string to prefix each line with;
  *  caller supplies trailing spaces for alignment if desired
- * @prefix_type: controls whether prefix of an offset, address, or none
- *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
+ * @prefix_type: controls whether prefix of an offset, hashed address,
+ *  unhashed address, or none is printed (%DUMP_PREFIX_OFFSET,
+ *  %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_UNHASHED, %DUMP_PREFIX_NONE)
  * @rowsize: number of bytes to print per line; must be 16 or 32
  * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
  * @buf: data blob to dump
@@ -256,6 +257,10 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 				   linebuf, sizeof(linebuf), ascii);
 
 		switch (prefix_type) {
+		case DUMP_PREFIX_UNHASHED:
+			printk("%s%s%px: %s\n",
+			       level, prefix_str, ptr + i, linebuf);
+			break;
 		case DUMP_PREFIX_ADDRESS:
 			printk("%s%s%p: %s\n",
 			       level, prefix_str, ptr + i, linebuf);
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 707453f5d58e..017c4d7e93f1 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -335,8 +335,9 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
  * @s: seq_buf descriptor
  * @prefix_str: string to prefix each line with;
  *  caller supplies trailing spaces for alignment if desired
- * @prefix_type: controls whether prefix of an offset, address, or none
- *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
+ * @prefix_type: controls whether prefix of an offset, hashed address,
+ *  unhashed address, or none is printed (%DUMP_PREFIX_OFFSET,
+ *  %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_UNHASHED, %DUMP_PREFIX_NONE)
  * @rowsize: number of bytes to print per line; must be 16 or 32
  * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
  * @buf: data blob to dump
@@ -374,6 +375,10 @@ int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str, int prefix_type,
 				   linebuf, sizeof(linebuf), ascii);
 
 		switch (prefix_type) {
+		case DUMP_PREFIX_UNHASHED:
+			ret = seq_buf_printf(s, "%s%px: %s\n",
+			       prefix_str, ptr + i, linebuf);
+			break;
 		case DUMP_PREFIX_ADDRESS:
 			ret = seq_buf_printf(s, "%s%p: %s\n",
 			       prefix_str, ptr + i, linebuf);
-- 
2.25.1

