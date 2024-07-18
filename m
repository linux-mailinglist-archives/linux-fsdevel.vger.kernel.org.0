Return-Path: <linux-fsdevel+bounces-23926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F50934F30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C228284335
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AEB1422D1;
	Thu, 18 Jul 2024 14:37:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438986F312;
	Thu, 18 Jul 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313433; cv=none; b=NffpU84/cm7HhHjpn7ubbCTGem4VclLYFG3WiCbXBOtzQBy4BeRgE4QfEIcBzLMTWhyJy2Wy8ImTJgLVfmlOuGLrzuZ13OO41stCaJ93G6CrvfLxivpf763tIkgQjtgX4E9Tcr6DHD4Q+Ojuchofknt5bKTvI7PCyzMY5G4SzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313433; c=relaxed/simple;
	bh=KG+r9+pdBxGhUyc5bKGSm19ff+3ISaJmIXIzLEDRzxg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VFx0NvDLz/M0qhLp2+u0gJlGuBqOa6BRd6OgQR6zYotMOgqYmUUgm9rleXkOVcQbyBw4c59pGbp3b5JtOZRqb6/zugYT/NzVnRDjgSIH9mTq6Lh36PKL9pJKe1qVEf2HbKGda9tEJ0hbKI4Z3UlZjXUcvuLJBpEsch/7asMD1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4WPvYC0VmNz9v7Hk;
	Thu, 18 Jul 2024 21:58:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1531314061D;
	Thu, 18 Jul 2024 22:17:15 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnJC7RI5lm88lbAA--.56617S2;
	Thu, 18 Jul 2024 15:17:14 +0100 (CET)
Message-ID: <ae769bbfe51a2c1c270739a91defc0dfbd5b8b5a.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Kees Cook
	 <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>,  Linus Torvalds <torvalds@linux-foundation.org>, Paul
 Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>,  Alejandro
 Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>,
 Christian Heimes <christian@python.org>, Dmitry Vyukov
 <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, Eric Chiang
 <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, Florian Weimer
 <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James
 Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>,  Jann Horn
 <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, Lakshmi
 Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi
 <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T .
 Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski
 <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew
 Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet
 <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, Shuah
 Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Steve
 Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, Thibaut
 Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel
 <vincent.strubel@ssi.gouv.fr>,  Xiaoming Ni <nixiaoming@huawei.com>, Yin
 Fengwei <fengwei.yin@intel.com>,  kernel-hardening@lists.openwall.com,
 linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Date: Thu, 18 Jul 2024 16:16:45 +0200
In-Reply-To: <20240706.eng1ieSh0wa5@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
	 <20240704190137.696169-3-mic@digikod.net> <202407041711.B7CD16B2@keescook>
	 <20240705.IeTheequ7Ooj@digikod.net> <202407051425.32AF9D2@keescook>
	 <20240706.eng1ieSh0wa5@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAnJC7RI5lm88lbAA--.56617S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyUAw4rKrWDKF4UtF15twb_yoWxWw1fpa
	yrAayUKF4DGF10y3Z2k3W8Xa4SkrWxJF1UWr9Iqryruwn09F1IgrW3tr4Y9FykursY93W2
	vrW2v343Wa4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUVZ2-UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBGaYenQJ5wAAsQ

On Sat, 2024-07-06 at 16:56 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Jul 05, 2024 at 02:44:03PM -0700, Kees Cook wrote:
> > On Fri, Jul 05, 2024 at 07:54:16PM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > On Thu, Jul 04, 2024 at 05:18:04PM -0700, Kees Cook wrote:
> > > > On Thu, Jul 04, 2024 at 09:01:34PM +0200, Micka=C3=ABl Sala=C3=BCn =
wrote:
> > > > > Such a secure environment can be achieved with an appropriate acc=
ess
> > > > > control policy (e.g. mount's noexec option, file access rights, L=
SM
> > > > > configuration) and an enlighten ld.so checking that libraries are
> > > > > allowed for execution e.g., to protect against illegitimate use o=
f
> > > > > LD_PRELOAD.
> > > > >=20
> > > > > Scripts may need some changes to deal with untrusted data (e.g. s=
tdin,
> > > > > environment variables), but that is outside the scope of the kern=
el.
> > > >=20
> > > > If the threat model includes an attacker sitting at a shell prompt,=
 we
> > > > need to be very careful about how process perform enforcement. E.g.=
 even
> > > > on a locked down system, if an attacker has access to LD_PRELOAD or=
 a
> > >=20
> > > LD_PRELOAD should be OK once ld.so will be patched to check the
> > > libraries.  We can still imagine a debug library used to bypass secur=
ity
> > > checks, but in this case the issue would be that this library is
> > > executable in the first place.
> >=20
> > Ah yes, that's fair: the shell would discover the malicious library
> > while using AT_CHECK during resolution of the LD_PRELOAD.
>=20
> That's the idea, but it would be checked by ld.so, not the shell.
>=20
> >=20
> > > > seccomp wrapper (which you both mention here), it would be possible=
 to
