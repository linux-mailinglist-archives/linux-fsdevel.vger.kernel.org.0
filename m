Return-Path: <linux-fsdevel+bounces-38762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD3A08230
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 22:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432C83A5119
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2386204C15;
	Thu,  9 Jan 2025 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URwMaejJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F284A1A;
	Thu,  9 Jan 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457904; cv=none; b=LUGENqjoCSaADeqjMUD5IYQprN49zAWoz0tHt5AgtmN4OfuHiiTCvdIo8/JHQxXhGCACgRTEDXcS8zGMBKtR/Vkm2WEwD2Ou3VA992jd0pMYgRTDieMcQjJ0PFZTus+jmMAoL+cNRGXghINK+QdjSxMHZAHLPJ9ebWs7itdE3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457904; c=relaxed/simple;
	bh=1yJ0e5/OwEoC8r0HyVkyQRZkVvS3sFqIOYejRPMNS6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+tYYhfHIdezcmZeRDqUOAysa9b0L3jzhBCj7zLgkW6JWuJAh3OsyDtvCiK0t1It3GBAHQ0KuG8AkbWzUP4CTopxdy630CJ+8b9PFzUjeUOKqurO2vaf4nHCIFp0FBYyuOtGuKTM5NDtiQhQotCm8HJ0ynOis2T1r19vL2us5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URwMaejJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4368a293339so16672785e9.3;
        Thu, 09 Jan 2025 13:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736457901; x=1737062701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOoR/8Dr4be46fIaMOo0H5NYBvd9peocu0o/2tt3jDk=;
        b=URwMaejJTUmDrh08NcjKQOvS9RmUJfStY0WqhKwoXibAoMawRaxHmlqlyXdZh4wLT+
         c/2MbjIl32+AyxdaKuqbreSMhEtF9zmrHgoesSmnnVHVVGRduJBdjQvtKZMf2O+Xo4ED
         AX1vehDAOxYNYfgtdarYyewmI39BJhIcg0+r8LzOZgv6BzQTXOYU7bocxiY9YysBvDES
         fx/EpHDAjrCwJnqx9fVngH78MjsgDf2uXgkV74UnrxSRoI+GELhKo4XEl/E27aSvKH+0
         lTdwiwcCD1M4pQV32kI5l/h7Xnc7iBAKiufLFsoC2aThAuJlNbHXK2vKpol71zfsGlHb
         UOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736457901; x=1737062701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOoR/8Dr4be46fIaMOo0H5NYBvd9peocu0o/2tt3jDk=;
        b=DDzovI2WUFDiYno6fCfWolw5raxU8XaWV4OoGmroaB5wuwseEoGzbqujVXn2lDUae9
         Pg28g7Gax7cjO6sDC9y0VXoV83AW14Fkp5PilL1xlOojcIiXR+PwX+Pogbdb7l6AfMYb
         Ss1GKzxpnHWAZN9G2Q9kUxjznqrkIX8E5b7wbWjKFWZOZ+IaGQgNpBONAgN7m/1pp0Uk
         XU1kZn5Jb/gZ8pyiWyp+kN/absKXN4X5eBRUP9jRi7CzkKWyal2czQOQy7IW/sIQ3W72
         Yn/+RKw9L6qVYu80OgfELjj4WLqJaWuFWwz7UQu9u5vsCjTu8gr/77ocMpdbe2Ezrjuk
         F3yg==
X-Forwarded-Encrypted: i=1; AJvYcCUsGzRhnrsuAksi8ENtEUMW10ekagMJm9G+2Tr3pdm50lOC7dD+acd+eI0n3lsOnqIPe1opUkyxpGh6sYifsw==@vger.kernel.org, AJvYcCWWQdHfosrKRzmoY74QopL98g2Pkvuy7BoglPRxlJvfmp0Nep/5mTj8Rl7/541qGm2hWw8=@vger.kernel.org, AJvYcCXcXpdZ8rl3hmsEqVxOmR5hC5ToP2NQ7kw1raxXSNAjwXSc03zKqhmcfJfGdxtj3iz1dbd9t+5rcx0texCB@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJ0we726AQ7r3t0kFPNMwNJYKSy85/wVdNlKRk13ZAmHNIsPj
	UMQ1wGgwPGnhu3mSKivi7MQEwG5FkjSRshLfRdjNQhp/YN7UrHp+N+kzjBNqu6LVLf4AcNC7jVR
	fPF8Mcq6wXNzthAgPbFp3fDp3Egk=
