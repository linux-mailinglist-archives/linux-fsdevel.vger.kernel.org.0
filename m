Return-Path: <linux-fsdevel+bounces-24346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A493D9F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 22:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD456B21E16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 20:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E4E149DF1;
	Fri, 26 Jul 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/HhQ/5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06A18641;
	Fri, 26 Jul 2024 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026640; cv=none; b=tG1hDLcmpuYh8omadJxh/7l5ItX13afJi6eddh+lfOgyrsrwr/rXlD7N8R7HFl9FId8GbHx8zcPuRcWab8LTVCW23tCoxe6CF6778V7JQajPXkj72GIaH4TCoZ6Tmpl6mGLEu38B+kuL/6RbuTH+8naOsHrZyemO+/nc1Zw60aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026640; c=relaxed/simple;
	bh=hM8iivXgSA4AqwIarR0kTiPI4WtIKtBZ4ns7ldzts4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHRYS/fF/pYVt/ix2UAw2MCXnUuyGaeBNOUI9r4RZBzcpG0YnoZKtDYHlk3JA+f1ryyGq++j5mgNrafUn9332IH/4e3+EtF9rTJ3tZu9vW8RGLWdRH6NCWMFvh1z2oACkX9+rvOPfgiQhDgkBk2bbLLRcuu09S5DQXt7+5oSBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/HhQ/5r; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368663d7f80so32177f8f.3;
        Fri, 26 Jul 2024 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722026637; x=1722631437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsUmGU/Xd8GlODUPJCjW1QXb2HsgcufehzB5dimi4dI=;
        b=T/HhQ/5rK0HMDNEpTWlgKjTnPKEPGHSYA5Emr0kPKtEG9+JTL3rq50Se4uB9Y97s8S
         rl6BmYiWC1uxJiJ/dAArYYiSs1N2zrbPtCN+c5r247Ej6+ZFdNcoCWKC2WDNTEhEgkro
         v5NR4zr3mPp/4Jts7SP9MGjub1BkRbiyZiPf1Lo3OiKSZnKJjQORaTI3dLErubwfnaKB
         EyNn+dl5JOfaGeCh6X/K5snhpyp8aYC3XnPhWoDMiteIf3gzWrkSdat0no/Rvo9iBHLX
         I2jD5P/V07EEuD61156uRPsujxN49bZFgzyyxeB6QrhOb4FcUYVa676h7bI/SdQCuZmF
         7l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722026637; x=1722631437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsUmGU/Xd8GlODUPJCjW1QXb2HsgcufehzB5dimi4dI=;
        b=ISikVOYL9JYyGd8E3MMhzxlscaT39AaJWNmlkl1i4WZhULXmu1ok3f5QAFT0tgGPyW
         MpZVBxX95oN62ZAjiX4PH0wDQQ+nsn33bl3sk9p/NNL9UHqZhAfPUbbOXfFTKJE0UJpk
         tMQkKI7ljf9f80CsZyYSf6FwDYAgkh54HEi5NP1LHozcbqXUf5WmHHrUgU/Au74NvEYh
         4WwuhPATcj/DGXDhyLev5I4QOdBHGS9oGLcDdS3j4HwTwzzHZQutdmtUsGTBRkm4irk9
         UQYcsBV08zoZWe9HoEyA0wXhBOQQARgAVA/Phx/8byvvqFYyKFfeJQQwRh1xhBvXahrs
         fGnA==
X-Forwarded-Encrypted: i=1; AJvYcCUwpsek4U3WLlHB02qESESPShWM7AZEWX/JDyIROsAngi2wjMp/gHVRawoOHmbJrLJ4WigBv2mtbFT81b6SuNroSKNqakp/UTy+rnCbTg==
X-Gm-Message-State: AOJu0YxRn6ddWaie+qoFr5icl9ICjqxShIiD85GRB1WjtcC5iiKFvC28
	y5YkEA+U52EBUJcgzBiqignxTlKvNHL7TaeSEQEHKVoVf9Yx65DotQjY5Qqp+Wlf55MyJ0bKb7M
	kl3s3vZhL6tOVh6ZnEGrQ4irQNYU=
X-Google-Smtp-Source: AGHT+IF/2WvisaCojPRg+FrIbmLFaXFsgDsfCrIqb9HopHeSr/rZn/YC8CZhzxSnXdOi7/orIpacdo0VoODzHctT8Vs=
X-Received: by 2002:a05:6000:178b:b0:368:3b1a:8350 with SMTP id
 ffacd0b85a97d-36b5cf240a3mr530842f8f.19.1722026636746; Fri, 26 Jul 2024
 13:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com> <20240726085604.2369469-2-mattbobrowski@google.com>
In-Reply-To: <20240726085604.2369469-2-mattbobrowski@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Jul 2024 13:43:45 -0700
Message-ID: <CAADnVQJdv9rjCHMzmE+W4AO3GgKjNjS_c06kC0iXe+itDstGZQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:56=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
> +
> +static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
> +{
> +       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> +           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> +               return 0;
> +       return -EACCES;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_fs_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &bpf_fs_kfunc_set_ids,
> +       .filter =3D bpf_fs_kfuncs_filter,
> +};
> +
> +static int __init bpf_fs_kfuncs_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc=
_set);
> +}

Aside from buf__sz <=3D 0 that Christian spotted
the bpf_fs_kfuncs_filter() is a watery water.
It's doing a redundant check that is already covered by

register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,...

I'll remove it while applying.

