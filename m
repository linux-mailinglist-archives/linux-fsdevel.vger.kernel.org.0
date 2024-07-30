Return-Path: <linux-fsdevel+bounces-24588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2AF940CAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 10:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27739B293EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 08:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747771946D2;
	Tue, 30 Jul 2024 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKlcqIXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936E1946AF;
	Tue, 30 Jul 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329951; cv=none; b=VPRSjFsuBZWhu20KPGp+eH9UQM0zshwifaYsceHvtFxMkgGiChe0ZxoxwUDDRxrOksVqzgJa9NbJoiuGwIdwECR+lYGbFyEB5z52YYeSyO+dPPFf/Iya6P3c2skdNvN7W38HrdJpQyMzQWHVwfriR6+PXStylYSnKfhJiMM6Z3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329951; c=relaxed/simple;
	bh=j20RqtXFvbXCUyQ8BFQH4YqmQwCiyncX0UNNT58JPcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WesKNa4DNqGadyRH+Yjfgt6BZSdh9ix+wyVfAjTVdAO/iS4rRUMi4WJoxq4Bru1ALn8akm+1eQ/kqikJOprD+hy6BwN9ZjG6wxB1ebmIrKplJpkzF+pFLH/COra/r4XGoYtVXyF6aAu0ygFk7T+fbW3rhs8Hos8ZGbpxbOeoLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKlcqIXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70BCC4AF09;
	Tue, 30 Jul 2024 08:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722329951;
	bh=j20RqtXFvbXCUyQ8BFQH4YqmQwCiyncX0UNNT58JPcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKlcqIXN2gNz/HMazGbiYngqP+Dcqs5f1WV9qb8BxQ0REdTBV1DLgoMe5Lb6Yujqh
	 JO3v3TDUpm+8lA7jCstdPje6B5/shSi654YRc8Q1EkWrHjZfkjNZE71+QcETEOLEHP
	 b6jbyZGkoSw9WoSkbiEZEy7e/hNEmm3xuVXQeH7f07AUufjBF6XZzqg/I7y0JTjJR4
	 2WXdABwRFJcYyRz1bLfopszXmFxDsyDLbl9r3uvTNcwTKCdZy5+lHMskJ4E7BtudHi
	 Bgs7u8Lc730Zht9AI/iiLP/TZsYeCQpj/z5bd9u1fdP0cfbsrSGYo4OJP/f5u6tK6y
	 vDv/yPSO3xjRQ==
Date: Tue, 30 Jul 2024 10:59:04 +0200
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
Message-ID: <20240730-unwahr-tannenwald-ee6157a063a4@brauner>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <2FE83412-65A5-451B-8722-E0B8035BFD30@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2FE83412-65A5-451B-8722-E0B8035BFD30@fb.com>

On Tue, Jul 30, 2024 at 05:58:31AM GMT, Song Liu wrote:
> Hi Christian, 
> 
> Thanks a lot for your detailed explanation! We will revisit the design 
> based on these comments and suggestions. 
> 
> One more question about a potential new kfunc bpf_get_inode_xattr(): 
> Should it take dentry as input? IOW, should it look like:
> 
> __bpf_kfunc int bpf_get_inode_xattr(struct dentry *dentry, const char *name__str,
>                                     struct bpf_dynptr *value_p)
> {
>         struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
>         u32 value_len;
>         void *value;
>         int ret;
> 
>         if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
>                 return -EPERM;
> 
>         value_len = __bpf_dynptr_size(value_ptr);
>         value = __bpf_dynptr_data_rw(value_ptr, value_len);
>         if (!value)
>                 return -EINVAL;
> 
>         ret = inode_permission(&nop_mnt_idmap, inode, MAY_READ);
>         if (ret)
>                 return ret;
>         return __vfs_getxattr(dentry, inode, name__str, value, value_len);
> }
> 
> 
> I am asking because many security_inode_* hooks actually taking dentry as 
> argument. So it makes sense to use dentry for kfuncs. Maybe we should

Some filesystems (i) require access to the @dentry in their xattr
handlers (e.g. 9p) and (ii) ->get() and ->set() xattr handlers can be
called when @inode hasn't been attached to @dentry yet.

So if you allowed to call bpf_get_*_xattr() from
security_d_instantiate() to somehow retrieve xattrs from there, then you
need to pass @dentry and @inode separately and you cannot use
@dentry->d_inode because it would still be NULL.

However, I doubt you'd call bpf_get_*_xattr() from
security_d_instantiate() so imo just pass the dentry and add a check
like:

struct inode *inode = d_inode(dentry);
if (WARN_ON(!inode))
	return -EINVAL;

in there.

