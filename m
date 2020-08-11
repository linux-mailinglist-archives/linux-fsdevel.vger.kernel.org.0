Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD59A2420A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 21:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHKTyq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 15:54:46 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33894 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgHKTyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:54:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k5aM2-006w1u-2J; Tue, 11 Aug 2020 13:54:38 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k5aM0-0006qV-DY; Tue, 11 Aug 2020 13:54:37 -0600
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
        linux-fsdevel@vger.kernel.org,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
References: <20200723171227.446711-1-mic@digikod.net>
        <20200723171227.446711-5-mic@digikod.net>
Date:   Tue, 11 Aug 2020 14:51:10 -0500
In-Reply-To: <20200723171227.446711-5-mic@digikod.net> (=?utf-8?Q?=22Micka?=
 =?utf-8?Q?=C3=ABl_Sala=C3=BCn=22's?=
        message of "Thu, 23 Jul 2020 19:12:24 +0200")
Message-ID: <87mu31klld.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1k5aM0-0006qV-DY;;;mid=<87mu31klld.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19RgEacPTOOZLsDHrqkrRNQrFXSZ8c0Z8c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_XMDrugObfuBody_08,
        XMBrknScrpt_02,XMSubLong,XM_B_SpammyWords,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 XMBrknScrpt_02 Possible Broken Spam Script
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?****;Micka=c3=abl Sala=c3=bcn <mic@digikod.net>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 1087 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (0.9%), b_tie_ro: 9 (0.8%), parse: 1.45 (0.1%),
         extract_message_metadata: 29 (2.7%), get_uri_detail_list: 7 (0.6%),
        tests_pri_-1000: 13 (1.2%), tests_pri_-950: 1.17 (0.1%),
        tests_pri_-900: 1.03 (0.1%), tests_pri_-90: 256 (23.6%), check_bayes:
        228 (21.0%), b_tokenize: 35 (3.3%), b_tok_get_all: 20 (1.8%),
        b_comp_prob: 6 (0.6%), b_tok_touch_all: 163 (15.0%), b_finish: 1.45
        (0.1%), tests_pri_0: 752 (69.2%), check_dkim_signature: 0.79 (0.1%),
        check_dkim_adsp: 5 (0.5%), poll_dns_idle: 0.26 (0.0%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 16 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v7 4/7] fs: Introduce O_MAYEXEC flag for openat2(2)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mickaël Salaün <mic@digikod.net> writes:

> When the O_MAYEXEC flag is passed, openat2(2) may be subject to
> additional restrictions depending on a security policy managed by the
> kernel through a sysctl or implemented by an LSM thanks to the
> inode_permission hook.  This new flag is ignored by open(2) and
> openat(2) because of their unspecified flags handling.  When used with
> openat2(2), the default behavior is only to forbid to open a directory.
>
> The underlying idea is to be able to restrict scripts interpretation
> according to a policy defined by the system administrator.  For this to
> be possible, script interpreters must use the O_MAYEXEC flag
> appropriately.  To be fully effective, these interpreters also need to
> handle the other ways to execute code: command line parameters (e.g.,
> option -e for Perl), module loading (e.g., option -m for Python), stdin,
> file sourcing, environment variables, configuration files, etc.
> According to the threat model, it may be acceptable to allow some script
> interpreters (e.g. Bash) to interpret commands from stdin, may it be a
> TTY or a pipe, because it may not be enough to (directly) perform
> syscalls.  Further documentation can be found in a following patch.
>
> Even without enforced security policy, userland interpreters can set it
> to enforce the system policy at their level, knowing that it will not
> break anything on running systems which do not care about this feature.
> However, on systems which want this feature enforced, there will be
> knowledgeable people (i.e. sysadmins who enforced O_MAYEXEC
> deliberately) to manage it.  A simple security policy implementation,
> configured through a dedicated sysctl, is available in a following
> patch.
>
> O_MAYEXEC should not be confused with the O_EXEC flag which is intended
> for execute-only, which obviously doesn't work for scripts.  However, a
> similar behavior could be implemented in userland with O_PATH:
> https://lore.kernel.org/lkml/1e2f6913-42f2-3578-28ed-567f6a4bdda1@digikod.net/
>
> The implementation of O_MAYEXEC almost duplicates what execve(2) and
> uselib(2) are already doing: setting MAY_OPENEXEC in acc_mode (which can
> then be checked as MAY_EXEC, if enforced).

You are allowing S_IFBLK, S_IFCHR, S_IFIFO, S_IFSOCK as targets for
O_MAYEXEC?

You are not requiring the opened script be executable?

You are not requring path_noexec?  Despite the original patch that
inspired this was checking path_noexec?

I honestly think this patch is buggy.  If you could reuse MAY_EXEC in
the kernel and mean what exec means when it says MAY_EXEC that would be
useful.

As it is this patch appears wrong and dangerously confusing as it implies
execness but does not implement execness.

If you were simply defining O_EXEC and reusing MAY_EXEC as it exists
or exists with cleanups in the kernel this would be a small change that
would seem to make reasonable sense.  But as you are not reusing
anything from MAY_EXEC this code does not make any sense as I am reading
it.

Eric


