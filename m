Return-Path: <linux-fsdevel+bounces-53601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9486AF0E2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C325D1895EB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C423909C;
	Wed,  2 Jul 2025 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnbQj4P+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF64199FAB;
	Wed,  2 Jul 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445448; cv=none; b=armS+Hiy3L71eBDHTU1JS0PHFwQn0gAKsDmU2jwVuK4+aXHJaXC2rxU/R3m0ou9IMBLYPC4XAdpGsFZD/iqQQLJm4osJiT4YgEQzfmlSJ+BnCNKPSmlx4qpQbYYm4fQk5m9yGbTtA4UaAEJmQv63n9ZjR+AzlhM7cz+gGdp3+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445448; c=relaxed/simple;
	bh=7FKJlxsE3jn0DBQjOcrwyHFOhJYRK7izfigAF+uSDSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obMa0h7InINWRncBTAPO/D3uePD++XTYnV9YiZdq7Zh0VaPHcZ9M9+4rTBH7LtRojyKB/2HsjkyIGPbIPPeb5Jwr6iuMhPRBTvhGxVJwkzYLwicaTTTfZw1j6nOPQH46DuzU2JUzzXcH75zw5e0xABxTUE2QgU1HtFEVlHRa12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnbQj4P+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D89CC4CEED;
	Wed,  2 Jul 2025 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751445447;
	bh=7FKJlxsE3jn0DBQjOcrwyHFOhJYRK7izfigAF+uSDSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnbQj4P+3Qk3nuPFka95au2yTsmaM4nbadj3AFA7E2doUoKwlPJFnM9XZqkkqUxtH
	 h9zolEpQ7MgT8sSL5uSNNOPxOSZ5FehghjL2cXHztZpJ5G4BKycMWImcEa98WUwVaJ
	 PsxPVx7i1HC6nkfcPbHinKf9AUEYxQTr+HU/Teo7GGiJ0Dd9+VsiJ3LWRc8d3Mu4ov
	 e0OBp7eRIyv9ks3/H8Rzqz87VLigFw8Jh4O20X/pQWBsrx6iorZQ67/V78PkADkGDj
	 0sttnQ2RrP06/biqhNfR8xK51U/9vVYd0rdN2ulLaoXaxmMUxr6C94yZBvtmcv0bkD
	 Ztk1gC1XnJQxg==
Date: Wed, 2 Jul 2025 10:37:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
Message-ID: <20250702-anhaften-postleitzahl-06a4d4771641@brauner>
References: <20250623063854.1896364-1-song@kernel.org>
 <20250623-rebel-verlust-8fcd4cdd9122@brauner>
 <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com>
 <20250701-angebahnt-fortan-6d4804227e87@brauner>
 <CAADnVQ+pPt7Zt8gS0aW75WGrwjmcUcn3s37Ahd9bnLyzOfB=3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+pPt7Zt8gS0aW75WGrwjmcUcn3s37Ahd9bnLyzOfB=3g@mail.gmail.com>

On Tue, Jul 01, 2025 at 07:51:55AM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 1, 2025 at 1:32 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Jun 26, 2025 at 07:14:20PM -0700, Alexei Starovoitov wrote:
> > > On Mon, Jun 23, 2025 at 4:03 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Sun, 22 Jun 2025 23:38:50 -0700, Song Liu wrote:
> > > > > Introduce a new kfunc bpf_cgroup_read_xattr, which can read xattr from
> > > > > cgroupfs nodes. The primary users are LSMs, cgroup programs, and sched_ext.
> > > > >
> > > >
> > > > Applied to the vfs-6.17.bpf branch of the vfs/vfs.git tree.
> > > > Patches in the vfs-6.17.bpf branch should appear in linux-next soon.
> > >
> > > Thanks.
> > > Now merged into bpf-next/master as well.
> > >
> > > > Please report any outstanding bugs that were missed during review in a
> > > > new review to the original patch series allowing us to drop it.
> > >
> > > bugs :(
> > >
> > > > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > > > patch has now been applied. If possible patch trailers will be updated.
> > >
> > > Pls don't. Keep it as-is, otherwise there will be merge conflicts
> > > during the merge window.
> >
> > This is just the common blurb. As soon as another part of the tree
> > relies on something we stabilize the branch and only do fixes on top and
> > never rebase. We usually recommend just pulling the branch which I think
> > you did.
> >
> > >
> > > > Note that commit hashes shown below are subject to change due to rebase,
> > > > trailer updates or similar. If in doubt, please check the listed branch.
> > > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > > > branch: vfs-6.17.bpf
> > > >
> > > > [1/4] kernfs: remove iattr_mutex
> > > >       https://git.kernel.org/vfs/vfs/c/d1f4e9026007
> > > > [2/4] bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
> > > >       https://git.kernel.org/vfs/vfs/c/535b070f4a80
> > > > [3/4] bpf: Mark cgroup_subsys_state->cgroup RCU safe
> > > >       https://git.kernel.org/vfs/vfs/c/1504d8c7c702
> > > > [4/4] selftests/bpf: Add tests for bpf_cgroup_read_xattr
> > > >       https://git.kernel.org/vfs/vfs/c/f4fba2d6d282
> > >
> > > Something wrong with this selftest.
> > > Cleanup is not done correctly.
> > >
> > > ./test_progs -t lsm_cgroup
> > > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > > ./test_progs -t lsm_cgroup
> > > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > > ./test_progs -t cgroup_xattr
> > > Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED
> > > ./test_progs -t lsm_cgroup
> > > test_lsm_cgroup_functional:PASS:bind(ETH_P_ALL) 0 nsec
> > > (network_helpers.c:121: errno: Cannot assign requested address) Failed
> > > to bind socket
> > > test_lsm_cgroup_functional:FAIL:start_server unexpected start_server:
> > > actual -1 < expected 0
> > > (network_helpers.c:360: errno: Bad file descriptor) getsockopt(SOL_PROTOCOL)
> > > test_lsm_cgroup_functional:FAIL:connect_to_fd unexpected
> > > connect_to_fd: actual -1 < expected 0
> > > test_lsm_cgroup_functional:FAIL:accept unexpected accept: actual -1 < expected 0
> > > test_lsm_cgroup_functional:FAIL:getsockopt unexpected getsockopt:
> > > actual -1 < expected 0
> > > test_lsm_cgroup_functional:FAIL:sk_priority unexpected sk_priority:
> > > actual 0 != expected 234
> > > ...
> > > Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
> > >
> > >
> > > Song,
> > > Please follow up with the fix for selftest.
> > > It will be in bpf-next only.
> >
> > We should put that commit on the shared vfs-6.17.bpf branch.
> 
> The branch had a conflict with bpf-next which was resolved
> in the merge commit. Then _two_ fixes were applied on top.
> And one fix is right where conflict was.
> So it's not possible to apply both fixes to vfs-6.17.bpf.
> imo this shared branch experience wasn't good.
> We should have applied the series to bpf-next only.
> It was more bpf material than vfs. I wouldn't do this again.

Absolutely not. Anything that touches VFS will go through VFS. Shared
branches work just fine. We manage to do this with everyone else in the
kernel so bpf is able to do this as well. If you'd just asked this would
not have been an issue. Merge conflicts are a fact of kernel
development, we all deal with it you can too.

