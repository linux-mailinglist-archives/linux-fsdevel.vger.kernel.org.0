Return-Path: <linux-fsdevel+bounces-50376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB080ACBA67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 19:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3970B3B2E06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A946223DED;
	Mon,  2 Jun 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="M8OOQWx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3822578D
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885760; cv=none; b=ChsRlv556ChAuC8afxDy1aELmefzTy0R6IZCwzhdSOUvecidCZZSPgik+rDSzVLAU42Lxss1ex9IhQkScvICeFePvPaMkSOPDGMrsgio5+llPGvWnWiiKPb4jbuzjvjK9XxNPSbgwRk19IYsri/mgGvkOGVG5541b480MwMXE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885760; c=relaxed/simple;
	bh=VUhI7CSW76kd/2BwwKOpp8s7Bj4/P8quxGT6EYFmteI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC3Q2+SW7t3T3YhagwCHdC0Z7OiNw3yyLmYLD6RXckERaDEB23P8pM1JPs1BDMKc/TnLvkQasd/gITZts9Fm+7Isml4c2e0v+eii7zWb5mo2aXNz9r3EnWE19xTf84W7iyrGB4BQfKPGYwK2M1XB8EWKrXD26LX/GE63rWFRi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=M8OOQWx+; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bB1GF445mzsq2;
	Mon,  2 Jun 2025 19:35:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748885749;
	bh=I1+g0eVqjmTqLKooXrJGQ9n+AkRh/ReUCRj2fzMRkns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8OOQWx+BGV1YUVOeH25ve75KC7jFyye0iOoy0EdCVr6ZYaGDhtsX014OSqpfPhUm
	 +3dbggZnfrD0emuVwQjB8/b2KnTe5Fle3MHkvDZTinGUDPcs8WLizrFvMv4EhSC1Fo
	 YzC244GupgBAhzLZ6CBxPV9ycq9vUURFtNoKj8sU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bB1GD2KT5zbdy;
	Mon,  2 Jun 2025 19:35:48 +0200 (CEST)
Date: Mon, 2 Jun 2025 19:35:47 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, 
	gnoack@google.com
Subject: Re: [PATCH bpf-next 2/4] landlock: Use path_parent()
Message-ID: <20250602.Oqu6piethung@digikod.net>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-3-song@kernel.org>
 <027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org>
X-Infomaniak-Routing: alpha

