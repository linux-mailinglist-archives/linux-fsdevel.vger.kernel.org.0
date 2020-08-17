Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5327247A11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgHQWKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:10:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33034 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730109AbgHQWKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:10:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKK-001GzL-Fa; Mon, 17 Aug 2020 16:10:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKI-0004PB-Th; Mon, 17 Aug 2020 16:10:00 -0600
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
Date:   Mon, 17 Aug 2020 17:04:15 -0500
Message-Id: <20200817220425.9389-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKI-0004PB-Th;;;mid=<20200817220425.9389-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19tqAAFzqLxCS2GoSp2VZiejTvW45zKPBA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_XMDrugObfuBody_08,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1176 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 11 (0.9%), b_tie_ro: 9 (0.8%), parse: 1.82 (0.2%),
         extract_message_metadata: 18 (1.5%), get_uri_detail_list: 2.3 (0.2%),
        tests_pri_-1000: 22 (1.9%), tests_pri_-950: 1.65 (0.1%),
        tests_pri_-900: 1.44 (0.1%), tests_pri_-90: 71 (6.0%), check_bayes: 69
        (5.8%), b_tokenize: 11 (0.9%), b_tok_get_all: 8 (0.7%), b_comp_prob:
        2.9 (0.2%), b_tok_touch_all: 43 (3.7%), b_finish: 1.10 (0.1%),
        tests_pri_0: 1037 (88.2%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 3.1 (0.3%), poll_dns_idle: 0.67 (0.1%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 6 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 07/17] proc/fd: In tid_fd_mode use fcheck_task
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When discussing[1] exec and posix file locks it was realized that none
of the callers of get_files_struct fundamentally needed to call
get_files_struct, and that by switching them to helper functions
instead it will both simplify their code and remove unnecessary
increments of files_struct.count.  Those unnecessary increments can
result in exec unnecessarily unsharing files_struct which breaking
posix locks, and it can result in fget_light having to fallback to
fget reducing system performance.

Using fcheck_task instead of get_files_struct clarifies tid_fd_mode by
removing a step.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/fd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..4048a87c51ee 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -83,18 +83,13 @@ static const struct file_operations proc_fdinfo_file_operations = {
 
 static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
 {
-	struct files_struct *files = get_files_struct(task);
 	struct file *file;
 
-	if (!files)
-		return false;
-
 	rcu_read_lock();
-	file = fcheck_files(files, fd);
+	file = fcheck_task(task, fd);
 	if (file)
 		*mode = file->f_mode;
 	rcu_read_unlock();
-	put_files_struct(files);
 	return !!file;
 }
 
-- 
2.25.0

