Return-Path: <linux-fsdevel+bounces-37008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA289EC49D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 07:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815D216845B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0501C3F06;
	Wed, 11 Dec 2024 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FwE/iTqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63B5661
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897566; cv=none; b=XixteN/RzodKqD/KW9bJbKq9Tyw1yY/dAr4PMNavRVzWsmGm7FyugTkUDzPTdNHVEL1rU7CeyKwL34ZhGxWDbTBGo9yKmprugsSYjl2ETIi3ECbLijVZh062x48AS3b0mNb5/P6YN5bdoFCiHr5DOcecTX+kfPkEYFA/xpKRtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897566; c=relaxed/simple;
	bh=UywFhfkXLAXUj2HRhrsNnTpgx+D9BSDIsqMGabD+kmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSMxF7MLQtGab2Fy7j9J4wL51jeSGhv6ZqinWJGbz2XpjABVvT1ipcFT5te0l1uZe6b3sLU2U5BymzpWtaVbY1GWeE63z9Mu9Ux22M+iClf8u7B/XI4unrPPOKLeki+gwuTaACvRccuKMR+TAdlPZi8yQm6VK6SaFOVPHvxV/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FwE/iTqV; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71deb3be3f1so284686a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 22:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733897563; x=1734502363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrstZ9FI7oDoywTSDKrx13VheyHzF0xgj4Fa7hmhx4k=;
        b=FwE/iTqVR2wByuC+n2xY1XwwJp79ApyuwTNsrhqXvXY6ZhDodZ8dPXcb7IxN++GsTP
         PIgM9eU2NWgXL+hY8ztPBRcmHYebzjuaICTNcXp7wu8MMoy8lQMHUaHByiGXyMIcN19G
         xNBX3O/e08Zxhz1+cUaNXDGjmv7rGZcP9ghzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733897563; x=1734502363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrstZ9FI7oDoywTSDKrx13VheyHzF0xgj4Fa7hmhx4k=;
        b=cjtPraX+gpB1TSV8l888ynVh94lFESRz9cyS0VKMWFiJbjelLrG89hir84WnP6gv0z
         Q5JgJrlVk4Umuwebc6FKVv5l861tCrK8ATOW+KL3X8y9hAO8LphtnOzu9/utvyBsQ3Gi
         z/l1IiK77KCVXZ5+OncUf9PgMK3Z63rDkxd1xZjRjxgduLnPFuxggvzPNhmVl8fBY/xA
         NAUPNq7il/NjwIoSPE4UB4xCtRTQ+WoDhFZ63ovdb3HC17svGb1Crs9RkYZ+bj/9Hxwc
         fxbu91iM1mRbn1E0WGbBBBTJ6BOyfZtiYogR8+unkm0Ve/BG4BI+mgufmnxSpvzkhRn0
         0cQw==
X-Forwarded-Encrypted: i=1; AJvYcCWzxNoYvLa32x5A19kFKgiaN9hSwKD5bck5j4+TxYqucJQGx+nQE73ZknXUL+Aqr4zPR9YB5izJBuIlEiLv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1YPg8H+14XsH2tqfTHOzYAnfqv6ACLOh8M2+s3mY5Ua7saF6v
	2tK4Nm++8kx1QFU3n7kZ1QxnnvJXTdT9omi2J7G+4MZKrkd0ph/0ugk56MeCtSqvPXQSxJ0T7MU
	FF6rmyzxGxKPCUWxadR9GKKFm2/HoBMq/opee
X-Gm-Gg: ASbGncv6BbP+fvkTwcak4jCJfpgNlAYqtGSDfs+miAEsAGU8Gta1E+facA177YceEq9
	avhkcYnBQpkKvY2Db63P+WoIxsR7YJ2sk7iacmjHh/dDVj3yVBUr6Q98NPjkGWVN3
