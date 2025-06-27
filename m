Return-Path: <linux-fsdevel+bounces-53133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F3AEADB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 06:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701B556342D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC951C84C6;
	Fri, 27 Jun 2025 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqQsdhNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC8433CB;
	Fri, 27 Jun 2025 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750997086; cv=none; b=E7FIbhrbH6PixSlpLlMATi2howEXERoPIdquRPNFbOEiGizkw0tDKBZLjCDsqrqsodFYtoMmmvL2d5IT3Vdi1mnCb/H3ZKr9sJ+5oh2eGkwqYT3E7fFd31vX366Xvgs+vTulivadV4y2ZcAW6t6yPC4htr6eRHZCvlcIJFNRqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750997086; c=relaxed/simple;
	bh=Mma9CMSMYc/gD5PCHcAaBFj3rdMlrbBicSyXXt9PcNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CH+fdUQoNoYrSKPhkzqKjsLyXwy3hR6iRwOjJmc0HDENGrGUJLDDdTpisrACc4SSBAdWK0YN6ntkKftS3+zJli9nGsumGHM2Lwwk0s+4VShNwaDbvgbVwMNQxgU6fKyQs9BEfbauyKcEsc3cTnZDf7oTW6XCtaK1tw2YNK7XHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqQsdhNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A37C4CEF3;
	Fri, 27 Jun 2025 04:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750997086;
	bh=Mma9CMSMYc/gD5PCHcAaBFj3rdMlrbBicSyXXt9PcNw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GqQsdhNHawq+twbptt2NsZrIZKLSabBpQD8l9QCIvtKBdw6zr0kum6stEkpAQg3d4
	 dh/Zee7lp4FeqOWOtb/hPstD7eb1WZQi7o+o0mgmxnBi/aDjVXqW9CL53IS40cof8S
	 5btltkZpJZRkXm+lPpKeK/d6JkAZCrwL+gi8QaFZqWAv4/WRhQ6wbex8D6BHA/nB2R
	 GLj6xRtD32CzobSbXj6JVrj3VR2al3BDFucGbOGaVOZK+zufw+FtB6oBFspD9S3B0/
	 yeT+Zl456Sgorvbopz4XQlsW2ZerjX/8/4nuYhkBQBQqo9xxtUp4K55kyCE1h1+9Wh
	 unEBKSHzEPiZw==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a6f0bcdf45so24453891cf.0;
        Thu, 26 Jun 2025 21:04:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEvFnWpy0Xw2lE75sZJkC7YwD49dcVKsVrN218hQjj2kS6Xw5361BfxYsg89CaBfLdHhGLEm2iMwWAvhOYrg7DnujI2a7j@vger.kernel.org, AJvYcCVuGO6WrSIk4mB57pqWphnnajmq1o9LQki7S69qaHqlRFSQcLm8k8YUdt8tUcwZRE1Uo1TLiS4KNrMQpu3C@vger.kernel.org, AJvYcCWJM/81xbjCcgU1w4+nkJN8TMyHbpcoR+ZBfVSbpCrxhKvDNq8LwdTB8Gi+Cp7Srk3tOPU=@vger.kernel.org, AJvYcCXqF5Nf9vj2euzgmzrVQqvjEEnT9TTTuK6vgRhsg6PqJKqjHrntYTakTWd7jOjsftUdzOoumY9LIBW3GuNkmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQQEUVYf20Df/hKMxeUlYepm0aR8PY0PNxxOv+4vUr3VoJgzm
	Q809Bhqan9LdsBEl8tqkZRFDlZctuxgJpn9o+RaaoRq8pktU0da0aK/BPUnNKof8LY/kQkh0M7X
	2pkaUP9sCifnDe8hxS1oW3Acmtk+Fi/Y=
X-Google-Smtp-Source: AGHT+IEhPbrm4/U3sDNEwA/4jw/JLLVdlPl7uDfbqleHnpYFV4MonybK6KW/yjpz6QK1Zg9rw+cYaygKu52dDc4wc4Q=
X-Received: by 2002:ac8:7d84:0:b0:4a7:1460:f1bd with SMTP id
 d75a77b69052e-4a7fc9ca4b4mr32081011cf.8.1750997085228; Thu, 26 Jun 2025
 21:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623063854.1896364-1-song@kernel.org> <20250623-rebel-verlust-8fcd4cdd9122@brauner>
 <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com>
In-Reply-To: <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 26 Jun 2025 21:04:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7JAgXUObzkMAs_B=O09uHfhkgSuFV5nvUJbsv=Fh8JyA@mail.gmail.com>
X-Gm-Features: Ac12FXzTPC_HoMmxjQGDCDLY07r8m3jwZx7i6Y_SyAOwjpCqaDat_mHEFoscOM0
Message-ID: <CAPhsuW7JAgXUObzkMAs_B=O09uHfhkgSuFV5nvUJbsv=Fh8JyA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Amir Goldstein <amir73il@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 7:14=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]
> ./test_progs -t lsm_cgroup
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> ./test_progs -t lsm_cgroup
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> ./test_progs -t cgroup_xattr
> Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED
> ./test_progs -t lsm_cgroup
> test_lsm_cgroup_functional:PASS:bind(ETH_P_ALL) 0 nsec
> (network_helpers.c:121: errno: Cannot assign requested address) Failed
> to bind socket
> test_lsm_cgroup_functional:FAIL:start_server unexpected start_server:
> actual -1 < expected 0
> (network_helpers.c:360: errno: Bad file descriptor) getsockopt(SOL_PROTOC=
OL)
> test_lsm_cgroup_functional:FAIL:connect_to_fd unexpected
> connect_to_fd: actual -1 < expected 0
> test_lsm_cgroup_functional:FAIL:accept unexpected accept: actual -1 < exp=
ected 0
> test_lsm_cgroup_functional:FAIL:getsockopt unexpected getsockopt:
> actual -1 < expected 0
> test_lsm_cgroup_functional:FAIL:sk_priority unexpected sk_priority:
> actual 0 !=3D expected 234
> ...
> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
>
>
> Song,
> Please follow up with the fix for selftest.
> It will be in bpf-next only.

The issue is because cgroup_xattr calls "ip link set dev lo up"
in setup, and calls "ip link set dev lo down" in cleanup. Most
other tests only call "ip link set dev lo up". IOW, it appears to
me that cgroup_xattr is doing the cleanup properly. To fix this,
we can either remove "dev lo down" from cgroup_xattr, or add
"dev lo up" to lsm_cgroups. Do you have any preference one
way or another?

Thanks,
Song