> > > > run commands where the resulting process is tricked into thinking i=
t
> > > > doesn't have the bits set.
> > >=20
> > > As explained in the UAPI comments, all parent processes need to be
> > > trusted.  This meeans that their code is trusted, their seccomp filte=
rs
> > > are trusted, and that they are patched, if needed, to check file
> > > executability.
> >=20
> > But we have launchers that apply arbitrary seccomp policy, e.g. minijai=
l
> > on Chrome OS, or even systemd on regular distros. In theory, this shoul=
d
> > be handled via other ACLs.
>=20
> Processes running with untrusted seccomp filter should be considered
> untrusted.  It would then make sense for these seccomp filters/programs
> to be considered executable code, and then for minijail and systemd to
> check them with AT_CHECK (according to the securebits policy).
>=20
> >=20
> > > > But this would be exactly true for calling execveat(): LD_PRELOAD o=
r
> > > > seccomp policy could have it just return 0.
> > >=20
> > > If an attacker is allowed/able to load an arbitrary seccomp filter on=
 a
> > > process, we cannot trust this process.
> > >=20
> > > >=20
> > > > While I like AT_CHECK, I do wonder if it's better to do the checks =
via
> > > > open(), as was originally designed with O_MAYEXEC. Because then
> > > > enforcement is gated by the kernel -- the process does not get a fi=
le
> > > > descriptor _at all_, no matter what LD_PRELOAD or seccomp tricks it=
 into
> > > > doing.
> > >=20
> > > Being able to check a path name or a file descriptor (with the same
> > > syscall) is more flexible and cover more use cases.
> >=20
> > If flexibility costs us reliability, I think that flexibility is not
> > a benefit.
>=20
> Well, it's a matter of letting user space do what they think is best,
> and I think there are legitimate and safe uses of path names, even if I
> agree that this should not be used in most use cases.  Would we want
> faccessat2(2) to only take file descriptor as argument and not file
> path? I don't think so but I'd defer to the VFS maintainers.
>=20
> Christian, Al, Linus?
>=20
> Steve, could you share a use case with file paths?
>=20
> >=20
> > > The execveat(2)
> > > interface, including current and future flags, is dedicated to file
> > > execution.  I then think that using execveat(2) for this kind of chec=
k
> > > makes more sense, and will easily evolve with this syscall.
> >=20
> > Yeah, I do recognize that is feels much more natural, but I remain
> > unhappy about how difficult it will become to audit a system for safety
> > when the check is strictly per-process opt-in, and not enforced by the
> > kernel for a given process tree. But, I think this may have always been
> > a fiction in my mind. :)
>=20
> Hmm, I'm not sure to follow. Securebits are inherited, so process tree.
> And we need the parent processes to be trusted anyway.
>=20
> >=20
> > > > And this thinking also applies to faccessat() too: if a process can=
 be
> > > > tricked into thinking the access check passed, it'll happily interp=
ret
> > > > whatever. :( But not being able to open the fd _at all_ when O_MAYE=
XEC
> > > > is being checked seems substantially safer to me...
> > >=20
> > > If attackers can filter execveat(2), they can also filter open(2) and
> > > any other syscalls.  In all cases, that would mean an issue in the
> > > security policy.
> >=20
> > Hm, as in, make a separate call to open(2) without O_MAYEXEC, and pass
> > that fd back to the filtered open(2) that did have O_MAYEXEC. Yes, true=
.
> >=20
> > I guess it does become morally equivalent.
> >=20
> > Okay. Well, let me ask about usability. Right now, a process will need
> > to do:
> >=20
> > - should I use AT_CHECK? (check secbit)
> > - if yes: perform execveat(AT_CHECK)
> >=20
> > Why not leave the secbit test up to the kernel, and then the program ca=
n
> > just unconditionally call execveat(AT_CHECK)?
>=20
> That was kind of the approach of the previous patch series and Linus
> wanted the new interface to follow the kernel semantic.  Enforcing this
> kind of restriction will always be the duty of user space anyway, so I
> think it's simpler (i.e. no mix of policy definition, access check, and
> policy enforcement, but a standalone execveat feature), more flexible,
> and it fully delegates the policy enforcement to user space instead of
> trying to enforce some part in the kernel which would only give the
> illusion of security/policy enforcement.

A problem could be that from IMA perspective there is no indication on
whether the interpreter executed or not execveat(). Sure, we can detect
that the binary supports it, but if the enforcement was
enabled/disabled that it is not recorded.

Maybe, setting the process flags should be influenced by the kernel,
for example not allowing changes and enforcing when there is an IMA
policy loaded requiring to measure/appraise scripts.

Roberto

> >=20
> > Though perhaps the issue here is that an execveat() EINVAL doesn't
> > tell the program if AT_CHECK is unimplemented or if something else
> > went wrong, and the secbit prctl() will give the correct signal about
> > AT_CHECK availability?
>=20
> This kind of check could indeed help to identify the issue.


