Return-Path: <linux-fsdevel+bounces-31742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B663599AA9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB881F2228E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5FD1C1ACF;
	Fri, 11 Oct 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq5/iFLl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBAE1BD4E7;
	Fri, 11 Oct 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668414; cv=none; b=HeZq/zrSugugKe9Y3u2YfjAiP6Io8AK2r5w08MDoGHgNciQptyJDk3z/Se6p1CYlAtHcYXRPuzt28Q5pZihbLyLlnWxMgMVWdcvCty8VtsqrEdaVP3wHzZxsryArMeRLuRX1FLThQ7NQu9V7hrffz1mVyVe1vrcLsmrkxR1fW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668414; c=relaxed/simple;
	bh=M+hdYJlFyL0OZx5yExYHmOFQXmQgma78xTFYbCNq0io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJ8ImsDZXT4Q1h7atgxfuoZ2vGp5ADAYtcT9qcpYRiQrOWpC4Vf7OSl4TNFmeoywXdACtixo13eHDqar5zp9c8GG/0bNTIstn2mAhzCApWkzKSc9YhY7yWUOVMh97ESc7ZZU05bFZaMyQ8qzDHZHKKEFeI24zGJhfmRezgncgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq5/iFLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683F1C4CED2;
	Fri, 11 Oct 2024 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668414;
	bh=M+hdYJlFyL0OZx5yExYHmOFQXmQgma78xTFYbCNq0io=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hq5/iFLllAr4TOwrmWCx/OtZ6lEhPewnjt2QHTTPaiS9es2MxaPaQ9tOOPSMmatuW
	 H5WYkBrCZWOO2TC44R1i7mJMvDnM70C9Ga+bkyDs1JYQIwp/Je6BtuEPRNysW78ZsV
	 ZxOnRFjdbkhzobrMz0DY0/IRM/TNVQa5t9c50hlJLUPdYS4Ys3zuYVDu+nYFh2FsmH
	 nh7yMenHDsUa6iN3s1SRsAKkVcgs9hEUJGKgisaLHPemhYd61TU4iAJs2mAZyHXwJK
	 C4BupP+G5UfZ8BAPE90P+K1RCXjPrtD55FsNyqqGj6T3TwGsJpZfTMDFgE/fkSuwYP
	 ry/j/vttLiRyg==
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8354c496c90so72108739f.3;
        Fri, 11 Oct 2024 10:40:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0Niv9xYzju7/i4/w1xpt8nGb3ARvdQ0yL54EwOzmJwkZJZttSg9VEXknmzbfpQ4iQwk8krB1ZlKL6katH@vger.kernel.org, AJvYcCXMVH2POQJcuQUVWyZzx8qV1rFbOMxufYLZ+o385v5seBGXLdFA/BMLur5vMrBeghWlZG89wYSAlmL7G7Oq@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCS0b1ox8Vzq2kccQl776jqa9fQR7QRIGbib41scro3bUp02Y
	fbs0Vu6fNYxwPTbvXJ47284Kz8i+2oAHQ2Bf/lgzy3rMEwUyj7qWK8gQ8/D8Qcpjfh5LEO4lYmx
	GQ1oZ7yBMVC7FfdLR09HS/aHQQP8=
X-Google-Smtp-Source: AGHT+IEw7zHvzixrCNkcdvbFz3a6TBhJkMVm8ycQ5AOQZEAi5W1sZlvl3yEl5OfWvfU5y3PKoFGNOr/ijiz/Acz/JZs=
X-Received: by 2002:a05:6e02:18cd:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a3bcdb421amr2020225ab.7.1728668413737; Fri, 11 Oct 2024
 10:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002214637.3625277-1-song@kernel.org>
In-Reply-To: <20241002214637.3625277-1-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 11 Oct 2024 10:40:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6nv=-wEaoPxB_+VQTkfnvYzBtfjbrg2EeNK7jjN6V83g@mail.gmail.com>
Message-ID: <CAPhsuW6nv=-wEaoPxB_+VQTkfnvYzBtfjbrg2EeNK7jjN6V83g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] security.bpf xattr name prefix
To: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz
Cc: kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kpsingh@kernel.org, 
	mattbobrowski@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian, Al, and Jan,

Could you please review and share your comments on this set?

Thanks,
Song

On Wed, Oct 2, 2024 at 2:47=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Follow up discussion in LPC 2024 [1], that we need security.bpf xattr
> prefix. This set adds "security.bpf" xattr name prefix, and allows
> bpf kfuncs bpf_get_[file|dentry]_xattr() to read these xattrs.
>
>
> [1] https://lpc.events/event/18/contributions/1940/
>
> Song Liu (2):
>   fs/xattr: bpf: Introduce security.bpf xattr name prefix
>   selftests/bpf: Extend test fs_kfuncs to cover security.bpf xattr names
>
>  fs/bpf_fs_kfuncs.c                            | 19 ++++++++-
>  include/uapi/linux/xattr.h                    |  4 ++
>  .../selftests/bpf/prog_tests/fs_kfuncs.c      | 40 ++++++++++++++-----
>  .../selftests/bpf/progs/test_get_xattr.c      | 30 ++++++++++++--
>  4 files changed, 78 insertions(+), 15 deletions(-)
>
> --
> 2.43.5

