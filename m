Return-Path: <linux-fsdevel+bounces-25385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729194B528
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 04:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE041C216C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 02:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5E42AB0;
	Thu,  8 Aug 2024 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1jrsBZR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F7208C4;
	Thu,  8 Aug 2024 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085398; cv=none; b=oU7nCfIVJLZXfZTXDv1L9bqtUqdN7Zs/1FOA1BdN6TF0SiTq/WXqs/ECAh3AuTfUjHQ1mf1KWjHvva170DgLGJ3c0d7vbokXwqqOZVHeQqpfVOkcb8/M/Q5Rd/vgj+5x88LhwGdmonlpKIpxT1ehvh/NYKJOxHPDDjZFnMxdiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085398; c=relaxed/simple;
	bh=08sDwspuwXqyP/cnTLOgVWO66jmEEEako3F85Piab+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIMpApBZaoSzlIaGUvyPDqAWoVjEvEqt5jRDT2VWRT0BN+IPs/r9FPUXl8Qghza8YAqcNI2S7QAimppoL8ohYeWxExdBAcaAXoOVSKato3Yww3N8N6Mc+jTNk/r5vmwCcN3lsaJ8Ni3QeWB+oJArFa/8S463pMDP9PN4HBBVIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1jrsBZR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b7acf213a3so2974356d6.1;
        Wed, 07 Aug 2024 19:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723085395; x=1723690195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wCK7OrHV/RXkSDhtoAmVTQPNoEQ+lSxs9BlEtpZYM8=;
        b=J1jrsBZRUimlSuaDiWN+k8GCMptHmap8/65h6sn88a1+lg2Lt2ITexZGK6z5P1q7sp
         7nnyNgcWAK0vAT3NWyERls83p4Oj7iu5BjtNNPufJ7LvEmk+zjzf15HT2cSXMoJyr/Xp
         SQdxKcxKTHzbTon5iuMaEXWrxVRqLpvOFQSnKt9XXWU1ZxcwYocq9wVE8DiOGSMvjC+4
         IIBD91J8A6zlegZcwK1nzPKhT81sVGHA7blIhGfxYh6y2M2KC/s0j6R0Bk7xuGnj1YUT
         Rsn2D4pgQqdQ4Npi7Inu5xWGipgeqrU6ylbVli+61bc/MphQS2yssARqvrtg3lpj1pE7
         IfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723085395; x=1723690195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wCK7OrHV/RXkSDhtoAmVTQPNoEQ+lSxs9BlEtpZYM8=;
        b=dIehA2vPt7Zi3DKbOa+/Wku4WqRSBmwLIWialMyIhiWmQGBvYeY5lEJe+0iFjT7xJL
         bo2aUTNTJ1rEL5Bn5oi1CIRfU4Oe70Y4axb97lPGLNjBZiaANCxE9oUNm9tiujtNnSiF
         nA6Hz6TL/qIwoP6yREH03frkSI4526fGzdSU+U3olX3EH1DbhTbBETPpy1EShydOzdNn
         O8CzNhwVMqd5nhEVoUJH33VUaEtqTejruTgwrh+W2laxA8yFF6w3j4KxCu6MZ1a9Ivvg
         gl+m2WbLyY8MQq9X1mO/9y94Qoavocz9lzQbl+zbzmJ8ekXkmrmgXCTyfQFRiz45ugwV
         NZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+TGBzLlntCAvXWY821qwZGhhKhyA8qHA86wm7XOhzkUVfD6wZibxLMoaEpMxOs4iiAZZrUNK2K/Mf64DHqPxiDgtqGfsQRPQvD1GR2iM+rZOtCILQTaGJDce9BE/FOvQtdIyHxcLQNU49RFrEFoc7A3mZgKPUxs3hyjEet+WjGLHNPA98iywHT9ilKgLyamXVtlJOg/IwNNeyckt3qMb1VXSFdpo4dSA6Kj2FdaA+2TK89/+dKvtejdgJCdCNIpW7207O4e89mJKPR9uKpc8YBDvPhNyKM5Zk1qx3UxtLFCdBskZ/NES48PnLVGgC2eEVESHp5w==
X-Gm-Message-State: AOJu0YwYhGgG5FMgAXtDpWre6I6ImdGadI+R/Y3j1b37+Y7/r9IglA/5
	yDkQdlXHsMSMFyKaUjCHU+vLAJrgoxdw3uw4qVyCJXBg56LZBT9J+vW2uEGamfyUtQCoomKbVIB
	5REMoxccMckarNo04hNjuzO1TqMg=
X-Google-Smtp-Source: AGHT+IFAUbAmwMhJNJgsN0YPryyoi42HRLLz74PRZZtqqDpLNMLF+qLuRDBW3t/1Fjr4gj2UTXsNjeSbG/Ntg/8Q0mk=
X-Received: by 2002:a05:6214:4b0f:b0:6b5:4aa9:9687 with SMTP id
 6a1803df08f44-6bd6bd971c9mr6794786d6.50.1723085395024; Wed, 07 Aug 2024
 19:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfbosf5wdo65dk4@srb3hsk72zwq>
In-Reply-To: <2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfbosf5wdo65dk4@srb3hsk72zwq>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 8 Aug 2024 10:49:17 +0800
Message-ID: <CALOAHbBKzrvibUbj-1W7Z79AZsvOpMeG--EZ0pf2k0iyuPa1_w@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Alejandro Colomar <alx@kernel.org>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	alexei.starovoitov@gmail.com, audit@vger.kernel.org, bpf@vger.kernel.org, 
	catalin.marinas@arm.com, dri-devel@lists.freedesktop.org, 
	ebiederm@xmission.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	rostedt@goodmis.org, selinux@vger.kernel.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 1:28=E2=80=AFAM Alejandro Colomar <alx@kernel.org> w=
