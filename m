Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C85242012
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 21:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgHKTD2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 15:03:28 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:49030 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:03:25 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k5ZYK-006qgE-65; Tue, 11 Aug 2020 13:03:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k5ZYJ-0006gu-5w; Tue, 11 Aug 2020 13:03:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200723171227.446711-1-mic@digikod.net>
        <20200723171227.446711-2-mic@digikod.net>
Date:   Tue, 11 Aug 2020 13:59:48 -0500
In-Reply-To: <20200723171227.446711-2-mic@digikod.net> (=?utf-8?Q?=22Micka?=
 =?utf-8?Q?=C3=ABl_Sala=C3=BCn=22's?=
        message of "Thu, 23 Jul 2020 19:12:21 +0200")
Message-ID: <87eeodnh3v.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1k5ZYJ-0006gu-5w;;;mid=<87eeodnh3v.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Ak6/vsLtopnFYs9ZfaNrZr8Zt2Ow/qiA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,XMSubLong,
        XM_B_SpammyWords,XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4981]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?**;Micka=c3=abl Sala=c3=bcn <mic@digikod.net>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 518 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.8%), b_tie_ro: 2.8 (0.5%), parse: 0.84
        (0.2%), extract_message_metadata: 17 (3.2%), get_uri_detail_list: 1.82
        (0.4%), tests_pri_-1000: 20 (3.9%), tests_pri_-950: 1.04 (0.2%),
        tests_pri_-900: 0.86 (0.2%), tests_pri_-90: 154 (29.7%), check_bayes:
        145 (28.1%), b_tokenize: 11 (2.2%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 2.0 (0.4%), b_tok_touch_all: 119 (23.0%), b_finish: 0.78
        (0.2%), tests_pri_0: 268 (51.7%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 1.96 (0.4%), poll_dns_idle: 37 (7.1%), tests_pri_10:
        1.63 (0.3%), tests_pri_500: 48 (9.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v7 1/7] exec: Change uselib(2) IS_SREG() failure to EACCES
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mickaël Salaün <mic@digikod.net> writes:

> From: Kees Cook <keescook@chromium.org>
>
> Change uselib(2)' S_ISREG() error return to EACCES instead of EINVAL so
> the behavior matches execve(2), and the seemingly documented value.
> The "not a regular file" failure mode of execve(2) is explicitly
> documented[1], but it is not mentioned in uselib(2)[2] which does,
> however, say that open(2) and mmap(2) errors may apply. The documentation
> for open(2) does not include a "not a regular file" error[3], but mmap(2)
> does[4], and it is EACCES.

Do you have enough visibility into uselib to be certain this will change
will not cause regressions?

My sense of uselib is that it would be easier to remove the system call
entirely (I think it's last use was in libc5) than to validate that a
change like this won't cause problems for the users of uselib.

For the kernel what is important are real world users and the manpages
are only important as far as they suggest what the real world users do.

Eric


> [1] http://man7.org/linux/man-pages/man2/execve.2.html#ERRORS
> [2] http://man7.org/linux/man-pages/man2/uselib.2.html#ERRORS
> [3] http://man7.org/linux/man-pages/man2/open.2.html#ERRORS
> [4] http://man7.org/linux/man-pages/man2/mmap.2.html#ERRORS
>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Link: https://lore.kernel.org/r/20200605160013.3954297-2-keescook@chromium.org
> ---
>  fs/exec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index e6e8a9a70327..d7c937044d10 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -141,11 +141,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
>  	if (IS_ERR(file))
>  		goto out;
>  
> -	error = -EINVAL;
> +	error = -EACCES;
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		goto exit;
>  
> -	error = -EACCES;
>  	if (path_noexec(&file->f_path))
>  		goto exit;
