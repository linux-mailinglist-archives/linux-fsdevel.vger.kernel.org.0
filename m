Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61991247A44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgHQWM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:12:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60738 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbgHQWLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:11:52 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nM6-001r3z-LL; Mon, 17 Aug 2020 16:11:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKu-0004PB-RU; Mon, 17 Aug 2020 16:10:37 -0600
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
        =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 17 Aug 2020 17:04:24 -0500
Message-Id: <20200817220425.9389-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKu-0004PB-RU;;;mid=<20200817220425.9389-16-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0S5jwtFNklOV06k8NI64kO/U96GXuYSw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 390 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 33 (8.3%), b_tie_ro: 2.7 (0.7%), parse: 1.29
        (0.3%), extract_message_metadata: 12 (3.0%), get_uri_detail_list: 1.79
        (0.5%), tests_pri_-1000: 12 (3.0%), tests_pri_-950: 1.01 (0.3%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 89 (22.9%), check_bayes:
        88 (22.5%), b_tokenize: 7 (1.8%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 1.75 (0.4%), b_tok_touch_all: 69 (17.6%), b_finish: 0.75
        (0.2%), tests_pri_0: 230 (59.0%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 1.03 (0.3%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 6 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 16/17] file: Merge __alloc_fd into alloc_fd
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function __alloc_fd was added to support binder[1].  With binder
fixed[2] there are no more users.  Further with get_files_struct
removed there can be no more users of __alloc_fd that pass anything
except current->files.

As alloc_fd just calls __alloc_fd with "files=current->files",
merge them together by transforming the files parameter into a
ocal variable initialized to current->files.

[1] dcfadfa4ec5a ("new helper: __alloc_fd()")
[2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 11 +++--------
 include/linux/fdtable.h |  2 --
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 505b2e81ad3e..221fc4f97f61 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -465,9 +465,9 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 /*
  * allocate a file descriptor, mark it busy.
  */
-int __alloc_fd(struct files_struct *files,
-	       unsigned start, unsigned end, unsigned flags)
+static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 {
+	struct files_struct *files = current->files;
 	unsigned int fd;
 	int error;
 	struct fdtable *fdt;
@@ -523,14 +523,9 @@ int __alloc_fd(struct files_struct *files,
 	return error;
 }
 
-static int alloc_fd(unsigned start, unsigned end, unsigned flags)
-{
-	return __alloc_fd(current->files, start, end, flags);
-}
-
 int __get_unused_fd_flags(unsigned flags, unsigned long nofile)
 {
-	return __alloc_fd(current->files, 0, nofile, flags);
+	return alloc_fd(0, nofile, flags);
 }
 
 int get_unused_fd_flags(unsigned flags)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 4da8aacc461a..d8f6c4921d85 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -116,8 +116,6 @@ int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
 
-extern int __alloc_fd(struct files_struct *files,
-		      unsigned start, unsigned end, unsigned flags);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-- 
2.25.0

