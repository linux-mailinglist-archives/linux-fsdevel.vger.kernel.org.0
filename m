Return-Path: <linux-fsdevel+bounces-48922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0EFAB5FD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 01:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC808648BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF2A20E01F;
	Tue, 13 May 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbyrfekk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650465695;
	Tue, 13 May 2025 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747178157; cv=none; b=Z3AD7EDHdWTAm59X5Exs7uedyPlVJasOyOPYYd0B/triqFJptxfhRabm3cMGc4VwNZ90mXSa2W0ALVD21IgX1ScyfAoEj/z8HFOVo5sUw32YkWZPuGc7+U/rCosxCDjrHXx0gK4GWVXeIa3j07ZGwJgU3udAk5xSaI7U6b6VaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747178157; c=relaxed/simple;
	bh=D1xptH/oUUu2Ir6TIND9ijE6bIO59tshllRcbOwV8RA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=USYzLQTLR4Y9V1HY8/F37OV6pHd+9Ki7H99kIsKfeb4KbxMZL/a+y/TtBcBjTs8B/tiau5qzYLM6tkiQtFI5+/jEbxhVvpJiH3xUBFAITIQvv3Mxy+x7J+9whXogu1SDDuS6IejzYq2CkXXmdwM0gKfLa8x40+H/5Hw/Jp0pJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbyrfekk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D25C4CEE4;
	Tue, 13 May 2025 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747178155;
	bh=D1xptH/oUUu2Ir6TIND9ijE6bIO59tshllRcbOwV8RA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=lbyrfekkL4E0T/hAUnBfDulhbb6usyNaJtme2vR2/ky2gRqD+ndeR3IniYfurhtZh
	 lLhSVaSXdO0Ww+iGUxipKvrtqkP1qyTQvKzeiN1r0ijh5byJ/5sgY4jzOj2ESU/2dP
	 ciDrdAQS849TJBCLZ99kl5mI33j18FhF80nfH6RDA9N4gcxqbNTKmow6aZU66sZ+8L
	 +ovjKTewFSR1ErUBCCCu8DtURdLrjSH41VA2veimgDUTEznRiHJiWIJ0hHVgfvlfJj
	 BKEfccUhY9NS1gJGonGxMd2/oWo4JXjvpkUcbSMmQF22CR5tUZt88pDqX+zZRKjnJx
	 AZ1mLZBpGBQ4w==
Date: Tue, 13 May 2025 16:15:52 -0700
From: Kees Cook <kees@kernel.org>
To: Jann Horn <jannh@google.com>
CC: Mateusz Guzik <mjguzik@gmail.com>, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Jorge Merlino <jorge.merlino@canonical.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>,
 Richard Haines <richard_c_haines@btinternet.com>,
 Casey Schaufler <casey@schaufler-ca.com>, Xin Long <lucien.xin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Todd Kjos <tkjos@google.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Prashanth Prahlad <pprahlad@redhat.com>, Micah Morton <mortonm@chromium.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Andrei Vagin <avagin@gmail.com>,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 linux-hardening@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
User-Agent: K-9 Mail for Android
In-Reply-To: <CAG48ez0aP8LaGppy6Yon7xcFbQa1=CM-HXSZChvXYV2VJZ8y7g@mail.gmail.com>
References: <20221006082735.1321612-1-keescook@chromium.org> <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein> <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com> <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org> <h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve> <D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org> <CAG48ez0aP8LaGppy6Yon7xcFbQa1=CM-HXSZChvXYV2VJZ8y7g@mail.gmail.com>
Message-ID: <6C9B4DB6-0E73-471D-A278-39F61A825DB6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 13, 2025 2:09:48 PM PDT, Jann Horn <jannh@google=2Ecom> wrote:
>On Tue, May 13, 2025 at 10:57=E2=80=AFPM Kees Cook <kees@kernel=2Eorg> wr=
ote:
>> On May 13, 2025 6:05:45 AM PDT, Mateusz Guzik <mjguzik@gmail=2Ecom> wro=
te:
>> >Here is my proposal: *deny* exec of suid/sgid binaries if fs_struct is
>> >shared=2E This will have to be checked for after the execing proc beco=
mes
>> >single-threaded ofc=2E
>>
>> Unfortunately the above Chrome helper is setuid and uses CLONE_FS=2E
>
>Chrome first launches a setuid helper, and then the setuid helper does
>CLONE_FS=2E Mateusz's proposal would not impact this usecase=2E
>
>Mateusz is proposing to block the case where a process first does
>CLONE_FS, and *then* one of the processes sharing the fs_struct does a
>setuid execve()=2E Linux already downgrades such an execve() to be
>non-setuid, which probably means anyone trying to do this will get
>hard-to-understand problems=2E Mateusz' proposal would just turn this
>hard-to-debug edgecase, which already doesn't really work, into a
>clean error; I think that is a nice improvement even just from the
>UAPI standpoint=2E
>
>If this change makes it possible to clean up the kernel code a bit, even =
better=2E


Ah! Okay, I appreciate the clarification=2E :) I'm game to try making it a=
n error instead of silent downgrading=2E

-Kees


--=20
Kees Cook
--=20
Kees Cook

