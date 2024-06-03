Return-Path: <linux-fsdevel+bounces-20810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C88D815C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58403B231DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140E584D27;
	Mon,  3 Jun 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY7MjAQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CAB288DF;
	Mon,  3 Jun 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414545; cv=none; b=iNov4I8FhBu5E1RYWIOGf4i4lTcbjxddVsUmWUivUrh8+A1weKZGSwT5tFix0B+3T4MOrgjEtsPoBdTaK62se7lvOpM45SroWo0wjx/tBQePQVfk2r6aTpIObP0qWWAMv/JDXl5ZLwgC/txcX+coZCgKkL3oa9wwXiqtCKEQEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414545; c=relaxed/simple;
	bh=aoxYSkwX+tV+MwMpCD6gcgbnNLkztkC6LLaSmt3gHik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/LVAdOifGPR+tJ2cMFLo61q9P5stzivv+tDyY0EHb5ENw9d9Ji1mQWBHXgltnH44v/KRRbRFb211RWAxpzVnaEXPPdsBuQw7u5diCfyF5c69fSHSYQFzMs+pim9M4JBMeIDjUIDFDNKQRfeTg0253NFejRW2cCXNGVBPM82xtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY7MjAQv; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ae0abdf095so22586686d6.2;
        Mon, 03 Jun 2024 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717414543; x=1718019343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/pL0kZCeM1y16ZAOktPzW9q0OBMB22PikjjFd/rS+w=;
        b=IY7MjAQvE5fw1U2yiXaOKJVtYjdd8A0wTJf5Jdgaoer2my4WfCLhM2QRBTH4gYplIi
         /zoEFv1/xxK4LjVo+NbIj8cIm7OodTBmArb4w4c76iocR4JWKuiBHKytb1NvEZ2DNdIC
         jfk2piiZny5R51T095op3y2Kx7XL1tudJY3hQ2/7l89CVGoIt+fJTIom02cK4ctk8WJY
         maXInlVdOcPQgz7QwoH6CzUmkej8aSuwwakoXGC60w+d18pT9nsnoRpmtS0ONoiO+I8z
         4+poAGOhiy81wZ6ScIdyKseKHQ6zOW3bMyg8rOWA48RDsudsAEHkh9ZZJrfTiV2TYE6x
         hx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717414543; x=1718019343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/pL0kZCeM1y16ZAOktPzW9q0OBMB22PikjjFd/rS+w=;
        b=MHg1qeWG/6HyOFNucbfFbBf4o9xvhd6JQOpQiDqs1nMoqJA+/7Srf/2YgmtMx96K8Y
         VApz/zO4PI2Zuo6o7xH2ePoAPP4yzXYvVxV8lr8SRq6tjHgJakSby4mHDeaJr9JZEX2M
         PazPPqjhlY2Vew77eda7pgMWPv9b7BChtSUkFhe/HnJN/vuHw/2kuFncelJnFnvKYgAd
         Xl0k6tuO2XUpLg4WnHJR2mWNNXLCtHxOr0r7WhPb78DR9UpnYzbL6FYIcXgMTIJE4YGw
         yz4Jtvz9XcckRcprvLHN2sWtfrD8nY38dujEbnx1sKc42hXtlsx1H1knBFtnjjdLsGm8
         Ds5w==
X-Forwarded-Encrypted: i=1; AJvYcCVSSY3nVl6kSgaELn5nHbTRYLjQLj8LMljC+VIoJKbl585Vfg3xCPvM81RAyoIKNFU/7MqEn1WY43pP+rJi//6RKaPYCdIs1qQ+HrPl9xUXi08LatEatPZ1Ao+SKDaL6pjXJ2ifLTxFs+YvJ3auy4jfCiCWxALw3/O4zneIeZ6ze8aGgBVGFaXC5V/05uXEVLreoQGZDcX9BzkyUy0PZXbrwXmH7Bw6r1CSalhS80dkoF+jL6l5CCQUvHAy1NLhyFo0nXjdARGIAvtwZQ+5uid3xl15ik3ln+OgJlmfNQ==
X-Gm-Message-State: AOJu0Yw4yruvQ15d3ZEGIk3GO1xM+Y/g4IzO5XG1C/KfZM7MgwVtr9TV
	NMyHF5Fg6U3Lqk8SvYdrpUlUFMgo/jWxGhlRK2ry09yX+qomTzEte3eoUBvsWs+Dj0G/EqYHhsS
	Aeked5ch6Yplkfs5ra2ZocyPbIwY=
