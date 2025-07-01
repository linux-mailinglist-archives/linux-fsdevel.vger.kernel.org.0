Return-Path: <linux-fsdevel+bounces-53533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFEAAEFFA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F136D16D4BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3052279DC3;
	Tue,  1 Jul 2025 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERfIN8og"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F01E502;
	Tue,  1 Jul 2025 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387024; cv=none; b=YD51Ru6QcU3KDY6rQcMA+OM4+cZssJDgvQdVH1rB/Q4Lj2gDl3+/RPdAT3TVfED546jkXfYG8DTHzOx+RHAe3UnqU4ynqMG6DBOWzcFi9MVaVZ/hcfRK12UEJJX/rggJwOzF9UN+QPKHyNAqGcEPhudaTII0ShE1QMKbgLOYtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387024; c=relaxed/simple;
	bh=zLFJiUp306D50BbDU6KAinugtteiVzfyb16LXOsRAPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EipbXtQY5pQWe7RRgUOKbzHNTNi0FDhNvZVf02UecjKXqUBRoXC+xp/xjK6QtiomUoTM3JNZpzUA+Do5JoL+R+tk0lQaiZPUADJFF2DhijSsotCT5nx7BKxCUTb9NldCdAa7IvlgD5gHMjVHs9zp7YXa51Xh+JrtGZbBq/sxDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERfIN8og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F844C4CEF3;
	Tue,  1 Jul 2025 16:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751387022;
	bh=zLFJiUp306D50BbDU6KAinugtteiVzfyb16LXOsRAPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ERfIN8og9ztGMSxGVvuulm+OTF4o6qq9o/NCIiIPn5cAqpTHTb8zSK0rRvuY/7oWi
	 IDn4/UsOvG3ui7jq/MPU51G3JzJgLyQ/wzMjv1befpZF4RVbzJqD1XzPjT/n/SjeFS
	 C1foDWkH5CzX9MAMQ3hRok+wlCbzwegP34YjZQzfyGt3fyHKHJeRIAPxOyeW5JuD9x
	 hT1Y/TEwaKD/dy+Ge9wuyDBKbRibCZZLfEENKmujA4B4xVxK1hAh9o3GDKVaySkYxN
	 K0aUPwg3sVyH+aaKwg4lE1ltn6LB9BnyhzOPDf9SMcI9rUk28bWodSrw+PwhvWg0PP
	 9n95qeWsrRL2A==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-701046cfeefso32435276d6.2;
        Tue, 01 Jul 2025 09:23:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWllDMPZPZwd5dzTlQULIr/VFv481vFeySaDRVjJ4+Wwr8RTpxMVNT2CQfgZsd6aaS+/PMpTKqalh+7I03EHc0SPqdKf2Wm@vger.kernel.org, AJvYcCX5v65H6RyfElKC9FJvoIAmH8V1QmwAMd2IYhUGZPnalrpTLDdvNQ7mVLDnlHQxsaZvZiylaRNz9blTsDit6w==@vger.kernel.org, AJvYcCXh3i0pYuqFq1xQ/QaeKVWaaMxq5orhWphqZHSWZOkPJLTAzLE3izoK4IZZiJKSf95WZRrJmYRxR6iUVzxQ@vger.kernel.org, AJvYcCXq8RbhRL9QPMMx24tyjxIJiH/bevS1Fcsjr37MNWTnqQMU0tPlMGALqtHU+Mrf4GscqH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gtDOdJ1ec8lUDtpGMNy21SE0twuAQCjXI7nLM8oRdGD/udoB
	j/kQKGjA6v3truONuyK34WatPlFgFbo/76SYKPCl7BItYulcP5HPF/+1W1YaZ5PYQKRzA0OXO70
	dntQgrdEMhrN7RdPahjZvsNRLm9PVg8s=
X-Google-Smtp-Source: AGHT+IEmOXLvDsXavGbzXpIGcLoe4Fk91A1Xta3xcwv/BTc1hYncD23gPsD76c7Rtk9rCiquNg45T40IBOlQvX3JYbg=
X-Received: by 2002:a05:6214:4b10:b0:701:894:2b91 with SMTP id
 6a1803df08f44-70108942c74mr97689136d6.14.1751387021541; Tue, 01 Jul 2025
 09:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623063854.1896364-1-song@kernel.org> <20250623-rebel-verlust-8fcd4cdd9122@brauner>
 <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com>
 <CAPhsuW7JAgXUObzkMAs_B=O09uHfhkgSuFV5nvUJbsv=Fh8JyA@mail.gmail.com>
 <CAADnVQKNR1QES31HPNriYBAzmoxdG=sWyqwvDTtthROgezah3w@mail.gmail.com>
 <6230B3E5-E6B7-4D79-B3A4-9A250B19B242@meta.com> <20250701-zipfel-sachlage-c494f4e0df91@brauner>
