Return-Path: <linux-fsdevel+bounces-40427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF3AA23508
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6080E164526
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1AF1F1306;
	Thu, 30 Jan 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRlkk74m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A64A35;
	Thu, 30 Jan 2025 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738268648; cv=none; b=kjPkUmAuIT9uYCvbuNabB8BxXMUDAigEOWQy4FouJtKF4NtyPmt0tEQBE5MJ0mvHyd5yAYwPISYiikmf7cK240BYaJClMtB3NFl+nwcqmHWSAtoaBYBXYPvwQKbWnRWQGH2IDNx5HPkD6ThxDLE/x252QMzHD5QZtByiOl2oYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738268648; c=relaxed/simple;
	bh=fcVzhnqBbO27IvJ9WownzhHG6Rj7fo3UL/gsFbTqje8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P71VBgco/v+hGabtWrLAkHFGKWLDuQryCcojLK+C/ajPAhjxRB6mec1bQRpSzPumasaUrfkrqjxYjLHc8oGQmv1b9E8BgbabFKJEQ3kaxCArS2M6ooUZbsnoCpV2MM/We0uj79NLGUCy0/unS3BAIV7/BTKJxLWmrLkkChlQceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRlkk74m; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863703258fso1539443f8f.1;
        Thu, 30 Jan 2025 12:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738268645; x=1738873445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV+2ASZNLztOoZlL3PTiOudYi7XA5OszIeYYPdoNj+s=;
        b=DRlkk74mTF2GsGqMXSpR3vj+j3M/9ui1TPBZ03yf7xw+0/2fxHBkHM9HTESULhy2Lt
         oGirF3yzJUaX9Lhl7Ze8u5newYzMOBsWE5TUoW63KPjjQWUnS4oQ1jkR3P1RRTBIGAdI
         XdLB3tUyyINzmzf1jKfhjmwBpGwhaS8qDxu5k7Xz9dDz29Pd00xkxSMuWhpw22evVOVM
         EKxHQgj+mq8jBSxya12rLOh8mhfWQ6ZCANzkKG/34VVnlj6nix/MTKER43930Yk0Hnl6
         cReEfxPkG9/JgpNV/EEIeXxpLl318LvksfeuI0AxTpUXBE14rFsAmvb4qwJUwfr2vsNK
         STWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738268645; x=1738873445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xV+2ASZNLztOoZlL3PTiOudYi7XA5OszIeYYPdoNj+s=;
        b=xQ/sq/6Y9oFo7PKDs0D6LYcrfwuNt1sLhgwjWDhb/jfdAQ3cG7QB8UK+LWrEgZUOGb
         IDpsTBEO5fOjq+dwum0YOd8txWRbs7wyn7GX33kOKOhU58Xkn/LSCb/r24Hw7erhXk81
         A55po8g9Hmz0GdXC0MoCRf4u4mxiJ+9oJxodRDqUOk6vHkBtXFk46gAJ+P0nsJBU4U7o
         k3b7YKFu6bU5M40mvnADRtVqon2MpbtNiTUL6E3nOaZ9BtVv65Fd8f+F3ss34JH6H10y
         bGQYHvTtSZO5tZNVAP++Qoi7GWKtYGXILXIQkWPyLXhzIP0G1HdXF3HzxTxqwUcyKW77
         1ZKw==
X-Forwarded-Encrypted: i=1; AJvYcCU1wvFisYK7oYSYbgLIRbqVtFND+MsM9AxbJmb9wsnp08sSDJ/OHwm6pNinWCvnna2/Z+4twW065d/oclwP@vger.kernel.org, AJvYcCVdKAzWMbp2crW+WZvkxHftAsVHpYgBCiAYtwrU0+bNdMbxd58LA/WxOsi8u+0JONV+bRoTcGl/FoMrYBcXSw==@vger.kernel.org, AJvYcCVwUie2uFVjP/uv7jKuTdhGEaiAP9NHox78ybMXXqhWTTrwtvAbVl3xMMLj4Cfu/7niGYP49TTJAkh1APuic6gDaGEkyIZb@vger.kernel.org, AJvYcCWDcrXvAOPnS+hJ9DxWl6B/y6tshmjnWa1aFs3Wx/528ofgmnO8e1eWXqz85fXDgc6Lg8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywng7m4FgNZCIhp/saYcKr7JWikwIlU2F7CgKAHWqTfsMBpqmSL
	Me/s/Hf6lG3TKo5M/dJad804Gqr8MI1WffEalaaPvMqdO941NkuyXUc8GD0B+xyK9ix5jmn7/kI
	gWptx0TBAsmgEjvYALy0D7uCe7vc=
X-Gm-Gg: ASbGncsiEsg/yxDAh9kVdKIWNI/SszDOQFrI5atVuJ1xGT2wzaP4Lx9w/pn7/8K58Zc
	alCA6cfk7PDuji+wRF8uBXca5IK10GO/9ZMQojRUSRw6ys2lE3F+l/K4/Q0/yb1GYWafjuuQR
