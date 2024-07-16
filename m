Return-Path: <linux-fsdevel+bounces-23775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C838932CD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05E8B23FE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986A19F482;
	Tue, 16 Jul 2024 15:58:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30210195B27;
	Tue, 16 Jul 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145505; cv=none; b=kTM3tk4N+nfjD6G8rD6QXUrzzjBsB58Xu+OrHgCrceAMqBMx5paf9+6ne8+6a3L4amdOo4R23ZlrfFeqM0q7dsYKNfW1opSb7IccKmJ6PXaZ83gyrttHhVKhiRCZlsVGQvXv6kg6/fGVLRmrKbFan9VPSgzjzBinNklz9Knw8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145505; c=relaxed/simple;
	bh=x01xUcW0fNo3bqc70fBVuuGS0X2cQFPaRzseNMmOH9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRXmNyHRI+ZUTrEhgLdOUy2Sg2mR0fwWv8VqQt+arM/EpdEx2TMT15FwawEBg1ukWeTQ44twfIthjYGDTaU1JRy4Udc0Uwmz97/x43BCwP8f3y2QEc0jW+Gs9FqFixMnBQXONd26vzqezkyH2FzIvoOKlq4KuullKEPbc2h6jis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4WNjmc1xyNz9v7Jq;
	Tue, 16 Jul 2024 23:34:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id EB28F14051C;
	Tue, 16 Jul 2024 23:58:12 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA35i93mJZmA3M7AA--.19133S2;
	Tue, 16 Jul 2024 16:58:11 +0100 (CET)
Message-ID: <9e3df65c2bf060b5833558e9f8d82dcd2fe9325a.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v19 0/5] Script execution control (was O_MAYEXEC)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Mimi Zohar
	 <zohar@linux.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>,  Kees Cook <keescook@chromium.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore
 Ts'o <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, Aleksa Sarai
 <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, Andy
 Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Casey
 Schaufler <casey@schaufler-ca.com>, Christian Heimes
 <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, Eric Biggers
 <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, Fan Wu
 <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, James Morris
 <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>,  Jann Horn
 <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, Lakshmi
 Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi
 <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T .
 Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski
 <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew
 Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Nicolas
 Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,  Scott Shell
 <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>,  Steve Dower <steve.dower@python.org>, Steve Grubb
 <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
 Vincent Strubel <vincent.strubel@ssi.gouv.fr>,  Xiaoming Ni
 <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
 kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Tue, 16 Jul 2024 17:57:39 +0200
In-Reply-To: <20240709.AhJ7oTh1biej@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
	 <55b4f6291e8d83d420c7d08f4233b3d304ce683d.camel@linux.ibm.com>
	 <20240709.AhJ7oTh1biej@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwA35i93mJZmA3M7AA--.19133S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy7ZFWrJryfuF4xCr1kuFg_yoWxXFWfpa
	naga12kF4kGF18Arn7K3WfuF1Sgws5JFW5Wrn8WryrZas0yr10qr4Svr15uFyDJFWFya42
	vr4avr9xZw1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkvb40E47kJMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IUYt5r7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBGaV1uwLqwAAsq

On Tue, 2024-07-09 at 22:43 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Mon, Jul 08, 2024 at 04:35:38PM -0400, Mimi Zohar wrote:
> > Hi Micka=C3=ABl,
> >=20
> > On Thu, 2024-07-04 at 21:01 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > > Hi,
> > >=20
> > > The ultimate goal of this patch series is to be able to ensure that
> > > direct file execution (e.g. ./script.sh) and indirect file execution
> > > (e.g. sh script.sh) lead to the same result, especially from a securi=
ty
> > > point of view.
> > >=20
> > > Overview
> > > --------
> > >=20
> > > This patch series is a new approach of the initial O_MAYEXEC feature,
> > > and a revamp of the previous patch series.  Taking into account the l=
ast
> > > reviews [1], we now stick to the kernel semantic for file executabili=
ty.
> > > One major change is the clear split between access check and policy
> > > management.
> > >=20
> > > The first patch brings the AT_CHECK flag to execveat(2).  The goal is=
 to
