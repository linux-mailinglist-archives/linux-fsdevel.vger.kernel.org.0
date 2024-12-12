Return-Path: <linux-fsdevel+bounces-37115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8F19EDCDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 01:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5816C1889FCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 00:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5B51DA3D;
	Thu, 12 Dec 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIdJieHL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A83201;
	Thu, 12 Dec 2024 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964819; cv=none; b=hlAh7asY/xPYYGaCUOnsCnpP2sYUvXehXyWtQsIb0eFm+Sfp/O6Hc1J0wtfZi/2jHix1RSE8GhPYXavEYwnKICz1c6zZmB5P66QbvqpQCHDutjbuzn4VN38BkbZ6hQmfG4JkChNwZJQQ/rNcuM/iEUWRFGRyMgYOMui5ZHLGVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964819; c=relaxed/simple;
	bh=byN7WDhdPTMpRrfEUsWe2vdT3nvwPjmqUy7rdxVn538=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRi3/RHhi4GVbFc1DZBljlX3g8ccQMda+b/PWZ2tRwJZXas7j5JSZ0XMhnrUOtTBCr7vCGCU1dmwtdRBPpeaGsWp4rNM6gyD6MWHm6bucIJYCPAPqnrugOdUblKjcGJY1EZU1kz+m6aIM6dnWRmjcju9Kj9WJbqVjVuVIp5ClkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIdJieHL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43622354a3eso276955e9.1;
        Wed, 11 Dec 2024 16:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733964816; x=1734569616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKnB4XecQCWi7/usSFJOWTDJcNSr9AZUZeqZRViJV3I=;
        b=cIdJieHL3UTZUOF0ljKarlyfv9AvfhH9clyYM2A3rtbGwN0tX070Sqm5s5bTStMU2j
         GFTrRsxO21xhT3430EWQHwglX52tL7DzZn3DRNpQLBufxpVlRm0VYu1U2WMc/+jA55Lr
         qGXsRv4bF3IZPoqYgUPpxzxRgKWXcZs+HzIzAjzRuZ9DjJLqZE77lgD6hMCcizrbWr8j
         p5VvV4LR5QP/w6gjPB4r+6L8N3PmW87km/wRr6WZ35FcMpqeVB/QdTndgeU49QSFMPR1
         isUAU2g2oXPPDLtzsycOTQE8QZ869NrrJZKmP+y0rxJVUDWW07mjrNEUtau9lJf0UKI1
         Ui0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733964816; x=1734569616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKnB4XecQCWi7/usSFJOWTDJcNSr9AZUZeqZRViJV3I=;
        b=mfLCQM2+LssJy5kxhkKTCktwvchMlpCfkivPiFWTCgSeDiur4NKzQU+dFqufGNWJmE
         l+kqzTxwltOYDQVSVMMaenCJV7+nHXEkiEz236n5VjGZPSjncV6hqDOLYygAmb4A2vcR
         g+YZsa9Jz6H3QVx3gA0VExVDcYXleKuf0P4O3ZIczMWlffkZfIprf4GO4MLqFa0yeZcZ
         oD/PkknkRakz3+qE8OO88lSgTbwU5//sT07stcZ09+JDw9fLmzo2NO34ddbRzorQt/q4
         Yh3Ep1tyqI3XCJfm1gfaM4L7UqZUL5XrWAbdCmHS8ccOjNBcauU/WrbkeJBWSWNEe4aL
         vUZA==
X-Forwarded-Encrypted: i=1; AJvYcCUkKOH9VjlrVYknD2Gn8x6K1wk+jhNt7kB1jqH/hvJPt8lOPH9O/Up//cJLhixrtyJeR2NtvA/A/2EVu58SKg==@vger.kernel.org, AJvYcCWjCOT1fl3uj3sJiH1AbYmdzCnzwXkTfudowIeWKxxnaIbLMInqxNSGks7ABPIusSpZaR4=@vger.kernel.org, AJvYcCWqwL8bgYu4Qpxds3HB92lZfkNv8P638AKeKw/VDVu5iu+oWlnP/UERB5QZkJMzT+wpCe3O6yu6Ft0S7bax@vger.kernel.org
X-Gm-Message-State: AOJu0YzemwLXR+MjMiJ+nAcoGmDXbJFeeD1zCaf1MAqtL4OtG1SllZAT
	4/YDVMN/lpxi/PnDEPYOnzKhG7y9q+QcORG7AiuER8pNzIVANexodIxu/3PsrCXLdS1H2tRg4UP
	RYvqoxQZqJWJ2ISE0gIpDyW/jQsg=
