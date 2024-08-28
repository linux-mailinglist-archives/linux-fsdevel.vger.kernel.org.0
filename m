Return-Path: <linux-fsdevel+bounces-27576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D8E9627F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236081F25411
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0F186619;
	Wed, 28 Aug 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLArsCt1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06717BEAB;
	Wed, 28 Aug 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849874; cv=none; b=BI5I9A7yV8ckt5axpdn/N6rmbLCC0FqSIi2LifR2icw15X7IX0JKJCsXjrNLTc9TIrlW3uodg5bynabLBOaAocsD4K3ziys5SdDlxCZNcGJjWE4bhxsp8u2JVHIxEPRi2dWgJEuCsZXNaf+ekslNNc2STZesPUYZcwNEjuO8EP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849874; c=relaxed/simple;
	bh=XQwE1UqhwI172D6a6kc3gjP1iHymRSudK+/ZnlUNkqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFP+j6iOR6KlaMIj5MzAFtvayfNlLbhbsqzEtPcf+42eZ9GKCAiJCxJ6Pi1z9zuvrhmPXPJRhUqTP+n0lhLoecxsrA18bHSI+1uLu52vVshdAcynFP65/JsrohgOT11abdB4/FQ17eFY1NeNy8v8NAXwdnUETicYQEg5vAkxYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLArsCt1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf90d52e79so36757176d6.3;
        Wed, 28 Aug 2024 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724849871; x=1725454671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75zSlLwUuo3vTsXNiB/Bg248lll9xEE0NLqRnWuoevM=;
        b=gLArsCt1AMcKr9OxA17BIdgojvRi7s0rpUH9KQNH0d6Hqc4k6G8dxjQvU6NwRgf5fn
         4qKttec1CNbz7K4YJoAug7EpYXjqPICLVBUuCp2y4UweZRWKT/FM2hR+0R0TBSK5Xqm3
         3Dsy6MBLgE4AhqhJ+yI3ALIrN+iEXKFiBCM0ObFY1LgEsSvmB5SEFY9611McUd8WjK6F
         kvAOCqcHQd7yl9go3em1EhXTRBd13lyuPFO8mxyLK8kSrIKFFxwTpNTV+gPuDqco/gqi
         pb7EhqGJRA2yJVnuuaUO7aTJ1+9RPXChE908F19JKLpx4wxC2jhqXXbkSSWWn1a+isvb
         hfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724849871; x=1725454671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75zSlLwUuo3vTsXNiB/Bg248lll9xEE0NLqRnWuoevM=;
        b=xJXUvdmH2GcFFn1YxnKpSSSD/E7owZ9cIlIY0+ku79aw26HnryAzCAYLytlfEwHVQT
         /o3zpq6bLkUkw7KNC5xm5R8+ZVnAmjVf8UTqiQ0jvAN5xjZfabnkG9QKTX2qsdKSy9n2
         DtQ5+/f4Yg8Yk168GBdCah2UBXN7b0nE2B2YtyiuZRLnaWxDOduKXcZUeSzlZI/yo5zc
         Cr+e7pnOJ0vaiayjnGXJdEHsmEliiZhnlnkrKoU3h5YWx8LglQI7ACcm4tYcNlNppnOc
         IHQBvcMk+d2V8Stl6MzIScp1GCaP0XBA/r1PdNhp+a6r28Ndzaq+bGRiJDMmTVZa0vAA
         D2mw==
X-Forwarded-Encrypted: i=1; AJvYcCUuHnkdX2wAmSo+KdxHXi2eYlkyas1jqi3iNlYlvsqOWTpoC6t5cUAjP7OBih7G0cXq/ihHL7hx@vger.kernel.org, AJvYcCVOLjf981pMBOj3dE7OiTKVwlcEo9Xs0mwFPLz4YzlQtaZzuADq78uFvgqdcuIFyZe31oeklbII1Q==@vger.kernel.org, AJvYcCVWKuDngX93rqHaTnY/Gj+IfPfq4C57wvXwLFiVKU+lF98brMRL1FpfuqSGp32gDuGSPF+f@vger.kernel.org, AJvYcCX4lMSE7wrmCSPP4+AHlEec9M5II7wbq0cQZmgDYipPGI4OfcFMceJnEggQRhVwu3js7SVSzQmvxtxG6qjZwWwpiGTa6bnG@vger.kernel.org, AJvYcCXKOgJFtSRNWjdo+KSZyf61E1pZDHLrecfGmZfadlCxeCKm8x5E3d7zxHPSkEgjIjceU5vLNmbNX3XtpRiPmw==@vger.kernel.org, AJvYcCXbmENwDCPXjaNJwM23K/RTY1AyFRRwPhBxMEASykkmZESmdpggcbcxYH+UrkZssRoJDuefQcYIqwocw5Y9SnFnLAhJ@vger.kernel.org, AJvYcCXfqL84c/g4aRpMSfuGEij1p3OJWGuSAZItiH21Hl6vtIkNOLfrQRd6XPUYrkB30jO3/+MTnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PZWx8NBj2W83uDZFw1Aog/HcNo57PNeHcUXuEgQwtfksZm0a
	obsaWutauqFIprgpPecbwX1kTkgrM/ERtTXZLA9QD5eH2KEha1Ua2T+sp3GBUZD/fGW/Kl5WHDD
	Ybgf4jZyfvsF64RKO2VG38eMp088=
