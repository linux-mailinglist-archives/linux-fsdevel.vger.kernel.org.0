Return-Path: <linux-fsdevel+bounces-27584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C3A9628EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13501F24472
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEED18801B;
	Wed, 28 Aug 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRxvuoOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007E187859;
	Wed, 28 Aug 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852477; cv=none; b=svCN69QxIXqJW7HlTP+TkUrVRpK6u+VDl8lLEsIsk6gQ/4xe5qYFrFz9y/EOqCdzJPE9XWDL3YA8aRmOS0TXNq/fC2XhunLRCrxGuwojEGpdbLV6tItCW94ATc0fK77J9jycGA0A5hd9/1hccaQlCrbOrVt64S5nwyt0tw8bf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852477; c=relaxed/simple;
	bh=MzQ4mhd43I2cOjdIJoSDvEkdKxgyadmgOCAoCn+gjX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTXgCMKT5lVU8DsXY3Cy3lbCHoDNyQpYFhYb0+XMFBbcv3bX42m9Od1SK4LczxRJI8srTwvOkbgO2RJF772+bA71NfHeqmVMUnEsh8suayGyCc2cVs05cxJuzBIa99OQ/CcBZrYWvtDAQ1vCfbRCp36Z6smGyuonKuQIUVQDHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRxvuoOk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4503ccbc218so5379141cf.1;
        Wed, 28 Aug 2024 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724852474; x=1725457274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM22fWGyfP7pTHMrkwvXyYB2yArAZ5REiY88yMWxV58=;
        b=eRxvuoOkpaL64xzK5yKUon/u8k7s7Fr6Zz44taihPZS08p7PtaN2uIQXOiDSytRO4m
         kDw0sFRTcpNzgs8TBxqG1xvvUDnvsmL+mus7lLt+lNq+j5fZCYuGx+l7kF4yMgRuRaDf
         K+SOs0GErAmpakAMh3YkFjT3s7Z5TT64dKPpxS3R1oqamXt8nldAe1I5MkrdVtMZjkUV
         BRi05/EKaQEFug0ySfSsGYGGKCnKljAD/o/lRAYc9qg/2Cjwtup63euoQx5R/i1PBTDG
         ZAiejBIovq/6rrkUinUF6rdDkp3e+WNcH4JzWmnIJkEw3dnrm87h2hdIVGQgxfJAP4yh
         w3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724852474; x=1725457274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM22fWGyfP7pTHMrkwvXyYB2yArAZ5REiY88yMWxV58=;
        b=e1PdeaJUMDhSMrWCjsfiUhx8Y0wCI+O9R0t55+7yNBpa2r+NxJBNbPFMx4f2yPv2WH
         vkM3AsDxhktdtS9DOOuHlMll30/DzbBJdLbVG0KBZohTE0MUUeAatJOJTxA5z1ZEUyRR
         iOq4348i/tZt3dUTQDyswYsGpJNLLPz7l+sB9rmVce0bC3tPjttr5WKrb/HtfwCwqpNM
         zPquU5z/AzfWJqK539HaIEfwgVCkTzkKz5JlciUwTw8Pp4W7PUB6+2BHULjAPbRr3Wmf
         BoqO4JmPLpGKMnOvJSFwcj346JNT5VBWtz27KLuQEnCnsBxVYGKPumW3+nufTDfEWtyQ
         UZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCVzHKn0BRReGQofpXCitEmIHi+s6UHgU1eHQPffAbBEnWwyZwhVKcZ7vh//x6ZyMwNquv8Vq8Q7nAckwkJ9mw==@vger.kernel.org, AJvYcCWN/A+CuQJr2gQxjNEBQISrd6S2GfBdORtQ/fs6QjpRYqZRzvRn3OEJCVTRJKByavula7m/nsgPCg==@vger.kernel.org, AJvYcCWgINZfyAMGVHNo9F5uu9LHBgKU8zrM5lwamsKdCmSEWcrGHcCsQuXX249gw6TboKShs9Nk9BpWv6RgzVlgTU4PWw6M@vger.kernel.org, AJvYcCWmwLwWHc/n/u44DBm2RiXwTmqur37fHkO20IvgM5VGE+JFwdFq6kCJMWWqgr+3l7fZ1xbk@vger.kernel.org, AJvYcCWr+9ZoR8TtpE73uN17Ddnl02xaP99+XKz9Mzo8CcBYTY3ywToD9BaHlD8Hq06V08+u2vXUPsSP@vger.kernel.org, AJvYcCXBFsNli4RMjFYFcGqVxJ76ANvMPAM9trwqKLgRkq22UpgbgbkaM93g5pj1noRMsfa9kQh6yf2xht6ImPQJmaDYlKbRmsMW@vger.kernel.org, AJvYcCXurZlIOWuzybKP8KkPPTsMrB4T+RNy+TeI4VbIkDrf3fswSOIAJwgvXaHRG2GTpkgtuvOspw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7am4TNgPDNzlVBBH/nRPkdgq4+fEMATBaDtbRo3OMExZ7T9Js
	E3UXJiC/dufG2gkv1yfZ9e88C8fCop9pBMZxEITCfLJJ+yo+lGODR8LZ0eXR3tHYri07UbWFsew
	jWH8TuHAFK8RipqulpkF/9wNmqWE=
