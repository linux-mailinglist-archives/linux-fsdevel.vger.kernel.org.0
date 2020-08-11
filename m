Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669E2242055
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 21:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHKTbh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 15:31:37 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56630 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgHKTbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:31:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k5ZzW-006toT-91; Tue, 11 Aug 2020 13:31:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k5ZzU-00036t-PY; Tue, 11 Aug 2020 13:31:21 -0600
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
        <20200723171227.446711-3-mic@digikod.net>
Date:   Tue, 11 Aug 2020 14:27:54 -0500
In-Reply-To: <20200723171227.446711-3-mic@digikod.net> (=?utf-8?Q?=22Micka?=
 =?utf-8?Q?=C3=ABl_Sala=C3=BCn=22's?=
        message of "Thu, 23 Jul 2020 19:12:22 +0200")
Message-ID: <87o8nhm18l.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1k5ZzU-00036t-PY;;;mid=<87o8nhm18l.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19o313fM1rdJpFj27lRA/GiywQHoqdRBk0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_XMDrugObfuBody_08,XM_B_SpammyWords,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?*;Micka=c3=abl Sala=c3=bcn <mic@digikod.net>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 490 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 11 (2.2%), parse: 1.24
        (0.3%), extract_message_metadata: 15 (3.0%), get_uri_detail_list: 2.8
        (0.6%), tests_pri_-1000: 22 (4.6%), tests_pri_-950: 1.36 (0.3%),
        tests_pri_-900: 1.24 (0.3%), tests_pri_-90: 81 (16.5%), check_bayes:
        79 (16.1%), b_tokenize: 15 (3.1%), b_tok_get_all: 14 (2.9%),
        b_comp_prob: 3.6 (0.7%), b_tok_touch_all: 40 (8.2%), b_finish: 1.22
        (0.2%), tests_pri_0: 342 (69.8%), check_dkim_signature: 0.86 (0.2%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 1.26 (0.3%), tests_pri_10:
        2.5 (0.5%), tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v7 2/7] exec: Move S_ISREG() check earlier
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
> The execve(2)/uselib(2) syscalls have always rejected non-regular
> files. Recently, it was noticed that a deadlock was introduced when trying
> to execute pipes, as the S_ISREG() test was happening too late. This was
> fixed in commit 73601ea5b7b1 ("fs/open.c: allow opening only regular files
> during execve()"), but it was added after inode_permission() had already
> run, which meant LSMs could see bogus attempts to execute non-regular
> files.
>
> Move the test into the other inode type checks (which already look
> for other pathological conditions[1]). Since there is no need to use
> FMODE_EXEC while we still have access to "acc_mode", also switch the
> test to MAY_EXEC.
>
> Also include a comment with the redundant S_ISREG() checks at the end of
> execve(2)/uselib(2) to note that they are present to avoid any mistakes.

The comment is:
> +	/*
> +	 * may_open() has already checked for this, so it should be
> +	 * impossible to trip now. But we need to be extra cautious
> +	 * and check again at the very end too.
> +	 */
Those comments scare me.  Why do you need to be extra cautious?
How can the file type possibly change between may_open and anywhere?
The type of a file is immutable after it's creation.

If the comment said check just in case something went wrong with
code maintenance I could understand but that isn't what the comment
says.

Also the fallthrough change below really should be broken out into
it's own change.


> My notes on the call path, and related arguments, checks, etc:
>
> do_open_execat()
>     struct open_flags open_exec_flags = {
>         .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
>         .acc_mode = MAY_EXEC,
>         ...
>     do_filp_open(dfd, filename, open_flags)
>         path_openat(nameidata, open_flags, flags)
>             file = alloc_empty_file(open_flags, current_cred());
>             do_open(nameidata, file, open_flags)
>                 may_open(path, acc_mode, open_flag)
> 		    /* new location of MAY_EXEC vs S_ISREG() test */
>                     inode_permission(inode, MAY_OPEN | acc_mode)
>                         security_inode_permission(inode, acc_mode)
>                 vfs_open(path, file)
>                     do_dentry_open(file, path->dentry->d_inode, open)
>                         /* old location of FMODE_EXEC vs S_ISREG() test */
>                         security_file_open(f)
>                         open()
>
> [1] https://lore.kernel.org/lkml/202006041910.9EF0C602@keescook/
>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/r/20200605160013.3954297-3-keescook@chromium.org
> ---
>  fs/exec.c  | 14 ++++++++++++--
>  fs/namei.c |  6 ++++--
>  fs/open.c  |  6 ------
>  3 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index d7c937044d10..bdc6a6eb5dce 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -141,8 +141,13 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
>  	if (IS_ERR(file))
>  		goto out;
>  
> +	/*
> +	 * may_open() has already checked for this, so it should be
> +	 * impossible to trip now. But we need to be extra cautious
> +	 * and check again at the very end too.
> +	 */
>  	error = -EACCES;
> -	if (!S_ISREG(file_inode(file)->i_mode))
> +	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
>  		goto exit;
>  
>  	if (path_noexec(&file->f_path))
> @@ -886,8 +891,13 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
>  	if (IS_ERR(file))
>  		goto out;
>  
> +	/*
> +	 * may_open() has already checked for this, so it should be
> +	 * impossible to trip now. But we need to be extra cautious
> +	 * and check again at the very end too.
> +	 */
>  	err = -EACCES;
> -	if (!S_ISREG(file_inode(file)->i_mode))
> +	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
>  		goto exit;
>
>  	if (path_noexec(&file->f_path))
> diff --git a/fs/namei.c b/fs/namei.c
> index 72d4219c93ac..a559ad943970 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2849,16 +2849,18 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>  	case S_IFLNK:
>  		return -ELOOP;
>  	case S_IFDIR:
> -		if (acc_mode & MAY_WRITE)
> +		if (acc_mode & (MAY_WRITE | MAY_EXEC))
>  			return -EISDIR;
>  		break;
>  	case S_IFBLK:
>  	case S_IFCHR:
>  		if (!may_open_dev(path))
>  			return -EACCES;
> -		/*FALLTHRU*/
> +		fallthrough;
                ^^^^^^^^^^^
That is an unrelated change and should be sent separately.

>  	case S_IFIFO:
>  	case S_IFSOCK:
> +		if (acc_mode & MAY_EXEC)
> +			return -EACCES;
>  		flag &= ~O_TRUNC;
>  		break;
>  	}
> diff --git a/fs/open.c b/fs/open.c
> index 6cd48a61cda3..623b7506a6db 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -784,12 +784,6 @@ static int do_dentry_open(struct file *f,
>  		return 0;
>  	}
>  
> -	/* Any file opened for execve()/uselib() has to be a regular file. */
> -	if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) {
> -		error = -EACCES;
> -		goto cleanup_file;
> -	}
> -
>  	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
>  		error = get_write_access(inode);
>  		if (unlikely(error))