X-Gm-Gg: ASbGncugPY0/ag18/wNYa1U9QF4mBCJTpUZY8KUv0Brw4QcdMQpo5cjQk62tUihaXdb
	Lm4mSyk8Li+SfQ4LndYal5n3LPOJSs9pVRCTgDBeF1gfpb/fCvzSqcA==
X-Google-Smtp-Source: AGHT+IHJ0V/n5o1F+xqBQZUEAU3zS+MYembnTZnKtAXpXggJBdYNpoW6u7txZP4/rz21wvZfcsxLguOP/iBJp4N8WZM=
X-Received: by 2002:a05:6000:1fa2:b0:38a:1b94:ecc1 with SMTP id
 ffacd0b85a97d-38a8730afbcmr6591505f8f.25.1736457900374; Thu, 09 Jan 2025
 13:25:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080E0DFE4F9BAFFDB9D113B99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLU=W7fuEQommfDYrxr9A2ESV7E3uUAm4VUbEugKEZbkQ@mail.gmail.com>
 <AM6PR03MB50805EAC8B42B0570A2F76B399032@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQJYVLEs8zr414j1xRZ_DAAwcxiCC-1YqDOt8oF13Wf6zw@mail.gmail.com> <CAPhsuW7KYss11bQpJo-1f7Pdpb=ky2QWQ=zoJuX3buYm1_nbFA@mail.gmail.com>
In-Reply-To: <CAPhsuW7KYss11bQpJo-1f7Pdpb=ky2QWQ=zoJuX3buYm1_nbFA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Jan 2025 13:24:49 -0800
X-Gm-Features: AbW1kvbqazBD03N0bYLLZAUTuDNucNUn9KUDnF0X-bYFOrpMFmAfMp1FBqoeOvs
Message-ID: <CAADnVQ+_ViQ6GLgscTLuWnsuhS8eajNSDG3jpTAjYWUoDBJvTg@mail.gmail.com>
Subject: Re: per st_ops kfunc allow/deny mask. Was: [PATCH bpf-next v6 4/5]
 bpf: Make fs kfuncs available for SYSCALL program type
To: Song Liu <song@kernel.org>
Cc: Juntong Deng <juntong.deng@outlook.com>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 12:49=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Jan 9, 2025 at 11:24=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Dec 23, 2024 at 4:51=E2=80=AFPM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> > >
> > > >
> > > > The main goal is to get rid of run-time mask check in SCX_CALL_OP()=
 and
