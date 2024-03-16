Return-Path: <linux-fsdevel+bounces-14549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D933187D828
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 04:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A19C28294D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 03:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B694C61;
	Sat, 16 Mar 2024 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEWZxkSy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB652907;
	Sat, 16 Mar 2024 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710559467; cv=none; b=ijCNd5QoVUksO6xY6VITCW2XiPgBLeipoN0UaNhZ2yXo4k6mALChb7R5WNQaDogkh9DKAN/Ar1YHrzhCkoIJXN/s/jSSp+3yi/odVt323QmgQO0oEqSeDwpql8eVc10HpJKsbCXpX650B7OTA2K68xb41rPc2sUmxO9QINoBHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710559467; c=relaxed/simple;
	bh=GsnMpqncKTzVCk2TUl4teQVRc7jp0Ahi0iNXkDzmMH8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fSjJedro3RyuAHXrhpnrLVjEo75MyaRcaD+W5f+sL96hYEgw+LidCQPj+IFPhLfr0+DCf3WMedueQk63IR3nkpOgCR2s5A+acS9yB6xOOMI2/YD6D3nECwS8QEC7TZM0z1cUOn8pqy59PTIGF4B+VNoTOAYXP7x9UojXb9QuM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEWZxkSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC76FC433F1;
	Sat, 16 Mar 2024 03:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710559467;
	bh=GsnMpqncKTzVCk2TUl4teQVRc7jp0Ahi0iNXkDzmMH8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cEWZxkSyp4BIiaJTcZRaTOWkLGkGdES/06iwZ6zpWMRiozxcrZc923kKj5R7lHJgD
	 aKQqaAHBa7y4qux6ct+ij0qBOkEkaIeOYdh6quVWHO2w9z+0DsSdXKm6UnIkngzVXm
	 kodv5GYY1vYhdh1Yo8yC0U5QVe4T4DM7zmnt4+vGXj+OB2k1FlQB2cTjUkE47dHgfw
	 z0rTDS2Bl8ybE+j+Vv1qp83nAjWIiqt/zKF0cWwR4ve2kE2BFq6ZclwuJ2wZ+JhNLu
	 7QQkmjiedt7VsVRJGl3rTb6JfDCrwTyngjj++5DhtTxnyUiNs+iyO+2fajGlkIGivd
	 rIxwG5IBG9o3w==
Date: Fri, 15 Mar 2024 20:24:27 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
 =?ISO-8859-1?Q?Christian_G=F6ttsche?= <cgzones@googlemail.com>
CC: linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Alexei Starovoitov <ast@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Alfred Piccioni <alpic@google.com>,
 John Johansen <john.johansen@canonical.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] lsm: introduce new hook security_vm_execstack
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHC9VhRkawYWQN0UY2R68Qn4pRijpXgu97YOr6XPA7Ls0-zQcA@mail.gmail.com>
References: <20240315181032.645161-1-cgzones@googlemail.com> <20240315181032.645161-2-cgzones@googlemail.com> <CAHC9VhRkawYWQN0UY2R68Qn4pRijpXgu97YOr6XPA7Ls0-zQcA@mail.gmail.com>
Message-ID: <5368DC74-41CF-4450-AF6F-FFB51EFCCF99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 15, 2024 1:22:39 PM PDT, Paul Moore <paul@paul-moore=2Ecom> wrote=
:
>On Fri, Mar 15, 2024 at 2:10=E2=80=AFPM Christian G=C3=B6ttsche
><cgzones@googlemail=2Ecom> wrote:
>>
>> Add a new hook guarding instantiations of programs with executable
>> stack=2E  They are being warned about since commit 47a2ebb7f505 ("execv=
e:
>> warn if process starts with executable stack")=2E  Lets give LSMs the
>> ability to control their presence on a per application basis=2E
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail=2Ecom>
>> ---
>>  fs/exec=2Ec                     |  4 ++++
>>  include/linux/lsm_hook_defs=2Eh |  1 +
>>  include/linux/security=2Eh      |  6 ++++++
>>  security/security=2Ec           | 13 +++++++++++++
>>  4 files changed, 24 insertions(+)
>
>Looking at the commit referenced above, I'm guessing the existing
>security_file_mprotect() hook doesn't catch this?
>
>> diff --git a/fs/exec=2Ec b/fs/exec=2Ec
>> index 8cdd5b2dd09c=2E=2Ee6f9e980c6b1 100644
>> --- a/fs/exec=2Ec
>> +++ b/fs/exec=2Ec
>> @@ -829,6 +829,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
>>         BUG_ON(prev !=3D vma);
>>
>>         if (unlikely(vm_flags & VM_EXEC)) {
>> +               ret =3D security_vm_execstack();
>> +               if (ret)
>> +                       goto out_unlock;
>> +
>>                 pr_warn_once("process '%pD4' started with executable st=
ack\n",
>>                              bprm->file);
>>         }
>
>Instead of creating a new LSM hook, have you considered calling the
>existing security_file_mprotect() hook?  The existing LSM controls
>there may not be a great fit in this case, but I'd like to hear if
>you've tried that, and if you have, what made you decide a new hook
>was the better option?

Also, can't MDWE handle this already?
https://git=2Ekernel=2Eorg/linus/b507808ebce23561d4ff8c2aa1fb949fe402bc61

-Kees

--=20
Kees Cook

