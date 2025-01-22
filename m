Return-Path: <linux-fsdevel+bounces-39809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F7A18912
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 01:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A1D7A4442
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 00:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E242AA5;
	Wed, 22 Jan 2025 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adogl/c3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543917BA2;
	Wed, 22 Jan 2025 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737506654; cv=none; b=B+B3S7AbIymEB3txbz8rYHjrrrVMRWxuxt4yUv6ciFEnUOdn/ecCp6JcQs1yIZVdnLPB2XqfdHG06cMRCjFo1F5EvV/79Pd9/ZunhrPIUcc75amo//DikiJLx9aaBuQsjQZ9d+mRRwWxvxBHtdZkiWKstuG6tdM7mfmNxU3P3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737506654; c=relaxed/simple;
	bh=bHrkhl9T8OM/4LzjT2l3HaGzlPn+DxogdOXXkY9iDhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByFPlcJvHpV2kPCIeGvWednOKwkvJXxDlTPVnEviD6tQ8Vl8dcnHx0ZOe2HkHP5bpJBc6wBqJIYfWfC8rEYae+Jvn0Q4Tz6n1hrA6mwtf/TfMAp1S7PC71ew2d1PyW7QcUu1KlG7REV+Jd03dTdbDsuk/VvRzyH/I/rN0ayfMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Adogl/c3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436341f575fso69472435e9.1;
        Tue, 21 Jan 2025 16:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737506650; x=1738111450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4R81WZYHwRRJmKdu7KdOG2Sv4xkPqtcKbni1I78ENU=;
        b=Adogl/c3OcynqqcDxcnHZ11ZMDXMM4FiW7M59PNniPCJoC5SSuWNdB8xGYvpcVo5tE
         zoTdmhMlnCw+i6JHPh4dc2oQOjKFaEZZagUZ4RNPM4VXwr4K0L9DM3HmRIuoeHLe3W6h
         nc1KNTEhsuPlmj07B6eGJY8D7i+8DUqfbBhKyN8eC4JqYERnhSDQ+ydbLMWrQcbZt8LH
         lje8zG7XAy0Rs6PRqobSnwpVvxx+n+2UORMi42AAE/hYIgruWnKmY+4oSmuBNjQgWqIM
         dMB+qaF5TZmr6O3xP8dUR/0zAekl82K0m6NmksEmdp8YHRn610lnUhVkVzYBLGH8PT1r
         Ty9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737506650; x=1738111450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4R81WZYHwRRJmKdu7KdOG2Sv4xkPqtcKbni1I78ENU=;
        b=RIQMCN5bqJkvsgJQHK3AXn7Yiy5V8c9qqQHuSuubqH6nzI4+xm25YJyCHhbNmSz0hH
         2bthvKhTvS6H+kAxB399rGXaRGz+dIf7/bFepZjpzz45+EwJKPxeOG4+yQ1IGr1uVJip
         Aef1FvcY/D6Rpq4QdFMVBTUt4C0Ejb/FzpTklYVG1VK9Ida7+ntW2HIYde+kDSSrH3p5
         bLShLkACoDiepYVDp5UfBme4iiGlnZ5fT8Rzm2Fta7Vg5UN7T/M1avl/Q2lC6WviPl/h
         esASOeR8oAgStx9eZ5ZJaYrguSVC2MYIs3vCiGYzS8H49gpcbKg8m1AqEki4Bo/MM5H1
         uJmA==
X-Forwarded-Encrypted: i=1; AJvYcCUwhBhXNESLrG/6BYkVD9Vi5AMtWnvK0z205TTEhPOQfsYkNW5wuHZtegGVGOeVn23ErRwYXVIhyM7JjSZh/A==@vger.kernel.org, AJvYcCWFr4gO9zYTF7HOtkwmUzZ2Z1DHsRE4gbqyaV5YH38EwfEVqGRjgrfYPwnEp9ywTuRErRRV0oXhCT7JBzs+@vger.kernel.org, AJvYcCWp7UPMoFsbUkRbOyp/qfLBG+Gn2pX8DtBCUzYd9L5NYwzoeRE2ZmA0+PpiI5QpwvQhVeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8FoF7CAzVCPfYP58ymK7S/nKFNGPGW2tDMdAYl2zpWYEdrLY
	FMw7HYwzKBqyg1CimVhHj+jl1JiRAavX9CRbQWdbntejeWDOW2vXp8dcnxM1pKDC3LqP6vy3oeO
	c5BuKQib8f40EcwijS4G64kKjZwM=
