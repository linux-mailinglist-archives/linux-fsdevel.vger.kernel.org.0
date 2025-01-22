Return-Path: <linux-fsdevel+bounces-39859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2F2A19824
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EC63A9A4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4F21519B;
	Wed, 22 Jan 2025 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFjoVkMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196062147F0;
	Wed, 22 Jan 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568788; cv=none; b=EYmUm4PpQe483hLbo34HGtEHYhhA+pOwr+ewr6z0mr71ti59xgMcrLLHJe2dZ2+bb9sNhlXZLq9oAoB20QpuqwzCnpW2tGXWaylTBekmfkpclIOlVCchHmFm8qTI8ACBkJmtSTNNIyggPnX1OgkQPFwzxaiMGXV+4j2eGULYn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568788; c=relaxed/simple;
	bh=H/gAGW5mUg9X7OZvlovBl0Z1G3QkMWlVoJ3zKYxdsiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZqyFvI7FQyb2ST/rsxgGGAX5USroc3I3c+r0YZ2ToO8w0sNEznlxV9eeF6g8MRP02JmYwuYgPQ/MdhoxscJ0Fvjzysj3C02tm/hbEjhx6EKWsvuSzlFVf4HrkbCOFPjfhc3hB48U02MTsCROkM0xm1NNttv9IHlMCXa+YHndbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFjoVkMs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso3882582f8f.0;
        Wed, 22 Jan 2025 09:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737568785; x=1738173585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjGhE/Pv/KpTN1+mcyUldkY6LGoiejB+r+xA1Qw55mo=;
        b=bFjoVkMsviBLB8XAsKNJoqx9ktKIpbKjZzd6a/2fZFWSzmTjClaLTPnzLOq5+csCCR
         w4gT40HlZFxX1GkB/7dWVgEzO7g96USaFt28r6yj3umbW0H9uiMcsgfwLlzuP753Q6Mx
         tZsHEUhyuHsMoacxNKVGeeOxhYZW6C1EwLp89YJaAzOOpLDhTLVOwkiZfShjJRB7HpeB
         eziBuc/eHBcK/vxFHawqRS2J5CiFUeW8nf4xgVXn49ILJiza0dLUIZFoB6ttGqAVifJQ
         e499TPOz1o/otRS5QI/2KrzbWkWEdNKYuiVWMH8ZnSBueT0dY2llY5PTLheA9JjnnjY1
         QWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737568785; x=1738173585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjGhE/Pv/KpTN1+mcyUldkY6LGoiejB+r+xA1Qw55mo=;
        b=hRsIXI30SeGY3lhITjHCaM7GFMpqGW4s/r+ub4PN7aobMsTEDQG7k3eGPp4K3bNRyU
         557Znud3p256Yx7x+riZ6eMC2ib3kBYao27H1cvhETszOFdyZTr3fl60S/W0sWjh+FZz
         R17pEQ4d8sH/1TXqqorx7bb3Zdy9D7xV0WxiSWtwIfURkaYGd4C9Pct1fdnayZUN+P7f
         ZUuKd9OBCiV8hr9XXsMDKX56OkvPHqAt3nWFcsXaXibFq+5Wt2w7pzfEnhnPmAv4U+Ru
         GhpEjCv2uOuozIFMkyhuWdpSAoldQUDc3tO++n/UFcjrIdlIXKu078MDz5jkfb6fLAIa
         HmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW1qiSXyfRYVULU1vO6dsI/XQ+LUPoNgTVQiBdBJyXUJYGMcdVS/DoUCM8ivTjAU8TZHtnGvuQNA34WI0N@vger.kernel.org, AJvYcCVZXLrmWIZTFSnbqnYYu7ajYcSrOD2yik79OIfX6pIoqoD61vWXOGll0sFwsgVpyZFYXobuI/w5DQEhtm4lyQ==@vger.kernel.org, AJvYcCW6f4MeIBluluVW7y8yXELyKu5vaVgrmCddfaB8F3teESVoFQmMEgeNuHNdpq7fTNuqbyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTQtcrfmTHxTY7aM04ovvlBkasVsZEXJzTx4q24UqufgrCzXu
	XOHvEVHkKvjBqT0arFAFS14iHVWZ/HmfWxb0SefVMiwYT+eMd3kB3c2X5sTkqhodKcfv5qZhWGR
	RWE7+lcXhd0+gf6GZ+MQ7UiTuGNo=
X-Gm-Gg: ASbGncuBGwRzAVpy2cp4zAqvrH49rWSNKsNdzhdJ+79R9yicAhMt6al+YMTTHDtZP0T
	f7v2GXn8NsBZvO771rso48XCo4vlQeXqh7CrDcb0ch7CwxSNzk52kjaJCoCKq90PCFU3sxLbcUi
	c4oLC1tPs=