X-Gm-Gg: ASbGncsqEwU6qhBgYWECMv3RUnM2HAhAYb9HDK2M/pfCfbv5AQ4uNsdSkMiMKIPe3YX
	3A8D9iSgaemJNBXxRFkYoefjKXed665wNarhMcQSAyssOTAnwKiw=
X-Google-Smtp-Source: AGHT+IH/mKsp0uN60R/gKzDmnIlqvZmGyvhQfrkTddN+zAT1YjYpi6/NHhpaljgC5NNzO2XrR4KrR4NQ1VhoEo9PuMY=
X-Received: by 2002:a05:600c:1f0d:b0:434:a923:9310 with SMTP id
 5b1f17b1804b1-4361c3c5015mr39402995e9.15.1733964815558; Wed, 11 Dec 2024
 16:53:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-eckig-april-9ffc098f193b@brauner> <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>
 <AM6PR03MB508072B5D29C8BD433AD186E993E2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB508072B5D29C8BD433AD186E993E2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Dec 2024 16:53:24 -0800
Message-ID: <CAADnVQK3toLsVLVYjGVXEuQGWUKF98OG9ogAQbJ4UeER42ZyGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for SYSCALL
 and TRACING program types
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:29=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> On 2024/12/10 18:58, Alexei Starovoitov wrote:
> > On Tue, Dec 10, 2024 at 6:43=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> >>
> >> On Tue, Dec 10, 2024 at 02:03:53PM +0000, Juntong Deng wrote:
> >>> Currently fs kfuncs are only available for LSM program type, but fs
> >>> kfuncs are generic and useful for scenarios other than LSM.
> >>>
> >>> This patch makes fs kfuncs available for SYSCALL and TRACING
> >>> program types.
> >>
> >> I would like a detailed explanation from the maintainers what it means
> >> to make this available to SYSCALL program types, please.
> >
> > Sigh.
> > This is obviously not safe from tracing progs.
> >
> >  From BPF_PROG_TYPE_SYSCALL these kfuncs should be safe to use,
> > since those progs are not attached to anything.
> > Such progs can only be executed via sys_bpf syscall prog_run command.
> > They're sleepable, preemptable, faultable, in task ctx.
> >
> > But I'm not sure what's the value of enabling these kfuncs for
> > BPF_PROG_TYPE_SYSCALL.
>
> Thanks for your reply.
>
> Song said here that we need some of these kfuncs to be available for
> tracing functions [0].
>
> If Song saw this email, could you please join the discussion?
>
> [0]:
> https://lore.kernel.org/bpf/CAPhsuW6ud21v2xz8iSXf=3DCiDL+R_zpQ+p8isSTMTw=
=3DEiJQtRSw@mail.gmail.com/
>
> For BPF_PROG_TYPE_SYSCALL, I think BPF_PROG_TYPE_SYSCALL has now
> exceeded its original designed purpose and has become a more general
> program type.
>
> Currently BPF_PROG_TYPE_SYSCALL is widely used in HID drivers, and there
> are some use cases in sched-ext (CRIB is also a use case, although still
> in infancy).

hid switched to use struct_ops prog type.
I believe syscall prog type in hid is a legacy code.
Those still present might be leftovers for older kernels.

sched-ext is struct_ops only. No syscall progs there.

> As BPF_PROG_TYPE_SYSCALL becomes more general, it would be valuable to
> make more kfuncs available for BPF_PROG_TYPE_SYSCALL.

Maybe. I still don't understand how it helps CRIB goal.

