Return-Path: <linux-fsdevel+bounces-53201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CA8AEBCBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CA66A44BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3932E9ED0;
	Fri, 27 Jun 2025 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGsj/jY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BB19E990;
	Fri, 27 Jun 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039981; cv=none; b=e/TzdVki8Fz7EktPHKKeN7iAAwC8LVLmupv+zoS3vDcfaV8cW173waxxyhwc/JnEOBAnUZT8NLAu/G6vSLPpXNZBRhmFJ2rNO6j8KvNpIqzABjLgp1uOMjzyiBFLLA66rgQNLAsPyfWTqSgLv/DZHFwT7AsAfEVPrWMHq83hERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039981; c=relaxed/simple;
	bh=UL5P2G8QwWKYeIIOTiUC5tzsMqmjCmX1SN6IgdbYSZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JD46EK2i8UnwB45DupS1z+yUvOm6fO71P8tBq3g1Zk5zTnvFzg40/DCNsHq4UtwAh8d6wBOpY41g6rgBQj4nNhy9qpC4V9DGIUTCdjgbRPZpcZx9H62+TsDSQgC7Ru6f4ZLC1fZL8rPZdYNZCdApQsEdnRxtILw/xtc9gUzAzv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGsj/jY5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso2437632f8f.1;
        Fri, 27 Jun 2025 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751039978; x=1751644778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL5P2G8QwWKYeIIOTiUC5tzsMqmjCmX1SN6IgdbYSZc=;
        b=PGsj/jY5lECkMQTXDIJ66wMwZNWBA5xUKpsiZHOvbEh3Eg3TtOOm069JA1kz+k3gDR
         EOcrB9GX7iQ1+V8Vq3v7yMAWqk8phoUcTgfnM7YDtQQP9mEdtJD1wg3O7t7rE8tykKtk
         1NyiFL7n6m48rMCeMNK5BiZwXX9VVDxKoUFA1T9yGkYJgZA0FFPVz+d29TZ1/cS1Ve9A
         /FBHrB6+KtOsMdtWA14N/eK15xEXnw3YHekuWZNWmYWKlibcBZEOHARJ4XjKQkdAC0Cg
         ZG+jFRtMRgKd5U4TBYqpdJisZ1PPEEng38lnfb4sEdTZVqPhLQKKKKOwe/qcCTJ9DogK
         TcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751039978; x=1751644778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL5P2G8QwWKYeIIOTiUC5tzsMqmjCmX1SN6IgdbYSZc=;
        b=h0McMvDxk1bNMUZyL7u18cbdYJJfQw+rVVwgIkAqt9YLxmgWpc2TEG8k5vCf27zuxc
         poj9a0E6VCyco1qM16i6u2zpHk41Cgz1/Pj/lOAWk6XjmkZEryLhKJd110T2cmLtS71k
         0pwiAQbbMj2oegA/l8rJv0NTzIKTzOYl03d5PkdrL/v13qFZyDCp/hPhI/3u0CkF5aio
         jSL5YhqMxctkDXG6OqifXS9wUXZ5hBopuAZVqZTFN2rnT0W5hL44M/+BsKNvCC9wMj3F
         f/w6q2Rd2e+ILlSINZ74VsxyFhFcpzMA0yXoY6wmlrnGIK5h0lX0mmSsKNJ/uGW4I9Ls
         +YAg==
X-Forwarded-Encrypted: i=1; AJvYcCUBMR/cvCrblVr2vmtMWzRr6ExtSamvhhco4zPw5DpfrbgQag7+vnEwlRHGq0akDTntEKne5vCl9du85uBl@vger.kernel.org, AJvYcCUQ3oUhw/qQjNgH45QpXeB8s0lROIKIWNPGRQGQBWs1uA1gZ1Mr7gry4JI/w66+cgwuXucqqQdQV2E4qafvuJFUuMsZdxQZ@vger.kernel.org, AJvYcCW6yCgRUZp9ptyha1Ps0xL1Ecs4fzfVRN387C8VokquuUEo5lt3wBV8uA9hT7hgk/2U7f7vNSg5mdjLiLMaGA==@vger.kernel.org, AJvYcCXOxRnCpSOp4JXwlk3/Z3KAys8E0ITD2Lo0Zy6DszM9uZzGKqnlTR8zsU1uxkapNHjaU0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGczBG6PdD6NZFh00iSJV0HshLHLHvF972LKwm1p3qZ87PqtxH
	V78iYztrlANfNSB2FrmzEkY2uUgQUX4N9CeHbCvKxify9AlP/xupqnJafNLVeMdQpThehcXCedL
	o/AG19H6sFm5WA4QQ+b4+YOj3M/KiWHQ=
