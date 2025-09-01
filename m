Return-Path: <linux-fsdevel+bounces-59893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6709B3EC2B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17F71A86117
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FFD30649F;
	Mon,  1 Sep 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXd/Elnu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417F02EFD82
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743923; cv=none; b=WgJD4cdANZ142NrzRFRa4yCdvffodf8kNZc5smccYagQTOHB3SYTDPuehAL6UaI53NVBm4ts2FlfDx3L9YOQXK9SHtcWL008GyLCCfKmArZG2CBC/QRwPw9wvxysYKrLS8OHY4l7WJ3/o/N2ek5Si8U0lipolq2HfI/2lcl4YLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743923; c=relaxed/simple;
	bh=Xy9c0RnED3HT39yD+fhi1E7AHRKldhfJxdRE7gKyi/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfK7jk5tLE3wJ6CHwf5IJLvSjaixKrNHWAyepV+SAx2h+p9veL3kAH09iosy3XS/z7MgW90afOpXUmy8Nw5zvROGmhok5M2BJJ9WanfNCPGiUhvWBzKgIWOUJm7KAbyJZRt0wvDI6K69xWgC7TC2/urXdTOKpD1QPma2Ikciquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXd/Elnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C724BC4CEFB
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756743922;
	bh=Xy9c0RnED3HT39yD+fhi1E7AHRKldhfJxdRE7gKyi/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CXd/ElnufQqUWN+52vrwfcCFCPxm1Y7RYAy43CzWIcGE10p4UpjeyEu+3ZA4j47D8
	 HAfOtA5+6AegBT//Axhd9MM0csftWMWkKWehgjmBq67+ADUMojTIpiwrbnJYJqBeik
	 eTxx7PF+MsvQdRLGpcxm8UNGPh/kjhIAP1xu2+juDOmVYV3OgHKGWcIdjEluKGL1XG
	 nB8mnQsiJX4y1kmyNH4SEpC/g6p5N5M1PJ+aIrqlo7pkhBrjClYKP1M/uHD9GoR6FB
	 5LUHUCJn8u2K4Al6kROEE+MZqkBpatai9i54iOzNmlFjiY2PaVO/GYZtE08pciiiSF
	 RbaCNVoWw55Ww==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f918d71eso34478741fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 09:25:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPut7gOEV9LA7r9FGfqf90VCcnM2fEntFmIxiVykWmfT9ZN1ec+Wu1c808pQ4rLBOHnH+bqEwhjB7GOYiL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21egkeMuKapQ5ROfDWUU2yuJTbfhajhR57lZIuZinhz75032A
	kfHXTlg4Yro3FsMgrKRg/RDfRSHQWU/RLxUYG66pNBoDVv3k9wiQS39TCYprcnkXvNNvplPR3C/
	Hpt+80/vtM2Rw7Wz3kXwmcJV99GPL2x7+aQCRLGuy
X-Google-Smtp-Source: AGHT+IHQaKnUNWLNFQYNtSQSa47g2pu7CpYY6T/b9pUgP8BH0aybd+qYJdHgPCMppjygHDMCLF/KHVs2OD16WVL33oA=
X-Received: by 2002:a05:651c:1543:b0:336:e1c4:6c6f with SMTP id
 38308e7fff4ca-336e1c47336mr14179671fa.19.1756743920925; Mon, 01 Sep 2025
 09:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net> <2025-08-27-obscene-great-toy-diary-X1gVRV@cyphar.com>
 <54e27d05bae55749a975bc7cbe109b237b2b1323.camel@huaweicloud.com>
In-Reply-To: <54e27d05bae55749a975bc7cbe109b237b2b1323.camel@huaweicloud.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 1 Sep 2025 09:25:09 -0700
X-Gmail-Original-Message-ID: <CALCETrUtJmWxKYSi6QQAGpQR_ETNfoBidCu_VEq8Lx9iJAOyEw@mail.gmail.com>
X-Gm-Features: Ac12FXxyw6xiBo675X_GNr-mU7ryRcDYbQiEmCEhhXrRzSi1-YYVHnkbnMyWAA0
Message-ID: <CALCETrUtJmWxKYSi6QQAGpQR_ETNfoBidCu_VEq8Lx9iJAOyEw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you clarify this a bit for those of us who are not well-versed in
exactly what "measurement" does?

On Mon, Sep 1, 2025 at 2:42=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> > Now, in cases where you have IMA or something and you only permit signe=
d
> > binaries to execute, you could argue there is a different race here (an
> > attacker creates a malicious script, runs it, and then replaces it with
> > a valid script's contents and metadata after the fact to get
> > AT_EXECVE_CHECK to permit the execution). However, I'm not sure that
>
> Uhm, let's consider measurement, I'm more familiar with.
>
> I think the race you wanted to express was that the attacker replaces
> the good script, verified with AT_EXECVE_CHECK, with the bad script
> after the IMA verification but before the interpreter reads it.
>
> Fortunately, IMA is able to cope with this situation, since this race
> can happen for any file open, where of course a file can be not read-
> locked.

I assume you mean that this has nothing specifically to do with
scripts, as IMA tries to protect ordinary (non-"execute" file access)
as well.  Am I right?

>
> If the attacker tries to concurrently open the script for write in this
> race window, IMA will report this event (called violation) in the
> measurement list, and during remote attestation it will be clear that
> the interpreter did not read what was measured.
>
> We just need to run the violation check for the BPRM_CHECK hook too
> (then, probably for us the O_DENY_WRITE flag or alternative solution
> would not be needed, for measurement).

This seems consistent with my interpretation above, but ...

>
> Please, let us know when you apply patches like 2a010c412853 ("fs:
> don't block i_writecount during exec"). We had a discussion [1], but
> probably I missed when it was decided to be applied (I saw now it was
> in the same thread, but didn't get that at the time). We would have
> needed to update our code accordingly. In the future, we will try to
> clarify better our expectations from the VFS.

... I didn't follow this.

Suppose there's some valid contents of /bin/sleep.  I execute
/bin/sleep 1m.  While it's running, I modify /bin/sleep (by opening it
for write, not by replacing it), and the kernel in question doesn't do
ETXTBSY.  Then the sleep process reads (and executes) the modified
contents.  Wouldn't a subsequent attestation fail?  Why is ETXTBSY
needed?