rote:
>
> Hi Linus,
>
> Serge let me know about this thread earlier today.
>
> On 2024-08-05, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Mon, 5 Aug 2024 at 20:01, Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > One concern about removing the BUILD_BUG_ON() is that if we extend
> > > TASK_COMM_LEN to a larger size, such as 24, the caller with a
> > > hardcoded 16-byte buffer may overflow.
> >
> > No, not at all. Because get_task_comm() - and the replacements - would
> > never use TASK_COMM_LEN.
> >
> > They'd use the size of the *destination*. That's what the code already =
does:
> >
> >   #define get_task_comm(buf, tsk) ({                      \
> >   ...
> >         __get_task_comm(buf, sizeof(buf), tsk);         \
> >
> > note how it uses "sizeof(buf)".
>
> In shadow.git, we also implemented macros that are named after functions
> and calculate the appropriate number of elements internally.
>
>         $ grepc -h STRNCAT .
>         #define STRNCAT(dst, src)  strncat(dst, src, NITEMS(src))
>         $ grepc -h STRNCPY .
>         #define STRNCPY(dst, src)  strncpy(dst, src, NITEMS(dst))
>         $ grepc -h STRTCPY .
>         #define STRTCPY(dst, src)  strtcpy(dst, src, NITEMS(dst))
>         $ grepc -h STRFTIME .
>         #define STRFTIME(dst, fmt, tm)  strftime(dst, NITEMS(dst), fmt, t=
m)
>         $ grepc -h DAY_TO_STR .
>         #define DAY_TO_STR(str, day, iso)   day_to_str(NITEMS(str), str, =
day, iso)
>
> They're quite useful, and when implementing them we found and fixed
> several bugs thanks to them.
>
> > Now, it might be a good idea to also verify that 'buf' is an actual
> > array, and that this code doesn't do some silly "sizeof(ptr)" thing.
>
> I decided to use NITEMS() instead of sizeof() for that reason.
> (NITEMS() is just our name for ARRAY_SIZE().)
>
>         $ grepc -h NITEMS .
>         #define NITEMS(a)            (SIZEOF_ARRAY((a)) / sizeof((a)[0]))
>
> > We do have a helper for that, so we could do something like
> >
> >    #define get_task_comm(buf, tsk) \
> >         strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->comm)
>
> We have SIZEOF_ARRAY() for when you want the size of an array:
>
>         $ grepc -h SIZEOF_ARRAY .
>         #define SIZEOF_ARRAY(a)      (sizeof(a) + must_be_array(a))

There is already a similar macro in Linux:

  /**
   * ARRAY_SIZE - get the number of elements in array @arr
   * @arr: array to be sized
   */
  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +
__must_be_array(arr))

will use it instead of the sizeof().

>
> However, I don't think you want sizeof().  Let me explain why:
>
> -  Let's say you want to call wcsncpy(3) (I know nobody should be using
>    that function, not strncpy(3), but I'm using it as a standard example
>    of a wide-character string function).
>
>    You should call wcsncpy(dst, src, NITEMS(dst)).
>    A call wcsncpy(dst, src, sizeof(dst)) is bogus, since the argument is
>    the number of wide characters, not the number of bytes.
>
>    When translating that to normal characters, you want conceptually the
>    same operation, but on (normal) characters.  That is, you want
>    strncpy(dst, src, NITEMS(dst)).  While strncpy(3) with sizeof() works
>    just fine because sizeof(char)=3D=3D1 by definition, it is conceptuall=
y
>    wrong to use it.
>
>    By using NITEMS() (i.e., ARRAY_SIZE()), you get the __must_be_array()
>    check for free.
>
> In the end, SIZEOF_ARRAY() is something we very rarely use.  It's there
> only used in the following two cases at the moment:
>
>         #define NITEMS(a)            (SIZEOF_ARRAY((a)) / sizeof((a)[0]))
>         #define MEMZERO(arr)  memzero(arr, SIZEOF_ARRAY(arr))
>
> Does that sound convincing?
>
> For memcpy(3) for example, you do want sizeof(), because you're copying
> raw bytes, but with strings, in which characters are conceptually
> meaningful elements, NITEMS() makes more sense.
>
> BTW, I'm working on a __lengthof__ operator that will soon allow using
> it on function parameters declared with array notation.  That is,
>
>         size_t
>         f(size_t n, int a[n])
>         {
>                 return __lengthof__(a);  // This will return n.
>         }
>
> If you're interested in it, I'm developing and discussing it here:
> <https://inbox.sourceware.org/gcc-patches/20240806122218.3827577-1-alx@ke=
rnel.org/>
>
> >
> > as a helper macro for this all.
> >
> > (Although I'm not convinced we generally want the "_pad()" version,
> > but whatever).
>
> We had problems with it in shadow recently.  In user-space, it's similar
> to strncpy(3) (at least if you wrap it in a macro that makes sure that
> it terminates the string with a null byte).
>
> We had a lot of uses of strncpy(3), from old times where that was used
> to copy strings with truncation.  I audited all of that code (and
> haven't really finished yet), and translated to calls similar to
> strscpy(9) (we call it strtcpy(), as it _t_runcates).  The problem was
> that in some cases the padding was necessary, and in others it was not,
> and it was very hard to distinguish those.
>
> I recommend not zeroing strings unnecessarily, since that will make it
> hard to review the code later.  E.g., twenty years from now, someone
> takes a piece of code with a _pad() call, and has no clue if the zeroing
> was for a reason, or for no reason.
>
> On the other hand, not zeroing may make it easier to explot bugs, so
> whatever you think best.  In the kernel you may need to be more worried
> than in user space.  Whatever.  :)

Good point.
I will avoid using the _pad().

--
Regards
Yafang