X-Google-Smtp-Source: AGHT+IFxCXkzhpwgpdx7eCvc2wDO2gfqmMA00YgIOs2a9LuaEY3zZyJrEdtNsS/9JrQr9Bk+OHjxwKHXZd2HupYDbL8=
X-Received: by 2002:a5d:614b:0:b0:385:f13c:570f with SMTP id
 ffacd0b85a97d-38bf57a1e51mr17279523f8f.33.1737568785087; Wed, 22 Jan 2025
 09:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50806C5D9B5314E55D4204A499E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLk6w+AkpoWERoid54xZh_FeiV0q1_sVU2o-oMBkP2Y7w@mail.gmail.com> <AM6PR03MB5080CDA2F6336B1BA2FDF2C199E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5080CDA2F6336B1BA2FDF2C199E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Jan 2025 09:59:34 -0800
X-Gm-Features: AWEUYZkWeDZQredRuCv2R--gyu_IN3k2c_gHpYLrL79tHyNkx1ZN0P2rvqIGFls
Message-ID: <CAADnVQKkaWkSHLapcUe83YQcmhO+S=2w+1rB_NzUbt=TOW9WFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/5] bpf: Make fs kfuncs available for SYSCALL
 program type
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 5:34=E2=80=AFAM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> On 2025/1/22 00:43, Alexei Starovoitov wrote:
> > On Tue, Jan 21, 2025 at 5:09=E2=80=AFAM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>
> >> Currently fs kfuncs are only available for LSM program type, but fs
> >> kfuncs are generic and useful for scenarios other than LSM.
> >>
> >> This patch makes fs kfuncs available for SYSCALL program type.
> >>
> >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >> ---
> >>   fs/bpf_fs_kfuncs.c                                 | 14 ++++++------=
--
> >>   .../selftests/bpf/progs/verifier_vfs_reject.c      | 10 ----------
> >>   2 files changed, 6 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> >> index 4a810046dcf3..8a7e9ed371de 100644
> >> --- a/fs/bpf_fs_kfuncs.c
> >> +++ b/fs/bpf_fs_kfuncs.c
> >> @@ -26,8 +26,6 @@ __bpf_kfunc_start_defs();
> >>    * acquired by this BPF kfunc will result in the BPF program being r=
ejected by
> >>    * the BPF verifier.
> >>    *
> >> - * This BPF kfunc may only be called from BPF LSM programs.
> >> - *
> >>    * Internally, this BPF kfunc leans on get_task_exe_file(), such tha=
t calling
> >>    * bpf_get_task_exe_file() would be analogous to calling get_task_ex=
e_file()
> >>    * directly in kernel context.
> >> @@ -49,8 +47,6 @@ __bpf_kfunc struct file *bpf_get_task_exe_file(struc=
t task_struct *task)
> >>    * passed to this BPF kfunc. Attempting to pass an unreferenced file=
 pointer, or
> >>    * any other arbitrary pointer for that matter, will result in the B=
PF program
> >>    * being rejected by the BPF verifier.
> >> - *
> >> - * This BPF kfunc may only be called from BPF LSM programs.
> >>    */
> >>   __bpf_kfunc void bpf_put_file(struct file *file)
> >>   {
> >> @@ -70,8 +66,6 @@ __bpf_kfunc void bpf_put_file(struct file *file)
> >>    * reference, or else the BPF program will be outright rejected by t=
he BPF
> >>    * verifier.
> >>    *
> >> - * This BPF kfunc may only be called from BPF LSM programs.
> >> - *
> >>    * Return: A positive integer corresponding to the length of the res=
olved
> >>    * pathname in *buf*, including the NUL termination character. On er=
ror, a
> >>    * negative integer is returned.
> >> @@ -184,7 +178,8 @@ BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
> >>   static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> >>   {
> >>          if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> >> -           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> >> +           prog->type =3D=3D BPF_PROG_TYPE_LSM ||
> >> +           prog->type =3D=3D BPF_PROG_TYPE_SYSCALL)
> >>                  return 0;
> >>          return -EACCES;
> >>   }
> >> @@ -197,7 +192,10 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc=
_set =3D {
> >>
> >>   static int __init bpf_fs_kfuncs_init(void)
> >>   {
> >> -       return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kf=
unc_set);
> >> +       int ret;
> >> +
> >> +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_k=
func_set);
> >> +       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,=
 &bpf_fs_kfunc_set);
> >>   }
> >>
> >>   late_initcall(bpf_fs_kfuncs_init);
> >> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b=
/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> >> index d6d3f4fcb24c..5aab75fd2fa5 100644
> >> --- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> >> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> >> @@ -148,14 +148,4 @@ int BPF_PROG(path_d_path_kfunc_invalid_buf_sz, st=
ruct file *file)
> >>          return 0;
> >>   }
> >>
> >> -SEC("fentry/vfs_open")
> >> -__failure __msg("calling kernel function bpf_path_d_path is not allow=
ed")
> >> -int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct fil=
e *f)
> >> -{
> >> -       /* Calling bpf_path_d_path() from a non-LSM BPF program isn't =
permitted.
> >> -        */
> >> -       bpf_path_d_path(path, buf, sizeof(buf));
> >> -       return 0;
> >> -}
> >
> > A leftover from previous versions?
> > This test should still be rejected by the verifier.
>
> Thanks for your reply.
>
> Not a leftover.
>
> bpf_path_d_path can be called from SYSCALL program type, not only LSM
> program type, so it seems a bit weird to keep this test case?

How is it weird?
How is this related to syscall prog?
It's a check that fentry prog cannot call it.

