Return-Path: <linux-fsdevel+bounces-31929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2DF99DCA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 05:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEE31F2336B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 03:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869BE16F8E9;
	Tue, 15 Oct 2024 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND9Hp13D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4134C8C;
	Tue, 15 Oct 2024 03:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962125; cv=none; b=VdfkUm25xtxkMaI4jxximZpWTzZD7r4EfrmmkwuytoSn2fFQlS40YXqtngWjw5izi0Vlnp3NaoN094+j+KVafbqHJLDsA+DgsomjLdVO+5qNbjPSW17+6QTI5TjWgxA2jR2dAKOFI82xbOergwJ27PDCcYkj07bYiM/SEew/INc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962125; c=relaxed/simple;
	bh=E0WJ4rjhnWu0MB+l2de6nNeOUQNVkHTbUXniZh7gi8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLsAxYvPUSzelFEhG+B+6TIAtp/OGW3yYy/KfJ+SL8M6B0m3YTIJMr1zwqspZPkaWdu2VeA8TmsobL1ay0/C0qNWiA0T7tQd9Q5pkgUYFQsB+YazPOTdpdlh9eEnyhS1FxZ8pgPM78lC7124/08WLpHcwdoRgqcP70pCGvNOfWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND9Hp13D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD07C4CEC3;
	Tue, 15 Oct 2024 03:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728962124;
	bh=E0WJ4rjhnWu0MB+l2de6nNeOUQNVkHTbUXniZh7gi8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ND9Hp13D7S+5DQEP8BSTW6fpdb2LgqjdKb/k/74goht9dUl96it6uqFtX/Zndektg
	 14sLKUyWPurZNYyUX+/wgKrRLvAcq4JUVWEDpy6U0DiRKNtCKuOWbF6lhAAhxTiHRL
	 eMSj5kqysF+eEbabDMXN4ryzc9vAPrDu62mXUab0kEZvq33BYcblHqBQbeSTxgYHlc
	 fYjpEBWl+yIMP18KIFpeOat/jAtLBrjyNMC+Tud79WmSRR/5ydlwG8XioWxC3ifRbd
	 AYjWX7hjLzpHQBcOKyRm493jdRKGyYsZh5rhhAcevjkHTebTddqAfy80zPZ1sTsPV1
	 VWpDJhqJ9i4nQ==
Date: Tue, 15 Oct 2024 03:15:11 +0000
From: sergeh@kernel.org
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v20 2/6] security: Add EXEC_RESTRICT_FILE and
 EXEC_DENY_INTERACTIVE securebits
Message-ID: <Zw3d5ZmyK2mLBeeJ@lei>
References: <20241011184422.977903-1-mic@digikod.net>
 <20241011184422.977903-3-mic@digikod.net>
 <20241013025150.GA1056399@mail.hallyn.com>
 <20241014.jahHeitoo0uo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014.jahHeitoo0uo@digikod.net>

