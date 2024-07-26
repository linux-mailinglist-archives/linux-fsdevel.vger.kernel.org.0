Return-Path: <linux-fsdevel+bounces-24352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 753F993DB69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 01:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C48C1F245F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 23:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9416EC1C;
	Fri, 26 Jul 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPs2sdHM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFE16C6A4;
	Fri, 26 Jul 2024 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722037986; cv=none; b=UseRpzAfSKfUG6iFE1b5grpJ8SCjwfV4OxYbkNHtDU4R+T3/2irENnrr2QocN1TKYZ0P1Ea15T0N5VtciBv3GXNmZv+/K3hEliE6MlFmbP5ONAsyvuTA9htEav+LBZ8caiCpCUi/5K4vd8LB6M6XnYeDuVm2O4twmcuKArMz0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722037986; c=relaxed/simple;
	bh=J0uy78AlQJPnc9xKGpD1v9TV/2J5ZGAEKiC6VRFKeDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oq031w1wr44VeYP17ZO7dcCHcQMi7BjXy1W9ZtFpQJlJ2fXAQGEvupIqeuluagqwRHntUP7izlBwQNZzp4r5QexkUwNNe96txcGwgdL3tAnfOUKxMu2/6m61J8Q5t8dDrz24tKA2KxphXBwglPv2aZrqeWCPFjGZiPSMp5reId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPs2sdHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB897C4AF0E;
	Fri, 26 Jul 2024 23:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722037986;
	bh=J0uy78AlQJPnc9xKGpD1v9TV/2J5ZGAEKiC6VRFKeDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uPs2sdHMwdcLG+1ejboI5ee8b3eX7rowwSXFongRV9GV+2rce7Yf/vOvP5vGOMaLa
	 hN3InQ6ySMNV45s58CzdgLJVZDWv+4V0g84OGrF4am90Ju2azkjeLLf1i/xeOOIxvz
	 hNx5PDXK0/p/b4br86M/WQxKsvyxnBlJbjQ4iplaTh3PJ2cPS8nWaXbWLLxaSD4Dl6
	 zv9iXkzB3uzC2gC1355VF29NcjftTbBiWXr9ixkAdRS01Eagd9a6FqIJjRbPsx0ZKB
	 B3eMdbQ3R+btX8wawSvUIo6e3tt8xhrVmNKSynbG4Ipu6+SnrkpIac/7heqfjGBa0M
	 gQZ5PtAQcJzuQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so18375841fa.1;
        Fri, 26 Jul 2024 16:53:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWX3kfW3V5Sw6CjqZhqryqbFoqINM4QT6IxTw5xwTNu/G6OJL21GnrViEmnUk8gb1XTxSK1PQBxyaM9WppX2Lq1odhYzC1R8oQSrpwn2Q==
X-Gm-Message-State: AOJu0YwRm409u5J8yysIk5y3cKrJUpAgMSRpCXwDdgY4qqttCFo3lRbz
	oglZCv3GKAJMTz8Xy0VVFTbRx0NL5CUo1XAKiKhuIrZggi3U8BpRmfOc+DXknOJVywRulluu8oP
	8sFRw1lGGRZa89bG9wKd3OXRxhK0=
X-Google-Smtp-Source: AGHT+IFMWqae+/R2Q5GWEhtBJ2olpPr+6kMtMrBQ0pKngzjT9TkdB1Gwxhjs7H+EZOBpGRb6PXImsMKhyyXIk+tBtfA=
X-Received: by 2002:a05:6512:32cb:b0:52c:ad70:6feb with SMTP id
 2adb3069b0e04-5309b718bb9mr245498e87.20.1722037984247; Fri, 26 Jul 2024
 16:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com> <20240726085604.2369469-2-mattbobrowski@google.com>
In-Reply-To: <20240726085604.2369469-2-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 26 Jul 2024 16:52:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4WcksBrLkwr8zwTZttmbpQCw1=D95Qs+X7Kj5zkTMA6g@mail.gmail.com>
Message-ID: <CAPhsuW4WcksBrLkwr8zwTZttmbpQCw1=D95Qs+X7Kj5zkTMA6g@mail.gmail.com>
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
> Add a new variant of bpf_d_path() named bpf_path_d_path() which takes
> the form of a BPF kfunc and enforces KF_TRUSTED_ARGS semantics onto
> its arguments.
>
> This new d_path() based BPF kfunc variant is intended to address the
> legacy bpf_d_path() BPF helper's susceptibility to memory corruption
> issues [0, 1, 2] by ensuring to only operate on supplied arguments
> which are deemed trusted by the BPF verifier. Typically, this means
> that only pointers to a struct path which have been referenced counted
> may be supplied.
>
> In addition to the new bpf_path_d_path() BPF kfunc, we also add a
> KF_ACQUIRE based BPF kfunc bpf_get_task_exe_file() and KF_RELEASE
> counterpart BPF kfunc bpf_put_file(). This is so that the new
> bpf_path_d_path() BPF kfunc can be used more flexibility from within
> the context of a BPF LSM program. It's rather common to ascertain the
> backing executable file for the calling process by performing the
> following walk current->mm->exe_file while instrumenting a given
> operation from the context of the BPF LSM program. However, walking
> current->mm->exe_file directly is never deemed to be OK, and doing so
> from both inside and outside of BPF LSM program context should be
> considered as a bug. Using bpf_get_task_exe_file() and in turn
> bpf_put_file() will allow BPF LSM programs to reliably get and put
> references to current->mm->exe_file.
>
> As of now, all the newly introduced BPF kfuncs within this patch are
> limited to sleepable BPF LSM program types. Therefore, they may only
> be called when a BPF LSM program is attached to one of the listed
> attachment points defined within the sleepable_lsm_hooks BTF ID set.
>
> [0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=3DQxU-jtCUfb5xQb3mLr=3D5Fcw=
ddF_VKfEBPs_Dg@mail.gmail.com/
> [1] https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org/
> [2] https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com=
/
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

checkpatch reported a few syntax issues on this one:

https://netdev.bots.linux.dev/static/nipa/874023/13742510/checkpatch/stdout