X-Google-Smtp-Source: AGHT+IFY02Fh9zFX1R5GIBuszCAimxxCsMAyxTddZA8UoFzTX5lo9Jl4O/3oYK9N+WgwYxNJeKpaVeeATA8PccpYr4g=
X-Received: by 2002:a05:6000:1a85:b0:38b:ee01:a5b with SMTP id
 ffacd0b85a97d-38c5a98de08mr4507429f8f.15.1738268644516; Thu, 30 Jan 2025
 12:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129205957.2457655-1-song@kernel.org> <20250129205957.2457655-6-song@kernel.org>
 <CAADnVQ+1Woq_mh_9iz+Dhdhw1TuXZgVrx38+aHn-bGZBVa5_uw@mail.gmail.com> <58833120-DD06-4024-B7F5-E255AC9261E6@fb.com>
In-Reply-To: <58833120-DD06-4024-B7F5-E255AC9261E6@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Jan 2025 12:23:53 -0800
X-Gm-Features: AWEUYZkkB50lvEISP2yfaCc8Z9aDGSq3hqMxf2vZ8lIYrimfx1QglBOlzd77btw
Message-ID: <CAADnVQLa97RqLONmcrfBWckGRWD+OKOFY0FMEu4_pSsoALtdgQ@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic
 for bpf_dynptr_from_skb
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Liam Wisehart <liamwisehart@meta.com>, 
	Shankaran Gnanashanmugam <shankaran@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 9:49=E2=80=AFAM Song Liu <songliubraving@meta.com> =
wrote:
>
> Hi Alexei,
>
> Thanks for the review!
>
> > On Jan 29, 2025, at 6:32=E2=80=AFPM, Alexei Starovoitov <alexei.starovo=
itov@gmail.com> wrote:
>
> [...]
>
> >>
> >> +BTF_ID_LIST(bpf_dynptr_from_skb_list)
> >> +BTF_ID(func, bpf_dynptr_from_skb)
> >> +BTF_ID(func, bpf_dynptr_from_skb_rdonly)
> >> +
> >> +static u32 bpf_kfunc_set_skb_remap(const struct bpf_prog *prog, u32 k=
func_id)
> >> +{
> >> +       if (kfunc_id !=3D bpf_dynptr_from_skb_list[0])
> >> +               return 0;
> >> +
> >> +       switch (resolve_prog_type(prog)) {
> >> +       /* Program types only with direct read access go here! */
> >> +       case BPF_PROG_TYPE_LWT_IN:
> >> +       case BPF_PROG_TYPE_LWT_OUT:
> >> +       case BPF_PROG_TYPE_LWT_SEG6LOCAL:
> >> +       case BPF_PROG_TYPE_SK_REUSEPORT:
> >> +       case BPF_PROG_TYPE_FLOW_DISSECTOR:
> >> +       case BPF_PROG_TYPE_CGROUP_SKB:
> >
> > This copy pastes the logic from may_access_direct_pkt_data(),
> > so any future change to that helper would need to update
> > this one as well.
>
> We can probably improve this with some helpers/macros.
>
> >
> >> +               return bpf_dynptr_from_skb_list[1];
> >
> > The [0] and [1] stuff is quite error prone.
> >
> >> +
> >> +       /* Program types with direct read + write access go here! */
> >> +       case BPF_PROG_TYPE_SCHED_CLS:
> >> +       case BPF_PROG_TYPE_SCHED_ACT:
> >> +       case BPF_PROG_TYPE_XDP:
> >> +       case BPF_PROG_TYPE_LWT_XMIT:
> >> +       case BPF_PROG_TYPE_SK_SKB:
> >> +       case BPF_PROG_TYPE_SK_MSG:
> >> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> >> +               return kfunc_id;
> >> +
> >> +       default:
> >> +               break;
> >> +       }
> >> +       return bpf_dynptr_from_skb_list[1];
> >> +}
> >> +
> >> static const struct btf_kfunc_id_set bpf_kfunc_set_skb =3D {
> >>        .owner =3D THIS_MODULE,
> >>        .set =3D &bpf_kfunc_check_set_skb,
> >> +       .hidden_set =3D &bpf_kfunc_check_hidden_set_skb,
> >
> > If I'm reading it correctly the hidden_set serves no additional purpose=
.
> > It splits the set into two, but patch 4 just adds them together.
>
> hidden_set does not have BTF_SET8_KFUNCS, so pahole will not export
> these kfuncs to vmlinux.h.
>
> >
> >> +       .remap =3D &bpf_kfunc_set_skb_remap,
> >
> > I'm not a fan of callbacks in general.
> > The makes everything harder to follow.
>
> This motivation here is to move polymorphism logic from verifier
> core to kfuncs owners. I guess we will need some callback to
> achieve this goal. Of course, we don't have to do it in this set.
>
>
> > For all these reasons I don't like this approach.
> > This "generality" doesn't make it cleaner or easier to extend.
> > For the patch 6... just repeat what specialize_kfunc()
> > currently does for dynptr ?
>
> Yes, specialize_kfunc() can handle this. But we will need to use
> d_inode_locked_hooks from 6/7 in specialize_kfunc(). It works,
> but it is not clean (to me).

I'm missing why that would be necessary to cross the layers
so much. I guess the code will tell.
Pls send an rfc to illustrate the unclean part.

> I will revise this set so that the polymorphism logic in handled
> in specialize_kfunc(). For longer term, maybe we should discuss
> "move some logic from verifier core to kfuncs" in the upcoming
> LSF/MM/BPF?

imo such topic is too narrow and detail oriented.
There is not much to gain from discussing it at lsfmm.
email works well for such discussions.

