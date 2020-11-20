Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F082BB9E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgKTXQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:16:37 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:48302 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbgKTXQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:16:35 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdp-006XdW-K3; Fri, 20 Nov 2020 16:16:33 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdo-00EG00-57; Fri, 20 Nov 2020 16:16:33 -0700
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
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri, 20 Nov 2020 17:14:27 -0600
Message-Id: <20201120231441.29911-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdo-00EG00-57;;;mid=<20201120231441.29911-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/+yR4JtgeSRtgRNcLI225rYxafT0I4Doo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TooManySym_01 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 497 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 13 (2.6%), b_tie_ro: 11 (2.2%), parse: 1.85
        (0.4%), extract_message_metadata: 19 (3.8%), get_uri_detail_list: 3.8
        (0.8%), tests_pri_-1000: 21 (4.3%), tests_pri_-950: 1.61 (0.3%),
        tests_pri_-900: 1.35 (0.3%), tests_pri_-90: 89 (17.8%), check_bayes:
        86 (17.4%), b_tokenize: 14 (2.9%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 55 (11.1%), b_finish: 1.12
        (0.2%), tests_pri_0: 337 (67.8%), check_dkim_signature: 0.82 (0.2%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 0.47 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 10/24] file: Rename fcheck lookup_fd_rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also remove the confusing comment about checking if a fd exists.  I
could not find one instance in the entire kernel that still matches
the description or the reason for the name fcheck.

The need for better names became apparent in the last round of
discussion of this set of changes[1].

[1] https://lkml.kernel.org/r/CAHk-=wj8BQbgJFLa+J0e=iT-1qpmCRTbPAJ8gd6MJQ=kbRPqyQ@mail.gmail.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Documentation/filesystems/files.rst          | 6 +++---
 arch/powerpc/platforms/cell/spufs/coredump.c | 2 +-
 fs/notify/dnotify/dnotify.c                  | 2 +-
 include/linux/fdtable.h                      | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/files.rst b/Documentation/filesystems/files.rst
index ea75acdb632c..bcf84459917f 100644
--- a/Documentation/filesystems/files.rst
+++ b/Documentation/filesystems/files.rst
@@ -62,7 +62,7 @@ the fdtable structure -
    be held.
 
 4. To look up the file structure given an fd, a reader
-   must use either fcheck() or files_lookup_fd_rcu() APIs. These
+   must use either lookup_fd_rcu() or files_lookup_fd_rcu() APIs. These
    take care of barrier requirements due to lock-free lookup.
 
    An example::
@@ -70,7 +70,7 @@ the fdtable structure -
 	struct file *file;
 
 	rcu_read_lock();
-	file = fcheck(fd);
+	file = lookup_fd_rcu(fd);
 	if (file) {
 		...
 	}
@@ -104,7 +104,7 @@ the fdtable structure -
    lock-free, they must be installed using rcu_assign_pointer()
    API. If they are looked up lock-free, rcu_dereference()
    must be used. However it is advisable to use files_fdtable()
-   and fcheck()/files_lookup_fd_rcu() which take care of these issues.
+   and lookup_fd_rcu()/files_lookup_fd_rcu() which take care of these issues.
 
 7. While updating, the fdtable pointer must be looked up while
    holding files->file_lock. If ->file_lock is dropped, then
diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 026c181a98c5..60b5583e9eaf 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -74,7 +74,7 @@ static struct spu_context *coredump_next_context(int *fd)
 	*fd = n - 1;
 
 	rcu_read_lock();
-	file = fcheck(*fd);
+	file = lookup_fd_rcu(*fd);
 	ctx = SPUFS_I(file_inode(file))->i_ctx;
 	get_spu_context(ctx);
 	rcu_read_unlock();
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 5dcda8f20c04..5486aaca60b0 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -327,7 +327,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 	}
 
 	rcu_read_lock();
-	f = fcheck(fd);
+	f = lookup_fd_rcu(fd);
 	rcu_read_unlock();
 
 	/* if (f != filp) means that we lost a race and another task/thread
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index fa8c402a7790..2a4a8fed536e 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -105,10 +105,10 @@ static inline struct file *files_lookup_fd_rcu(struct files_struct *files, unsig
 	return files_lookup_fd_raw(files, fd);
 }
 
-/*
- * Check whether the specified fd has an open file.
- */
-#define fcheck(fd)	files_lookup_fd_rcu(current->files, fd)
+static inline struct file *lookup_fd_rcu(unsigned int fd)
+{
+	return files_lookup_fd_rcu(current->files, fd);
+}
 
 struct task_struct;
 
-- 
2.25.0