X-Gm-Gg: ASbGncvixFJJHfAH2f5svlGjoJNczW89GjydRKjwRQspfNqcV+nfwfk1JuDfPzfV4Ku
	6nKaDIBOIW90aXpAx2KMAu7yy0ylZmLAfoCuiFZZKGw1gIV40Xrx7Z66GPPKc3VDqQ5Td+rLl08
	rPbzehCsM=
X-Google-Smtp-Source: AGHT+IEEKwyzfXKUc4b9e8LFNOvjsybVi9uCE47AFpHQRzIdQNOeCiOUsTOnv2HivtJMPQWkUhNNMQ9gOBSPV55lW7I=
X-Received: by 2002:adf:f48c:0:b0:385:f996:1b8e with SMTP id
 ffacd0b85a97d-38bf5659a94mr15406679f8f.16.1737506650271; Tue, 21 Jan 2025
 16:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50806C5D9B5314E55D4204A499E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB50806C5D9B5314E55D4204A499E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Jan 2025 16:43:59 -0800
X-Gm-Features: AbW1kvbeUP-oYfk3F8-ZGfSsh6jW_eY-R2uftHwYT1pCbWeFVLAlklm0dLw_LfI
Message-ID: <CAADnVQLk6w+AkpoWERoid54xZh_FeiV0q1_sVU2o-oMBkP2Y7w@mail.gmail.com>
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

On Tue, Jan 21, 2025 at 5:09=E2=80=AFAM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> Currently fs kfuncs are only available for LSM program type, but fs
> kfuncs are generic and useful for scenarios other than LSM.
>
> This patch makes fs kfuncs available for SYSCALL program type.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  fs/bpf_fs_kfuncs.c                                 | 14 ++++++--------
>  .../selftests/bpf/progs/verifier_vfs_reject.c      | 10 ----------
>  2 files changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 4a810046dcf3..8a7e9ed371de 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -26,8 +26,6 @@ __bpf_kfunc_start_defs();
>   * acquired by this BPF kfunc will result in the BPF program being rejec=
ted by
>   * the BPF verifier.
>   *
> - * This BPF kfunc may only be called from BPF LSM programs.
> - *
>   * Internally, this BPF kfunc leans on get_task_exe_file(), such that ca=
lling
>   * bpf_get_task_exe_file() would be analogous to calling get_task_exe_fi=
le()
>   * directly in kernel context.
> @@ -49,8 +47,6 @@ __bpf_kfunc struct file *bpf_get_task_exe_file(struct t=
ask_struct *task)
>   * passed to this BPF kfunc. Attempting to pass an unreferenced file poi=
nter, or
>   * any other arbitrary pointer for that matter, will result in the BPF p=
rogram
>   * being rejected by the BPF verifier.
> - *
> - * This BPF kfunc may only be called from BPF LSM programs.
>   */
>  __bpf_kfunc void bpf_put_file(struct file *file)
>  {
> @@ -70,8 +66,6 @@ __bpf_kfunc void bpf_put_file(struct file *file)
>   * reference, or else the BPF program will be outright rejected by the B=
PF
>   * verifier.
>   *
> - * This BPF kfunc may only be called from BPF LSM programs.
> - *
>   * Return: A positive integer corresponding to the length of the resolve=
d
>   * pathname in *buf*, including the NUL termination character. On error,=
 a
>   * negative integer is returned.
> @@ -184,7 +178,8 @@ BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
>  {
>         if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> -           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> +           prog->type =3D=3D BPF_PROG_TYPE_LSM ||
> +           prog->type =3D=3D BPF_PROG_TYPE_SYSCALL)
>                 return 0;
>         return -EACCES;
>  }
> @@ -197,7 +192,10 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_se=
t =3D {
>
>  static int __init bpf_fs_kfuncs_init(void)
>  {
> -       return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc=
_set);
> +       int ret;
> +
> +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfun=
c_set);
> +       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &b=
pf_fs_kfunc_set);
>  }
>
>  late_initcall(bpf_fs_kfuncs_init);
> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/to=
ols/testing/selftests/bpf/progs/verifier_vfs_reject.c
> index d6d3f4fcb24c..5aab75fd2fa5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> @@ -148,14 +148,4 @@ int BPF_PROG(path_d_path_kfunc_invalid_buf_sz, struc=
t file *file)
>         return 0;
>  }
>
> -SEC("fentry/vfs_open")
> -__failure __msg("calling kernel function bpf_path_d_path is not allowed"=
)
> -int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *=
f)
> -{
> -       /* Calling bpf_path_d_path() from a non-LSM BPF program isn't per=
mitted.
> -        */
> -       bpf_path_d_path(path, buf, sizeof(buf));
> -       return 0;
> -}

A leftover from previous versions?
This test should still be rejected by the verifier.