On Mon, Oct 14, 2024 at 09:40:34AM +0200, Mickaël Salaün wrote:
> On Sat, Oct 12, 2024 at 09:51:50PM -0500, Serge E. Hallyn wrote:
> > On Fri, Oct 11, 2024 at 08:44:18PM +0200, Mickaël Salaün wrote:
> > > The new SECBIT_EXEC_RESTRICT_FILE, SECBIT_EXEC_DENY_INTERACTIVE, and
> > > their *_LOCKED counterparts are designed to be set by processes setting
> > > up an execution environment, such as a user session, a container, or a
> > > security sandbox.  Unlike other securebits, these ones can be set by
> > > unprivileged processes.  Like seccomp filters or Landlock domains, the
> > > securebits are inherited across processes.
> > > 
> > > When SECBIT_EXEC_RESTRICT_FILE is set, programs interpreting code should
> > > control executable resources according to execveat(2) + AT_CHECK (see
> > > previous commit).
> > > 
> > > When SECBIT_EXEC_DENY_INTERACTIVE is set, a process should deny
> > > execution of user interactive commands (which excludes executable
> > > regular files).
> > > 
> > > Being able to configure each of these securebits enables system
> > > administrators or owner of image containers to gradually validate the
> > > related changes and to identify potential issues (e.g. with interpreter
> > > or audit logs).
> > > 
> > > It should be noted that unlike other security bits, the
> > > SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE bits are
> > > dedicated to user space willing to restrict itself.  Because of that,
> > > they only make sense in the context of a trusted environment (e.g.
> > > sandbox, container, user session, full system) where the process
> > > changing its behavior (according to these bits) and all its parent
> > > processes are trusted.  Otherwise, any parent process could just execute
> > > its own malicious code (interpreting a script or not), or even enforce a
> > > seccomp filter to mask these bits.
> > > 
> > > Such a secure environment can be achieved with an appropriate access
> > > control (e.g. mount's noexec option, file access rights, LSM policy) and
> > > an enlighten ld.so checking that libraries are allowed for execution
> > > e.g., to protect against illegitimate use of LD_PRELOAD.
> > > 
> > > Ptrace restrictions according to these securebits would not make sense
> > > because of the processes' trust assumption.
> > > 
> > > Scripts may need some changes to deal with untrusted data (e.g. stdin,
> > > environment variables), but that is outside the scope of the kernel.
> > > 
> > > See chromeOS's documentation about script execution control and the
> > > related threat model:
> > > https://www.chromium.org/chromium-os/developer-library/guides/security/noexec-shell-scripts/
> > > 
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Andy Lutomirski <luto@amacapital.net>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Serge Hallyn <serge@hallyn.com>
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > Link: https://lore.kernel.org/r/20241011184422.977903-3-mic@digikod.net
> > > ---
> > > 
> > > Changes since v19:
> > > * Replace SECBIT_SHOULD_EXEC_CHECK and SECBIT_SHOULD_EXEC_RESTRICT with
> > >   SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE:
> > >   https://lore.kernel.org/all/20240710.eiKohpa4Phai@digikod.net/
> > > * Remove the ptrace restrictions, suggested by Andy.
> > > * Improve documentation according to the discussion with Jeff.
> > > 
> > > New design since v18:
> > > https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> > > ---
> > >  include/uapi/linux/securebits.h | 113 +++++++++++++++++++++++++++++++-
> > >  security/commoncap.c            |  29 ++++++--
> > >  2 files changed, 135 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/securebits.h
> > > index d6d98877ff1a..351b6ecefc76 100644
> > > --- a/include/uapi/linux/securebits.h
> > > +++ b/include/uapi/linux/securebits.h
> > > @@ -52,10 +52,121 @@
> > >  #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
> > >  			(issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED))
> > >  
> > > +/*
> > > + * The SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE securebits
> > > + * are intended for script interpreters and dynamic linkers to enforce a
> > > + * consistent execution security policy handled by the kernel.
> > > + *
> > > + * Whether an interpreter should check these securebits or not depends on the
> > > + * security risk of running malicious scripts with respect to the execution
> > > + * environment, and whether the kernel can check if a script is trustworthy or
> > > + * not.  For instance, Python scripts running on a server can use arbitrary
> > > + * syscalls and access arbitrary files.  Such interpreters should then be
> > > + * enlighten to use these securebits and let users define their security
> > > + * policy.  However, a JavaScript engine running in a web browser should
> > > + * already be sandboxed and then should not be able to harm the user's
> > > + * environment.
> > > + *
> > > + * When SECBIT_EXEC_RESTRICT_FILE is set, a process should only interpret or
> > > + * execute a file if a call to execveat(2) with the related file descriptor and
> > > + * the AT_CHECK flag succeed.
> > > + *
> > > + * This secure bit may be set by user session managers, service managers,
> > > + * container runtimes, sandboxer tools...  Except for test environments, the
> > > + * related SECBIT_EXEC_RESTRICT_FILE_LOCKED bit should also be set.
> > > + *
> > > + * Programs should only enforce consistent restrictions according to the
> > > + * securebits but without relying on any other user-controlled configuration.
> > > + * Indeed, the use case for these securebits is to only trust executable code
> > > + * vetted by the system configuration (through the kernel), so we should be
> > > + * careful to not let untrusted users control this configuration.
> > > + *
> > > + * However, script interpreters may still use user configuration such as
> > > + * environment variables as long as it is not a way to disable the securebits
> > > + * checks.  For instance, the PATH and LD_PRELOAD variables can be set by a
> > > + * script's caller.  Changing these variables may lead to unintended code
> > > + * executions, but only from vetted executable programs, which is OK.  For this
> > > + * to make sense, the system should provide a consistent security policy to
> > > + * avoid arbitrary code execution e.g., by enforcing a write xor execute
> > > + * policy.
> > > + *
> > > + * SECBIT_EXEC_RESTRICT_FILE is complementary and should also be checked.
> > > + */
> > > +#define SECURE_EXEC_RESTRICT_FILE		8
> > > +#define SECURE_EXEC_RESTRICT_FILE_LOCKED	9  /* make bit-8 immutable */
> > > +
> > > +#define SECBIT_EXEC_RESTRICT_FILE (issecure_mask(SECURE_EXEC_RESTRICT_FILE))
> > > +#define SECBIT_EXEC_RESTRICT_FILE_LOCKED \
> > > +			(issecure_mask(SECURE_EXEC_RESTRICT_FILE_LOCKED))
> > > +
> > > +/*
> > > + * When SECBIT_EXEC_DENY_INTERACTIVE is set, a process should never interpret
> > > + * interactive user commands (e.g. scripts).  However, if such commands are
> > > + * passed through a file descriptor (e.g. stdin), its content should be
> > > + * interpreted if a call to execveat(2) with the related file descriptor and
> > > + * the AT_CHECK flag succeed.
> > > + *
> > > + * For instance, script interpreters called with a script snippet as argument
> > > + * should always deny such execution if SECBIT_EXEC_DENY_INTERACTIVE is set.
> > > + *
> > > + * This secure bit may be set by user session managers, service managers,
> > > + * container runtimes, sandboxer tools...  Except for test environments, the
> > > + * related SECBIT_EXEC_DENY_INTERACTIVE_LOCKED bit should also be set.
> > > + *
> > > + * See the SECBIT_EXEC_RESTRICT_FILE documentation.
> > > + *
> > > + * Here is the expected behavior for a script interpreter according to
> > > + * combination of any exec securebits:
> > > + *
> > > + * 1. SECURE_EXEC_RESTRICT_FILE=0 SECURE_EXEC_DENY_INTERACTIVE=0 (default)
> > > + *    Always interpret scripts, and allow arbitrary user commands.
> > > + *    => No threat, everyone and everything is trusted, but we can get ahead of
> > > + *       potential issues thanks to the call to execveat with AT_CHECK which
> > > + *       should always be performed but ignored by the script interpreter.
> > > + *       Indeed, this check is still important to enable systems administrators
> > > + *       to verify requests (e.g. with audit) and prepare for migration to a
> > > + *       secure mode.
> > > + *
> > > + * 2. SECURE_EXEC_RESTRICT_FILE=1 SECURE_EXEC_DENY_INTERACTIVE=0
> > > + *    Deny script interpretation if they are not executable, but allow
> > > + *    arbitrary user commands.
> > > + *    => The threat is (potential) malicious scripts run by trusted (and not
> > > + *       fooled) users.  That can protect against unintended script executions
> > > + *       (e.g. sh /tmp/*.sh).  This makes sense for (semi-restricted) user
> > > + *       sessions.
> > > + *
> > > + * 3. SECURE_EXEC_RESTRICT_FILE=0 SECURE_EXEC_DENY_INTERACTIVE=1
> > > + *    Always interpret scripts, but deny arbitrary user commands.
> > > + *    => This use case may be useful for secure services (i.e. without
> > > + *       interactive user session) where scripts' integrity is verified (e.g.
> > > + *       with IMA/EVM or dm-verity/IPE) but where access rights might not be
> > > + *       ready yet.  Indeed, arbitrary interactive commands would be much more
> > > + *       difficult to check.
> > > + *
> > > + * 4. SECURE_EXEC_RESTRICT_FILE=1 SECURE_EXEC_DENY_INTERACTIVE=1
> > > + *    Deny script interpretation if they are not executable, and also deny
> > > + *    any arbitrary user commands.
> > > + *    => The threat is malicious scripts run by untrusted users (but trusted
> > > + *       code).  This makes sense for system services that may only execute
> > > + *       trusted scripts.
> > > + */
> > > +#define SECURE_EXEC_DENY_INTERACTIVE		10
> > > +#define SECURE_EXEC_DENY_INTERACTIVE_LOCKED	11  /* make bit-10 immutable */
> > > +
> > > +#define SECBIT_EXEC_DENY_INTERACTIVE \
> > > +			(issecure_mask(SECURE_EXEC_DENY_INTERACTIVE))
> > > +#define SECBIT_EXEC_DENY_INTERACTIVE_LOCKED \
> > > +			(issecure_mask(SECURE_EXEC_DENY_INTERACTIVE_LOCKED))
> > > +
> > >  #define SECURE_ALL_BITS		(issecure_mask(SECURE_NOROOT) | \
> > >  				 issecure_mask(SECURE_NO_SETUID_FIXUP) | \
> > >  				 issecure_mask(SECURE_KEEP_CAPS) | \
> > > -				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE))
> > > +				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE) | \
> > > +				 issecure_mask(SECURE_EXEC_RESTRICT_FILE) | \
> > > +				 issecure_mask(SECURE_EXEC_DENY_INTERACTIVE))
> > >  #define SECURE_ALL_LOCKS	(SECURE_ALL_BITS << 1)
> > >  
> > > +#define SECURE_ALL_UNPRIVILEGED (issecure_mask(SECURE_EXEC_RESTRICT_FILE) | \
> > > +				 issecure_mask(SECURE_EXEC_DENY_INTERACTIVE))
> > > +
> > >  #endif /* _UAPI_LINUX_SECUREBITS_H */
> > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > index cefad323a0b1..52ea01acb453 100644
> > > --- a/security/commoncap.c
> > > +++ b/security/commoncap.c
> > > @@ -1302,21 +1302,38 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> > >  		     & (old->securebits ^ arg2))			/*[1]*/
> > >  		    || ((old->securebits & SECURE_ALL_LOCKS & ~arg2))	/*[2]*/
> > >  		    || (arg2 & ~(SECURE_ALL_LOCKS | SECURE_ALL_BITS))	/*[3]*/
> > > -		    || (cap_capable(current_cred(),
> > > -				    current_cred()->user_ns,
> > > -				    CAP_SETPCAP,
> > > -				    CAP_OPT_NONE) != 0)			/*[4]*/
> > >  			/*
> > >  			 * [1] no changing of bits that are locked
> > >  			 * [2] no unlocking of locks
> > >  			 * [3] no setting of unsupported bits
> > > -			 * [4] doing anything requires privilege (go read about
> > > -			 *     the "sendmail capabilities bug")
> > >  			 */
> > >  		    )
> > >  			/* cannot change a locked bit */
> > >  			return -EPERM;
> > >  
> > > +		/*
> > > +		 * Doing anything requires privilege (go read about the
> > > +		 * "sendmail capabilities bug"), except for unprivileged bits.
> > > +		 * Indeed, the SECURE_ALL_UNPRIVILEGED bits are not
> > > +		 * restrictions enforced by the kernel but by user space on
> > > +		 * itself.
> > > +		 */
> > > +		if (cap_capable(current_cred(), current_cred()->user_ns,
> > > +				CAP_SETPCAP, CAP_OPT_NONE) != 0) {
> > > +			const unsigned long unpriv_and_locks =
> > > +				SECURE_ALL_UNPRIVILEGED |
> > > +				SECURE_ALL_UNPRIVILEGED << 1;
> > > +			const unsigned long changed = old->securebits ^ arg2;
> > > +
> > > +			/* For legacy reason, denies non-change. */
> > > +			if (!changed)
> > > +				return -EPERM;
> > 
> > This is odd to me.  You say for legacy reasons, but, currently, calling
> > PR_SET_SECUREBITS with no changes returns 0.  So you may be breaking
> > a lot of programs here, unless I'm mistaken.
> 
> When we call PR_SET_SECUREBITS with 0 (and if it was 0 too), it
> currently goes through the capability check and return -EPERM if the
> caller doesn't have CAP_SETCAP.  This is tested with
> TEST_F(secbits, legacy) in tools/testing/selftests/exec/check-exec.c
> (patch 3/6).

Drat, my manual test case had a typo.  Right you are - it fails now.

thanks,
-serge

