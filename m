Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E0B3771C1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 May 2021 14:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhEHMaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 May 2021 08:30:35 -0400
Received: from foss.arm.com ([217.140.110.172]:53656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhEHMae (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 May 2021 08:30:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE3C139F;
        Sat,  8 May 2021 05:29:32 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BBF23F73B;
        Sat,  8 May 2021 05:29:25 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ftp.linux.org.uk>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jia He <justin.he@arm.com>
Subject: [PATCH RFC 3/3] s390/hmcdrv: remove the redundant directory path in debug message
Date:   Sat,  8 May 2021 20:25:30 +0800
Message-Id: <20210508122530.1971-4-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508122530.1971-1-justin.he@arm.com>
References: <20210508122530.1971-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It would be better to use full file path with '%pD' instead of hard coding.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/s390/char/hmcdrv_dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
index 20e9cd542e03..cdde75508c8a 100644
--- a/drivers/s390/char/hmcdrv_dev.c
+++ b/drivers/s390/char/hmcdrv_dev.c
@@ -137,7 +137,7 @@ static int hmcdrv_dev_open(struct inode *inode, struct file *fp)
 	if (rc)
 		module_put(THIS_MODULE);
 
-	pr_debug("open file '/dev/%pD' with return code %d\n", fp, rc);
+	pr_debug("open file '%pD' with return code %d\n", fp, rc);
 	return rc;
 }
 
@@ -146,7 +146,7 @@ static int hmcdrv_dev_open(struct inode *inode, struct file *fp)
  */
 static int hmcdrv_dev_release(struct inode *inode, struct file *fp)
 {
-	pr_debug("closing file '/dev/%pD'\n", fp);
+	pr_debug("closing file '%pD'\n", fp);
 	kfree(fp->private_data);
 	fp->private_data = NULL;
 	hmcdrv_ftp_shutdown();
@@ -231,7 +231,7 @@ static ssize_t hmcdrv_dev_read(struct file *fp, char __user *ubuf,
 	retlen = hmcdrv_dev_transfer((char *) fp->private_data,
 				     *pos, ubuf, len);
 
-	pr_debug("read from file '/dev/%pD' at %lld returns %zd/%zu\n",
+	pr_debug("read from file '%pD' at %lld returns %zd/%zu\n",
 		 fp, (long long) *pos, retlen, len);
 
 	if (retlen > 0)
@@ -248,7 +248,7 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
 {
 	ssize_t retlen;
 
-	pr_debug("writing file '/dev/%pD' at pos. %lld with length %zd\n",
+	pr_debug("writing file '%pD' at pos. %lld with length %zd\n",
 		 fp, (long long) *pos, len);
 
 	if (!fp->private_data) { /* first expect a cmd write */
@@ -272,7 +272,7 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
 	if (retlen > 0)
 		*pos += retlen;
 
-	pr_debug("write to file '/dev/%pD' returned %zd\n", fp, retlen);
+	pr_debug("write to file '%pD' returned %zd\n", fp, retlen);
 
 	return retlen;
 }
-- 
2.17.1

