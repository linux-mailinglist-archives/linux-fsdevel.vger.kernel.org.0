Return-Path: <linux-fsdevel+bounces-53439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4DBAEF124
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BE61BC60A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4984126A1CD;
	Tue,  1 Jul 2025 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP/o9bl2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94773213E6D;
	Tue,  1 Jul 2025 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358726; cv=none; b=ZSzYHKKfqoKioP5TTWxo1M+PFFHbhYaGn+/VEV8UmmC2O6J4qicdNXAZK5wgrltCXYMSz05hWMn2lDRYWZybDKk1WGewbQqJxlD1fvChdMmaSl4pwdY/JSCzS1i+dWJXH8PrBNFf+WkCmYu6T4NLzX6stQ6nX/vHK6el8DPz9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358726; c=relaxed/simple;
	bh=/7+pkp4WbYtUvgqARqha0maOzBZP7u7ePnf+Znr45xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrrsVoQ5xdK1dgk3ChqIf6glL5NrWHDyFDjtmLgrN/5n57KiWN2YzYUNqB5/zLOfwrc+J8lnbpQ0LK/AYFXYWm6FiUaoM33k5g/sBxVEKfXLDNxMJGy1uOpdP2HLaIE+dwwJtZD3WtfryE0FN4DqjMvdrKllkrRUvMT95uryhJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP/o9bl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389E7C4CEEB;
	Tue,  1 Jul 2025 08:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751358726;
	bh=/7+pkp4WbYtUvgqARqha0maOzBZP7u7ePnf+Znr45xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XP/o9bl2BTuqwDnKkbs6Se3x+BnCsy6lOWBg7iCxi2ScoPZlEfavsLjm3Te2hQHnn
	 mCjdtn5BU7dOUTtwpds5jCJZOyab3wXMNq7rBgfYlum4+gkuZGyYsJ0S3rCSCXExsG
	 2q+Zz7dZ5PflbpACYr1x3s/3XeHHqKiv5Dw8KIVOyY2kvBb44QjfpENRHEozFjErj0
	 PAnCS9WyHxjIvyA70oB3WDvwxJYwHYuiwQ/a4siEUuHbCdq7Ue1ws8BG7BYqRXe565
	 ktVRHaga8jik3NrdcsvkPOqVrm8fx1XSUDcD5uTixqx7kT64BI8jDpjyeushHGpOLg
	 m7+kaEorfYgBg==
Date: Tue, 1 Jul 2025 10:31:58 +0200
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
Message-ID: <20250701-angebahnt-fortan-6d4804227e87@brauner>
References: <20250623063854.1896364-1-song@kernel.org>
 <20250623-rebel-verlust-8fcd4cdd9122@brauner>
 <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com>

On Thu, Jun 26, 2025 at 07:14:20PM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 23, 2025 at 4:03 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sun, 22 Jun 2025 23:38:50 -0700, Song Liu wrote:
> > > Introduce a new kfunc bpf_cgroup_read_xattr, which can read xattr from
> > > cgroupfs nodes. The primary users are LSMs, cgroup programs, and sched_ext.
> > >
> >
> > Applied to the vfs-6.17.bpf branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.17.bpf branch should appear in linux-next soon.
> 
> Thanks.
> Now merged into bpf-next/master as well.
> 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> 
> bugs :(
> 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> 
> Pls don't. Keep it as-is, otherwise there will be merge conflicts
> during the merge window.

This is just the common blurb. As soon as another part of the tree
relies on something we stabilize the branch and only do fixes on top and
never rebase. We usually recommend just pulling the branch which I think
you did.

> 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-6.17.bpf
> >
> > [1/4] kernfs: remove iattr_mutex
> >       https://git.kernel.org/vfs/vfs/c/d1f4e9026007
> > [2/4] bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
> >       https://git.kernel.org/vfs/vfs/c/535b070f4a80
> > [3/4] bpf: Mark cgroup_subsys_state->cgroup RCU safe
> >       https://git.kernel.org/vfs/vfs/c/1504d8c7c702
> > [4/4] selftests/bpf: Add tests for bpf_cgroup_read_xattr
> >       https://git.kernel.org/vfs/vfs/c/f4fba2d6d282
> 
> Something wrong with this selftest.
> Cleanup is not done correctly.
> 
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
> (network_helpers.c:360: errno: Bad file descriptor) getsockopt(SOL_PROTOCOL)
> test_lsm_cgroup_functional:FAIL:connect_to_fd unexpected
> connect_to_fd: actual -1 < expected 0
> test_lsm_cgroup_functional:FAIL:accept unexpected accept: actual -1 < expected 0
> test_lsm_cgroup_functional:FAIL:getsockopt unexpected getsockopt:
> actual -1 < expected 0
> test_lsm_cgroup_functional:FAIL:sk_priority unexpected sk_priority:
> actual 0 != expected 234
> ...
> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
> 
> 
> Song,
> Please follow up with the fix for selftest.
> It will be in bpf-next only.

We should put that commit on the shared vfs-6.17.bpf branch.

