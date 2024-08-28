Return-Path: <linux-fsdevel+bounces-27587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E454596293C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA54B23E58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4995188CAB;
	Wed, 28 Aug 2024 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbjLpfkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117B2D600;
	Wed, 28 Aug 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852919; cv=none; b=EyK9jixn97YCWXk/5ndnZpgambIcUMvwxmF5pBJfHg/RTtM/hg2CH3oXee8iq13S0k5CPXPmXHlpK+z0jZe9/tKfhal0as5RtKo5A0H1oVwQvj9J7pVe2stKNr93KHggUrdbxCtocsilVm0qJS3jkd0uqNypECvo17gd0WrdyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852919; c=relaxed/simple;
	bh=TFXHpYUbMPU1PBJdBGzhBTwFtAf9olUiwemN+xYfsaI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BczjG21vG2G6uh8pM4nYtUWRzg7t2MtmdjTqKZWr5vZqgIlqDqWmVaih9kyAakCElVDYJABK7xrQ8SsvZFMIIdjIvIoV8SZu3ruVh9zR/p2JsubD9jeEGBG1ZUwTreRlSKaECwrYRkuri+Gt2Y4mPJM5uve39yDJn9JGgwt3+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbjLpfkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716F8C5FB24;
	Wed, 28 Aug 2024 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724852918;
	bh=TFXHpYUbMPU1PBJdBGzhBTwFtAf9olUiwemN+xYfsaI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EbjLpfkNlvuKmapZ4irEc3+VoB7uNdRFIRrm37fZuyRc+hVMgA7reiu+oN5SrtH3L
	 r5aLX0kCDbqvYUq/ujIE6rw/uu06Bt8oj9Hu3IKc0vGDwjC6fnE6vBD3dN9YNxQU8u
	 86Jxn9AehGCVE3LJBYwEIM2zAL48oXK+oLk4itMPso5Iz3c4nsCNfnEMtSE+18I/xd
	 dEAuNkIPUKy9qd7cUdbKJLBVMrTgzuXOGogCTlVmiTQFwD7hn+LA/8kxfBjngnteo+
	 RG5H8USGaa8sS94tdIcVvfhl5sQn6YRvK++Lwf+dnnbWq/xtWKAknb2oyJmTD/thI0
	 PmekGQbSXjv1Q==
Date: Wed, 28 Aug 2024 06:48:39 -0700
From: Kees Cook <kees@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>, Alejandro Colomar <alx@kernel.org>
CC: akpm@linux-foundation.org, torvalds@linux-foundation.org,
 justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com,
 rostedt@goodmis.org, catalin.marinas@arm.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 audit@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <keescook@chromium.org>, Matus Jokay <matus.jokay@stuba.sk>,
 "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
