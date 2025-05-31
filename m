Return-Path: <linux-fsdevel+bounces-50254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED381AC9A1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 10:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8801BA10FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCB823815B;
	Sat, 31 May 2025 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jq0/Bi8+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B72376F2
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 May 2025 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748680850; cv=none; b=fKBX4QJX3ab0HOvETnBWaFw/06rGd8+rKS8VWj7H/Gam82fdgGVegtRa+jMhYYbZhPwAwjr/4wBhlvdSeVahHFdQ19f9goWQaTFc36kuQ3hTkWr9FiVowu5zJt+XwrB+8gBoY1HvyidMiuqGQIkFyNunJdeUC+x1xOQtVRNRy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748680850; c=relaxed/simple;
	bh=nTTvmO1cQS3F/SnYQlmbLHNx64KvT3g8uZsDvQW8aiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enj9KU9KrpQG4S6zxFpwCijM0LMNfAFCd2FZvJ8kmQGgD3abi2J86DbCP1mvK3m41VcXsVuh5odHzZbh00gNrUOmPCCk3Zc8l077PbXiZ9LtXfCksqGl7Jjk7UxdSaIS04wLYIW495qdnlHHQVN5nFOXviGsdoQHb+PYRfyWrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jq0/Bi8+; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b8YTg2G0szT3S;
	Sat, 31 May 2025 10:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748680839;
	bh=aDOO32soUx4ivBS0LOVNv8TRKSSec0lWi7HQfvCT8e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jq0/Bi8+MOFNrvGElUvgAA7b3qMIfXmvs2twjH4EckrdBmPRh0NkPqeDhqTtGHKWj
	 dGyOIb/Vwxx8I3F21FPxR3kwyxqfjiZ94ePth/mpbkFxdUsG20sLI1so0QWMf8sbiq
	 B1ff02L/uAlw5HdyIhkoa527/lgUTp03qqNX0lbU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b8YTf4WfDzSmT;
	Sat, 31 May 2025 10:40:38 +0200 (CEST)
Date: Sat, 31 May 2025 10:40:37 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, 
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250531.NaQu4eic9ieN@digikod.net>
References: <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV>
 <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV>
 <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV>
 <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
 <20250530.euz5beesaSha@digikod.net>
 <CAPhsuW5U-nPk4MFdZSeBNds0qEHjQZrC=c5q+AGNpsKiveC2wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5U-nPk4MFdZSeBNds0qEHjQZrC=c5q+AGNpsKiveC2wA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, May 30, 2025 at 11:55:22AM -0700, Song Liu wrote:
> On Fri, May 30, 2025 at 5:20 AM Mickaël Salaün <mic@digikod.net> wrote:
> [...]
> > >
> > > If we update path_parent in this patchset with choose_mountpoint(),
> > > and use it in Landlock, we will close this race condition, right?
> >
> > choose_mountpoint() is currently private, but if we add a new filesystem
> > helper, I think the right approach would be to expose follow_dotdot(),
> > updating its arguments with public types.  This way the intermediates
> > mount points will not be exposed, RCU optimization will be leveraged,
> > and usage of this new helper will be simplified.
> 
> I think it is easier to add a helper similar to follow_dotdot(), but not with
> nameidata. follow_dotdot() touches so many things in nameidata, so it
> is better to keep it as-is. I am having the following:

I was not suggesting to expose nameidata (only struct path and int), but
yes, a standalone helper is OK and it will not tie it to the current
follow_dotdot() internals.

> 
> /**
>  * path_parent - Find the parent of path

Because we update @path, I'd suggest a name containing "walk", something
like path_walk_parent().

>  * @path: input and output path.
>  * @root: root of the path walk, do not go beyond this root. If @root is
>  *        zero'ed, walk all the way to real root.
>  *
>  * Given a path, find the parent path. Replace @path with the parent path.
>  * If we were already at the real root or a disconnected root, @path is
>  * not changed.

We should explain that the semantic is the same as follow_dotdot(), but
not follow_dots().

>  *
>  * Returns:
>  *  true  - if @path is updated to its parent.
>  *  false - if @path is already the root (real root or @root).
>  */
> bool path_parent(struct path *path, const struct path *root)
> {
>         struct dentry *parent;
> 
>         if (path_equal(path, root))
>                 return false;
> 
>         if (unlikely(path->dentry == path->mnt->mnt_root)) {
>                 struct path p;
> 
>                 if (!choose_mountpoint(real_mount(path->mnt), root, &p))
>                         return false;
>                 path_put(path);
>                 *path = p;
>                 return true;
>         }
> 
>         if (unlikely(IS_ROOT(path->dentry)))
>                 return false;
> 
>         parent = dget_parent(path->dentry);
>         if (unlikely(!path_connected(path->mnt, parent))) {
>                 dput(parent);
>                 return false;
>         }
>         dput(path->dentry);
>         path->dentry = parent;
>         return true;
> }
> EXPORT_SYMBOL_GPL(path_parent);
> 
> And for Landlock, it is simply:
> 
>                 if (path_parent(&walker_path, &root))
>                         continue;
> 
>                 if (unlikely(IS_ROOT(walker_path.dentry))) {
>                         /*
>                          * Stops at disconnected or real root directories.
>                          * Only allows access to internal filesystems
>                          * (e.g. nsfs, which is reachable through
>                          * /proc/<pid>/ns/<namespace>).
>                          */
>                         if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
>                                 allowed_parent1 = true;
>                                 allowed_parent2 = true;
>                         }
>                         break;
>                 }
> 
> Does this look right?

Yes, thanks.

Al, Christian, would that be OK to backport this helper to fix the
Landlock issue?  If yes, Song could you please put it in in a place that
could be easily backported down to 5.15 e.g., just after handle_dots()?

> 
> Thanks,
> Song
> 

