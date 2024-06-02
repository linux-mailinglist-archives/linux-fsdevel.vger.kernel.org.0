Return-Path: <linux-fsdevel+bounces-20748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE288D772C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 18:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401541C21212
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D755C3E;
	Sun,  2 Jun 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq0bR5SS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DF4778C;
	Sun,  2 Jun 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717346134; cv=none; b=j6vpniDYZWD6y1/mxQLawKOG2KReIJ11EnVJ+TvoRF7s2EazFCI9dSvk4PmNFZMZxtDwqLys7W4aSmpB9louPUdqG9I74xQMVT0gw0jDf5lVAMJlhTIn+4k3S4T7oHgTcurxNQ4IEui5tEqba+97JutZw4SSlvu6RNXIUdMOXS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717346134; c=relaxed/simple;
	bh=r82fZk9re4kiB+HKLO6WiG+MsU1AilTXXjpCSldZGF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgiusQ02nKF9IbKvqjPUre0ANZUKP3qYfw2iMxvCrdmaDNWlLP7nq9vbu2N1fNSAM39MibB7vmYEbEugTH+8+GsCVrWzeXyS58t+ku+kL2OWw5bkKewZh2YbK+PDUxwNwmrmCLlSlSs9c6+YBLTrTFGtjPxnS7iqm7Spk83enVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq0bR5SS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35e4be5bd7fso1031565f8f.1;
        Sun, 02 Jun 2024 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717346131; x=1717950931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3F/P98Vvj42F4uAlpuFuX2wB1pLK9ulXz/7ywvM+Wo=;
        b=Dq0bR5SSvLVJ/5Dn6QjQ5w2YIldf+IfZ0xkc1xKade5APFOCExr0/FnICwX0lhQRa8
         jr/tfDnYEaaqa2SjNZFCLZ9tWsoKdP/+m2vzQhuB7TG24oIUT8hKTdi+PDPTb2fgz+B+
         bViAs8giwixJNssKv8VB8B9rWj/dGMxdx1raTiwqO41ER4j3J3WGCKgE+Xa2xkji3GSY
         Ty3gTenupusY+/gxFtmzg2VuTMLS8LlthcCJM5etJMCKmOhnEOqnyUiszitFwbV/bXvR
         uTAtItJMIDRNaitycIrd/1cj60VtVg2pD/hkrMMZrzyNDt2e56+ndzNDIiTpgEpRFFy0
         jNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717346131; x=1717950931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3F/P98Vvj42F4uAlpuFuX2wB1pLK9ulXz/7ywvM+Wo=;
        b=b6kdWulmwitQk0J5s2r7V5rr9H1yDphIPItGHTZkFok5s1ix5zhZWF2Ej9xsoUc+LD
         jyqZDCmzsryiYasG/BBqGBQrcEPw3851lKI9TPvQzmuIFgU8hM2wCEsSY7L0SLbvPM56
         +cryL9zlrsm9nH44zYfC20WAwjFtpe6vuzVgV0is6zI51uj+jVEWzTlkvw3Rr3IZTrrz
         3fWGL0TqQzccOYdLgJDs9yHA/OpXL3ICYdj/yHjH2eel7or6aIsGO5m66S5jVeUhI/rg
         MaHoe2VZVmqdmZfc226khIVnkwHeJ+pSOXxIMEMOrutCKdaiLKTAlpqoDazX2Ib8lF4E
         CzNw==