> This is an updated subset of the patch initially written by Vincent
> Strubel for CLIP OS 4:
> https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> This patch has been used for more than 12 years with customized script
> interpreters.  Some examples (with the original O_MAYEXEC) can be found
> here:
> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
>
> Co-developed-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
> Signed-off-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
> Co-developed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Deven Bowers <deven.desai@linux.microsoft.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>
> Changes since v6:
> * Do not set __FMODE_EXEC for now because of inconsistent behavior:
>   https://lore.kernel.org/lkml/202007160822.CCDB5478@keescook/
> * Returns EISDIR when opening a directory with O_MAYEXEC.
> * Removed Deven Bowers and Kees Cook Reviewed-by tags because of the
>   current update.
>
> Changes since v5:
> * Update commit message.
>
> Changes since v3:
> * Switch back to O_MAYEXEC, but only handle it with openat2(2) which
>   checks unknown flags (suggested by Aleksa Sarai). Cf.
>   https://lore.kernel.org/lkml/20200430015429.wuob7m5ofdewubui@yavin.dot.cyphar.com/
>
> Changes since v2:
> * Replace O_MAYEXEC with RESOLVE_MAYEXEC from openat2(2).  This change
>   enables to not break existing application using bogus O_* flags that
>   may be ignored by current kernels by using a new dedicated flag, only
>   usable through openat2(2) (suggested by Jeff Layton).  Using this flag
>   will results in an error if the running kernel does not support it.
>   User space needs to manage this case, as with other RESOLVE_* flags.
>   The best effort approach to security (for most common distros) will
>   simply consists of ignoring such an error and retry without
>   RESOLVE_MAYEXEC.  However, a fully controlled system may which to
>   error out if such an inconsistency is detected.
>
> Changes since v1:
> * Set __FMODE_EXEC when using O_MAYEXEC to make this information
>   available through the new fanotify/FAN_OPEN_EXEC event (suggested by
>   Jan Kara and Matthew Bobrowski):
>   https://lore.kernel.org/lkml/20181213094658.GA996@lithium.mbobrowski.org/
> ---
>  fs/fcntl.c                       | 2 +-
>  fs/namei.c                       | 4 ++--
>  fs/open.c                        | 6 ++++++
>  include/linux/fcntl.h            | 2 +-
>  include/linux/fs.h               | 2 ++
>  include/uapi/asm-generic/fcntl.h | 7 +++++++
>  6 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 2e4c0fa2074b..0357ad667563 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -1033,7 +1033,7 @@ static int __init fcntl_init(void)
>  	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
>  	 * is defined as O_NONBLOCK on some platforms and not on others.
>  	 */
> -	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
> +	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
>  		HWEIGHT32(
>  			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
>  			__FMODE_EXEC | __FMODE_NONOTIFY));
> diff --git a/fs/namei.c b/fs/namei.c
> index ddc9b25540fe..3f074ec77390 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -428,7 +428,7 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
>  /**
>   * inode_permission - Check for access rights to a given inode
>   * @inode: Inode to check permission on
> - * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
> + * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC, %MAY_OPENEXEC)
>   *
>   * Check for read/write/execute permissions on an inode.  We use fs[ug]id for
>   * this, letting us set arbitrary permissions for filesystem access without
> @@ -2849,7 +2849,7 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>  	case S_IFLNK:
>  		return -ELOOP;
>  	case S_IFDIR:
> -		if (acc_mode & (MAY_WRITE | MAY_EXEC))
> +		if (acc_mode & (MAY_WRITE | MAY_EXEC | MAY_OPENEXEC))
>  			return -EISDIR;
>  		break;
>  	case S_IFBLK:
> diff --git a/fs/open.c b/fs/open.c
> index 623b7506a6db..21c2c1020574 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -987,6 +987,8 @@ inline struct open_how build_open_how(int flags, umode_t mode)
>  		.mode = mode & S_IALLUGO,
>  	};
>  
> +	/* O_MAYEXEC is ignored by syscalls relying on build_open_how(). */
> +	how.flags &= ~O_MAYEXEC;
>  	/* O_PATH beats everything else. */
>  	if (how.flags & O_PATH)
>  		how.flags &= O_PATH_FLAGS;
> @@ -1054,6 +1056,10 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  	if (flags & __O_SYNC)
>  		flags |= O_DSYNC;
>  
> +	/* Checks execution permissions on open. */
> +	if (flags & O_MAYEXEC)
> +		acc_mode |= MAY_OPENEXEC;
> +
>  	op->open_flag = flags;
>  
>  	/* O_TRUNC implies we need access checks for write permissions */
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index 7bcdcf4f6ab2..e188a360fa5f 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -10,7 +10,7 @@
>  	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
>  	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> -	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> +	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_MAYEXEC)
>  
>  /* List of all valid flags for the how->upgrade_mask argument: */
>  #define VALID_UPGRADE_FLAGS \
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f5abba86107d..56f835c9a87a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -101,6 +101,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  #define MAY_CHDIR		0x00000040
>  /* called from RCU mode, don't block */
>  #define MAY_NOT_BLOCK		0x00000080
> +/* the inode is opened with O_MAYEXEC */
> +#define MAY_OPENEXEC		0x00000100
>  
>  /*
>   * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index 9dc0bf0c5a6e..bca90620119f 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -97,6 +97,13 @@
>  #define O_NDELAY	O_NONBLOCK
>  #endif
>  
> +/*
> + * Code execution from file is intended, checks such permission.  A simple
> + * policy can be enforced system-wide as explained in
> + * Documentation/admin-guide/sysctl/fs.rst .
> + */
> +#define O_MAYEXEC	040000000
> +
>  #define F_DUPFD		0	/* dup */
>  #define F_GETFD		1	/* get close_on_exec */
>  #define F_SETFD		2	/* set/clear close_on_exec */