> > > enable user space to check if a file could be executed (by the kernel=
).
> > > Unlike stat(2) that only checks file permissions, execveat2(2) +
> > > AT_CHECK take into account the full context, including mount points
> > > (noexec), caller's limits, and all potential LSM extra checks (e.g.
> > > argv, envp, credentials).
> > >=20
> > > The second patch brings two new securebits used to set or get a secur=
ity
> > > policy for a set of processes.  For this to be meaningful, all
> > > executable code needs to be trusted.  In practice, this means that
> > > (malicious) users can be restricted to only run scripts provided (and
> > > trusted) by the system.
> > >=20
> > > [1] https://lore.kernel.org/r/CAHk-=3DwjPGNLyzeBMWdQu+kUdQLHQugznwY7C=
vWjmvNW47D5sog@mail.gmail.com
> > >=20
> > > Script execution
> > > ----------------
> > >=20
> > > One important thing to keep in mind is that the goal of this patch
> > > series is to get the same security restrictions with these commands:
> > > * ./script.py
> > > * python script.py
> > > * python < script.py
> > > * python -m script.pyT
> >=20
> > This is really needed, but is it the "only" purpose of this patch set o=
r can it
> > be used to also monitor files the script opens (for read) with the inte=
ntion of
> > executing.
>=20
> This feature can indeed also be used to monitor files requested by
> scripts to be executed e.g. using
> https://docs.python.org/3/library/io.html#io.open_code
>=20
> IMA/EVM can include this check in its logs.
>=20
> >=20
> > >=20
> > > However, on secure systems, we should be able to forbid these command=
s
> > > because there is no way to reliably identify the origin of the script=
:
> > > * xargs -a script.py -d '\r' -- python -c
> > > * cat script.py | python
> > > * python
> > >=20
> > > Background
> > > ----------
> > >=20
> > > Compared to the previous patch series, there is no more dedicated
> > > syscall nor sysctl configuration.  This new patch series only add new
> > > flags: one for execveat(2) and four for prctl(2).
> > >=20
> > > This kind of script interpreter restriction may already be used in
> > > hardened systems, which may need to fork interpreters and install
> > > different versions of the binaries.  This mechanism should enable to
> > > avoid the use of duplicate binaries (and potential forked source code=
)
> > > for secure interpreters (e.g. secure Python [2]) by making it possibl=
e
> > > to dynamically enforce restrictions or not.
> > >=20
> > > The ability to control script execution is also required to close a
> > > major IMA measurement/appraisal interpreter integrity [3].
> >=20
> > Definitely.  But it isn't limited to controlling script execution, but =
also
> > measuring the script.  Will it be possible to measure and appraise the =
indirect
> > script calls with this patch set?
>=20
> Yes. You should only need to implement security_bprm_creds_for_exec()
> for IMA/EVM.
>=20
> BTW, I noticed that IMA only uses the security_bprm_check() hook (which
> can be called several times for one execve), but
> security_bprm_creds_for_exec() might be more appropriate.

Ok, I tried a trivial modification to have this working:

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima=
_main.c
index f04f43af651c..2a6b04c91601 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -554,6 +554,14 @@ static int ima_bprm_check(struct linux_binprm *bprm)
                                   MAY_EXEC, CREDS_CHECK);
 }
=20
+static int ima_bprm_creds_for_exec(struct linux_binprm *bprm)
+{
+       if (!bprm->is_check)
+               return 0;
+
+       return ima_bprm_check(bprm);
+}
+
 /**
  * ima_file_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
@@ -1177,6 +1185,7 @@ static int __init init_ima(void)
=20
 static struct security_hook_list ima_hooks[] __ro_after_init =3D {
        LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
+       LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
        LSM_HOOK_INIT(file_post_open, ima_file_check),
        LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
        LSM_HOOK_INIT(file_release, ima_file_free),


I also adapted the Clip OS 4 patch for bash.

The result seems good so far:

# echo "measure fowner=3D2000 func=3DBPRM_CHECK" > /sys/kernel/security/ima=
/policy

# ./bash /root/test.sh
Hello World

# cat /sys/kernel/security/ima/ascii_runtime_measurements
10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bde=
d9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
10 4cd9df168a2cf8d18be46543e66c76a53ca6a03d ima-ng sha256:e7f3c2dab66f56fef=
963fbab55fc6d64bc22a5f900c29042e6ecd87e08f2b535 /root/test.sh

So, it is there.

It works only with +x permission. If not, I get:

# ./bash /root/test.sh
./bash: /root/test.sh: Permission denied

But the Clip OS 4 patch does not cover the redirection case:

# ./bash < /root/test.sh
Hello World

Do you have a more recent patch for that?

Thanks

Roberto

> >=20
> > Mimi
> >=20
> > > This new execveat + AT_CHECK should not be confused with the O_EXEC f=
lag
> > > (for open) which is intended for execute-only, which obviously doesn'=
t
> > > work for scripts.
> > >=20
> > > I gave a talk about controlling script execution where I explain the
> > > previous approaches [4].  The design of the WIP RFC I talked about
> > > changed quite a bit since then.
> > >=20
> > > [2] https://github.com/zooba/spython
> > > [3] https://lore.kernel.org/lkml/20211014130125.6991-1-zohar@linux.ib=
m.com/
> > > [4] https://lssna2023.sched.com/event/1K7bO
> > >=20
> >=20
> >=20


