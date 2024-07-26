Return-Path: <linux-fsdevel+bounces-24309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB41593D291
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 13:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF5C1F21C98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1860A17A93B;
	Fri, 26 Jul 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCRHfvik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7AC219EA;
	Fri, 26 Jul 2024 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994706; cv=none; b=kt1TOxwkRuGM/jHnRqSVGbUbuW0/wmSNrce1apHqPB/rg5hwAIWx8vv+xCErMy6W/N2vOp0VJPAGjjKfLJnzeA4lyGOv+9x7SbbfD7GN9dvduFjW6PDX+ihIroqt9lfDtDMUpwzJHB/oUVHIj6D5HeQfYiVcCxokYt2/26Es5Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994706; c=relaxed/simple;
	bh=eiFrnlEUEtXEpfYmJoBp3el2l9cHfefFJBOA7DotVU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvpWo5jS1uJHIMDtwY4rO65lEJ8DnJiWF9CvidKa+I2AT5m3Bhabr40TZgC2SgEbFe2ps7pJzcQBxffC4Hp5R/PxDABzlmCqdVEdb8CPou3uUz6oyZ8QGSUfLnz2YSNxHsQUWjis6ano75z1EGQ70F+r1tHTIMGCHyjR5pNFMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCRHfvik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F72C32782;
	Fri, 26 Jul 2024 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721994705;
	bh=eiFrnlEUEtXEpfYmJoBp3el2l9cHfefFJBOA7DotVU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCRHfvik6OhJ4XuyvfAXfpfygxLpx+LvsQSNomgZxDa7kNkq1Usr+cT+KV9CPEj6K
	 MccRZPyKf7EoCsjHmlATSsB+iuelf4yxm64NGOdYgs6thSOSo34jgVKoJVZA2dJHgF
	 PkQGoneFVon5z52+WcYm2jLxhQAioEqc7vYECKQs/3AsLCPkLlrsh9TfkOa9ilgMwr
	 6B5O0OvBg66P3GmqES4hwTdtn67Eb8coovULuG1UCiy/PilpB4AVu0CI7XTCuzDvGJ
	 URpaNrpVwseFQKXP1/LxwM3oShCLLiI0bnqeRGqgvLVCz0OA1k5LwNrEzQUVf7N1w+
	 sNcDKfRVg6fhQ==
Date: Fri, 26 Jul 2024 13:51:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com" <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Message-ID: <20240726-beisammen-degen-b70ec88e7ab2@brauner>
References: <20240725234706.655613-1-song@kernel.org>
 <20240725234706.655613-3-song@kernel.org>
 <20240726-frequentieren-undenkbar-5b816a3b8876@brauner>
 <1A0AAD8C-366E-45E2-A386-B4CCB5401D81@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1A0AAD8C-366E-45E2-A386-B4CCB5401D81@fb.com>

On Fri, Jul 26, 2024 at 09:19:54AM GMT, Song Liu wrote:
> Hi Christian, 
> 
> > On Jul 26, 2024, at 12:06 AM, Christian Brauner <brauner@kernel.org> wrote:
> 
> [...]
> 
> >> +
> >> + for (i = 0; i < 10; i++) {
> >> + ret = bpf_get_dentry_xattr(dentry, "user.kfunc", &value_ptr);
> >> + if (ret == sizeof(expected_value) &&
> >> +    !bpf_strncmp(value, ret, expected_value))
> >> + matches++;
> >> +
> >> + prev_dentry = dentry;
> >> + dentry = bpf_dget_parent(prev_dentry);
> > 
> > Why do you need to walk upwards and instead of reading the xattr values
> > during security_inode_permission()?
> 
> In this use case, we would like to add xattr to the directory to cover
> all files under it. For example, assume we have the following xattrs:
> 
>   /bin  xattr: user.policy_A = value_A
>   /bin/gcc-6.9/ xattr: user.policy_A = value_B
>   /bin/gcc-6.9/gcc xattr: user.policy_A = value_C
> 
> /bin/gcc-6.9/gcc will use value_C;
> /bin/gcc-6.9/<other_files> will use value_B;
> /bin/<other_folder_or_file> will use value_A;
> 
> By walking upwards from security_file_open(), we can finish the logic 
> in a single LSM hook:
> 
>     repeat:
>         if (dentry have user.policy_A) {
>             /* make decision based on value */;
>         } else {
>             dentry = bpf_dget_parent();
>             goto repeat;
>         }
> 
> Does this make sense? Or maybe I misunderstood the suggestion?

Imho, what you're doing belongs into inode_permission() not into
security_file_open(). That's already too late and it's somewhat clear
from the example you're using that you're essentially doing permission
checking during path lookup.

Btw, what you're doing is potentially very heavy-handed because you're
retrieving xattrs for which no VFS cache exists so you might end up
causing a lot of io.

Say you have a 10000 deep directory hierarchy and you open a
file_at_level_10000. With that dget_parent() logic in the worst case you
end up walking up the whole hierarchy reading xattr values from disk
10000 times. You can achieve the same result and cleaner if you do the
checking in inode_permission() where it belongs and you only cause all
of that pain once and you abort path lookup correctly.

Also, I'm not even sure this is always correct because you're
retroactively checking what policy to apply based on the xattr value
walking up the parent chain. But a rename could happen and then the
ancestor chain you're checking is different from the current chain or
there's a bunch of mounts along the way.

Imho, that dget_parent() thing just encourages very badly written bpf
LSM programs. That's certainly not an interface we want to expose.

> Also, we don't have a bpf_get_inode_xattr() yet. I guess we will need
> it for the security_inode_permission approach. If we agree that's a 

Yes, that's fine.

You also need to ensure that you're only reading user.* xattrs. I know
you already do that for bpf_get_file_xattr() but this helper needs the
same treatment.

And you need to force a drop-out of RCU path lookup btw because you're
almost definitely going to block when you check the xattr.

> better approach, I more than happy to implement it that way. In fact,
> I think we will eventually need both bpf_get_inode_xattr() and 
> bpf_get_dentry_xattr(). 

I'm not sure about that because it's royally annoying in the first place
that we have to dentry and inode separately in the xattr handlers
because LSMs sometimes call them from a location when the dentry and
inode aren't yet fused together. The dentry is the wrong data structure
to care about here.