X-Google-Smtp-Source: AGHT+IGVdDZRdAbiWZ5RYcs75Y+9kyklByrS1cllsDWIp6LEk4Cl8MdoT9mGOnGBew4RhB5tPSnWZccJF6guOMsDPnY=
X-Received: by 2002:a05:6214:320c:b0:6c1:5283:e67b with SMTP id
 6a1803df08f44-6c16deb306dmr178438206d6.47.1724849871190; Wed, 28 Aug 2024
 05:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828030321.20688-1-laoar.shao@gmail.com> <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
In-Reply-To: <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 28 Aug 2024 20:57:13 +0800
Message-ID: <CALOAHbCR52PSzc2JMN+kwJZW-b1yPzSgqznzmcE9Ldp3nx9=XQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
To: Alejandro Colomar <alx@kernel.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	Matus Jokay <matus.jokay@stuba.sk>, "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 6:15=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Yafang,
>
> On Wed, Aug 28, 2024 at 11:03:14AM GMT, Yafang Shao wrote:
> > We want to eliminate the use of __get_task_comm() for the following
> > reasons:
> >
> > - The task_lock() is unnecessary
> >   Quoted from Linus [0]:
> >   : Since user space can randomly change their names anyway, using lock=
ing
> >   : was always wrong for readers (for writers it probably does make sen=
se
> >   : to have some lock - although practically speaking nobody cares ther=
e
> >   : either, but at least for a writer some kind of race could have
> >   : long-term mixed results
> >
> > - The BUILD_BUG_ON() doesn't add any value
> >   The only requirement is to ensure that the destination buffer is a va=
lid
> >   array.
> >
> > - Zeroing is not necessary in current use cases
> >   To avoid confusion, we should remove it. Moreover, not zeroing could
> >   potentially make it easier to uncover bugs. If the caller needs a
> >   zero-padded task name, it should be explicitly handled at the call si=
te.
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Link: https://lore.kernel.org/all/CAHk-=3DwivfrF0_zvf+oj6=3D=3DSh=3D-np=
JooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
> > Link: https://lore.kernel.org/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwKwu=
99v7+b6AyHMmaDFA@mail.gmail.com/
> > Suggested-by: Alejandro Colomar <alx@kernel.org>
> > Link: https://lore.kernel.org/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurf=
bosf5wdo65dk4@srb3hsk72zwq
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Cc: Matus Jokay <matus.jokay@stuba.sk>
> > Cc: Alejandro Colomar <alx@kernel.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > ---
> >  fs/exec.c             | 10 ----------
> >  fs/proc/array.c       |  2 +-
> >  include/linux/sched.h | 32 ++++++++++++++++++++++++++------
> >  kernel/kthread.c      |  2 +-
> >  4 files changed, 28 insertions(+), 18 deletions(-)
> >
>
> [...]
>
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index f8d150343d42..c40b95a79d80 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
>
> [...]
>
> > @@ -1914,10 +1917,27 @@ static inline void set_task_comm(struct task_st=
ruct *tsk, const char *from)
> >       __set_task_comm(tsk, from, false);
> >  }
> >
> > -extern char *__get_task_comm(char *to, size_t len, struct task_struct =
*tsk);
> > +/*
>
> [...]
>
> > + * - ARRAY_SIZE() can help ensure that @buf is indeed an array.
> > + */
> >  #define get_task_comm(buf, tsk) ({                   \
> > -     BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);     \
> > -     __get_task_comm(buf, sizeof(buf), tsk);         \
> > +     strscpy(buf, (tsk)->comm, ARRAY_SIZE(buf));     \
>
> I see that there's a two-argument macro
>
>         #define strscpy(dst, src)       sized_strscpy(dst, src, sizeof(ds=
t))

This macro is defined in arch/um/include/shared/user.h, which is not
used outside
the arch/um/ directory.
This marco should be addressed.

>
> which is used in patch 2/8

The strscpy() function used in this series is defined in
include/linux/string.h, which already checks whether the input is an
array:

#define __strscpy0(dst, src, ...)       \
        sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
#define __strscpy1(dst, src, size)      sized_strscpy(dst, src, size)

#define __strscpy_pad0(dst, src, ...)   \
        sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
#define __strscpy_pad1(dst, src, size)  sized_strscpy_pad(dst, src, size)


>
>         diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>         index 6f0d6fb6523f..e4ef5e57dde9 100644
>         --- a/kernel/auditsc.c
>         +++ b/kernel/auditsc.c
>         @@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
>                 context->target_uid =3D task_uid(t);
>                 context->target_sessionid =3D audit_get_sessionid(t);
>                 security_task_getsecid_obj(t, &context->target_sid);
>         -       memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
>         +       strscpy(context->target_comm, t->comm);
>          }
>
>          /**
>
> I propose modifying that macro to use ARRAY_SIZE() instead of sizeof(),
> and then calling that macro here too.  That would not only make sure
> that this is an array, but make sure that every call to that macro is an
> array.  An if there are macros for similar string functions that reduce
> the argument with a usual sizeof(), the same thing could be done to
> those too.

I have no preference between using ARRAY_SIZE() or sizeof(dst) +
__must_be_array(dst). However, for consistency, it might be better to
use ARRAY_SIZE().


--
Regards

Yafang

