Return-Path: <linux-fsdevel+bounces-37724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F39F6392
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1277A5A12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7819CC2A;
	Wed, 18 Dec 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Y3m5zst7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE319C569;
	Wed, 18 Dec 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518480; cv=none; b=ETX658o9W3z6aWj3unUyIMcjPysjbjTxC4Jlp2day9Ps5Um8RpostWRUgvjD8iJTKmG4/QB0dZzR1vbYIMT7z06Rqmm0bfflyaaHXdIEj+8Nee4oxhgAtYtzmPVNXGpWNV2t0nnce3rn2w9wJ6UzZV528776yOSOCekziHvG9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518480; c=relaxed/simple;
	bh=JzcGOfKtkEy6n+r62/AfOmSnwem/3Lv/+YkzITbANxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRWS3ZZ0VZI7WCbE8mh+fAc1t3GKNXYGdk86V4mmGj0l11H8nGyQMQ0oxaeJUq4HvIkLSR974YmmtPrarD/VrR5AqvbndfdiGkzo7ircmr28KRAFxLsKPRNgCaYXMsl/aj2c0x5w9HAlrnOxIT0/WFop+VvuhetwiNImg8JjvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Y3m5zst7; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YCqwM6bLyzQxs;
	Wed, 18 Dec 2024 11:41:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734518467;
	bh=norZX96vwM8+ta5z1TEvL+srgGLTB0P/RZqsKZDM5XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3m5zst7CyHobTtTlbIrSmdzHO6E6y+NZjvueTijUlNHZXMgg7jev0iYVuTqsJkxv
	 ZEBy+t7VYIRXEV0rQ243MHkHrtpzBBVfcsPgEo8cK+HgdcdEUZ15s+1gWgSI6HHY9T
	 buDHrT/vMbwxv1DRBIk1VU6P2zQgula7XRAm0QBA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YCqwG0Lfrz7wQ;
	Wed, 18 Dec 2024 11:41:01 +0100 (CET)
Date: Wed, 18 Dec 2024 11:40:59 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v23 0/8] Script execution control (was O_MAYEXEC)
Message-ID: <20241218.aBaituy0veK7@digikod.net>
References: <20241212174223.389435-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212174223.389435-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Thu, Dec 12, 2024 at 06:42:15PM +0100, Mickaël Salaün wrote:
> Hi,
> 
> The goal of this patch series is to be able to ensure that direct file
> execution (e.g. ./script.sh) and indirect file execution (e.g. sh
> script.sh) lead to the same result, especially from a security point of
> view.
> 
> The main changes from the previous version are the rename of
> AUDIT_INTEGRITY_DATA_CHECK to AUDIT_INTEGRITY_USERSPACE, and new
> Reviewed-by and Tested-by tags.  This series is based on v6.13-rc2 and
> it also applies on linux-next.
> 
> The current status is summarized in this article:
> https://lwn.net/Articles/982085/
> I also gave a talk at LPC last month:
> https://lpc.events/event/18/contributions/1692/
> And here is a proof of concept for Python (for now, for the previous
> version: v19): https://github.com/zooba/spython/pull/12
> 
> Kees, this series should be good now, I'll let you take it to your tree
> if it's OK with you.

In the meantime I've pushed it in my tree, it should appear in -next
tomorrow.  Please, let me know when you take it, I'll remove it from my
tree.

