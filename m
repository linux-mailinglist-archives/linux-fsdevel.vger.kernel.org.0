Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C091E83F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2QtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 12:49:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50598 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 12:49:19 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeiC1-0004dx-4W; Fri, 29 May 2020 10:49:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeiC0-000320-4Z; Fri, 29 May 2020 10:49:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 29 May 2020 11:45:19 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeiC0-000320-4Z;;;mid=<87d06mr8ps.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19FqMS4UCj4uFahOW3cpzT9fghbuED8hZo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 630 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.8%), b_tie_ro: 10 (1.6%), parse: 1.18
        (0.2%), extract_message_metadata: 4.2 (0.7%), get_uri_detail_list:
        1.45 (0.2%), tests_pri_-1000: 5 (0.9%), tests_pri_-950: 1.64 (0.3%),
        tests_pri_-900: 1.38 (0.2%), tests_pri_-90: 230 (36.4%), check_bayes:
        228 (36.2%), b_tokenize: 9 (1.5%), b_tok_get_all: 8 (1.3%),
        b_comp_prob: 3.0 (0.5%), b_tok_touch_all: 204 (32.3%), b_finish: 1.02
        (0.2%), tests_pri_0: 356 (56.4%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 1.01 (0.2%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/2] exec: Remove the computation of bprm->cred
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


My last chunk of cleanups was clearly too a bit too big, with too many
issues going on so let's try this again with just the most important
cleanup.

Recomputing the uids, gids, capabilities, and related flags each time a
new bprm->file is set is error prone, and as it turns out unnecessary.

Building upon my previous exec clean up work this set of changes splits
per_clear temporarily into two separate flags which is the last step in
causing the code to recompute everything each time a new bprm->file is
considered. Then the code is refactored to run the credential from file
calculation later so that recomputation is not necessary.

Doing this in two steps should allow anyone who has problems later to
bisect and tell if it was the semantic change or the refactoring that
caused them problems.

Eric W. Biederman (2):
      exec: Add a per bprm->file version of per_clear
      exec: Compute file based creds only once

 fs/binfmt_misc.c              |  2 +-
 fs/exec.c                     | 57 ++++++++++++++++++-------------------------
 include/linux/binfmts.h       |  9 ++-----
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/lsm_hooks.h     | 22 +++++++++--------
 include/linux/security.h      |  9 ++++---
 security/commoncap.c          | 22 +++++++++--------
 security/security.c           |  4 +--
 8 files changed, 59 insertions(+), 68 deletions(-)

---

This builds upon my previous exec cleanup work at:
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-next

Thank you,
Eric