X-Gm-Gg: ASbGncuFmG5AFab2KoHUvrTvFawgfm1BSnpra+Lf+4Z4Ibzjoi9FjA+k8H5lQEoURFV
	lKrxuNodhMkPs8Zl91sDRfeEIQmmYSYUriM8MMcodydGpm1Tvkl4AhJvHD92zeRIyJE7vWm+2i6
	P4ebX6q0ip5PHhcpoiNONiss47flqYbkBucYgDToPPcz9YWxDDJAV5eZI6Ze2Ae95wIVbyxRWk
X-Google-Smtp-Source: AGHT+IF1U4dcY9xhsGy4rlWEcfGwUP3bOoZNh7p3VrXI1JSMiPPMIzqk94XvixfjE42EY3uQb8qxFRdvlbjNH2ISQ9I=
X-Received: by 2002:a05:6000:2711:b0:3a4:f7d9:3f56 with SMTP id
 ffacd0b85a97d-3a8f435e574mr2894930f8f.2.1751039977933; Fri, 27 Jun 2025
 08:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623063854.1896364-1-song@kernel.org> <20250623-rebel-verlust-8fcd4cdd9122@brauner>
 <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com> <CAPhsuW7JAgXUObzkMAs_B=O09uHfhkgSuFV5nvUJbsv=Fh8JyA@mail.gmail.com>
In-Reply-To: <CAPhsuW7JAgXUObzkMAs_B=O09uHfhkgSuFV5nvUJbsv=Fh8JyA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Jun 2025 08:59:26 -0700
X-Gm-Features: Ac12FXxIczTM5K68rlq_78aPZtKoDWfs-hoiBCYqfl1f8Bf6HdGD3OkhePHxzBk
Message-ID: <CAADnVQKNR1QES31HPNriYBAzmoxdG=sWyqwvDTtthROgezah3w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
To: Song Liu <song@kernel.org>
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

On Thu, Jun 26, 2025 at 9:04=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Jun 26, 2025 at 7:14=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> [...]
> > ./test_progs -t lsm_cgroup
> > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > ./test_progs -t lsm_cgroup
> > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > ./test_progs -t cgroup_xattr
> > Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED
> > ./test_progs -t lsm_cgroup
> > test_lsm_cgroup_functional:PASS:bind(ETH_P_ALL) 0 nsec
> > (network_helpers.c:121: errno: Cannot assign requested address) Failed
> > to bind socket
> > test_lsm_cgroup_functional:FAIL:start_server unexpected start_server:
> > actual -1 < expected 0
> > (network_helpers.c:360: errno: Bad file descriptor) getsockopt(SOL_PROT=
OCOL)
> > test_lsm_cgroup_functional:FAIL:connect_to_fd unexpected
> > connect_to_fd: actual -1 < expected 0
> > test_lsm_cgroup_functional:FAIL:accept unexpected accept: actual -1 < e=
xpected 0
> > test_lsm_cgroup_functional:FAIL:getsockopt unexpected getsockopt:
> > actual -1 < expected 0
> > test_lsm_cgroup_functional:FAIL:sk_priority unexpected sk_priority:
> > actual 0 !=3D expected 234
> > ...
> > Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
> >
> >
> > Song,
> > Please follow up with the fix for selftest.
> > It will be in bpf-next only.
>
> The issue is because cgroup_xattr calls "ip link set dev lo up"
> in setup, and calls "ip link set dev lo down" in cleanup. Most
> other tests only call "ip link set dev lo up". IOW, it appears to
> me that cgroup_xattr is doing the cleanup properly. To fix this,
> we can either remove "dev lo down" from cgroup_xattr, or add
> "dev lo up" to lsm_cgroups. Do you have any preference one
> way or another?

It messes with "lo" without switching netns? Ouch.
Not sure what tests you copied that code from,
but all "ip" commands, ping_group_range, and sockets
don't need to be in the test. Instead of triggering
progs through lsm/socket_connect hook can't you use
a simple hook like lsm/bpf or lsm/file_open that doesn't require
networking setup ?