X-Google-Smtp-Source: AGHT+IFjzapg7E7fLM9DyXss2TEsc/ZVX4eep97+cVt6UEkJnt1fbUvoixTfgps7XXEw1DxxiLeKZ98SLq3qa7Gdo5I=
X-Received: by 2002:a05:6870:c153:b0:295:f266:8aee with SMTP id
 586e51a60fabf-2a012db100emr341140fac.5.1733897562659; Tue, 10 Dec 2024
 22:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205160925.230119-1-mic@digikod.net> <20241205160925.230119-3-mic@digikod.net>
 <20241210.FahfahPu5dae@digikod.net>
In-Reply-To: <20241210.FahfahPu5dae@digikod.net>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 10 Dec 2024 22:12:31 -0800
Message-ID: <CABi2SkXMKtD-_3s-HK6W2Qp2-+GaQfckVbXwsaX5FRJGnD_irQ@mail.gmail.com>
Subject: Re: [PATCH v22 2/8] security: Add EXEC_RESTRICT_FILE and
 EXEC_DENY_INTERACTIVE securebits
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 8:48=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Thu, Dec 05, 2024 at 05:09:19PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > The new SECBIT_EXEC_RESTRICT_FILE, SECBIT_EXEC_DENY_INTERACTIVE, and
> > their *_LOCKED counterparts are designed to be set by processes setting
> > up an execution environment, such as a user session, a container, or a
> > security sandbox.  Unlike other securebits, these ones can be set by
> > unprivileged processes.  Like seccomp filters or Landlock domains, the
> > securebits are inherited across processes.
> >
> > When SECBIT_EXEC_RESTRICT_FILE is set, programs interpreting code shoul=
d
> > control executable resources according to execveat(2) + AT_EXECVE_CHECK
> > (see previous commit).
> >
> > When SECBIT_EXEC_DENY_INTERACTIVE is set, a process should deny
> > execution of user interactive commands (which excludes executable
> > regular files).
> >
> > Being able to configure each of these securebits enables system
> > administrators or owner of image containers to gradually validate the
> > related changes and to identify potential issues (e.g. with interpreter
> > or audit logs).
> >
> > It should be noted that unlike other security bits, the
> > SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE bits are
> > dedicated to user space willing to restrict itself.  Because of that,
> > they only make sense in the context of a trusted environment (e.g.
> > sandbox, container, user session, full system) where the process
> > changing its behavior (according to these bits) and all its parent
> > processes are trusted.  Otherwise, any parent process could just execut=
e
> > its own malicious code (interpreting a script or not), or even enforce =
a
> > seccomp filter to mask these bits.
> >
> > Such a secure environment can be achieved with an appropriate access
> > control (e.g. mount's noexec option, file access rights, LSM policy) an=
d
> > an enlighten ld.so checking that libraries are allowed for execution
> > e.g., to protect against illegitimate use of LD_PRELOAD.
> >
> > Ptrace restrictions according to these securebits would not make sense
> > because of the processes' trust assumption.
> >
> > Scripts may need some changes to deal with untrusted data (e.g. stdin,
> > environment variables), but that is outside the scope of the kernel.
> >
> > See chromeOS's documentation about script execution control and the
> > related threat model:
> > https://www.chromium.org/chromium-os/developer-library/guides/security/=
noexec-shell-scripts/
> >
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241205160925.230119-3-mic@digikod.net
> > ---
> >
> > Changes since v21:
> > * Extend user documentation with exception regarding tailored execution
> >   environments (e.g. chromeOS's libc) as discussed with Jeff.
> >
> > Changes since v20:
> > * Move UAPI documentation to a dedicated RST file and format it.
> >
> > Changes since v19:
> > * Replace SECBIT_SHOULD_EXEC_CHECK and SECBIT_SHOULD_EXEC_RESTRICT with
> >   SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE:
> >   https://lore.kernel.org/all/20240710.eiKohpa4Phai@digikod.net/
> > * Remove the ptrace restrictions, suggested by Andy.
> > * Improve documentation according to the discussion with Jeff.
> >
> > New design since v18:
> > https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> > ---
> >  Documentation/userspace-api/check_exec.rst | 107 +++++++++++++++++++++
> >  include/uapi/linux/securebits.h            |  24 ++++-
> >  security/commoncap.c                       |  29 ++++--
> >  3 files changed, 153 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/check_exec.rst b/Documentation=
/userspace-api/check_exec.rst
> > index 393dd7ca19c4..05dfe3b56f71 100644
> > --- a/Documentation/userspace-api/check_exec.rst
> > +++ b/Documentation/userspace-api/check_exec.rst
> > @@ -5,6 +5,31 @@
> >  Executability check
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > +The ``AT_EXECVE_CHECK`` :manpage:`execveat(2)` flag, and the
> > +``SECBIT_EXEC_RESTRICT_FILE`` and ``SECBIT_EXEC_DENY_INTERACTIVE`` sec=
urebits
> > +are intended for script interpreters and dynamic linkers to enforce a
> > +consistent execution security policy handled by the kernel.  See the
> > +`samples/check-exec/inc.c`_ example.
> > +
> > +Whether an interpreter should check these securebits or not depends on=
 the
> > +security risk of running malicious scripts with respect to the executi=
on
> > +environment, and whether the kernel can check if a script is trustwort=
hy or
> > +not.  For instance, Python scripts running on a server can use arbitra=
ry
> > +syscalls and access arbitrary files.  Such interpreters should then be
> > +enlighten to use these securebits and let users define their security =
policy.
> > +However, a JavaScript engine running in a web browser should already b=
e
> > +sandboxed and then should not be able to harm the user's environment.
> > +
> > +Script interpreters or dynamic linkers built for tailored execution en=
vironments
> > +(e.g. hardened Linux distributions or hermetic container images) could=
 use
> > +``AT_EXECVE_CHECK`` without checking the related securebits if backwar=
d
> > +compatibility is handled by something else (e.g. atomic update ensurin=
g that
> > +all legitimate libraries are allowed to be executed).  It is then reco=
mmended
> > +for script interpreters and dynamic linkers to check the securebits at=
 run time
> > +by default, but also to provide the ability for custom builds to behav=
e like if
> > +``SECBIT_EXEC_RESTRICT_FILE`` or ``SECBIT_EXEC_DENY_INTERACTIVE`` were=
 always
> > +set to 1 (i.e. always enforce restrictions).
>
> Jeff, does this work for you?
>
Yes. Thanks for updating this section.


> I'll update the IMA patch with a last version but otherwise it should be
> good: https://lore.kernel.org/all/20241210.Wie6ion7Aich@digikod.net/
>
> > +
> >  AT_EXECVE_CHECK
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > @@ -35,3 +60,85 @@ be executable, which also requires integrity guarant=
ees.
> >  To avoid race conditions leading to time-of-check to time-of-use issue=
s,
> >  ``AT_EXECVE_CHECK`` should be used with ``AT_EMPTY_PATH`` to check aga=
inst a
> >  file descriptor instead of a path.
> > +
> > +SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +When ``SECBIT_EXEC_RESTRICT_FILE`` is set, a process should only inter=
pret or
> > +execute a file if a call to :manpage:`execveat(2)` with the related fi=
le
> > +descriptor and the ``AT_EXECVE_CHECK`` flag succeed.
> > +
> > +This secure bit may be set by user session managers, service managers,
> > +container runtimes, sandboxer tools...  Except for test environments, =
the
> > +related ``SECBIT_EXEC_RESTRICT_FILE_LOCKED`` bit should also be set.
> > +
> > +Programs should only enforce consistent restrictions according to the
> > +securebits but without relying on any other user-controlled configurat=
ion.
> > +Indeed, the use case for these securebits is to only trust executable =
code
> > +vetted by the system configuration (through the kernel), so we should =
be
> > +careful to not let untrusted users control this configuration.
> > +
> > +However, script interpreters may still use user configuration such as
> > +environment variables as long as it is not a way to disable the secure=
bits
> > +checks.  For instance, the ``PATH`` and ``LD_PRELOAD`` variables can b=
e set by
> > +a script's caller.  Changing these variables may lead to unintended co=
de
> > +executions, but only from vetted executable programs, which is OK.  Fo=
r this to
> > +make sense, the system should provide a consistent security policy to =
avoid
> > +arbitrary code execution e.g., by enforcing a write xor execute policy=
.
> > +
> > +When ``SECBIT_EXEC_DENY_INTERACTIVE`` is set, a process should never i=
nterpret
> > +interactive user commands (e.g. scripts).  However, if such commands a=
re passed
> > +through a file descriptor (e.g. stdin), its content should be interpre=
ted if a
> > +call to :manpage:`execveat(2)` with the related file descriptor and th=
e
> > +``AT_EXECVE_CHECK`` flag succeed.
> > +
> > +For instance, script interpreters called with a script snippet as argu=
ment
> > +should always deny such execution if ``SECBIT_EXEC_DENY_INTERACTIVE`` =
is set.
> > +
> > +This secure bit may be set by user session managers, service managers,
> > +container runtimes, sandboxer tools...  Except for test environments, =
the
> > +related ``SECBIT_EXEC_DENY_INTERACTIVE_LOCKED`` bit should also be set=
.
> > +
> > +Here is the expected behavior for a script interpreter according to co=
mbination
> > +of any exec securebits:
> > +
> > +1. ``SECBIT_EXEC_RESTRICT_FILE=3D0`` and ``SECBIT_EXEC_DENY_INTERACTIV=
E=3D0``
> > +
> > +   Always interpret scripts, and allow arbitrary user commands (defaul=
t).
> > +
> > +   No threat, everyone and everything is trusted, but we can get ahead=
 of
> > +   potential issues thanks to the call to :manpage:`execveat(2)` with
> > +   ``AT_EXECVE_CHECK`` which should always be performed but ignored by=
 the
> > +   script interpreter.  Indeed, this check is still important to enabl=
e systems
> > +   administrators to verify requests (e.g. with audit) and prepare for
> > +   migration to a secure mode.
> > +
> > +2. ``SECBIT_EXEC_RESTRICT_FILE=3D1`` and ``SECBIT_EXEC_DENY_INTERACTIV=
E=3D0``
> > +
> > +   Deny script interpretation if they are not executable, but allow
> > +   arbitrary user commands.
> > +
> > +   The threat is (potential) malicious scripts run by trusted (and not=
 fooled)
> > +   users.  That can protect against unintended script executions (e.g.=
 ``sh
> > +   /tmp/*.sh``).  This makes sense for (semi-restricted) user sessions=
.
> > +
> > +3. ``SECBIT_EXEC_RESTRICT_FILE=3D0`` and ``SECBIT_EXEC_DENY_INTERACTIV=
E=3D1``
> > +
> > +   Always interpret scripts, but deny arbitrary user commands.
> > +
> > +   This use case may be useful for secure services (i.e. without inter=
active
> > +   user session) where scripts' integrity is verified (e.g.  with IMA/=
EVM or
> > +   dm-verity/IPE) but where access rights might not be ready yet.  Ind=
eed,
> > +   arbitrary interactive commands would be much more difficult to chec=
k.
> > +
> > +4. ``SECBIT_EXEC_RESTRICT_FILE=3D1`` and ``SECBIT_EXEC_DENY_INTERACTIV=
E=3D1``
> > +
> > +   Deny script interpretation if they are not executable, and also den=
y
> > +   any arbitrary user commands.
> > +
> > +   The threat is malicious scripts run by untrusted users (but trusted=
 code).
> > +   This makes sense for system services that may only execute trusted =
scripts.
> > +
> > +.. Links
> > +.. _samples/check-exec/inc.c:
> > +   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/samples/check-exec/inc.c
>
Reviewed-by: Jeff Xu < jeffxu@chromium.org>
Tested-by: Jeff Xu <jeffxu@chromium.org>