In-Reply-To: <20250701-zipfel-sachlage-c494f4e0df91@brauner>
From: Song Liu <song@kernel.org>
Date: Tue, 1 Jul 2025 09:23:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Afn7h5W4+ZY-Ly=y55ByXd3TCXej3PXUYkBcj89X7mw@mail.gmail.com>
X-Gm-Features: Ac12FXwoxUXF1BftxcJoa-MPjmMFWSZnTYLkoVIX0gjJZQj2RBiSmVgBhwZCHbw
Message-ID: <CAPhsuW5Afn7h5W4+ZY-Ly=y55ByXd3TCXej3PXUYkBcj89X7mw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <songliubraving@meta.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kernel Team <kernel-team@meta.com>, 
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

On Tue, Jul 1, 2025 at 1:32=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Jun 27, 2025 at 04:20:58PM +0000, Song Liu wrote:
> >
> >
> > > On Jun 27, 2025, at 8:59=E2=80=AFAM, Alexei Starovoitov <alexei.staro=
voitov@gmail.com> wrote:
> > >
> > > On Thu, Jun 26, 2025 at 9:04=E2=80=AFPM Song Liu <song@kernel.org> wr=
ote:
> > >>
> > >> On Thu, Jun 26, 2025 at 7:14=E2=80=AFPM Alexei Starovoitov
> > >> <alexei.starovoitov@gmail.com> wrote:
> > >> [...]
> > >>> ./test_progs -t lsm_cgroup
> > >>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > >>> ./test_progs -t lsm_cgroup
> > >>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > >>> ./test_progs -t cgroup_xattr
> > >>> Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED
> > >>> ./test_progs -t lsm_cgroup
> > >>> test_lsm_cgroup_functional:PASS:bind(ETH_P_ALL) 0 nsec
> > >>> (network_helpers.c:121: errno: Cannot assign requested address) Fai=
led
> > >>> to bind socket
> > >>> test_lsm_cgroup_functional:FAIL:start_server unexpected start_serve=
r:
> > >>> actual -1 < expected 0
> > >>> (network_helpers.c:360: errno: Bad file descriptor) getsockopt(SOL_=
PROTOCOL)
> > >>> test_lsm_cgroup_functional:FAIL:connect_to_fd unexpected
> > >>> connect_to_fd: actual -1 < expected 0
> > >>> test_lsm_cgroup_functional:FAIL:accept unexpected accept: actual -1=
 < expected 0
> > >>> test_lsm_cgroup_functional:FAIL:getsockopt unexpected getsockopt:
> > >>> actual -1 < expected 0
> > >>> test_lsm_cgroup_functional:FAIL:sk_priority unexpected sk_priority:
> > >>> actual 0 !=3D expected 234
> > >>> ...
> > >>> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
> > >>>
> > >>>
> > >>> Song,
> > >>> Please follow up with the fix for selftest.
> > >>> It will be in bpf-next only.
> > >>
> > >> The issue is because cgroup_xattr calls "ip link set dev lo up"
> > >> in setup, and calls "ip link set dev lo down" in cleanup. Most
> > >> other tests only call "ip link set dev lo up". IOW, it appears to
> > >> me that cgroup_xattr is doing the cleanup properly. To fix this,
> > >> we can either remove "dev lo down" from cgroup_xattr, or add
> > >> "dev lo up" to lsm_cgroups. Do you have any preference one
> > >> way or another?
> > >
> > > It messes with "lo" without switching netns? Ouch.
> >
> > Ah, I see the problem now.
> >
> > > Not sure what tests you copied that code from,
> > > but all "ip" commands, ping_group_range, and sockets
> > > don't need to be in the test. Instead of triggering
> > > progs through lsm/socket_connect hook can't you use
> > > a simple hook like lsm/bpf or lsm/file_open that doesn't require
> > > networking setup ?
> >
> > Yeah, let me fix the test with a different hook.
>
> Where's the patch?

Here is a fix to kernel/bpf/helprs.c by Eduard:
https://lore.kernel.org/bpf/20250627175309.2710973-1-eddyz87@gmail.com/

This fix addresses build errors with certain config.

Here is my fix to the selftests:
https://lore.kernel.org/bpf/20250627191221.765921-1-song@kernel.org/

I didn't CC linux-fsdevel because all the changes are in the
selftests, and the error is independent of the new code.

Thanks,
Song