User-Agent: K-9 Mail for Android
In-Reply-To: <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>
References: <20240828030321.20688-1-laoar.shao@gmail.com> <20240828030321.20688-2-laoar.shao@gmail.com> <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd> <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7> <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>
Message-ID: <7839453E-CA06-430A-A198-92EB906F94D9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 28, 2024 6:40:35 AM PDT, Yafang Shao <laoar=2Eshao@gmail=2Ecom> =
wrote:
>On Wed, Aug 28, 2024 at 8:58=E2=80=AFPM Alejandro Colomar <alx@kernel=2Eo=
rg> wrote:
>>
>> On Wed, Aug 28, 2024 at 12:15:40PM GMT, Alejandro Colomar wrote:
>> > Hi Yafang,
>> >
>> > On Wed, Aug 28, 2024 at 11:03:14AM GMT, Yafang Shao wrote:
>> > > We want to eliminate the use of __get_task_comm() for the following
>> > > reasons:
>> > >
>> > > - The task_lock() is unnecessary
>> > >   Quoted from Linus [0]:
>> > >   : Since user space can randomly change their names anyway, using =
locking
>> > >   : was always wrong for readers (for writers it probably does make=
 sense
>> > >   : to have some lock - although practically speaking nobody cares =
there
>> > >   : either, but at least for a writer some kind of race could have
>> > >   : long-term mixed results
>> > >
>> > > - The BUILD_BUG_ON() doesn't add any value
>> > >   The only requirement is to ensure that the destination buffer is =
a valid
>> > >   array=2E
>> > >
>> > > - Zeroing is not necessary in current use cases
>> > >   To avoid confusion, we should remove it=2E Moreover, not zeroing =
could
>> > >   potentially make it easier to uncover bugs=2E If the caller needs=
 a
>> > >   zero-padded task name, it should be explicitly handled at the cal=
l site=2E
>> > >
>> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation=2Eorg>
>> > > Link: https://lore=2Ekernel=2Eorg/all/CAHk-=3DwivfrF0_zvf+oj6=3D=3D=
Sh=3D-npJooP8chLPEfaFV0oNYTTBA@mail=2Egmail=2Ecom [0]
>> > > Link: https://lore=2Ekernel=2Eorg/all/CAHk-=3DwhWtUC-AjmGJveAETKOMe=
MFSTwKwu99v7+b6AyHMmaDFA@mail=2Egmail=2Ecom/
>> > > Suggested-by: Alejandro Colomar <alx@kernel=2Eorg>
>> > > Link: https://lore=2Ekernel=2Eorg/all/2jxak5v6dfxlpbxhpm3ey7oup4g2l=
nr3ueurfbosf5wdo65dk4@srb3hsk72zwq
>> > > Signed-off-by: Yafang Shao <laoar=2Eshao@gmail=2Ecom>
>> > > Cc: Alexander Viro <viro@zeniv=2Elinux=2Eorg=2Euk>
>> > > Cc: Christian Brauner <brauner@kernel=2Eorg>
>> > > Cc: Jan Kara <jack@suse=2Ecz>
>> > > Cc: Eric Biederman <ebiederm@xmission=2Ecom>
>> > > Cc: Kees Cook <keescook@chromium=2Eorg>
>> > > Cc: Alexei Starovoitov <alexei=2Estarovoitov@gmail=2Ecom>
>> > > Cc: Matus Jokay <matus=2Ejokay@stuba=2Esk>
>> > > Cc: Alejandro Colomar <alx@kernel=2Eorg>
>> > > Cc: "Serge E=2E Hallyn" <serge@hallyn=2Ecom>
>> > > ---
>> > >  fs/exec=2Ec             | 10 ----------
>> > >  fs/proc/array=2Ec       |  2 +-
>> > >  include/linux/sched=2Eh | 32 ++++++++++++++++++++++++++------
>> > >  kernel/kthread=2Ec      |  2 +-
>> > >  4 files changed, 28 insertions(+), 18 deletions(-)
>> > >
>> >
>> > [=2E=2E=2E]
>> >
>> > > diff --git a/include/linux/sched=2Eh b/include/linux/sched=2Eh
>> > > index f8d150343d42=2E=2Ec40b95a79d80 100644
>> > > --- a/include/linux/sched=2Eh
>> > > +++ b/include/linux/sched=2Eh
>> >
>> > [=2E=2E=2E]
>> >
>> > > @@ -1914,10 +1917,27 @@ static inline void set_task_comm(struct tas=
k_struct *tsk, const char *from)
>> > >     __set_task_comm(tsk, from, false);
>> > >  }
>> > >
>> > > -extern char *__get_task_comm(char *to, size_t len, struct task_str=
uct *tsk);
>> > > +/*
>> >
>> > [=2E=2E=2E]
>> >
>> > > + * - ARRAY_SIZE() can help ensure that @buf is indeed an array=2E
>> > > + */
>> > >  #define get_task_comm(buf, tsk) ({                 \
>> > > -   BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);     \
>> > > -   __get_task_comm(buf, sizeof(buf), tsk);         \
>> > > +   strscpy(buf, (tsk)->comm, ARRAY_SIZE(buf));     \
>> >
>> > I see that there's a two-argument macro
>> >
>> >       #define strscpy(dst, src)       sized_strscpy(dst, src, sizeof(=
dst))
>> >
>> > which is used in patch 2/8
>> >
>> >       diff --git a/kernel/auditsc=2Ec b/kernel/auditsc=2Ec
>> >       index 6f0d6fb6523f=2E=2Ee4ef5e57dde9 100644
>> >       --- a/kernel/auditsc=2Ec
>> >       +++ b/kernel/auditsc=2Ec
>> >       @@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t=
)
>> >               context->target_uid =3D task_uid(t);
>> >               context->target_sessionid =3D audit_get_sessionid(t);
>> >               security_task_getsecid_obj(t, &context->target_sid);
>> >       -       memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
>> >       +       strscpy(context->target_comm, t->comm);
>> >        }
>> >
>> >        /**
>>
>> Ahh, the actual generic definition is in <include/linux/string=2Eh>=2E
>> You could do
>>
>>         diff --git i/include/linux/string=2Eh w/include/linux/string=2E=
h
>>         index 9edace076ddb=2E=2E060504719904 100644
>>         --- i/include/linux/string=2Eh
>>         +++ w/include/linux/string=2Eh
>>         @@ -76,11 +76,11 @@ ssize_t sized_strscpy(char *, const char *,=
 size_t);
>>           * known size=2E
>>           */
>>          #define __strscpy0(dst, src, =2E=2E=2E)      \
>>         -       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(d=
st))
>>         +       sized_strscpy(dst, src, ARRAY_SIZE(dst))
>>          #define __strscpy1(dst, src, size)     sized_strscpy(dst, src,=
 size)
