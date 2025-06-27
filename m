Return-Path: <linux-fsdevel+bounces-53124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F527AEACB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 04:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82264E2FE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 02:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F41191F66;
	Fri, 27 Jun 2025 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMfbi+44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5DF4430;
	Fri, 27 Jun 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990474; cv=none; b=pnCtCPubbQYdMOzFyeqWVf8F6dXEC4IhueU2iWYThuWNlKXbL+chtS1jGahAkfLE6H6dkbr5ryQ7LpSv8yglLHBmtRDZXMpn/Kl3kGHv8HBtWPmjqqheT3j+ihGSMdqITBxkNYYvXjdhMMJFdJYs09bkeyREoxKMmY5/6dKv7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990474; c=relaxed/simple;
	bh=dI4gZ+8FzlaNHjUsB5SGQuiANMweHx2aAKZjzQFvAaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2cRjN9/YbhFOjD6N2DNB74CGgeCdpQRc8e1XTWQg8YyQPvNGex1YLVL0UP7V6nrnzgcVyV07kMkcj073fspy/N5AmhP1+SvDn5ejdF75/D4xD+zRXN7q6HJi1b066sQXchul/dhObfPyz2ea9/jKKhHol6Vy89tv27UfhF7TSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMfbi+44; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a588da60dfso1074930f8f.1;
        Thu, 26 Jun 2025 19:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750990471; x=1751595271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4lNwGl5/Jt7PfY8MgdOgaaMPKP74HZQfLuN1tx9Z0E=;
        b=IMfbi+44J7GzX39UYP6f6MKKG6yHX0QWjLGmln9EQRoeISrZU18uT6KZJUHrfnf3zj
         ATK9UzsRIio+s8zMuMoBreELjTvWD1+XWvbt84QUtY0IZ1EPXSqg7qzF3vKC6Nm2vuNm
         HWaT3JWxi+dCdSmsPhsGoTEoy+494BVCQHPjlKWfe2T4ndIZtvbb5s0kZXS5sEGBzD9n
         XwQDFOHKsnIZB8DxkClRLD42dFSqgrt4rx9kVc3Mq7l7UASof8ZHXsN9PznTR8jRlKoJ
         0XzC5udPdsw4Q+qHeDJvu09r94hy/ZWqr59kGqQLHA1f58ghmU9ZI9+7fJa3ek0XzGSI
         0u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750990471; x=1751595271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4lNwGl5/Jt7PfY8MgdOgaaMPKP74HZQfLuN1tx9Z0E=;
        b=nK/wKbFt0RssoCMRH6xqiHadLWdGajR4KxxJzLOInJEnPImJpgUgbXs8vsF7i+4fVg
         dVkZMDVPnn6zSrA9EL5/YIUn2K3kff2droZMhjupkSYz+J96QIC6e08ApiRDmVQfSfn+
         TFGCGyl6IL8pBK2nxtbHP4HGruWbd/OWY+yLX2bWRpvS7NRsv3BWz4FTd8xZRVGcXaCK
         T7MVH7+PgS3OWvNHsy+GW9CMSu9eWjps8iichngafdCm+/Od6M0OMlvpJpC+0i9nuT6o
         YYngXTmKno9aQaqpjL4xvoywbW/zNlhDGYDkhMzdWx0G9n68aLHwn0RL1uGT5DFtQG9t
         VoKw==
X-Forwarded-Encrypted: i=1; AJvYcCU+t3Rl9PUIPRLgqfd09rBVnuUlROqAOdfWU1EabwC/VYDDGPgvo5do/X7ZyqvZ0PxacsA=@vger.kernel.org, AJvYcCUJzvPG6P5UdIkPD+oPHAHlzTpG92u1rjcWOEv7jt/NALlsyH9FumjNBElavmomqMP4349Z5GaOW+NhxtqbbyWD9bHhczJv@vger.kernel.org, AJvYcCVNBQJD8TQtpsURyJE/vDWKtusOuzCcbOkO73vdmrgFk2yjt/odDCR+RSxSD06xaWv/tXi3x1gf87GANNv3tA==@vger.kernel.org, AJvYcCWE7ULaXRSBvnuFBWilUVNtTjXx8r3ISzvbP5pAPnyfXdiWbn/3JxxsnGrnpmpHXDvyjyx0Y4NWyR1VtP8K@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzxTYBnSq4C6V9l5zH0c4+ZXIRVi0KE6EWnASzKzDCMB9Lh9d
	nQdt69r6FVVsXc9mSO2ifUItBVeBbTFjoC/SHHkLo6wCQyI3fGY9UsKq3nzYuoqe4DBfQ/PNX0/
	bGid47EWZAmE0toqBBYOtDumLraMyDc0=
