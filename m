Return-Path: <linux-fsdevel+bounces-24347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0172893DA25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 23:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA61C1F24889
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 21:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C4149DE4;
	Fri, 26 Jul 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7Xv0CQm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDBE748A;
	Fri, 26 Jul 2024 21:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029141; cv=none; b=bi1kZzbCbkGsBMk8sDbXoiguvtEu5kl48gvYYNfH3BdSnmLWS+7cUTiHQa6h/+wmkIUYvgZNUmGxznzJMPD1GlaZqoSB4BzhAie72g9RxmdcTPWHUBf3PjPZFy/VyO9nU5ZRVVo3Tzcq9v1pMtV5eNurtltG1B/kmMLHTpnuSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029141; c=relaxed/simple;
	bh=dGtjdsM0MYUinBeyrunagVNApFyw25OHOkvnVOiuFQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKWi99aWb24aIf+vCZyd5CucNWkhvOvOiUA7OkoPAcdwNp4Hebo1nIrZKq9WmP57GhUTjSMi419DBRwqm30D6unywtHWcUgXkVgWArNWH8H65GZIIKv7wOVeHBb5cEo2XvzBOgX09p5Ce3PWvr4QHPJazp/lfy3h8P1fbs/C9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7Xv0CQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567A5C4AF0A;
	Fri, 26 Jul 2024 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722029140;
	bh=dGtjdsM0MYUinBeyrunagVNApFyw25OHOkvnVOiuFQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S7Xv0CQmyzJmB0dLQeAxXkmizQURNojzNqqYBfJPRnXg85BKk9KyQ/qSnFlDEF3xE
	 jLJ67TkKcTInhEjbiMuHD8LnYl7kVcZrhWWO+C4Fh88GglIIhB1HaOG0e2+QyQVNoJ
	 5hO8oIXKMoUHWYwXovO+VgVEqQS+YLwcliAVs9DLuTu2Qs9IdX7aXHKXmu0EcARBX6
	 XS7ayxdoPCQpgHPuS2JN89tPeV6+faaLV2AQ444Oxh34mGl1MouEpufGrPcq8mx1Sm
	 aPYYq2P+NfY/zIOVwPcqLjwdy8siQ7Kg9ruNL7hzijhpK/AZKyca5Wbc5A6zdn9ABN
	 nc1ic7DVQduGw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efd530a4eso2568954e87.0;
        Fri, 26 Jul 2024 14:25:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLftTG21oRPPZhT71WZBkK5NQy7hwViRMtQqQGjCOvEiPgyRgBxNnOFaZafGRO9P4yITo/biyzTo911plJWUtWdLSVufwWpEXxyz6kgQ==
X-Gm-Message-State: AOJu0YzYrIcQy4splB8n/+QAs23+9//w1RqOxNjvDNm2nnbGRCmaWIOq
	Kc1WX99Jb0ivGFoOERVj9wu5yEqbhEopbxN333o4UNPKn3lqcMWBYtwBRfoL1j+XhwN4iOyObDf
	aQ8+pWqg0EwAVxNFCzVJcwSHAIdc=
X-Google-Smtp-Source: AGHT+IHujnYlHv0s5WVRnzT0cfpS/EzmC5Rz3kif1yuB8sO4y2vzvkxIJkzO5QsyL+rFv5wtcG6Jd+aU44G5q2mk4lk=
X-Received: by 2002:a05:6512:2524:b0:52e:9b15:1c60 with SMTP id
 2adb3069b0e04-5309b2ca2eemr770178e87.48.1722029138560; Fri, 26 Jul 2024
 14:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com> <20240726085604.2369469-2-mattbobrowski@google.com>
In-Reply-To: <20240726085604.2369469-2-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 26 Jul 2024 14:25:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7fOvLM+LUf11+iYQH1vAiC0wUonXhq3ewrEvb40eYMdQ@mail.gmail.com>
Message-ID: <CAPhsuW7fOvLM+LUf11+iYQH1vAiC0wUonXhq3ewrEvb40eYMdQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, 
	jannh@google.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	jolsa@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:56=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
[...]
> +       len =3D buf + buf__sz - ret;
> +       memmove(buf, ret, len);
> +       return len;
> +}
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> +BTF_ID_FLAGS(func, bpf_get_task_exe_file,
> +            KF_ACQUIRE | KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE | KF_SLEEPABLE)

Do we really need KF_SLEEPABLE for bpf_put_file?

Thanks,
Song

> +BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS | KF_SLEEPABLE)
> +BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
> +
[...]