On Sat, May 31, 2025 at 02:51:22PM +0100, Tingmao Wang wrote:
> On 5/28/25 23:26, Song Liu wrote:
> > Use path_parent() to walk a path up to its parent.
> > 
> > While path_parent() has an extra check with path_connected() than existing
> > code, there is no functional changes intended for landlock.
> > 
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  security/landlock/fs.c | 34 +++++++++++++++++-----------------
> >  1 file changed, 17 insertions(+), 17 deletions(-)
> > 
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index 6fee7c20f64d..32a24758ad6e 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -837,7 +837,6 @@ static bool is_access_to_paths_allowed(
> >  	 * restriction.
> >  	 */
> >  	while (true) {
> > -		struct dentry *parent_dentry;
> >  		const struct landlock_rule *rule;
> >  
> >  		/*
> > @@ -896,19 +895,17 @@ static bool is_access_to_paths_allowed(
> >  		if (allowed_parent1 && allowed_parent2)
> >  			break;
> >  jump_up:
> > -		if (walker_path.dentry == walker_path.mnt->mnt_root) {
> > -			if (follow_up(&walker_path)) {
> > -				/* Ignores hidden mount points. */
> > -				goto jump_up;
> > -			} else {
> > -				/*
> > -				 * Stops at the real root.  Denies access
> > -				 * because not all layers have granted access.
> > -				 */
> > -				break;
> > -			}
> > -		}
> > -		if (unlikely(IS_ROOT(walker_path.dentry))) {
> > +		switch (path_parent(&walker_path)) {
> > +		case PATH_PARENT_CHANGED_MOUNT:
> > +			/* Ignores hidden mount points. */
> > +			goto jump_up;
> > +		case PATH_PARENT_REAL_ROOT:
> > +			/*
> > +			 * Stops at the real root.  Denies access
> > +			 * because not all layers have granted access.
> > +			 */
> > +			goto walk_done;
> > +		case PATH_PARENT_DISCONNECTED_ROOT:
> >  			/*
> >  			 * Stops at disconnected root directories.  Only allows
> >  			 * access to internal filesystems (e.g. nsfs, which is
> 
> I was looking at the existing handling of disconnected root in Landlock
> and I realized that the comment here confused me a bit:
> 
> /*
>  * Stops at disconnected root directories.  Only allows
>  * access to internal filesystems (e.g. nsfs, which is
>  * reachable through /proc/<pid>/ns/<namespace>).
>  */
> 
> In the original code, this was under a
> 
>     if (unlikely(IS_ROOT(walker_path.dentry)))
> 
> which means that it only stops walking if we found out we're disconnected
> after reaching a filesystem boundary.  However if before we got to this
> point, we have already collected enough rules to allow access, access
> would be allowed, even if we're currently disconnected.  Demo:
> 
> / # cd /
> / # cp /linux/samples/landlock/sandboxer .
> / # mkdir a b
> / # mkdir a/foo
> / # echo baz > a/foo/bar
> / # mount --bind a b
> / # LL_FS_RO=/ LL_FS_RW=/ ./sandboxer bash
> Executing the sandboxed command...
> / # cd /b/foo
> /b/foo # cat bar
> baz
> /b/foo # mv /a/foo /foo
> /b/foo # cd ..     # <- We're now disconnected
> bash: cd: ..: No such file or directory
> /b/foo # cat bar
> baz                # <- but landlock still lets us read the file
> 
> However, I think this patch will change this behavior due to the use of
> path_connected
> 
> root@10a8fff999ce:/# mkdir a b
> root@10a8fff999ce:/# mkdir a/foo
> root@10a8fff999ce:/# echo baz > a/foo/bar
> root@10a8fff999ce:/# mount --bind a b
> root@10a8fff999ce:/# LL_FS_RO=/ LL_FS_RW=/ ./sandboxer bash
> Executing the sandboxed command...
> bash: cannot set terminal process group (191): Inappropriate ioctl for device
> bash: no job control in this shell
> root@10a8fff999ce:/# cd /b/foo
> root@10a8fff999ce:/b/foo# cat bar
> baz
> root@10a8fff999ce:/b/foo# mv /a/foo /foo
> root@10a8fff999ce:/b/foo# cd ..
> bash: cd: ..: No such file or directory
> root@10a8fff999ce:/b/foo# cat bar
> cat: bar: Permission denied

This is a good test case, we should add a test for that.

> 
> I'm not sure if the original behavior was intentional, but since this
> technically counts as a functional changes, just pointing this out.

This is indeed an issue.

> 
> Also I'm slightly worried about the performance overhead of doing
> path_connected for every hop in the iteration (but ultimately it's
> Mickaël's call).

Yes, we need to check with a benchmark.  We might want to keep the
walker_path.dentry == walker_path.mnt->mnt_root check inlined.

> At least for Landlock, I think if we want to block all
> access to disconnected files, as long as we eventually realize we have
> been disconnected (by doing the "if dentry == path.mnt" check once when we
> reach root), and in that case deny access, we should be good.
> 
> 
> > @@ -918,12 +915,15 @@ static bool is_access_to_paths_allowed(
> >  				allowed_parent1 = true;
> >  				allowed_parent2 = true;
> >  			}
> > +			goto walk_done;
> > +		case PATH_PARENT_SAME_MOUNT:
> >  			break;
> > +		default:
> > +			WARN_ON_ONCE(1);
> > +			goto walk_done;
> >  		}
> > -		parent_dentry = dget_parent(walker_path.dentry);
> > -		dput(walker_path.dentry);
> > -		walker_path.dentry = parent_dentry;
> >  	}
> > +walk_done:
> >  	path_put(&walker_path);
> >  
> >  	if (!allowed_parent1) {
> 
> 

