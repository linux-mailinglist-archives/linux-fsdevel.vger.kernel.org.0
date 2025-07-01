Return-Path: <linux-fsdevel+bounces-53529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ACAAEFD2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082E03A6270
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D1F278768;
	Tue,  1 Jul 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHkl0ymo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73C191493;
	Tue,  1 Jul 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381529; cv=none; b=SCp2pSfFHpOQyG0NxN2SLwhi/7C8y6UgtAOEYBCVW3mG3DhfsXjY4WKYSSOK1VBknekQ5lamQiPMFb39Xm5Sp83XDdbElmWlBrIPZKLsoIB01quxEvJ7CUZs6UdVKTGDNEeE2OeKGxAlQLgBo/qAxXiN1WcElCMj2uxqsFWMzDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381529; c=relaxed/simple;
	bh=FBz6CHJBicR2pGluF6ujCI+8Krednj6xthZsed1pmVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqteeNkucS+7zCMdom5cXPLUYKGp6hLhT+t94pdhH4p5bU7OjBlUCeN+4ygd2GuNimYmDC9o8hpYmwpLRF+JghW/0WhMyaotBzNODysigW4ReeSYG+JhCawtkRTz2ojhtlZ1gpcImioFLAlaANN0WlXaH4Xb+TeQlPUJEEX6SeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHkl0ymo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so3119950f8f.3;
        Tue, 01 Jul 2025 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751381526; x=1751986326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ek4SqQniFJZ7MXXJ++v2O8Gv2vKTdHUNE8dqL5pR18=;
        b=UHkl0ymokbvm+Yov4Um+fKQe/80YVnXWj9G4q5hMUZBcct/0LIHqGugW165FWoZ5sj
         xmEF30XZjtD09gv/4NzJ1a0kffKpc4Ezkz2aVYfOsap0eM09jldL8P49v4u3m5Bvo4gb
         Nv3Ulwhlddy5hJZw0Qn4vQMRkvFU9mBFp+iDs/nshT85uk7FaJiDbbFpuqoZYhgkXA7k
         dPd2aA0d7Cul7jwqHLT8jf10zixC4ibd/woTCCsd6dfV43qumJKXxGNlJj1PjzHQlAL2
         eahk7AAgaYnq5Df5LX4qzI+8zSOXUv+V2cE7LiaZU0FfjWQHDgfY6oDXFxJJ5xK6Mjnv
         OGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381526; x=1751986326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ek4SqQniFJZ7MXXJ++v2O8Gv2vKTdHUNE8dqL5pR18=;
        b=SYe+ZgrKq9szNnf7c2tp9DN3F6ib4pnw97LbZI0kNnh3+KluKD37LMDhzLdwdLavC7
         T4HHbx76JVQ/PYhwsPq6ytXbs/QtvIE9h8cDzoWOuDvd3ayJahsQYseOHS6K5WVWtOfl
         +y2PgoKij3zMstjuUlCyJkcJHKr6vVGqgOChTAMRVFySlRW+xg+OC02i8HhdZDqOMwfO
         yOUKphogSBCYUJXffbSeHyTUkGQbifPtSycJuFo77XrJzHKmJ3zJcjMdRcB/twuCpudB
         LvqlPr1wp669WklzsWhehp4npzIlwfjjd88AnttnMlYMxQ3XSmzaJkwLW6QbRr7jAgoi
         +ssQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0f8fIhThrB0d8L/jcv1lPg8bXRWdJJ7yBMYNbueSeUgs0BMoOosxIFtDYc6eMnWBOrRtZMe1HqW1Qn95c@vger.kernel.org, AJvYcCU4ANCrqFnLivRZIDE1ESmyDIuaSh8pT9bnuCNXoxGxBxgf3gftTIUr8artfzNEtSDN2ODRR2X3tJUcvmGWkB3fE8EAI9B3@vger.kernel.org, AJvYcCVTzygdgeaFlq7Hsi3+VAxjTA1GYzhncXyhodI262QnRc2AqvKPMagriL04dOJpcRkScvg=@vger.kernel.org, AJvYcCVrS4NjTMoaX4tifmObbQyz+ucREhqjveVb8zCzGr4XNA70sqaoVTOHiWvDX+UY1TddgEm86d5vtCwbbxEGOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YysPczdEhFx16L1c67pVBq9jYe11fyhlFkFRtn4XQMw/Zrl6wTz
	FYPCHQuvUG9mv8oyQMyUDJ6C7R4zTwcNYJamhLN0a3bVztAOPGq5lv6wnR+TjZg/sRqFBj2gf2u
	teIvWCBK9Xf88ZpTRVTX5CIaYcI+XVgo=
X-Gm-Gg: ASbGncvMaooTPo5q51c+e0jP3+yIlV/TPGbsOw0W8rVJFu/cYrybEWBIy91xQVoCQqp
	m1Zzc3eHAl774eiB7FDU7HYoHtpSOPXDN6vpaoU4sPxWbc7gd75joITD2Qf7/wy6FacdWuCkvUG
	RdRoKDHBOmKconskG/iCR7MHFsSJDWwjDbWkvsLfxdSHbi98MSY5AFqx///tH0rmIjEEDkuw==
X-Google-Smtp-Source: AGHT+IGKzLq2rMPPcse4lnU6v+U9DyGWe222t8mFLJDMSnqWvg0sGJMLifb2mqoSJN33I385OhKGsLxrNhsv3Moj48A=
X-Received: by 2002:a05:6000:440f:b0:3a4:efbb:6df3 with SMTP id
 ffacd0b85a97d-3a8f454904fmr11877755f8f.10.1751381526043; Tue, 01 Jul 2025
 07:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623063854.1896364-1-song@kernel.org> <20250623-rebel-verlust-8fcd4cdd9122@brauner>
 <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com> <20250701-angebahnt-fortan-6d4804227e87@brauner>
In-Reply-To: <20250701-angebahnt-fortan-6d4804227e87@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Jul 2025 07:51:55 -0700
X-Gm-Features: Ac12FXykWeB_Z6ktVqcnHu80evDF073sYgsQQr4QCL9_BlH1hTpHek0SHMgslxM
Message-ID: <CAADnVQ+pPt7Zt8gS0aW75WGrwjmcUcn3s37Ahd9bnLyzOfB=3g@mail.gmail.com>
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

On Tue, Jul 1, 2025 at 1:32=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Jun 26, 2025 at 07:14:20PM -0700, Alexei Starovoitov wrote:
> > On Mon, Jun 23, 2025 at 4:03=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Sun, 22 Jun 2025 23:38:50 -0700, Song Liu wrote:
> > > > Introduce a new kfunc bpf_cgroup_read_xattr, which can read xattr f=
rom
> > > > cgroupfs nodes. The primary users are LSMs, cgroup programs, and sc=
hed_ext.
> > > >
> > >
> > > Applied to the vfs-6.17.bpf branch of the vfs/vfs.git tree.
> > > Patches in the vfs-6.17.bpf branch should appear in linux-next soon.
> >
> > Thanks.
> > Now merged into bpf-next/master as well.
> >
> > > Please report any outstanding bugs that were missed during review in =
a
> > > new review to the original patch series allowing us to drop it.
> >
> > bugs :(
> >
> > > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > > patch has now been applied. If possible patch trailers will be update=
d.
> >
> > Pls don't. Keep it as-is, otherwise there will be merge conflicts
> > during the merge window.
>
> This is just the common blurb. As soon as another part of the tree
> relies on something we stabilize the branch and only do fixes on top and
> never rebase. We usually recommend just pulling the branch which I think
> you did.
>
> >
> > > Note that commit hashes shown below are subject to change due to reba=
se,
> > > trailer updates or similar. If in doubt, please check the listed bran=
ch.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > > branch: vfs-6.17.bpf
> > >
> > > [1/4] kernfs: remove iattr_mutex
> > >       https://git.kernel.org/vfs/vfs/c/d1f4e9026007
> > > [2/4] bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's =
node
> > >       https://git.kernel.org/vfs/vfs/c/535b070f4a80
> > > [3/4] bpf: Mark cgroup_subsys_state->cgroup RCU safe
> > >       https://git.kernel.org/vfs/vfs/c/1504d8c7c702
> > > [4/4] selftests/bpf: Add tests for bpf_cgroup_read_xattr
> > >       https://git.kernel.org/vfs/vfs/c/f4fba2d6d282
> >
> > Something wrong with this selftest.
> > Cleanup is not done correctly.
> >
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
> We should put that commit on the shared vfs-6.17.bpf branch.

The branch had a conflict with bpf-next which was resolved
in the merge commit. Then _two_ fixes were applied on top.
And one fix is right where conflict was.
So it's not possible to apply both fixes to vfs-6.17.bpf.
imo this shared branch experience wasn't good.
We should have applied the series to bpf-next only.
It was more bpf material than vfs. I wouldn't do this again.