> > > > make it static by the verifier. To make that happen scx_kf_mask fla=
gs
> > > > would need to become KF_* flags while each struct-ops callback will
> > > > specify the expected mask.
> > > > Then at struct-ops prog attach time the verifier will see the expec=
ted mask
> > > > and can check that all kfuncs calls of this particular program
> > > > satisfy the mask. Then all of the runtime overhead of
> > > > current->scx.kf_mask and scx_kf_allowed() will go away.
> > >
> > > Thanks for pointing this out.
> > >
> > > Yes, I am interested in working on it.
> > >
> > > I will try to solve this problem in a separate patch series.
> > >
> > >
> > > The following are my thoughts:
> > >
> > > Should we really use KF_* to do this? I think KF_* is currently more
> > > like declaring that a kfunc has some kind of attribute, e.g.
> > > KF_TRUSTED_ARGS means that the kfunc only accepts trusted arguments,
> > > rather than being used to categorise kfuncs.
> > >
> > > It is not sustainable to restrict the kfuncs that can be used based o=
n
> > > program types, which are coarse-grained. This problem will get worse
> > > as kfuncs increase.
> > >
> > > In my opinion, managing the kfuncs available to bpf programs should b=
e
> > > implemented as capabilities. Capabilities are a mature permission mod=
el.
> > > We can treat a set of kfuncs as a capability (like the various curren=
t
> > > kfunc_sets, but the current kfunc_sets did not carefully divide
> > > permissions).
> > >
> > > We should use separate BPF_CAP_XXX flags to manage these capabilities=
.
> > > For example, SCX may define BPF_CAP_SCX_DISPATCH.
> > >
> > > For program types, we should divide them into two levels, types and
> > > subtypes. Types are used to register common capabilities and subtypes
> > > are used to register specific capabilities. The verifier can check if
> > > the used kfuncs are allowed based on the type and subtype of the bpf
> > > program.
> > >
> > > I understand that we need to maintain backward compatibility to
> > > userspace, but capabilities are internal changes in the kernel.
> > > Perhaps we can make the current program types as subtypes and
> > > add 'types' that are only used internally, and more subtypes
> > > (program types) can be added in the future.
> >
> > Sorry for the delay.
> > imo CAP* approach doesn't fit.
> > caps are security bits exposed to user space.
> > Here there is no need to expose anything to user space.
> >
> > But you're also correct that we cannot extend kfunc KF_* flags
> > that easily. KF_* flags are limited to 32-bit and we're already
> > using 12 bits.
> > enum scx_kf_mask needs 5 bits, so we can squeeze them into
> > the current 32-bit field _for now_,
> > but eventually we'd need to refactor kfunc definition into a wider set:
> > BTF_ID_FLAGS(func, .. KF_*)
> > so that different struct_ops consumers can define their own bits.
> >
> > Right now SCX is the only st_ops consumer who needs this feature,
> > so let's squeeze into the existing KF facility.
> >
> > First step is to remap scx_kf_mask bits into unused bits in KF_
> > and annotate corresponding sched-ext kfuncs with it.
> > For example:
> > SCX_KF_DISPATCH will become
> > KF_DISPATCH (1 << 13)
> >
> > and all kfuncs that are allowed to be called from ->dispatch() callback
> > will be annotated like:
> > - BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
> > - BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
> > - BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
> > + BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
> > + BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_DISPATCH)
> > + BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_DISPATCH)
> >
> >
> > For sched_ext_ops callback annotations, I think,
> > the simplest approach is to add special
> > BTF_SET8_START(st_ops_flags)
> > BTF_ID_FLAGS(func, sched_ext_ops__dispatch, KF_DISPATCH)
> > and so on for other ops stubs.
> >
> > sched_ext_ops__dispatch() is an empty function that
> > exists in the vmlinux, and though it's not a kfunc
> > we can use it to annotate
> > (struct sched_ext_ops *)->dispatch() callback
> > with a particular KF_ flag
> > (or a set of flags for SCX_KF_RQ_LOCKED case).
> >
> > Then the verifier (while analyzing the program that is targeted
> > to be attach to this ->dispatch() hook)
> > will check this extra KF flag in st_ops
> > and will only allow to call kfuncs with matching flags:
> >
> > if (st_ops->kf_mask & kfunc->kf_mask) // ok to call kfunc from this cal=
lback
> >
> > The end result current->scx.kf_mask will be removed
> > and instead of run-time check it will become static verifier check.
>
> Shall we move some of these logics from verifier core to
> btf_kfunc_id_set.filter()? IIUC, this would avoid using extra
> KF_* bits. To make the filter functions more capable, we
> probably need to pass bpf_verifier_env into the filter() function.

Passing env is probably unnecessary,
but if save 'moff':
  const struct btf_type *t,
  const struct btf_member *member,
  u32 moff =3D __btf_member_bit_offset(t, member) / 8;

after successful check_struct_ops_btf_id() somewhere in prog->aux
then btf_kfunc_id_set.filter() can indeed do
moff =3D=3D offsetof(struct sched_ext_ops, dispatch)
 allow kfuncs suitable for dispatch.

