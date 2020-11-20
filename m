Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1AA2BB9CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgKTXQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:16:15 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:48144 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKTXQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:16:13 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdU-006Xbh-6t; Fri, 20 Nov 2020 16:16:12 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdT-00EG00-4X; Fri, 20 Nov 2020 16:16:11 -0700
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
Date:   Fri, 20 Nov 2020 17:14:21 -0600
Message-Id: <20201120231441.29911-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdT-00EG00-4X;;;mid=<20201120231441.29911-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/hV0hyPS0zo8CxNcnpJ9dbcaqQXH40V9k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 355 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 13 (3.5%), b_tie_ro: 11 (3.2%), parse: 1.29
        (0.4%), extract_message_metadata: 13 (3.7%), get_uri_detail_list: 2.3
        (0.7%), tests_pri_-1000: 14 (4.0%), tests_pri_-950: 1.29 (0.4%),
        tests_pri_-900: 1.04 (0.3%), tests_pri_-90: 76 (21.4%), check_bayes:
        74 (20.9%), b_tokenize: 10 (2.7%), b_tok_get_all: 7 (1.9%),
        b_comp_prob: 2.5 (0.7%), b_tok_touch_all: 51 (14.4%), b_finish: 1.03
        (0.3%), tests_pri_0: 222 (62.6%), check_dkim_signature: 0.74 (0.2%),
        check_dkim_adsp: 2.6 (0.7%), poll_dns_idle: 0.74 (0.2%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 8 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 04/24] kcmp: In kcmp_epoll_target use fget_task
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the helper fget_task and simplify the code.

As well as simplifying the code this removes one unnecessary increment of
struct files_struct.  This unnecessary increment of files_struct.count can
result in exec unnecessarily unsharing files_struct and breaking posix
locks, and it can result in fget_light having to fallback to fget reducing
performance.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-4-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/kcmp.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index b3ff9288c6cc..87c48c0104ad 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -107,7 +107,6 @@ static int kcmp_epoll_target(struct task_struct *task1,
 {
 	struct file *filp, *filp_epoll, *filp_tgt;
 	struct kcmp_epoll_slot slot;
-	struct files_struct *files;
 
 	if (copy_from_user(&slot, uslot, sizeof(slot)))
 		return -EFAULT;
@@ -116,23 +115,12 @@ static int kcmp_epoll_target(struct task_struct *task1,
 	if (!filp)
 		return -EBADF;
 
-	files = get_files_struct(task2);
-	if (!files)
+	filp_epoll = fget_task(task2, slot.efd);
+	if (!filp_epoll)
 		return -EBADF;
 
-	spin_lock(&files->file_lock);
-	filp_epoll = fcheck_files(files, slot.efd);
-	if (filp_epoll)
-		get_file(filp_epoll);
-	else
-		filp_tgt = ERR_PTR(-EBADF);
-	spin_unlock(&files->file_lock);
-	put_files_struct(files);
-
-	if (filp_epoll) {
-		filp_tgt = get_epoll_tfile_raw_ptr(filp_epoll, slot.tfd, slot.toff);
-		fput(filp_epoll);
-	}
+	filp_tgt = get_epoll_tfile_raw_ptr(filp_epoll, slot.tfd, slot.toff);
+	fput(filp_epoll);
 
 	if (IS_ERR(filp_tgt))
 		return PTR_ERR(filp_tgt);
-- 
2.25.0