>>
>>          #define __strscpy_pad0(dst, src, =2E=2E=2E)  \
>>         -       sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_arr=
ay(dst))
>>         +       sized_strscpy_pad(dst, src, ARRAY_SIZE(dst))
>>          #define __strscpy_pad1(dst, src, size) sized_strscpy_pad(dst, =
src, size)
>>
>>          /**
>
>Thank you for your suggestion=2E How does the following commit log look
>to you? Does it meet your expectations?
>
>    string: Use ARRAY_SIZE() in strscpy()
>
>    We can use ARRAY_SIZE() instead to clarify that they are regular char=
acters=2E
>
>    Co-developed-by: Alejandro Colomar <alx@kernel=2Eorg>
>    Signed-off-by: Alejandro Colomar <alx@kernel=2Eorg>
>    Signed-off-by: Yafang Shao <laoar=2Eshao@gmail=2Ecom>
>
>diff --git a/arch/um/include/shared/user=2Eh b/arch/um/include/shared/use=
r=2Eh
>index bbab79c0c074=2E=2E07216996e3a9 100644
>--- a/arch/um/include/shared/user=2Eh
>+++ b/arch/um/include/shared/user=2Eh
>@@ -14,7 +14,7 @@
>  * copying too much infrastructure for my taste, so userspace files
>  * get less checking than kernel files=2E
>  */
>-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + __must_be_array(x))
>
> /* This is to get size_t and NULL */
> #ifndef __UM_HOST__
>@@ -60,7 +60,7 @@ static inline void print_hex_dump(const char *level,
>const char *prefix_str,
> extern int in_aton(char *str);
> extern size_t strlcat(char *, const char *, size_t);
> extern size_t sized_strscpy(char *, const char *, size_t);
>-#define strscpy(dst, src)      sized_strscpy(dst, src, sizeof(dst))
>+#define strscpy(dst, src)      sized_strscpy(dst, src, ARRAY_SIZE(dst))

Uh, but why? strscpy() copies bytes, not array elements=2E Using sizeof() =
is already correct and using ARRAY_SIZE() could lead to unexpectedly small =
counts (in admittedly odd situations)=2E

What is the problem you're trying to solve here?

-Kees

--=20
Kees Cook

