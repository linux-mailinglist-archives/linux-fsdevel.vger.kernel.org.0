Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF16A247A08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgHQWJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:09:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46442 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbgHQWJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:09:43 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nK2-004vqa-O1; Mon, 17 Aug 2020 16:09:42 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nK2-0004PB-1w; Mon, 17 Aug 2020 16:09:42 -0600
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
Date:   Mon, 17 Aug 2020 17:04:11 -0500
Message-Id: <20200817220425.9389-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nK2-0004PB-1w;;;mid=<20200817220425.9389-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xZrYaiA6k9ZXiv8T/iVb4LyAeyhzSBjQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 325 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (3.3%), b_tie_ro: 9 (2.8%), parse: 1.04 (0.3%),
         extract_message_metadata: 10 (3.2%), get_uri_detail_list: 0.97 (0.3%),
         tests_pri_-1000: 14 (4.4%), tests_pri_-950: 1.30 (0.4%),
        tests_pri_-900: 1.06 (0.3%), tests_pri_-90: 74 (22.6%), check_bayes:
        72 (22.2%), b_tokenize: 8 (2.6%), b_tok_get_all: 6 (2.0%),
        b_comp_prob: 2.1 (0.6%), b_tok_touch_all: 51 (15.8%), b_finish: 0.91
        (0.3%), tests_pri_0: 201 (61.7%), check_dkim_signature: 0.53 (0.2%),
        check_dkim_adsp: 2.4 (0.7%), poll_dns_idle: 0.68 (0.2%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 03/17] exec: Remove reset_files_struct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that exec no longer needs to restore the previous value of current->files
on error there are no more callers of reset_files_struct so remove it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 12 ------------
 include/linux/fdtable.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 21c0893f2f1d..c585dbaf31a3 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -435,18 +435,6 @@ void put_files_struct(struct files_struct *files)
 	}
 }
 
-void reset_files_struct(struct files_struct *files)
-{
-	struct task_struct *tsk = current;
-	struct files_struct *old;
-
-	old = tsk->files;
-	task_lock(tsk);
-	tsk->files = files;
-	task_unlock(tsk);
-	put_files_struct(old);
-}
-
 void exit_files(struct task_struct *tsk)
 {
 	struct files_struct * files = tsk->files;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index f46a084b60b2..7cc9885044d9 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -108,7 +108,6 @@ struct task_struct;
 
 struct files_struct *get_files_struct(struct task_struct *);
 void put_files_struct(struct files_struct *fs);
-void reset_files_struct(struct files_struct *);
 int unshare_files(void);
 struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
-- 
2.25.0

