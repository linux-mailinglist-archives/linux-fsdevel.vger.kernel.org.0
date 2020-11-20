Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF282BBA16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgKTXUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:20:31 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:35878 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgKTXT6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:19:58 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh6-006UXX-JE; Fri, 20 Nov 2020 16:19:56 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFeU-00EG00-K5; Fri, 20 Nov 2020 16:17:18 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, criu@openvz.org,
        bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>
Date:   Fri, 20 Nov 2020 17:14:39 -0600
Message-Id: <20201120231441.29911-22-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFeU-00EG00-K5;;;mid=<20201120231441.29911-22-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19zSWrLrPbiAZCwM7yR70rMJTXOnXxmZFY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_XMDrugObfuBody_08
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 3313 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (0.4%), b_tie_ro: 11 (0.3%), parse: 1.94
        (0.1%), extract_message_metadata: 29 (0.9%), get_uri_detail_list: 2.8
        (0.1%), tests_pri_-1000: 38 (1.2%), tests_pri_-950: 1.53 (0.0%),
        tests_pri_-900: 1.26 (0.0%), tests_pri_-90: 68 (2.1%), check_bayes: 62
        (1.9%), b_tokenize: 12 (0.4%), b_tok_get_all: 7 (0.2%), b_comp_prob:
        2.7 (0.1%), b_tok_touch_all: 36 (1.1%), b_finish: 0.81 (0.0%),
        tests_pri_0: 249 (7.5%), check_dkim_signature: 1.03 (0.0%),
        check_dkim_adsp: 3.9 (0.1%), poll_dns_idle: 2889 (87.2%),
        tests_pri_10: 4.5 (0.1%), tests_pri_500: 2902 (87.6%), rewrite_mail:
        0.00 (0.0%)
Subject: [PATCH v2 22/24] file: Replace ksys_close with close_fd
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that ksys_close is exactly identical to close_fd replace
the one caller of ksys_close with close_fd.

[1] https://lkml.kernel.org/r/20200818112020.GA17080@infradead.org
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/autofs/dev-ioctl.c    |  5 +++--
 include/linux/syscalls.h | 12 ------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 322b7dfb4ea0..5bf781ea6d67 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -4,9 +4,10 @@
  * Copyright 2008 Ian Kent <raven@themaw.net>
  */
 
+#include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <linux/compat.h>
-#include <linux/syscalls.h>
+#include <linux/fdtable.h>
 #include <linux/magic.h>
 #include <linux/nospec.h>
 
@@ -289,7 +290,7 @@ static int autofs_dev_ioctl_closemount(struct file *fp,
 				       struct autofs_sb_info *sbi,
 				       struct autofs_dev_ioctl *param)
 {
-	return ksys_close(param->ioctlfd);
+	return close_fd(param->ioctlfd);
 }
 
 /*
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 9e055a0579f8..0f72f380db72 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1295,18 +1295,6 @@ static inline long ksys_ftruncate(unsigned int fd, loff_t length)
 	return do_sys_ftruncate(fd, length, 1);
 }
 
-extern int close_fd(unsigned int fd);
-
-/*
- * In contrast to sys_close(), this stub does not check whether the syscall
- * should or should not be restarted, but returns the raw error codes from
- * close_fd().
- */
-static inline int ksys_close(unsigned int fd)
-{
-	return close_fd(fd);
-}
-
 extern long do_sys_truncate(const char __user *pathname, loff_t length);
 
 static inline long ksys_truncate(const char __user *pathname, loff_t length)
-- 
2.25.0

