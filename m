Return-Path: <linux-fsdevel+bounces-53440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8D2AEF131
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7C71BC630B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389A26B777;
	Tue,  1 Jul 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsL/X8Gb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDA155A4D;
	Tue,  1 Jul 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358758; cv=none; b=Y2lhJxEo4iN4MnjDDBHgss6YzaOJWNTuO4xek5BRJtSojrH9UvBtvTYJX8Ypg6jDeOgiJ575BpW5iENQ9HPEzKrQcb0sBYHGFcAEcGiFl0UQk1wIqEhj0rgS6VOjFatvog063tDtgGe6xCCdkVnB0N5Beu9xo9a+rv0sEMcY9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358758; c=relaxed/simple;
	bh=6v7KGIA/pDZ0iJk81oc9Gmli1g1Ho0YGvEhGkIISPD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aokul8QBVOKYWr3xXgsXeOFQ7IRWAwFUnlR/p2BD/DshtSsFrWEqVvWry5fqTqVQuIIpfntgM5Ja/kIHWBOJYGPcTD/7bVSonxhq/34NeCTvvL+Rpsia1bcMrOIGMmlJmiVLGR0uAvYMRH84unFywDc+WSDEQmH2cw1fF0J6cXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsL/X8Gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F754C4CEEE;
	Tue,  1 Jul 2025 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751358756;
	bh=6v7KGIA/pDZ0iJk81oc9Gmli1g1Ho0YGvEhGkIISPD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OsL/X8GbY7DLGK6H39oWSB7hCGokaZi4iI7HpXu+Cv9uAAoppLpnggoM7M9ZmWX5B
	 xf9uwec938LKmjIXhXqWvntE+fg0I3a1c+F9SDd5unPZaY9fzsJtm+yyl59hubAmwS
	 6VXF9vz6LI2srIhiuqyniZq2QHTOvjYzo0E1nD/tka7aW9a4otn633EHxMzfv/+rVH
	 4TyhDfgh7Q9lYF0LmEZBTJ/+I7XCDEuy7T0RCmmRXe05MUwBC7OuukUXwF5gZo9Qb0
	 Lj2dof0cYXK/NCNXZLaYKYmw/3aupakgLgU9w0AavJRjyHJ/fTECXgLkaAHATyiSyl
	 HGtgA0d5q78+A==
Date: Tue, 1 Jul 2025 10:32:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <songliubraving@meta.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Song Liu <song@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
Message-ID: <20250701-zipfel-sachlage-c494f4e0df91@brauner>
References: <20250623063854.1896364-1-song@kernel.org>
 <20250623-rebel-verlust-8fcd4cdd9122@brauner>
 <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com>
 <CAPhsuW7JAgXUObzkMAs_B=O09uHfhkgSuFV5nvUJbsv=Fh8JyA@mail.gmail.com>
 <CAADnVQKNR1QES31HPNriYBAzmoxdG=sWyqwvDTtthROgezah3w@mail.gmail.com>
 <6230B3E5-E6B7-4D79-B3A4-9A250B19B242@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6230B3E5-E6B7-4D79-B3A4-9A250B19B242@meta.com>

On Fri, Jun 27, 2025 at 04:20:58PM +0000, Song Liu wrote:
> 
> 
> > On Jun 27, 2025, at 8:59 AM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> > On Thu, Jun 26, 2025 at 9:04 PM Song Liu <song@kernel.org> wrote:
> >> 
> >> On Thu, Jun 26, 2025 at 7:14 PM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >> [...]
> >>> ./test_progs -t lsm_cgroup
> >>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> >>> ./test_progs -t lsm_cgroup
> >>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> >>> ./test_progs -t cgroup_xattr
> >>> Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED
> >>> ./test_progs -t lsm_cgroup
> >>> test_lsm_cgroup_functional:PASS:bind(ETH_P_ALL) 0 nsec
> >>> (network_helpers.c:121: errno: Cannot assign requested address) Failed
> >>> to bind socket
> >>> test_lsm_cgroup_functional:FAIL:start_server unexpected start_server:
> >>> actual -1 < expected 0
> >>> (network_helpers.c:360: errno: Bad file descriptor) getsockopt(SOL_PROTOCOL)
> >>> test_lsm_cgroup_functional:FAIL:connect_to_fd unexpected
> >>> connect_to_fd: actual -1 < expected 0
> >>> test_lsm_cgroup_functional:FAIL:accept unexpected accept: actual -1 < expected 0
> >>> test_lsm_cgroup_functional:FAIL:getsockopt unexpected getsockopt:
> >>> actual -1 < expected 0
> >>> test_lsm_cgroup_functional:FAIL:sk_priority unexpected sk_priority:
> >>> actual 0 != expected 234
> >>> ...
> >>> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
> >>> 
> >>> 
> >>> Song,
> >>> Please follow up with the fix for selftest.
> >>> It will be in bpf-next only.
> >> 
> >> The issue is because cgroup_xattr calls "ip link set dev lo up"
> >> in setup, and calls "ip link set dev lo down" in cleanup. Most
> >> other tests only call "ip link set dev lo up". IOW, it appears to
> >> me that cgroup_xattr is doing the cleanup properly. To fix this,
> >> we can either remove "dev lo down" from cgroup_xattr, or add
> >> "dev lo up" to lsm_cgroups. Do you have any preference one
> >> way or another?
> > 
> > It messes with "lo" without switching netns? Ouch.
> 
> Ah, I see the problem now. 
> 
> > Not sure what tests you copied that code from,
> > but all "ip" commands, ping_group_range, and sockets
> > don't need to be in the test. Instead of triggering
> > progs through lsm/socket_connect hook can't you use
> > a simple hook like lsm/bpf or lsm/file_open that doesn't require
> > networking setup ?
> 
> Yeah, let me fix the test with a different hook. 

Where's the patch?