X-Google-Smtp-Source: AGHT+IEyHFAeIj+i9dwO5uOiV3XCouo/U0KX68AiGeUIHgmLKbuZ6ld4KcpgR5tcN/ds4tOwYEpli4MYtWggh3QrvFs=
X-Received: by 2002:a05:6214:448e:b0:6c1:84ce:8f31 with SMTP id
 6a1803df08f44-6c335c60e6emr43501846d6.0.1724852473892; Wed, 28 Aug 2024
 06:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828030321.20688-1-laoar.shao@gmail.com> <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd> <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7>
In-Reply-To: <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 28 Aug 2024 21:40:35 +0800
Message-ID: <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>
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

On Wed, Aug 28, 2024 at 8:58=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> On Wed, Aug 28, 2024 at 12:15:40PM GMT, Alejandro Colomar wrote:
> > Hi Yafang,
> >
> > On Wed, Aug 28, 2024 at 11:03:14AM GMT, Yafang Shao wrote:
> > > We want to eliminate the use of __get_task_comm() for the following
> > > reasons:
> > >
> > > - The task_lock() is unnecessary
> > >   Quoted from Linus [0]:
> > >   : Since user space can randomly change their names anyway, using lo=
cking
> > >   : was always wrong for readers (for writers it probably does make s=
ense
> > >   : to have some lock - although practically speaking nobody cares th=
ere
> > >   : either, but at least for a writer some kind of race could have
> > >   : long-term mixed results
> > >
> > > - The BUILD_BUG_ON() doesn't add any value
> > >   The only requirement is to ensure that the destination buffer is a =
valid
> > >   array.
> > >
> > > - Zeroing is not necessary in current use cases
> > >   To avoid confusion, we should remove it. Moreover, not zeroing coul=
d
> > >   potentially make it easier to uncover bugs. If the caller needs a
> > >   zero-padded task name, it should be explicitly handled at the call =
site.
> > >
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Link: https://lore.kernel.org/all/CAHk-=3DwivfrF0_zvf+oj6=3D=3DSh=3D-=
npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
> > > Link: https://lore.kernel.org/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwK=
wu99v7+b6AyHMmaDFA@mail.gmail.com/
> > > Suggested-by: Alejandro Colomar <alx@kernel.org>
> > > Link: https://lore.kernel.org/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueu=
rfbosf5wdo65dk4@srb3hsk72zwq
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > > Cc: Matus Jokay <matus.jokay@stuba.sk>
> > > Cc: Alejandro Colomar <alx@kernel.org>
> > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > > ---
> > >  fs/exec.c             | 10 ----------
> > >  fs/proc/array.c       |  2 +-
> > >  include/linux/sched.h | 32 ++++++++++++++++++++++++++------
> > >  kernel/kthread.c      |  2 +-
> > >  4 files changed, 28 insertions(+), 18 deletions(-)
> > >
> >
> > [...]
> >
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index f8d150343d42..c40b95a79d80 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> >
> > [...]
> >
> > > @@ -1914,10 +1917,27 @@ static inline void set_task_comm(struct task_=
struct *tsk, const char *from)
> > >     __set_task_comm(tsk, from, false);
> > >  }
> > >
> > > -extern char *__get_task_comm(char *to, size_t len, struct task_struc=
t *tsk);
> > > +/*
> >
> > [...]
> >
> > > + * - ARRAY_SIZE() can help ensure that @buf is indeed an array.
> > > + */
> > >  #define get_task_comm(buf, tsk) ({                 \
> > > -   BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);     \
> > > -   __get_task_comm(buf, sizeof(buf), tsk);         \
> > > +   strscpy(buf, (tsk)->comm, ARRAY_SIZE(buf));     \
> >
> > I see that there's a two-argument macro
> >
> >       #define strscpy(dst, src)       sized_strscpy(dst, src, sizeof(ds=
t))
> >
> > which is used in patch 2/8
> >
> >       diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> >       index 6f0d6fb6523f..e4ef5e57dde9 100644
> >       --- a/kernel/auditsc.c
> >       +++ b/kernel/auditsc.c
> >       @@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
> >               context->target_uid =3D task_uid(t);
> >               context->target_sessionid =3D audit_get_sessionid(t);
> >               security_task_getsecid_obj(t, &context->target_sid);
> >       -       memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
> >       +       strscpy(context->target_comm, t->comm);
> >        }
> >
> >        /**
>
> Ahh, the actual generic definition is in <include/linux/string.h>.
> You could do
>
>         diff --git i/include/linux/string.h w/include/linux/string.h
>         index 9edace076ddb..060504719904 100644
>         --- i/include/linux/string.h
>         +++ w/include/linux/string.h
>         @@ -76,11 +76,11 @@ ssize_t sized_strscpy(char *, const char *, s=
ize_t);
>           * known size.
>           */
>          #define __strscpy0(dst, src, ...)      \
>         -       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst=
))
>         +       sized_strscpy(dst, src, ARRAY_SIZE(dst))
>          #define __strscpy1(dst, src, size)     sized_strscpy(dst, src, s=
ize)
>
>          #define __strscpy_pad0(dst, src, ...)  \
>         -       sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array=
(dst))
>         +       sized_strscpy_pad(dst, src, ARRAY_SIZE(dst))
>          #define __strscpy_pad1(dst, src, size) sized_strscpy_pad(dst, sr=
c, size)
>
>          /**

Thank you for your suggestion. How does the following commit log look
to you? Does it meet your expectations?

    string: Use ARRAY_SIZE() in strscpy()

    We can use ARRAY_SIZE() instead to clarify that they are regular charac=
ters.

    Co-developed-by: Alejandro Colomar <alx@kernel.org>
    Signed-off-by: Alejandro Colomar <alx@kernel.org>
    Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index bbab79c0c074..07216996e3a9 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -14,7 +14,7 @@
  * copying too much infrastructure for my taste, so userspace files
  * get less checking than kernel files.
  */
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + __must_be_array(x))

 /* This is to get size_t and NULL */
 #ifndef __UM_HOST__
@@ -60,7 +60,7 @@ static inline void print_hex_dump(const char *level,
const char *prefix_str,
 extern int in_aton(char *str);
 extern size_t strlcat(char *, const char *, size_t);
 extern size_t sized_strscpy(char *, const char *, size_t);
-#define strscpy(dst, src)      sized_strscpy(dst, src, sizeof(dst))
+#define strscpy(dst, src)      sized_strscpy(dst, src, ARRAY_SIZE(dst))

 /* Copied from linux/compiler-gcc.h since we can't include it directly */
 #define barrier() __asm__ __volatile__("": : :"memory")
diff --git a/include/linux/string.h b/include/linux/string.h
index 9edace076ddb..060504719904 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h

@@ -76,11 +76,11 @@ ssize_t sized_strscpy(char *, const char *, size_t);
  * known size.
  */
 #define __strscpy0(dst, src, ...)      \
-       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
+       sized_strscpy(dst, src, ARRAY_SIZE(dst))
 #define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)

 #define __strscpy_pad0(dst, src, ...)  \
-       sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
+       sized_strscpy_pad(dst, src, ARRAY_SIZE(dst))
 #define __strscpy_pad1(dst, src, size) sized_strscpy_pad(dst, src, size)

 /**

--
Regards

Yafang

