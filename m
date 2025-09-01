Return-Path: <linux-fsdevel+bounces-59898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA6B3ED4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552D63BF7AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C31320A32;
	Mon,  1 Sep 2025 17:20:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923BA3064BC;
	Mon,  1 Sep 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747210; cv=none; b=hTBr/NQZk+61cuLhmnS6CfyDGIq69ZFy+g0poavrP5r8oPU19O5uGV9QpgBVOfO2stfbSzGzYmJvZnUiJINUBWPtFv9DGHAUp5TWslObY+EqA/3H73n0L5+AFJ76PcCjFe2ycb47mZz9V0MkwMs5zvDFmWxFoqbaMmvQU2Pk2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747210; c=relaxed/simple;
	bh=OCliu1SfADOcDmYo8NJcH4lbnknWaTHsYL6JjXO5UT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wc1jiQt73x7dDYtzsfC1fT61Wxxxw9eggJGWQGZWjouQlclZgp+7ovZMFg0T17B5ftQWQZY/24PjV1ceSaHx9tcSnGiGzpOoy4Ezs8PGTzvLUKJPeJlqI2+uzbZ4TbQxUi4qZIsVhW5GxbYLV79JCRAWD/imYaD/1xLyZrYwb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cFw9T1cfQzsZST;
	Tue,  2 Sep 2025 01:00:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 7C42F1402EC;
	Tue,  2 Sep 2025 01:02:06 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnvEF40bVoycaQAA--.3519S2;
	Mon, 01 Sep 2025 18:02:05 +0100 (CET)
Message-ID: <3d89a03f31cacb53a2ed8017899f2dab10476b62.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
 <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, Paul Moore
 <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, Arnd Bergmann
 <arnd@arndb.de>, Christian Heimes <christian@python.org>, Dmitry Vyukov
 <dvyukov@google.com>, Elliott Hughes <enh@google.com>, Fan Wu
 <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn
 <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet
 <corbet@lwn.net>,  Jordan R Abrahams <ajordanr@google.com>, Lakshmi
 Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi
 <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, Miklos
 Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Nicolas
 Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite
 <rowait@microsoft.com>,  Roberto Sassu <roberto.sassu@huawei.com>, Scott
 Shell <scottsh@microsoft.com>, Steve Dower <steve.dower@python.org>, Steve
 Grubb <sgrubb@redhat.com>,  kernel-hardening@lists.openwall.com,
 linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-integrity@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Date: Mon, 01 Sep 2025 19:01:42 +0200
In-Reply-To: <CALCETrUtJmWxKYSi6QQAGpQR_ETNfoBidCu_VEq8Lx9iJAOyEw@mail.gmail.com>
References: <20250822170800.2116980-1-mic@digikod.net>
	 <20250826-skorpion-magma-141496988fdc@brauner>
	 <20250826.aig5aiShunga@digikod.net>
	 <2025-08-27-obscene-great-toy-diary-X1gVRV@cyphar.com>
	 <54e27d05bae55749a975bc7cbe109b237b2b1323.camel@huaweicloud.com>
	 <CALCETrUtJmWxKYSi6QQAGpQR_ETNfoBidCu_VEq8Lx9iJAOyEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBnvEF40bVoycaQAA--.3519S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFykArWDJF1kKFykWw4fuFg_yoWrCw1xpF
	WFgw1kK3WDGF1xJw1xC3W7ZF1rCa4rJw43Jrn8tw1kAF98Zr10qrySgFWSqa4xZF9Ykw4Y
	qw4093s5Cw4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4U
	JwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	EksDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBGi1Q+gIFwAAs9

On Mon, 2025-09-01 at 09:25 -0700, Andy Lutomirski wrote:
> Can you clarify this a bit for those of us who are not well-versed in
> exactly what "measurement" does?
>=20
> On Mon, Sep 1, 2025 at 2:42=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > > Now, in cases where you have IMA or something and you only permit sig=
ned
> > > binaries to execute, you could argue there is a different race here (=
an
> > > attacker creates a malicious script, runs it, and then replaces it wi=
th
> > > a valid script's contents and metadata after the fact to get
> > > AT_EXECVE_CHECK to permit the execution). However, I'm not sure that
> >=20
> > Uhm, let's consider measurement, I'm more familiar with.
> >=20
> > I think the race you wanted to express was that the attacker replaces
> > the good script, verified with AT_EXECVE_CHECK, with the bad script
> > after the IMA verification but before the interpreter reads it.
> >=20
> > Fortunately, IMA is able to cope with this situation, since this race
> > can happen for any file open, where of course a file can be not read-
> > locked.
>=20
> I assume you mean that this has nothing specifically to do with
> scripts, as IMA tries to protect ordinary (non-"execute" file access)
> as well.  Am I right?

Yes, correct, violations are checked for all open() and mmap()
involving regular files. It would not be special to do it for scripts.

> > If the attacker tries to concurrently open the script for write in this
> > race window, IMA will report this event (called violation) in the
> > measurement list, and during remote attestation it will be clear that
> > the interpreter did not read what was measured.
> >=20
> > We just need to run the violation check for the BPRM_CHECK hook too
> > (then, probably for us the O_DENY_WRITE flag or alternative solution
> > would not be needed, for measurement).
>=20
> This seems consistent with my interpretation above, but ...

The comment here [1] seems to be clear on why the violation check it is
not done for execution (BPRM_CHECK hook). Since the OS read-locks the
files during execution, this implicitly guarantees that there will not
be concurrent writes, and thus no IMA violations.

However, recently, we took advantage of AT_EXECVE_CHECK to also
evaluate the integrity of scripts (when not executed via ./). Since we
are using the same hook for both executed files (read-locked) and
scripts (I guess non-read-locked), then we need to do a violation check
for BPRM_CHECK too, although it will be redundant for the first
category.

> > Please, let us know when you apply patches like 2a010c412853 ("fs:
> > don't block i_writecount during exec"). We had a discussion [1], but
> > probably I missed when it was decided to be applied (I saw now it was
> > in the same thread, but didn't get that at the time). We would have
> > needed to update our code accordingly. In the future, we will try to
> > clarify better our expectations from the VFS.
>=20
> ... I didn't follow this.
>=20
> Suppose there's some valid contents of /bin/sleep.  I execute
> /bin/sleep 1m.  While it's running, I modify /bin/sleep (by opening it
> for write, not by replacing it), and the kernel in question doesn't do
> ETXTBSY.  Then the sleep process reads (and executes) the modified
> contents.  Wouldn't a subsequent attestation fail?  Why is ETXTBSY
> needed?

Ok, this is actually a good opportunity to explain what it will be
missing. If you do the operations in the order you proposed, actually a
violation will be emitted, because the violating operation is an open()
and the check is done for this system call.

However, if you do the opposite, first open for write and then
execution, IMA will not be aware of that since it trusts the OS to not
make it happen and will not check for violations.

So yes, in your case the remote attestation will fail (actually it is
up to the remote verifier to decide...). But in the opposite case, the
writer could wait for IMA to measure the genuine content and then
modify the content conveniently. The remote attestation will succeed.

Adding the violation check on BPRM_CHECK should be sufficient to avoid
such situation, but I would try to think if there are other
implications for IMA of not read-locking the files on execution.

Roberto

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/security/integrity/ima/ima_main.c?h=3Dv6.17-rc4#n565