X-Google-Smtp-Source: AGHT+IEMPGXe1xq7rGBpGwfaIRAsELArfyOIl90qn3qIm6Yayy3B/d/0+DEKGHoLO4/5D6X82RkZyCrmvpduHJpXVSc=
X-Received: by 2002:a05:6214:3d99:b0:6af:c64c:d1a0 with SMTP id
 6a1803df08f44-6afc64cd5b7mr18050666d6.56.1717414542934; Mon, 03 Jun 2024
 04:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-2-laoar.shao@gmail.com>
 <87ikysdmsi.fsf@email.froward.int.ebiederm.org> <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
 <CAADnVQJ_RPg_xTjuO=+3G=4auZkS-t-F2WTs18rU2PbVdJVbdQ@mail.gmail.com>
 <874jabdygo.fsf@email.froward.int.ebiederm.org> <CAADnVQ+9T4n=ZhNMd57qfu2w=VqHM8Dzx-7UAAinU5MoORg63w@mail.gmail.com>
In-Reply-To: <CAADnVQ+9T4n=ZhNMd57qfu2w=VqHM8Dzx-7UAAinU5MoORg63w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 3 Jun 2024 19:35:04 +0800
Message-ID: <CALOAHbARXwZvr0GBxKc_c-3nay--h4NhvZbSyt8eZwijNW1a0w@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, audit@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:23=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Jun 2, 2024 at 10:53=E2=80=AFAM Eric W. Biederman <ebiederm@xmiss=
ion.com> wrote:
> >
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >
> > > On Sat, Jun 1, 2024 at 11:57=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > >>
> > >> On Sun, Jun 2, 2024 at 11:52=E2=80=AFAM Eric W. Biederman <ebiederm@=
xmission.com> wrote:
> > >> >
> > >> > Yafang Shao <laoar.shao@gmail.com> writes:
> > >> >
> > >> > > Quoted from Linus [0]:
> > >> > >
> > >> > >   Since user space can randomly change their names anyway, using=
 locking
> > >> > >   was always wrong for readers (for writers it probably does mak=
e sense
> > >> > >   to have some lock - although practically speaking nobody cares=
 there
> > >> > >   either, but at least for a writer some kind of race could have
> > >> > >   long-term mixed results
> > >> >
> > >> > Ugh.
> > >> > Ick.
> > >> >
> > >> > This code is buggy.
> > >> >
> > >> > I won't argue that Linus is wrong, about removing the
> > >> > task_lock.
> > >> >
> > >> > Unfortunately strscpy_pad does not work properly with the
> > >> > task_lock removed, and buf_size larger that TASK_COMM_LEN.
> > >> > There is a race that will allow reading past the end
> > >> > of tsk->comm, if we read while tsk->common is being
> > >> > updated.
> > >>
> > >> It appears so. Thanks for pointing it out. Additionally, other code,
> > >> such as the BPF helper bpf_get_current_comm(), also uses strscpy_pad=
()
> > >> directly without the task_lock. It seems we should change that as
> > >> well.
> > >
> > > Hmm. What race do you see?
> > > If lock is removed from __get_task_comm() it probably can be removed =
from
> > > __set_task_comm() as well.
> > > And both are calling strscpy_pad to write and read comm.
> > > So I don't see how it would read past sizeof(comm),
> > > because 'buf' passed into __set_task_comm is NUL-terminated.
> > > So the concurrent read will find it.
> >
> > The read may race with a write that is changing the location
> > of '\0'.  Especially if the new value is shorter than
> > the old value.
>
> so ?
> strscpy_pad in __[gs]et_task_comm will read/write either long
> or byte at a time.
> Assume 64 bit and, say, we had comm where 2nd u64 had NUL.
> Now two cpus are racing. One is writing shorter comm.
> Another is reading.
> The latter can read 1st u64 without NUL and will proceed
> to read 2nd u64. Either it will read the old u64 with NUL in it
> or it will read all zeros in 2nd u64 or some zeros in 2nd u64
> depending on how the compiler generated memset(.., 0, ..)
> as part of strscpy_pad().
> _pad() part is critical here.
> If it was just strscpy() then there would indeed be a chance
> of reading both u64-s and not finding NUL in any of them.
>
> > If you are performing lockless reads and depending upon a '\0'
> > terminator without limiting yourself to the size of the buffer
> > there needs to be a big fat comment as to how in the world
> > you are guaranteed that a '\0' inside the buffer will always
> > be found.
>
> I think Yafang can certainly add such a comment next to
> __[gs]et_task_comm.
>
> I prefer to avoid open coding memcpy + mmemset when strscpy_pad works.

Thanks for your explanation.
I will add a comment for it in the next version.

--=20
Regards
Yafang

