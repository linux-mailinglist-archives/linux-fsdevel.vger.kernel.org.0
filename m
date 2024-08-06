Return-Path: <linux-fsdevel+bounces-25061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D2F9487C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 05:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EBF1C2235C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 03:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3CE5B1FB;
	Tue,  6 Aug 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEJXF0Zj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D9AD51;
	Tue,  6 Aug 2024 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913277; cv=none; b=aGSlbWRymuQcOvlQtJ2mpwrCkOuVTbWsrKBXh00ABElDc+LL1kc+biVGCw5U4L7YsFkaHppNbk8VSz4+wAou88TscO6oBMzXCxu/q6HGRuZ8MjCFk8DptvQs1U820uy4PUuPpHXzA3BfHzhMVR0aON9ew/Pn+NuQJ/oBA/KB76A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913277; c=relaxed/simple;
	bh=gahnyWmiKh242/O7K215R843/jxHuH+fvyVuYT1PRVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GB0VI7rrJK+mxnZHJflzzkAosHmOA/IOHLTVyZpapg3TnpOHx30Pno9pyGQ99Donns4MF5DsYPFTyC6S8wQPSLx75J3L9XY7jKoCmAfrGDmEmdFrqCYTGsVLu554+uU4lgaFJANGkwrcxuuFOpPSmjyZ9hAd4fvjI64mK1GF4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEJXF0Zj; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so1216126d6.0;
        Mon, 05 Aug 2024 20:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722913275; x=1723518075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZR4E8D89jwg4yvmIjI2zPRIKoU2AHuL/vFtEuJY3nU=;
        b=OEJXF0ZjE3J9wRYhUez4NKc5nQeyfULcGboatdoH++gJdx2dOJUhTODxrFtjHLQwIU
         K8m7yC1OtDmKqZTTwEc59+JWB9ljTdh8mPWGHRfm5PVITduwwAB8GFhf3Zt9nUYpmgx9
         OKeLEdWgPNh19AB+tA0fJqUvBSOEroEtgRhCbDGqKUGYYEVj0jCWebdQ4GmxyV47885R
         nhKqmQuFkwOXZhuLhThgzwmMyg4QBuL3maHkHdWY23eFBU9BBFOgaktjfzQR0ntoxhyl
         ehh5ibw+cAstEsxdyIKzebIRHRakNfxmIYUwkqfIQZ9VQMCwOR19JXG+aFcyZIKkgx2x
         /8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913275; x=1723518075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZR4E8D89jwg4yvmIjI2zPRIKoU2AHuL/vFtEuJY3nU=;
        b=B6kUFXU8M29r3CjE7dzV65AhFWoUXwQXZwni6VbTIvjllRIe9bB/R5YjygWpfTM4ag
         +7LEDwsQZo8f46Lv45BbQVm0xz/L2U0SnYc0dwsvoSUsOA7MHRVXY1x/K+8f8QKz3cqK
         W4Bd2zxgfzBoqJow9Bdg70G/km8THAkyEgm3dU8EEsgOfJr8B4VLo3jFTmUK8vkcv3PG
         E62NltRcApvLL8+lf9lkg8RVH6pkCMhXhXCKAHbLAF5qAn3DT95YReXW5tqMGaHfz5p6
         y7odm3Id91bIde10OJWyi6KIhxbWYpIW83brJb4gS8O3k71ItKHOjqIM2v5dB1bU8RWY
         DvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzwznoM7Upnu6gIkS6oIzAkHCSCGRm0PPH/VSlW5xHFKcB3qLW0giMK42Ab7qMlfZQzd0D68Zbi1E1ccjALYoU/qV55VKjGHRWAESwvqn/6yIN7T/DFvT8JeQvCdtbr+/26Mhso6JQBnRjZDOrpMyUq+XiQtCVgmfi6COgV/YVgY+xLzf58KL4w7LvxZxuYsH4uebVqkKhod09WT0dN91hQzyJN69tZeTI7AuFh//DeXDzXo+5Q9JeywGWYp6IrSIdThQxy86VVBFypiE3L3OsbJMp7d5ns4y1unPTd+3QVoh+UYXQnqxruYAKVVo0fB5otT/k0w==
X-Gm-Message-State: AOJu0Yy8BFctZfq0G/3ZbD2WVjDLUt34WqYwywK9kNeOBLGZzMRuneVn
	+WAjBkgUzkqL2Dy2maQ/ep5MDseJHg0gke+EITStHG5H/WytiPKcCuPNAd4ucsz6gHrA53FxY7J
	iQDGjvNLTTyCvx3kR9+azgw5JHdk=
X-Google-Smtp-Source: AGHT+IH5UetJykoQ+AA9lUd/PNGcF9CreQ+CKGIYQr4sa6NtWmr6AOpHiEKJTnDf738MR+GOImNMUHgXoQCs1IfVbM8=
X-Received: by 2002:a05:6214:440b:b0:6b7:aed6:8470 with SMTP id
 6a1803df08f44-6bb983f7560mr162583526d6.28.1722913274688; Mon, 05 Aug 2024
 20:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com> <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
In-Reply-To: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 6 Aug 2024 11:00:36 +0800
Message-ID: <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:28=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 4 Aug 2024 at 00:56, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > There is a BUILD_BUG_ON() inside get_task_comm(), so when you use
> > get_task_comm(), it implies that the BUILD_BUG_ON() is necessary.
>
> Let's just remove that silly BUILD_BUG_ON(). I don't think it adds any
> value, and honestly, it really only makes this patch-series uglier
> when reasonable uses suddenly pointlessly need that double-underscore
> version..
>
> So let's aim at
>
>  (a) documenting that the last byte in 'tsk->comm{}' is always
> guaranteed to be NUL, so that the thing can always just be treated as
> a string. Yes, it may change under us, but as long as we know there is
> always a stable NUL there *somewhere*, we really really don't care.
>
>  (b) removing __get_task_comm() entirely, and replacing it with a
> plain 'str*cpy*()' functions
>
> The whole (a) thing is a requirement anyway, since the *bulk* of
> tsk->comm really just seems to be various '%s' things in printk
> strings etc.
>
> And once we just admit that we can use the string functions, all the
> get_task_comm() stuff is just unnecessary.
>
> And yes, some people may want to use the strscpy_pad() function
> because they want to fill the whole destination buffer. But that's
> entirely about the *destination* use, not the tsk->comm[] source, so
> it has nothing to do with any kind of "get_task_comm()" logic, and it
> was always wrong to care about the buffer sizes magically matching.
>
> Hmm?

One concern about removing the BUILD_BUG_ON() is that if we extend
TASK_COMM_LEN to a larger size, such as 24, the caller with a
hardcoded 16-byte buffer may overflow. This could be an issue with
code in include/linux/elfcore.h and include/linux/elfcore-compat.h,
posing a risk. However, I believe it is the caller's responsibility to
explicitly add a null terminator if it uses a fixed buffer that cannot
be changed. Therefore, the following code change is necessary:

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5ae8045f4df4..e4b0b7cf0c1f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1579,6 +1579,7 @@ static int fill_psinfo(struct elf_prpsinfo
*psinfo, struct task_struct *p,
        SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid))=
;
        rcu_read_unlock();
        get_task_comm(psinfo->pr_fname, p);
+       psinfo->pr_fname[15] =3D '\0';

        return 0;
 }

However, it is currently safe to remove the BUILD_BUG_ON() since
TASK_COMM_LEN is still 16.

--
Regards
Yafang

