Return-Path: <linux-fsdevel+bounces-37829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8249F8021
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C39188AA60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E222655F;
	Thu, 19 Dec 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGS2uemq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775B223E64;
	Thu, 19 Dec 2024 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626515; cv=none; b=e50KNFtoEA5VJSjbSHXLZpJ2f/TGY08EFv/Zky+ZT741J4H/b475hJfTd2fTsrXcWaV8Q/F6v1CMRUCqwKFXli1Z+jmLOvTBFXMIzjoDTSwxcFHG2+Rh9rvo3qb8GihsQihwtkgRZoZo/nMVwpaFFjUvPwsvKRiypllU4VQN1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626515; c=relaxed/simple;
	bh=FjsnUKfks9U0N82oHq5v3AkcFRCDT1236DGZJGpNZcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5ARlFvO9/Cwrn30aqCR8SZtgMSD/a3j+7moh8g+k3uoHU34cnYf6/A4EtAvtFafNWJ1vup+yvQuUXaROBcop7xRzFZ0dLJl+f3RBysXV1UjGI61U1mNBcnYWNRfvp7QU1bazs82Lx4rVd7rLBNJkR7vo2LOxMNggu/4Mn1d7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGS2uemq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e3621518so542008f8f.1;
        Thu, 19 Dec 2024 08:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734626512; x=1735231312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXsllVaoeoWh6730B25Ivn5lUpttsv8hfymuwDTfqqk=;
        b=GGS2uemqgJVS83SL1dtPSHORjREE+jRro+O2L+8rLld6TVLECpejntj5490fY/wdHT
         W2DQoxQ2JP3vsAO3U5+Tej25irCySDa+Ck3Lq3GuSKMnUb8z0viTfR4wXxVD3MYglRpL
         vrSuW6b0jFf686L6mVdUWuvYauP1A38SX4MfYvHWHVz3mNGNpgkgU1i6F4z4zjarkG5U
         mNNxuBoQCPLJovO5ODdhmyfT0u73tgFUNmEkbmH6nLWX1i0ySnku7ag8R8G8KlLLgslS
         XU8JEi4pkNtk2qhIR2RsIp8xq2KTLoHuHu7/XUq98yySeijNvjy+LPaVwtpxC8vIQ2YO
         ZzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734626512; x=1735231312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXsllVaoeoWh6730B25Ivn5lUpttsv8hfymuwDTfqqk=;
        b=hVYUyoO/K3O/EowT+a12iMskJ7qgtGoWSMpYdZWE5Nr53mU3XxiWFOgrDOfgeL2QSQ
         goq1reUY2l+qfiG4DGTpsecoJt33wKf8+rccBzo3GUb6dGlpZqVZ2ZsF+lFWGkcbPwF5
         9CiCQmsdOnN/bNUjxfOYQca31nPBkU/cI8wGhHYv6sy6ME2t9+hZM5GEBRvm4u8wNBWC
         lSwIhjmBZcYqYuNgwi3kDyjWUwk/7UmcOzSn9Cf5rus9p8x+2fqlaGENbNuwVkRvT97V
         JFFxQZAkJf1DNQPBrm31q5B7Ph0cWX/D9GO/XF0ASNHdEa2zOR0JXhu+F0jmLLhvg4+H
         Aedg==
X-Forwarded-Encrypted: i=1; AJvYcCWVoDizm26LlNuV2CEkqlj9fCf3NM8t5FLUa7E80b1mKS5yHmd6e6dnpb1a7bh2j/dxVc+xFY7ms02dv+EyQQ==@vger.kernel.org, AJvYcCWdklB2EGaZOAwfHZOSflTWPm0Y2kjKVlUCAdR1H/dz+jOfaCBhUb3kSP20mhz/rvhN22A575bV5MGRvqnW@vger.kernel.org, AJvYcCWpUih1x6n5ZnfogTLYkf5Tb+dWZPXbMhQYLfBNtuPUVlzg+qsJ16L1E8ueTF7NPBu43Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2VUynpv3eYMbflt92nIqlToUOcOQpuYUrptgZOwslpyu2dsa
	0B6ILE9xWk+rDPW7cc9LQqnNtAJvhsHvED240xxVx4468DKX2nW282T/WWm5sPDHDjQjhUVaHcu
	WtnvCyEanmACUvxzx7odCHeWsn2k=
X-Gm-Gg: ASbGncusvsUuQ7S99bncu+IoqWjP30Az/Nyc1PiJv2vagEAsiaQeSvYsF3kuIt8m/mG
	vv0f4pvS6uEL2LS+WKKnfvfXKMqqoFQamG1tmZFpn
X-Google-Smtp-Source: AGHT+IG632GnjuZiL2mrFEEMWXlT/cCnaAZz0QMpK3AEB+tsUZM/pv6qlctcyE2W6m0x+mKInM/g7aEZHDfioCFAm74=
X-Received: by 2002:a5d:6c63:0:b0:386:1c13:30d5 with SMTP id
 ffacd0b85a97d-388e4d4a602mr8391806f8f.7.1734626512200; Thu, 19 Dec 2024
 08:41:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080E0DFE4F9BAFFDB9D113B99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5080E0DFE4F9BAFFDB9D113B99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Dec 2024 08:41:41 -0800
Message-ID: <CAADnVQLU=W7fuEQommfDYrxr9A2ESV7E3uUAm4VUbEugKEZbkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/5] bpf: Make fs kfuncs available for SYSCALL
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

On Tue, Dec 17, 2024 at 3:45=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> -static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
> -{
> -       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> -           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> -               return 0;
> -       return -EACCES;
> -}
> -
>  static const struct btf_kfunc_id_set bpf_fs_kfunc_set =3D {
>         .owner =3D THIS_MODULE,
>         .set =3D &bpf_fs_kfunc_set_ids,
> -       .filter =3D bpf_fs_kfuncs_filter,
>  };
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

This is incorrect.
You have to keep bpf_fs_kfuncs_filter() and prog->type =3D=3D BPF_PROG_TYPE=
_LSM
check because bpf_prog_type_to_kfunc_hook() aliases LSM and fentry
into BTF_KFUNC_HOOK_TRACING category. It's been an annoying quirk.
We're figuring out details for significant refactoring of
register_btf_kfunc_id_set() and the whole registration process.

Maybe you would be interested in working on it?

The main goal is to get rid of run-time mask check in SCX_CALL_OP() and
make it static by the verifier. To make that happen scx_kf_mask flags
would need to become KF_* flags while each struct-ops callback will
specify the expected mask.
Then at struct-ops prog attach time the verifier will see the expected mask
and can check that all kfuncs calls of this particular program
satisfy the mask. Then all of the runtime overhead of
current->scx.kf_mask and scx_kf_allowed() will go away.