X-Forwarded-Encrypted: i=1; AJvYcCVrgmXB0PuuGJj+puScnUvFQ7aWafW6MAxiyptzbF4HYsBhX4eEt5rjfMPUeSlco4CVYXmK+ck6HDIA561M6DQyt5yl7rN6hnjj+wiD/oqEahEUDCidZspBg9e6yLEQp2bF1fjIYkNrx9/x3D9KBFKMnGckzwOBrFX6lzilWGqjuD7ls0EH3/cUGxw/kbyIwSryGQvVioruwycl8kqYyAZTMulQrE7uUd6abqXLTW3Q86mBwQRWAIj/rGCLmVGKd8e4mcJomb3aElRf1cD73EaTEU7j5lQxgYlLrPq07w==
X-Gm-Message-State: AOJu0YykYsI3+waM/jc63H4bVjXouhyZQ/nF80QtBMAaidTWNor++76H
	pF8Ul1cb1wTCY7DlaJC77feJ80Bi57AU4yrrPipLkav1c5WyJ6kfMesb4cMUGqaz63d/GZG660V
	HwcOo8vctnSUFv0kjukbktrhlblQ=
X-Google-Smtp-Source: AGHT+IGhoPhpe51Y6Tp0rsrrRoTYtVnReDI2hgHxSRyGOSVnzBaep7p/mha6bjIlUVzy7MousDnj/U19epRohpFPBTE=
X-Received: by 2002:a5d:4f01:0:b0:354:f66f:9292 with SMTP id
 ffacd0b85a97d-35e0f28441amr4419798f8f.28.1717346131116; Sun, 02 Jun 2024
 09:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-2-laoar.shao@gmail.com>
 <87ikysdmsi.fsf@email.froward.int.ebiederm.org> <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
In-Reply-To: <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 2 Jun 2024 09:35:19 -0700
Message-ID: <CAADnVQJ_RPg_xTjuO=+3G=4auZkS-t-F2WTs18rU2PbVdJVbdQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, audit@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 11:57=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Sun, Jun 2, 2024 at 11:52=E2=80=AFAM Eric W. Biederman <ebiederm@xmiss=
ion.com> wrote:
> >
> > Yafang Shao <laoar.shao@gmail.com> writes:
> >
> > > Quoted from Linus [0]:
> > >
> > >   Since user space can randomly change their names anyway, using lock=
ing
> > >   was always wrong for readers (for writers it probably does make sen=
se
> > >   to have some lock - although practically speaking nobody cares ther=
e
> > >   either, but at least for a writer some kind of race could have
> > >   long-term mixed results
> >
> > Ugh.
> > Ick.
> >
> > This code is buggy.
> >
> > I won't argue that Linus is wrong, about removing the
> > task_lock.
> >
> > Unfortunately strscpy_pad does not work properly with the
> > task_lock removed, and buf_size larger that TASK_COMM_LEN.
> > There is a race that will allow reading past the end
> > of tsk->comm, if we read while tsk->common is being
> > updated.
>
> It appears so. Thanks for pointing it out. Additionally, other code,
> such as the BPF helper bpf_get_current_comm(), also uses strscpy_pad()
> directly without the task_lock. It seems we should change that as
> well.

Hmm. What race do you see?
If lock is removed from __get_task_comm() it probably can be removed from
__set_task_comm() as well.
And both are calling strscpy_pad to write and read comm.
So I don't see how it would read past sizeof(comm),
because 'buf' passed into __set_task_comm is NUL-terminated.
So the concurrent read will find it.

> >
> > So __get_task_comm needs to look something like:
> >
> > char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *t=
sk)
> > {
> >         size_t len =3D buf_size;
> >         if (len > TASK_COMM_LEN)
> >                 len =3D TASK_COMM_LEN;
> >         memcpy(buf, tsk->comm, len);
> >         buf[len -1] =3D '\0';
> >         return buf;
> > }
>
> Thanks for your suggestion.
>
> >
> > What shows up in buf past the '\0' is not guaranteed in the above
> > version but I would be surprised if anyone cares.
>
> I believe we pad it to prevent the leakage of kernel data. In this
> case, since no kernel data will be leaked, the following change may be
> unnecessary.

It's not about leaking of kernel data, but more about not writing
garbage past NUL.
Because comm[] is a part of some record that is used as a key
in a hash map.

