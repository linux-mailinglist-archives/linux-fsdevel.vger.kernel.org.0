Return-Path: <linux-fsdevel+bounces-59762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8393EB3DEDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D051782C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F47130DEB5;
	Mon,  1 Sep 2025 09:41:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286C623E23C;
	Mon,  1 Sep 2025 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719673; cv=none; b=clhaBZraJXjorHnOgUbwtz+f6dvnS+EUi8c+2I/1WaBeWmpHo82BsDGKrKssN+2e8bETpnmxZwPrbhe7Q9IN+lR/61GZYawMKSgpHBL9KtMkR/lg3tJaa4LERGA2JtwssEWqh9ow/2o/84tW6BnuLM6+mxA/YefOET9mWBzQe5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719673; c=relaxed/simple;
	bh=tTYf9LKW6XZAWe8Mq9GSfJKgl+eQpwHG4OYySo6GQLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n39j9hn00eH6jAd6oN8WiFXQb8vt/ukkXAuNxAipTKMEPWhnCNjZlHyqTXZwFqqES9rJsqCh2wDf7Vt9djh4/HLUIdE+/6uK3Ikm/Z7D/SDA+lQF2U0bn1XAKkJYY1WIjwd9owpQ13a9y/TY2BicJ7cyEr1+NPOMz72jz9tf84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFk1X1B79z1HBR7;
	Mon,  1 Sep 2025 17:22:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CBB331402C4;
	Mon,  1 Sep 2025 17:24:39 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXbEFDZrVod9SLAA--.60560S2;
	Mon, 01 Sep 2025 10:24:38 +0100 (CET)
Message-ID: <54e27d05bae55749a975bc7cbe109b237b2b1323.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Aleksa Sarai <cyphar@cyphar.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
	 <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>,  Kees Cook <keescook@chromium.org>, Paul Moore
 <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,  Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Heimes
 <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes
 <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, Florian Weimer
 <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jeff Xu
 <jeffxu@google.com>,  Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams
 <ajordanr@google.com>, Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, Matt
 Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,  Robert Waite
 <rowait@microsoft.com>, Roberto Sassu <roberto.sassu@huawei.com>, Scott
 Shell <scottsh@microsoft.com>, Steve Dower <steve.dower@python.org>, Steve
 Grubb <sgrubb@redhat.com>, kernel-hardening@lists.openwall.com, 
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org
Date: Mon, 01 Sep 2025 11:24:17 +0200
In-Reply-To: <2025-08-27-obscene-great-toy-diary-X1gVRV@cyphar.com>
References: <20250822170800.2116980-1-mic@digikod.net>
	 <20250826-skorpion-magma-141496988fdc@brauner>
	 <20250826.aig5aiShunga@digikod.net>
	 <2025-08-27-obscene-great-toy-diary-X1gVRV@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAXbEFDZrVod9SLAA--.60560S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF15Gr15Jr4xtrW8Zw4fKrg_yoWrCFyfpF
	WFqwnIkF1DJr1Iyw1xC3WxZ3yFywsxJay3Jr95JrykA3W5uF1Igr1fKr4YvFZrCF4fKw1j
	vrWIv3s8urWDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4U
	JwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	EksDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGi1Q8AC1wAAsc

On Thu, 2025-08-28 at 10:14 +1000, Aleksa Sarai wrote:
> On 2025-08-26, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:
> > On Tue, Aug 26, 2025 at 11:07:03AM +0200, Christian Brauner wrote:
> > > Nothing has changed in that regard and I'm not interested in stuffing
> > > the VFS APIs full of special-purpose behavior to work around the fact
> > > that this is work that needs to be done in userspace. Change the apps=
,
> > > stop pushing more and more cruft into the VFS that has no business
> > > there.
> >=20
> > It would be interesting to know how to patch user space to get the same
> > guarantees...  Do you think I would propose a kernel patch otherwise?
>=20
> You could mmap the script file with MAP_PRIVATE. This is the *actual*
> protection the kernel uses against overwriting binaries (yes, ETXTBSY is
> nice but IIRC there are ways to get around it anyway). Of course, most
> interpreters don't mmap their scripts, but this is a potential solution.
> If the security policy is based on validating the script text in some
> way, this avoids the TOCTOU.
>=20
> Now, in cases where you have IMA or something and you only permit signed
> binaries to execute, you could argue there is a different race here (an
> attacker creates a malicious script, runs it, and then replaces it with
> a valid script's contents and metadata after the fact to get
> AT_EXECVE_CHECK to permit the execution). However, I'm not sure that

Uhm, let's consider measurement, I'm more familiar with.

I think the race you wanted to express was that the attacker replaces
the good script, verified with AT_EXECVE_CHECK, with the bad script
after the IMA verification but before the interpreter reads it.

Fortunately, IMA is able to cope with this situation, since this race
can happen for any file open, where of course a file can be not read-
locked.

If the attacker tries to concurrently open the script for write in this
race window, IMA will report this event (called violation) in the
measurement list, and during remote attestation it will be clear that
the interpreter did not read what was measured.

We just need to run the violation check for the BPRM_CHECK hook too
(then, probably for us the O_DENY_WRITE flag or alternative solution
would not be needed, for measurement).

Please, let us know when you apply patches like 2a010c412853 ("fs:
don't block i_writecount during exec"). We had a discussion [1], but
probably I missed when it was decided to be applied (I saw now it was
in the same thread, but didn't get that at the time). We would have
needed to update our code accordingly. In the future, we will try to
clarify better our expectations from the VFS.

Thanks

Roberto

[1]: https://lore.kernel.org/linux-fsdevel/88d5a92379755413e1ec3c981d9a04e6=
796da110.camel@huaweicloud.com/#t

> this is even possible with IMA (can an unprivileged user even set
> security.ima?). But even then, I would expect users that really need
> this would also probably use fs-verity or dm-verity that would block
> this kind of attack since it would render the files read-only anyway.
>=20
> This is why a more detailed threat model of what kinds of attacks are
> relevant is useful. I was there for the talk you gave and subsequent
> discussion at last year's LPC, but I felt that your threat model was
> not really fleshed out at all. I am still not sure what capabilities you
> expect the attacker to have nor what is being used to authenticate
> binaries (other than AT_EXECVE_CHECK). Maybe I'm wrong with my above
> assumptions, but I can't know without knowing what threat model you have
> in mind, *in detail*.
>=20
> For example, if you are dealing with an attacker that has CAP_SYS_ADMIN,
> there are plenty of ways for an attacker to execute their own code
> without using interpreters (create a new tmpfs with fsopen(2) for
> instance). Executable memfds are even easier and don't require
> privileges on most systems (yes, you can block them with vm.memfd_noexec
> but CAP_SYS_ADMIN can disable that -- and there's always fsopen(2) or
> mount(2)).
>=20
> (As an aside, it's a shame that AT_EXECVE_CHECK burned one of the
> top-level AT_* bits for a per-syscall flag -- the block comment I added
> in b4fef22c2fb9 ("uapi: explain how per-syscall AT_* flags should be
> allocated") was meant to avoid this happening but it seems you and the
> reviewers missed that...)
>=20


