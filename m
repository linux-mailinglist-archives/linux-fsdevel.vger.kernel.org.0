Return-Path: <linux-fsdevel+bounces-53638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3EAF1574
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39F64E050B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3D26E715;
	Wed,  2 Jul 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlHHtFxz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D52571D4;
	Wed,  2 Jul 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458803; cv=none; b=AZXcDfJN0Lt2UKp61CqFLCR+F30gVXAKxZllAGcAaGOA3bJ1VvLo0kM5azXBM2NDIlrTmPwbbfVWksdemgRqKpdiGjGtBEboLNxA6lnfbgmcbAOpV3CjhZXNPE+dC9vIVmTaytMpjhgU32x/lvOTrQjZUd+vj99sDJ1mXfCN2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458803; c=relaxed/simple;
	bh=WmHx38wO/IOxW7T06G2NR8K7vP2aHdYi16pgQxbPhH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqJNvzOYrcTYAZIif0ChTL1gIH7RpMgll2OAzUYWT/JwdResaC6sU7FE99VcrtdF7o8W937fjO/AH7+bd/Uz/cETLu3ewYKbBm0aalekAKofsA5IaZoL8QdczmNHgoehSXw6BS5us3W5MivaCEbvbpCBydiF6i2BCwtfZDK3NwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlHHtFxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AE9C4CEED;
	Wed,  2 Jul 2025 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751458803;
	bh=WmHx38wO/IOxW7T06G2NR8K7vP2aHdYi16pgQxbPhH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlHHtFxz92wS4b659x7PaMPM6f7+FUj0A657QPJWj0dwqns/AyxynIVFBiYVMLpMg
	 5mVkFCUKRFuRhQNfXpcvXLFnVySsciXaflVICjg9HFFFArj9Kw88lIVbpybKSbqjdr
	 v/OrToPtvN2zUkWED1LyMIIXkBI2WGMrUqGH+flmbsHso4YK8yu3njuk9pFiJsLrPS
	 VT2nqOocUOF9/OSQi0OZrXsf90jz2bx2uVPo1/NpGkxPvy5YcDaMK4twZh7uSF9oue
	 xR5TX8DJupxs6QHHRkZhtlWkBfDanF742YTX36hbsJpLJ/y1D23+fccVmKbBnMrEcP
	 KPaX5TX1ux5rQ==
Date: Wed, 2 Jul 2025 14:19:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Song Liu <songliubraving@meta.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
Message-ID: <20250702-nudelsalat-bestrafen-2762d79d3986@brauner>
References: <20250623063854.1896364-1-song@kernel.org>
 <20250623-rebel-verlust-8fcd4cdd9122@brauner>
 <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com>
 <CAPhsuW7JAgXUObzkMAs_B=O09uHfhkgSuFV5nvUJbsv=Fh8JyA@mail.gmail.com>
 <CAADnVQKNR1QES31HPNriYBAzmoxdG=sWyqwvDTtthROgezah3w@mail.gmail.com>
 <6230B3E5-E6B7-4D79-B3A4-9A250B19B242@meta.com>
 <20250701-zipfel-sachlage-c494f4e0df91@brauner>
 <CAPhsuW5Afn7h5W4+ZY-Ly=y55ByXd3TCXej3PXUYkBcj89X7mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5Afn7h5W4+ZY-Ly=y55ByXd3TCXej3PXUYkBcj89X7mw@mail.gmail.com>

On Tue, Jul 01, 2025 at 09:23:30AM -0700, Song Liu wrote:
> On Tue, Jul 1, 2025 at 1:32 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Jun 27, 2025 at 04:20:58PM +0000, Song Liu wrote:
> > >
> > >
> > > > On Jun 27, 2025, at 8:59 AM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 26, 2025 at 9:04 PM Song Liu <song@kernel.org> wrote:
> > > >>
> > > >> On Thu, Jun 26, 2025 at 7:14 PM Alexei Starovoitov
> > > >> <alexei.starovoitov@gmail.com> wrote:
> > > >> [...]
> > > >>> ./test_progs -t lsm_cgroup
> > > >>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > > >>> ./test_progs -t lsm_cgroup
> > > >>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > > >>> ./test_progs -t cgroup_xattr
> > > >>> Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED
> > > >>> ./test_progs -t lsm_cgroup
> > > >>> test_lsm_cgroup_functional:PASS:bind(ETH_P_ALL) 0 nsec
> > > >>> (network_helpers.c:121: errno: Cannot assign requested address) Failed
> > > >>> to bind socket
> > > >>> test_lsm_cgroup_functional:FAIL:start_server unexpected start_server:
> > > >>> actual -1 < expected 0
> > > >>> (network_helpers.c:360: errno: Bad file descriptor) getsockopt(SOL_PROTOCOL)
> > > >>> test_lsm_cgroup_functional:FAIL:connect_to_fd unexpected
> > > >>> connect_to_fd: actual -1 < expected 0
> > > >>> test_lsm_cgroup_functional:FAIL:accept unexpected accept: actual -1 < expected 0
> > > >>> test_lsm_cgroup_functional:FAIL:getsockopt unexpected getsockopt:
> > > >>> actual -1 < expected 0
> > > >>> test_lsm_cgroup_functional:FAIL:sk_priority unexpected sk_priority:
> > > >>> actual 0 != expected 234
> > > >>> ...
> > > >>> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
> > > >>>
> > > >>>
> > > >>> Song,
> > > >>> Please follow up with the fix for selftest.
> > > >>> It will be in bpf-next only.
> > > >>
> > > >> The issue is because cgroup_xattr calls "ip link set dev lo up"
> > > >> in setup, and calls "ip link set dev lo down" in cleanup. Most
> > > >> other tests only call "ip link set dev lo up". IOW, it appears to
> > > >> me that cgroup_xattr is doing the cleanup properly. To fix this,
> > > >> we can either remove "dev lo down" from cgroup_xattr, or add
> > > >> "dev lo up" to lsm_cgroups. Do you have any preference one
> > > >> way or another?
> > > >
> > > > It messes with "lo" without switching netns? Ouch.
> > >
> > > Ah, I see the problem now.
> > >
> > > > Not sure what tests you copied that code from,
> > > > but all "ip" commands, ping_group_range, and sockets
> > > > don't need to be in the test. Instead of triggering
> > > > progs through lsm/socket_connect hook can't you use
> > > > a simple hook like lsm/bpf or lsm/file_open that doesn't require
> > > > networking setup ?
> > >
> > > Yeah, let me fix the test with a different hook.
> >
> > Where's the patch?
> 
> Here is a fix to kernel/bpf/helprs.c by Eduard:
> https://lore.kernel.org/bpf/20250627175309.2710973-1-eddyz87@gmail.com/
> 
> This fix addresses build errors with certain config.
> 
> Here is my fix to the selftests:
> https://lore.kernel.org/bpf/20250627191221.765921-1-song@kernel.org/
> 
> I didn't CC linux-fsdevel because all the changes are in the
> selftests, and the error is independent of the new code.

Ah great, thank you for the info. That helped and we don't have to care then.

