Return-Path: <linux-fsdevel+bounces-37657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3179A9F565D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 19:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219947A42A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 18:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525751F9EB3;
	Tue, 17 Dec 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHyz0DEU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF01F867D;
	Tue, 17 Dec 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460382; cv=none; b=RFRuR9Gk0N7zdcCvtnIPZw2xUqLs4NK6sX02FuHAsETWlAk1aRtBvZZzzDexZKdDckESbnuM3qiIvzFOUTZsTd681WmBrRxPyR1jqU+Aw7JPFhbtFBHwQY8iEPuaofmIsWeNHeYDT9YhEnI6+G5kPB/FC1e+HZ8r0FeUkBbwMb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460382; c=relaxed/simple;
	bh=w9pYrgnaWj1ewcUC5uehoE4l2crEY1uOPkQ5NXBYUN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAS6OTedEaWOHFzgJ+1JMqYUZe2XNwCM5hVSeMfxEBDrGWfbwRyWyfPTO0Ygmg0J3xrw4LnHxUw+GrwL6x43vn2ETb/TXAJBT1LSnxPkjjsDuSaXuvJ8MjHWvbIdieSNfv8CxhzsGseFwccHnpneVeBJSIoqVSz3grzne/Y0OPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHyz0DEU; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso777680866b.2;
        Tue, 17 Dec 2024 10:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734460378; x=1735065178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyLfj9GHrrqzTUNE0LK7GJy5olirvva9Gvx5K9CGs5s=;
        b=OHyz0DEUbcnQfj5lZk6OqzcpPnXCEt0BIcVHt+doDVf5AkqbpOdhpe/fpKQPTajjnx
         KEjfKH8Nwsuit5GUhfcD6bF78T59IUZeiLcmTF39XyuF/FA2Xc0gz7a33sQhfTOJgm6B
         k9JY+nlKM54ZIrnKEAo2Kpz8yGiz6geN8c8yHheZaZdYCif0dW10TprWPRwSqpChtrWC
         MMdNlS9e/Gl0LRSp6lAu4s0I5bjBrDaD2HIILl1UpbbwmFp6TZMwfqW3E0Ycb6ln3sWJ
         WUxQlJDuhOGoINu4Becr11+6zAGLtpZx97AfVJNalKylRptuV8Ti2JR7vi/+hA+CCTEe
         5lXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460378; x=1735065178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyLfj9GHrrqzTUNE0LK7GJy5olirvva9Gvx5K9CGs5s=;
        b=BtrasCvp6UO5WcuoRsvukEwD0gWYcT26BWbT+8XxmqtvYT12LF+PqcPZNgyxdVAYS1
         44cqNQ+OtL9Rl/erZdyC6awonazApTs5Tq8KytdAUxtiU74FJj8cefHaDnHXT9ploGOW
         d+bbUJt0TYAQUXo7ib0T3o/adnfrm6MQ1yAjviic8/s08Sxh0XGKzQonta/U08heb78l
         BAHTVU9yNJK5iupTZuMsBc3YW9TvvNAEMVCvBelcKQfbxMY4HCR34jKW/yXFLf4SqtYq
         H5Zc0hcKt9Qke036tzQyRlDzAuH3eAvXIDXSZIiFr9AXznIDk7BFWZCUCfl/Ik19pswN
         tjqA==
X-Forwarded-Encrypted: i=1; AJvYcCU5msdfgM5ftN+06RN15NpoTRO8ljGo8/d4MnyzGlfhDzlnLRyWend1SqX8V/cHvsjXhOoI+utH4mUUiV6/8w==@vger.kernel.org, AJvYcCWKEWDBF5Wg/MG1b6lc9iap9iZ5EAhwns84v2pvxJIDF5rTPTSfQ5kxaIzrdTy7ZeLMDsaRH/Gkuh5YH9iy@vger.kernel.org, AJvYcCX/aicK/z53ULR0Zs3kcVWenCERMvTMSLo/Zef5m1HXMyn86NVvrnuHiOL0RqxmJVEC80E=@vger.kernel.org, AJvYcCX9+FLGQLIRkZA2+TwVnyh7ral4ypBYFZMbK0i1xYWBb52AFpZMG7Mab5Lklroh7ZXd6is0CYnfiR3ksNT0hPo1cN/oNx6P@vger.kernel.org
X-Gm-Message-State: AOJu0YzZyXphE2xxUI0r/hU5AMijoyfVQ5fyuOGSXy+fg+VBere5LsGn
	tcT/A/bRP+IJ1a7f4uCslZWt//cYvLYiHhgIkQ5a5rtDxFL8k3cM3RoLIq0/CBgZMMN5Q99e/rw
	68AgSFP3Qg1U4IgQKBuqHZHJ9bn8=