> 
> Overview
> --------
> 
> This patch series is a new approach of the initial O_MAYEXEC feature,
> and a revamp of the previous patch series.  Taking into account the last
> reviews [1], we now stick to the kernel semantic for file executability.
> One major change is the clear split between access check and policy
> management.
> 
> The first patch brings the AT_EXECVE_CHECK flag to execveat(2).  The
> goal is to enable user space to check if a file could be executed (by
> the kernel).  Unlike stat(2) that only checks file permissions,
> execveat2(2) + AT_EXECVE_CHECK take into account the full context,
> including mount points (noexec), caller's limits, and all potential LSM
> extra checks (e.g. argv, envp, credentials).
> 
> The second patch brings two new securebits used to set or get a security
> policy for a set of processes.  For this to be meaningful, all
> executable code needs to be trusted.  In practice, this means that
> (malicious) users can be restricted to only run scripts provided (and
> trusted) by the system.
> 
> [1] https://lore.kernel.org/r/CAHk-=wjPGNLyzeBMWdQu+kUdQLHQugznwY7CvWjmvNW47D5sog@mail.gmail.com
> 
> Script execution
> ----------------
> 
> One important thing to keep in mind is that the goal of this patch
> series is to get the same security restrictions with these commands:
> * ./script.py
> * python script.py
> * python < script.py
> * python -m script.py
> 
> However, on secure systems, we should be able to forbid these commands
> because there is no way to reliably identify the origin of the script:
> * xargs -a script.py -d '\r' -- python -c
> * cat script.py | python
> * python
> 
> Background
> ----------
> 
> Compared to the previous patch series, there is no more dedicated
> syscall nor sysctl configuration.  This new patch series only add new
> flags: one for execveat(2) and four for prctl(2).
> 
> This kind of script interpreter restriction may already be used in
> hardened systems, which may need to fork interpreters and install
> different versions of the binaries.  This mechanism should enable to
> avoid the use of duplicate binaries (and potential forked source code)
> for secure interpreters (e.g. secure Python [2]) by making it possible
> to dynamically enforce restrictions or not.
> 
> The ability to control script execution is also required to close a
> major IMA measurement/appraisal interpreter integrity [3].
> 
> This new execveat + AT_EXECVE_CHECK should not be confused with the
> O_EXEC flag (for open) which is intended for execute-only, which
> obviously doesn't work for scripts.
> 
> I gave a talk about controlling script execution where I explain the
> previous approaches [4].  The design of the WIP RFC I talked about
> changed quite a bit since then.
> 
> [2] https://github.com/zooba/spython
> [3] https://lore.kernel.org/lkml/20211014130125.6991-1-zohar@linux.ibm.com/
> [4] https://lssna2023.sched.com/event/1K7bO
> 
> Execution policy
> ----------------
> 
> The "execution" usage means that the content of the file descriptor is
> trusted according to the system policy to be executed by user space,
> which means that it interprets the content or (try to) maps it as
> executable memory.
> 
> It is important to note that this can only enable to extend access
> control managed by the kernel.  Hence it enables current access control
> mechanism to be extended and become a superset of what they can
> currently control.  Indeed, the security policy could also be delegated
> to an LSM, either a MAC system or an integrity system.
> 
> Complementary W^X protections can be brought by SELinux or IPE [5].
> 
> Being able to restrict execution also enables to protect the kernel by
> restricting arbitrary syscalls that an attacker could perform with a
> crafted binary or certain script languages.  It also improves multilevel
> isolation by reducing the ability of an attacker to use side channels
> with specific code.  These restrictions can natively be enforced for ELF
> binaries (with the noexec mount option) but require this kernel
> extension to properly handle scripts (e.g. Python, Perl).  To get a
> consistent execution policy, additional memory restrictions should also
> be enforced (e.g. thanks to SELinux).
> 
> [5] https://lore.kernel.org/lkml/1716583609-21790-1-git-send-email-wufan@linux.microsoft.com/
> 
> Prerequisite for security use
> -----------------------------
> 
> Because scripts might not currently have the executable permission and
> still run well as is, or because we might want specific users to be
> allowed to run arbitrary scripts, we also need a configuration
> mechanism.
> 
> According to the threat model, to get a secure execution environment on
> top of these changes, it might be required to configure and enable
> existing security mechanisms such as secure boot, restrictive mount
> points (e.g. with rw AND noexec), correct file permissions (including
> executable libraries), IMA/EVM, SELinux policy...
> 
> The first thing to patch is the libc to check loaded libraries (e.g. see
> chromeOS changes).  The second thing to patch are the script
> interpreters by checking direct scripts executability and by checking
> their own libraries (e.g. Python's imported files or argument-passed
> modules).  For instance, the PEP 578 [6] (Runtime Audit Hooks) enables
> Python 3.8 to be extended with policy enforcement points related to code
> interpretation, which can be used to align with the PowerShell audit
> features.  Additional Python security improvements (e.g. a limited
> interpreter without -c, stdin piping of code) are developed [2] [7].
> 
> [6] https://www.python.org/dev/peps/pep-0578/
> [7] https://lore.kernel.org/lkml/0c70debd-e79e-d514-06c6-4cd1e021fa8b@python.org/
> 
> libc patch
> ----------
> 
> Dynamic linking needs still need to check the libraries the same way
> interpreters need to check scripts.
> 
> chromeOS patches glibc with a fstatvfs check [8] [9]. This enables to
> check against noexec mount points, which is OK but doesn't fit with
> execve semantics.  Moreover, the kernel is not aware of such check, so
> all access control checks are not performed (e.g. file permission, LSMs
> security policies, integrity and authenticity checks), it is not handled
> with audit, and more importantly this would not work on generic
> distributions because of the strict requirement and chromeOS-specific
> assumptions.
> 
> [8] https://issuetracker.google.com/issues/40054993
> [9] https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/6abfc9e327241a5f684b8b941c899b7ca8b6dbc1/sys-libs/glibc/files/local/glibc-2.37/0007-Deny-LD_PRELOAD-of-files-in-NOEXEC-mount.patch
> 
> Examples
> --------
> 
> The initial idea comes from CLIP OS 4 and the original implementation
> has been used for more than a decade:
> https://github.com/clipos-archive/clipos4_doc
> Chrome OS has a similar approach:
> https://www.chromium.org/chromium-os/developer-library/guides/security/noexec-shell-scripts/
> 
> User space patches can be found here:
> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> There is more than the O_MAYEXEC changes (which matches this search)
> e.g., to prevent Python interactive execution. There are patches for
> Bash, Wine, Java (Icedtea), Busybox's ash, Perl and Python. There are
> also some related patches which do not directly rely on O_MAYEXEC but
> which restrict the use of browser plugins and extensions, which may be
> seen as scripts too:
> https://github.com/clipos-archive/clipos4_portage-overlay/tree/master/www-client
> 
> Past talks and articles
> -----------------------
> 
> Closing the script execution control gap at Linux Plumbers Conference
> 2024: https://lpc.events/event/18/contributions/1692/
> 
> An introduction to O_MAYEXEC was given at the Linux Security Summit
> Europe 2018 - Linux Kernel Security Contributions by ANSSI:
> https://www.youtube.com/watch?v=chNjCRtPKQY&t=17m15s
> 
> The "write xor execute" principle was explained at Kernel Recipes 2018 -
> CLIP OS: a defense-in-depth OS:
> https://www.youtube.com/watch?v=PjRE0uBtkHU&t=11m14s
> 
> LWN articles:
> * https://lwn.net/Articles/982085/
> * https://lwn.net/Articles/832959/
> * https://lwn.net/Articles/820000/
> 
> FAQ
> Link: https://lore.kernel.org/r/20241212174223.389435-1-mic@digikod.net
> ---
> 
> Q: Why not extend open(2) or openat2(2) with a new flag like O_MAYEXEC?
> A: Because it is not flexible enough:
> https://lore.kernel.org/r/CAG48ez0NAV5gPgmbDaSjo=zzE=FgnYz=-OHuXwu0Vts=B5gesA@mail.gmail.com
> 
> Q: Why not only allowing file descriptor to avoid TOCTOU?
> A: Because there are different use cases:
> https://lore.kernel.org/r/CAHk-=whb=XuU=LGKnJWaa7LOYQz9VwHs8SLfgLbT5sf2VAbX1A@mail.gmail.com
> 
> Q: We can copy a script into a memfd and use it as an executable FD.
>    Wouldn't that bypass the purpose of this patch series?
> A: If an attacker can create a memfd it means that a
>    malicious/compromised code is already running and it's too late for
>    script execution control to help.  This patch series makes it more
>    difficult for an attacker to execute arbitrary code on a trusted
>    system in the first place:
> https://lore.kernel.org/all/20240717.AGh2shahc9ee@digikod.net/
> 
> Q: What about ROP?
> A: See previous answer. If ROP is exploited then the attacker already
>    controls some code:
> https://lore.kernel.org/all/20240718.ahph4che5Shi@digikod.net/
> 
> Q: What about LD_PRELOAD environment variable?
> A: The dynamic linker should be enlighten to check if libraries are
>    allowed to be loaded.
> 
> Q: What about The PATH environment variable?
> A: All programs allowed to be executed are deemed trusted.
> 
> Q: Should we check seccomp filters too?
> A: Yes, they should be considered as executable code because they can
>    change the behavior of processes, similarly to code injection:
> https://lore.kernel.org/all/20240705.IeTheequ7Ooj@digikod.net/
> 
> Q: Could that be used for role transition?
> A: That would be risky and difficult to implement correctly:
> https://lore.kernel.org/all/20240723.Tae5oovie2ah@digikod.net/
> 
> Previous versions
> -----------------
> 
> v22: https://lore.kernel.org/r/20241205160925.230119-1-mic@digikod.net
> v21: https://lore.kernel.org/r/20241112191858.162021-1-mic@digikod.net
> v20: https://lore.kernel.org/r/20241011184422.977903-1-mic@digikod.net
> v19: https://lore.kernel.org/r/20240704190137.696169-1-mic@digikod.net
> v18: https://lore.kernel.org/r/20220104155024.48023-1-mic@digikod.net
> v17: https://lore.kernel.org/r/20211115185304.198460-1-mic@digikod.net
> v16: https://lore.kernel.org/r/20211110190626.257017-1-mic@digikod.net
> v15: https://lore.kernel.org/r/20211012192410.2356090-1-mic@digikod.net
> v14: https://lore.kernel.org/r/20211008104840.1733385-1-mic@digikod.net
> v13: https://lore.kernel.org/r/20211007182321.872075-1-mic@digikod.net
> v12: https://lore.kernel.org/r/20201203173118.379271-1-mic@digikod.net
> v11: https://lore.kernel.org/r/20201019164932.1430614-1-mic@digikod.net
> v10: https://lore.kernel.org/r/20200924153228.387737-1-mic@digikod.net
> v9: https://lore.kernel.org/r/20200910164612.114215-1-mic@digikod.net
> v8: https://lore.kernel.org/r/20200908075956.1069018-1-mic@digikod.net
> v7: https://lore.kernel.org/r/20200723171227.446711-1-mic@digikod.net
> v6: https://lore.kernel.org/r/20200714181638.45751-1-mic@digikod.net
> v5: https://lore.kernel.org/r/20200505153156.925111-1-mic@digikod.net
> v4: https://lore.kernel.org/r/20200430132320.699508-1-mic@digikod.net
> v3: https://lore.kernel.org/r/20200428175129.634352-1-mic@digikod.net
> v2: https://lore.kernel.org/r/20190906152455.22757-1-mic@digikod.net
> v1: https://lore.kernel.org/r/20181212081712.32347-1-mic@digikod.net
> 
> Regards,
> 
> Mickaël Salaün (7):
>   exec: Add a new AT_EXECVE_CHECK flag to execveat(2)
>   security: Add EXEC_RESTRICT_FILE and EXEC_DENY_INTERACTIVE securebits
>   selftests/exec: Add 32 tests for AT_EXECVE_CHECK and exec securebits
>   selftests/landlock: Add tests for execveat + AT_EXECVE_CHECK
>   samples/check-exec: Add set-exec
>   selftests: ktap_helpers: Fix uninitialized variable
>   samples/check-exec: Add an enlighten "inc" interpreter and 28 tests
> 
> Mimi Zohar (1):
>   ima: instantiate the bprm_creds_for_exec() hook
> 
>  Documentation/userspace-api/check_exec.rst    | 144 ++++++
>  Documentation/userspace-api/index.rst         |   1 +
>  fs/exec.c                                     |  20 +-
>  include/linux/binfmts.h                       |   7 +-
>  include/uapi/linux/audit.h                    |   1 +
>  include/uapi/linux/fcntl.h                    |   4 +
>  include/uapi/linux/securebits.h               |  24 +-
>  samples/Kconfig                               |   9 +
>  samples/Makefile                              |   1 +
>  samples/check-exec/.gitignore                 |   2 +
>  samples/check-exec/Makefile                   |  15 +
>  samples/check-exec/inc.c                      | 205 ++++++++
>  samples/check-exec/run-script-ask.inc         |   9 +
>  samples/check-exec/script-ask.inc             |   5 +
>  samples/check-exec/script-exec.inc            |   4 +
>  samples/check-exec/script-noexec.inc          |   4 +
>  samples/check-exec/set-exec.c                 |  85 ++++
>  security/commoncap.c                          |  29 +-
>  security/integrity/ima/ima_appraise.c         |  27 +-
>  security/integrity/ima/ima_main.c             |  29 ++
>  security/security.c                           |  10 +
>  tools/testing/selftests/exec/.gitignore       |   4 +
>  tools/testing/selftests/exec/Makefile         |  19 +-
>  .../selftests/exec/check-exec-tests.sh        | 205 ++++++++
>  tools/testing/selftests/exec/check-exec.c     | 456 ++++++++++++++++++
>  tools/testing/selftests/exec/config           |   2 +
>  tools/testing/selftests/exec/false.c          |   5 +
>  .../selftests/kselftest/ktap_helpers.sh       |   2 +-
>  tools/testing/selftests/landlock/fs_test.c    |  27 ++
>  29 files changed, 1341 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/userspace-api/check_exec.rst
>  create mode 100644 samples/check-exec/.gitignore
>  create mode 100644 samples/check-exec/Makefile
>  create mode 100644 samples/check-exec/inc.c
>  create mode 100755 samples/check-exec/run-script-ask.inc
>  create mode 100755 samples/check-exec/script-ask.inc
>  create mode 100755 samples/check-exec/script-exec.inc
>  create mode 100644 samples/check-exec/script-noexec.inc
>  create mode 100644 samples/check-exec/set-exec.c
>  create mode 100755 tools/testing/selftests/exec/check-exec-tests.sh
>  create mode 100644 tools/testing/selftests/exec/check-exec.c
>  create mode 100644 tools/testing/selftests/exec/config
>  create mode 100644 tools/testing/selftests/exec/false.c
> 
> 
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> -- 
> 2.47.1
> 
> 

