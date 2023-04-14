Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6356E26E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDNP0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDNP0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:26:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A3BCD312;
        Fri, 14 Apr 2023 08:26:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D5C44B3;
        Fri, 14 Apr 2023 08:25:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 52EE23F6C4;
        Fri, 14 Apr 2023 08:25:12 -0700 (PDT)
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-morello@op-lists.linaro.org
Subject: [PATCH v2 1/5] fcntl: Cast commands with int args explicitly
Date:   Fri, 14 Apr 2023 16:24:55 +0100
Message-Id: <20230414152459.816046-2-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
References: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to the fcntl API specification commands that expect an
integer, hence not a pointer, always take an int and not long. In
order to avoid access to undefined bits, we should explicitly cast
the argument to int.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
Cc: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: David Laight <David.Laight@ACULAB.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-morello@op-lists.linaro.org
Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
---
 fs/fcntl.c         | 29 +++++++++++++++--------------
 include/linux/fs.h |  2 +-
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index b622be119706..e871009f6c88 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -34,7 +34,7 @@
 
 #define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME)
 
-static int setfl(int fd, struct file * filp, unsigned long arg)
+static int setfl(int fd, struct file * filp, unsigned int arg)
 {
 	struct inode * inode = file_inode(filp);
 	int error = 0;
@@ -112,11 +112,11 @@ void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
 }
 EXPORT_SYMBOL(__f_setown);
 
-int f_setown(struct file *filp, unsigned long arg, int force)
+int f_setown(struct file *filp, int who, int force)
 {
 	enum pid_type type;
 	struct pid *pid = NULL;
-	int who = arg, ret = 0;
+	int ret = 0;
 
 	type = PIDTYPE_TGID;
 	if (who < 0) {
@@ -317,28 +317,29 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
 	void __user *argp = (void __user *)arg;
+	int argi = (int)arg;
 	struct flock flock;
 	long err = -EINVAL;
 
 	switch (cmd) {
 	case F_DUPFD:
-		err = f_dupfd(arg, filp, 0);
+		err = f_dupfd(argi, filp, 0);
 		break;
 	case F_DUPFD_CLOEXEC:
-		err = f_dupfd(arg, filp, O_CLOEXEC);
+		err = f_dupfd(argi, filp, O_CLOEXEC);
 		break;
 	case F_GETFD:
 		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
 		break;
 	case F_SETFD:
 		err = 0;
-		set_close_on_exec(fd, arg & FD_CLOEXEC);
+		set_close_on_exec(fd, argi & FD_CLOEXEC);
 		break;
 	case F_GETFL:
 		err = filp->f_flags;
 		break;
 	case F_SETFL:
-		err = setfl(fd, filp, arg);
+		err = setfl(fd, filp, argi);
 		break;
 #if BITS_PER_LONG != 32
 	/* 32-bit arches must use fcntl64() */
@@ -375,7 +376,7 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		force_successful_syscall_return();
 		break;
 	case F_SETOWN:
-		err = f_setown(filp, arg, 1);
+		err = f_setown(filp, argi, 1);
 		break;
 	case F_GETOWN_EX:
 		err = f_getown_ex(filp, arg);
@@ -391,28 +392,28 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		break;
 	case F_SETSIG:
 		/* arg == 0 restores default behaviour. */
-		if (!valid_signal(arg)) {
+		if (!valid_signal(argi)) {
 			break;
 		}
 		err = 0;
-		filp->f_owner.signum = arg;
+		filp->f_owner.signum = argi;
 		break;
 	case F_GETLEASE:
 		err = fcntl_getlease(filp);
 		break;
 	case F_SETLEASE:
-		err = fcntl_setlease(fd, filp, arg);
+		err = fcntl_setlease(fd, filp, argi);
 		break;
 	case F_NOTIFY:
-		err = fcntl_dirnotify(fd, filp, arg);
+		err = fcntl_dirnotify(fd, filp, argi);
 		break;
 	case F_SETPIPE_SZ:
 	case F_GETPIPE_SZ:
-		err = pipe_fcntl(filp, cmd, arg);
+		err = pipe_fcntl(filp, cmd, argi);
 		break;
 	case F_ADD_SEALS:
 	case F_GET_SEALS:
-		err = memfd_fcntl(filp, cmd, arg);
+		err = memfd_fcntl(filp, cmd, argi);
 		break;
 	case F_GET_RW_HINT:
 	case F_SET_RW_HINT:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..8da79822dbba 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1050,7 +1050,7 @@ extern void fasync_free(struct fasync_struct *);
 extern void kill_fasync(struct fasync_struct **, int, int);
 
 extern void __f_setown(struct file *filp, struct pid *, enum pid_type, int force);
-extern int f_setown(struct file *filp, unsigned long arg, int force);
+extern int f_setown(struct file *filp, int who, int force);
 extern void f_delown(struct file *filp);
 extern pid_t f_getown(struct file *filp);
 extern int send_sigurg(struct fown_struct *fown);
-- 
2.34.1

