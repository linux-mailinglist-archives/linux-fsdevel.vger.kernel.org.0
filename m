Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C6D2479EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgHQWHP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:07:15 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45574 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbgHQWHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:07:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nHN-004vaQ-Vv; Mon, 17 Aug 2020 16:06:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nHM-0004FX-Km; Mon, 17 Aug 2020 16:06:57 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
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
        KP Singh <kpsingh@chromium.org>
Date:   Mon, 17 Aug 2020 17:03:24 -0500
Message-ID: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1k7nHM-0004FX-Km;;;mid=<87ft8l6ic3.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/fUJAwFV2XgC7GXJ+FcckxCNXevxLZww=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,XMSubLong,
        XM_B_SpammyWords,XM_B_Unicode,XM_B_Unicode3 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 XM_B_Unicode3 BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 857 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 15 (1.7%), b_tie_ro: 13 (1.5%), parse: 1.40
        (0.2%), extract_message_metadata: 14 (1.7%), get_uri_detail_list: 3.6
        (0.4%), tests_pri_-1000: 18 (2.1%), tests_pri_-950: 1.60 (0.2%),
        tests_pri_-900: 1.25 (0.1%), tests_pri_-90: 119 (13.9%), check_bayes:
        118 (13.7%), b_tokenize: 9 (1.1%), b_tok_get_all: 12 (1.4%),
        b_comp_prob: 3.0 (0.4%), b_tok_touch_all: 89 (10.3%), b_finish: 1.20
        (0.1%), tests_pri_0: 669 (78.0%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.8 (0.3%), poll_dns_idle: 1.01 (0.1%), tests_pri_10:
        3.6 (0.4%), tests_pri_500: 11 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: exec: Move unshare_files and guarantee files_struct.count is correct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



A while ago it was reported that posix file locking goes wrong when a
multi-threaded process calls exec.  I looked into the history and this
is definitely a regression, that should be fixed if we can.

This set of changes cleanups of the code in exec so hopefully this code
will not regress again.  Then it adds helpers and fixes the users of
files_struct so the reference count is only incremented if COPY_FILES is
passed to clone.  Then it removes helpers (get_files_struct,
__install_fd, __alloc_fd, __close_fd) that are no longer needed and
if used would encourage code that increments the count of files_struct
somewhere besides in clone when COPY_FILES is passed.

In addition to fixing the bug in exec and simplifing the code this set
of changes by virtue of getting files_struct.count correct it optimizes
fdget.  With proc and other places not temporarily increasing the count
on files_struct __fget_light should succeed more often in being able to
return a struct file without touching it's reference count.

Fixing the count in files_struct was suggested by Oleg[1].

For those that are interested in the history of this issue I have
included as much of it as I could find in the first change.

 fs/coredump.c            |   5 +--
 fs/exec.c                |  26 ++++++-----
 fs/file.c                | 110 +++++++++++++++++++++--------------------------
 fs/open.c                |   2 +-
 fs/proc/fd.c             |  47 +++++++-------------
 include/linux/fdtable.h  |  13 ++----
 include/linux/syscalls.h |   6 +--
 kernel/bpf/syscall.c     |  20 ++-------
 kernel/bpf/task_iter.c   |  43 +++++-------------
 kernel/fork.c            |  12 +++---
 kernel/kcmp.c            |  20 ++-------
 11 files changed, 109 insertions(+), 195 deletions(-)

Eric W. Biederman (17):
      exec: Move unshare_files to fix posix file locking during exec
      exec: Simplify unshare_files
      exec: Remove reset_files_struct
      kcmp: In kcmp_epoll_target use fget_task
      bpf: In bpf_task_fd_query use fget_task
      file: Implement fcheck_task
      proc/fd: In tid_fd_mode use fcheck_task
      proc/fd: In proc_fd_link use fcheck_task
      file: Implement fnext_task
      proc/fd: In proc_readfd_common use fnext_task
      bpf/task_iter: In task_file_seq_get_next use fnext_task
      proc/fd: In fdinfo seq_show don't use get_files_struct
      file: Remove get_files_struct
      file: Merge __fd_install into fd_install
      file: In f_dupfd read RLIMIT_NOFILE once.
      file: Merge __alloc_fd into alloc_fd
      file: Rename __close_fd to close_fd and remove the files parameter

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Reported-by: Jeff Layton <jlayton@redhat.com>
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric
