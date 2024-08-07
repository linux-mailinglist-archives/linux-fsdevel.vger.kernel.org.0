Return-Path: <linux-fsdevel+bounces-25267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5719594A57E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB9F1F230BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30701DE850;
	Wed,  7 Aug 2024 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Msil/iWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892113AA38;
	Wed,  7 Aug 2024 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026601; cv=none; b=dv7YV0Ipn0M17d1ZAS64XF5qUjgJVl2sEUxdJdqn+z3t0WmYGz7CxKi7yTMDarIpD8/j4mMEcigMzCwWL23/N/+B2L/XugGrxPTmzlHORgVIxkheFCStmiKLK8GN1CXwNSJ+Cw6ytw45G4/xa+A2aJnoaa1S3bjSWw61ZqrByKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026601; c=relaxed/simple;
	bh=/G3zzECYtuk1Vk302TKyav+cThZJupBMQFxaiIoAPc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcoWJkNpfqSr3K0L1Rrm55sQCra6mRPuy8f3H9kXjd2OcG1zc9X//R8D2iXF2jOsgnfi87OUZj++/9RYSwJe47ch8nZumx1vS81HxcxWUleSHjfm7AfSz1tYzIeySMufVtuIlQLdWFOBh6HyfhdOTvFr6sVcVgJvucJwjiMSnWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Msil/iWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D20C32782;
	Wed,  7 Aug 2024 10:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026600;
	bh=/G3zzECYtuk1Vk302TKyav+cThZJupBMQFxaiIoAPc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Msil/iWNz98ncoDJXxs4t2pVxJrf5P08X9Bz9GVBVxRf1cGG43vFfDSe27mpQtchv
	 pimJ79riWTKpLdo2tTDvteySVMPzY9HMmZw1DH54ERGsZJ3IJIGrpEP5CpfqT1YgPw
	 58tfXJ8IyCy4v0J/G6oQbe5vHiNt/2qg/oWqgvFzhRChbjatlIee1HidLINogAmylI
	 eC0urE4XJ5kOlV1GjpdOGX7nKFy/bOvc7HQ2Rbi0YrkR0ZnwxhX+de64gLFMuj3dgt
	 glJ8h94h9ShC4lk/YDTzoGt2KCXa5F8p8FsGEYtbG/tXYulxWPMFayBRPkuHxjIEhF
	 HJIoef3AcFVnQ==
Date: Wed, 7 Aug 2024 12:29:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: viro@kernel.org, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	amir73il@gmail.com, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
Message-ID: <20240807-fehlschlag-entfiel-f03a6df0e735@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-17-viro@kernel.org>
 <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>

On Tue, Aug 06, 2024 at 03:32:20PM GMT, Andrii Nakryiko wrote:
> On Mon, Jul 29, 2024 at 10:20 PM <viro@kernel.org> wrote:
> >
> > From: Al Viro <viro@zeniv.linux.org.uk>
> >
> > Equivalent transformation.  For one thing, it's easier to follow that way.
> > For another, that simplifies the control flow in the vicinity of struct fd
> > handling in there, which will allow a switch to CLASS(fd) and make the
> > thing much easier to verify wrt leaks.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  kernel/bpf/verifier.c | 342 +++++++++++++++++++++---------------------
> >  1 file changed, 172 insertions(+), 170 deletions(-)
> >
> 
> This looks unnecessarily intrusive. I think it's best to extract the
> logic of fetching and adding bpf_map by fd into a helper and that way
> contain fdget + fdput logic nicely. Something like below, which I can
> send to bpf-next.
> 
> commit b5eec08241cc0263e560551de91eda73ccc5987d
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Tue Aug 6 14:31:34 2024 -0700
> 
>     bpf: factor out fetching bpf_map from FD and adding it to used_maps list
> 
>     Factor out the logic to extract bpf_map instances from FD embedded in
>     bpf_insns, adding it to the list of used_maps (unless it's already
>     there, in which case we just reuse map's index). This simplifies the
>     logic in resolve_pseudo_ldimm64(), especially around `struct fd`
>     handling, as all that is now neatly contained in the helper and doesn't
>     leak into a dozen error handling paths.
> 
>     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df3be12096cf..14e4ef687a59 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18865,6 +18865,58 @@ static bool bpf_map_is_cgroup_storage(struct
> bpf_map *map)
>          map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
>  }
> 
> +/* Add map behind fd to used maps list, if it's not already there, and return
> + * its index. Also set *reused to true if this map was already in the list of
> + * used maps.
> + * Returns <0 on error, or >= 0 index, on success.
> + */
> +static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd,
> bool *reused)
> +{
> +    struct fd f = fdget(fd);

Use CLASS(fd, f)(fd) and you can avoid all that fdput() stuff.