X-Gm-Gg: ASbGncv42M8qhCoIVNl7zCEqRvdNWgPA02ddt2uOdRd1RhtGqY2f6SiadwSzXdW6Vh2
	O4anP1VgOKmMbdsrWZDwYUDGIwCybHVaYZTPjdcQucKHanfuqKo2Vq4FweZGhrozHxZSTQBhj5U
	zIh9wse1+Kdh8Fq4VrRak+TZUOPFFUPkFEhJwG9uxeqxQI2QFXStTxn+csBtVtqUvak8MIqv8u
X-Google-Smtp-Source: AGHT+IHhQq7iiVPbFftO+a9tCi+ffYjvL3dZ8R3tbTzTtJ2i3ocuYXdA43JAjuSzuyh6wsuSStT9cpvNEaKlLt5V1bI=
X-Received: by 2002:adf:b603:0:b0:3a8:38b4:1d55 with SMTP id
 ffacd0b85a97d-3a8fe5b1dc2mr1023815f8f.28.1750990471164; Thu, 26 Jun 2025
 19:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623063854.1896364-1-song@kernel.org> <20250623-rebel-verlust-8fcd4cdd9122@brauner>
In-Reply-To: <20250623-rebel-verlust-8fcd4cdd9122@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Jun 2025 19:14:20 -0700
X-Gm-Features: Ac12FXzZ4cgBuecloSupKKY-UlToperUwwsAUxig5haY8CRIzCHHMpN-6hUT62U
Message-ID: <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <song@kernel.org>, Kernel Team <kernel-team@meta.com>, 
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

On Mon, Jun 23, 2025 at 4:03=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sun, 22 Jun 2025 23:38:50 -0700, Song Liu wrote:
> > Introduce a new kfunc bpf_cgroup_read_xattr, which can read xattr from
> > cgroupfs nodes. The primary users are LSMs, cgroup programs, and sched_=
ext.
> >
>
> Applied to the vfs-6.17.bpf branch of the vfs/vfs.git tree.
> Patches in the vfs-6.17.bpf branch should appear in linux-next soon.

Thanks.
Now merged into bpf-next/master as well.

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.

bugs :(

> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.

Pls don't. Keep it as-is, otherwise there will be merge conflicts
during the merge window.

> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.17.bpf
>
> [1/4] kernfs: remove iattr_mutex
>       https://git.kernel.org/vfs/vfs/c/d1f4e9026007
> [2/4] bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
>       https://git.kernel.org/vfs/vfs/c/535b070f4a80
> [3/4] bpf: Mark cgroup_subsys_state->cgroup RCU safe
>       https://git.kernel.org/vfs/vfs/c/1504d8c7c702
> [4/4] selftests/bpf: Add tests for bpf_cgroup_read_xattr
>       https://git.kernel.org/vfs/vfs/c/f4fba2d6d282

Something wrong with this selftest.
Cleanup is not done correctly.

./test_progs -t lsm_cgroup
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
./test_progs -t lsm_cgroup
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
./test_progs -t cgroup_xattr
Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED
./test_progs -t lsm_cgroup
test_lsm_cgroup_functional:PASS:bind(ETH_P_ALL) 0 nsec
(network_helpers.c:121: errno: Cannot assign requested address) Failed
to bind socket
test_lsm_cgroup_functional:FAIL:start_server unexpected start_server:
actual -1 < expected 0
(network_helpers.c:360: errno: Bad file descriptor) getsockopt(SOL_PROTOCOL=
)
test_lsm_cgroup_functional:FAIL:connect_to_fd unexpected
connect_to_fd: actual -1 < expected 0
test_lsm_cgroup_functional:FAIL:accept unexpected accept: actual -1 < expec=
ted 0
test_lsm_cgroup_functional:FAIL:getsockopt unexpected getsockopt:
actual -1 < expected 0
test_lsm_cgroup_functional:FAIL:sk_priority unexpected sk_priority:
actual 0 !=3D expected 234
...
Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED


Song,
Please follow up with the fix for selftest.
It will be in bpf-next only.