X-Gm-Gg: ASbGnct7zDx/ScHZDdbBfx7bbwDtuRV7cDagsMtmYTKUPGXDij2iwmTJpDE4uR/IKWp
	CPexEdAfrT5dll6BTO3Go3OnQBeomUEVMrhzeJUsnvi9spuX0a+/6VMGZSGs=
X-Google-Smtp-Source: AGHT+IE0D/9Vd3yi0S/mmNzZKU8P1GTbXnQCQ7s25+McRC8HupAM0mu1u0pwKZUxm/xxqzbOI7IqDHNoKS5+GIDw2W4=
X-Received: by 2002:a05:6402:35c6:b0:5d1:2377:5af3 with SMTP id
 4fb4d7f45d1cf-5d7ee3772f8mr356233a12.5.1734460378086; Tue, 17 Dec 2024
 10:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217063821.482857-1-song@kernel.org> <20241217063821.482857-5-song@kernel.org>
 <CAADnVQKnscWKZHbWt9cgTm7NZ4ZWQkHQ+41Hz=NWoEhUjCAbaw@mail.gmail.com> <7A7A74A6-ED23-455E-A963-8FE7E250C9AA@fb.com>
In-Reply-To: <7A7A74A6-ED23-455E-A963-8FE7E250C9AA@fb.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Dec 2024 19:32:21 +0100
Message-ID: <CAP01T76SVQ=TJgkTgkvSLY3DFTDUswj_aypAWmQhwKWFBEk_yw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 4/6] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
To: Song Liu <songliubraving@meta.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Song Liu <song@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Liam Wisehart <liamwisehart@meta.com>, 
	Shankaran Gnanashanmugam <shankaran@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Dec 2024 at 19:25, Song Liu <songliubraving@meta.com> wrote:
>
> Hi Alexei,
>
> Thanks for the review!
>
> > On Dec 17, 2024, at 8:50=E2=80=AFAM, Alexei Starovoitov <alexei.starovo=
itov@gmail.com> wrote:
> >
> > On Mon, Dec 16, 2024 at 10:38=E2=80=AFPM Song Liu <song@kernel.org> wro=
te:
> >>
> >> Add the following kfuncs to set and remove xattrs from BPF programs:
> >>
> >>  bpf_set_dentry_xattr
> >>  bpf_remove_dentry_xattr
> >>  bpf_set_dentry_xattr_locked
> >>  bpf_remove_dentry_xattr_locked
> >>
> >> The _locked version of these kfuncs are called from hooks where
> >> dentry->d_inode is already locked.
> >
> > ...
> >
> >> + *
> >> + * Setting and removing xattr requires exclusive lock on dentry->d_in=
ode.
> >> + * Some hooks already locked d_inode, while some hooks have not locke=
d
> >> + * d_inode. Therefore, we need different kfuncs for different hooks.
> >> + * Specifically, hooks in the following list (d_inode_locked_hooks)
> >> + * should call bpf_[set|remove]_dentry_xattr_locked; while other hook=
s
> >> + * should call bpf_[set|remove]_dentry_xattr.
> >> + */
> >
> > the inode locking rules might change, so let's hide this
> > implementation detail from the bpf progs by making kfunc polymorphic.
> >
> > To struct bpf_prog_aux add:
> > bool use_locked_kfunc:1;
> > and set it in bpf_check_attach_target() if it's attaching
> > to one of d_inode_locked_hooks
> >
> > Then in fixup_kfunc_call() call some helper that
> > if (prog->aux->use_locked_kfunc &&
> >    insn->imm =3D=3D special_kfunc_list[KF_bpf_remove_dentry_xattr])
> >     insn->imm =3D special_kfunc_list[KF_bpf_remove_dentry_xattr_locked]=
;
> >
> > The progs will be simpler and will suffer less churn
> > when the kernel side changes.
>
> I was thinking about something in similar direction.
>
> If we do this, shall we somehow hide the _locked version of the
> kfuncs, so that the user cannot use it? If so, what's the best
> way to do it?

Just don't add BTF_ID_FLAGS entries for them.
You'd also need to make an extra call to add_kfunc_call to add its
details before you can do the fixup.
That allows find_kfunc_desc to work.
I did something similar in earlier versions of resilient locks.
In add_kfunc_call's end (instead of directly returning):
func_id =3D get_shadow_kfunc_id(func_id, offset);
if (!func_id)
  return err;
return add_kfunc_call(env, func_id, offset);

Then check in fixup_kfunc_call to find shadow kfunc id and substitute imm.
Can use some other naming instead of "shadow".
Probably need to take a prog pointer to make a decision to find the
underlying kfunc id in your case.

>
> Thanks,
> Song
>

