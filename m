Return-Path: <linux-fsdevel+bounces-50490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDAACC8AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8B33A7203
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392DB23875D;
	Tue,  3 Jun 2025 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZpTsnApp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F422E402
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959481; cv=none; b=fF3ZmgjqI+ECz6diVQGYITRsU/SMIRHPmaYqxL5NLiX+y6mkAUxWKmcM4YhoJQhu7ZUY/pakj/WcnsTqTq/cs4c4I8Ynl9JKej//5uTenNZvZx6Hzipg3QcDa5j54/sDLDbf+SzdTbSgee2jB2GSIpFPMHtKC52DoXJ+HJUu0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959481; c=relaxed/simple;
	bh=1b8DspUyz9OW+fbjvbxpYBzRCKsiS+bnCshxo8k2YQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jULB7HAQ3XollriVMDVcz3k/J/+BckEFnOHiGrT3eJNsqX5YtB8zWabecEvPjEG/qKw/gq6PBJFT2VvYHDSrhafsgEamZqHPFYsLLuz7rPlA+JjIBEKqWLNc2pvBeHQ02wjEVVG9tmSij+2NYAEmqeV/sK4XNoRwkVQZ+042sZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZpTsnApp; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bBX6g68h8zsWd;
	Tue,  3 Jun 2025 15:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748958363;
	bh=KAWPoC9zvEPauaI6cyydJqYESbKFRZuHC+VAaZx5WOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpTsnApp49R+bNOiE6dP1hnLqDaxZAaNt6CdHZqRInjWyzOCgcN8BV3jRefow07O/
	 IPu0YHtePqzbVKozWgi6MIIW9lTy6Av+xMYRgXrcqG+tmBEQqtoV7jTuE8XIjfKWUy
	 VLA+gISFSvWnRABg3tBG6DJZF0hoRATTfpuHNrX4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bBX6f47pWzJxJ;
	Tue,  3 Jun 2025 15:46:02 +0200 (CEST)
Date: Tue, 3 Jun 2025 15:46:01 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, m@maowtm.org
Subject: Re: [PATCH v2 bpf-next 2/4] landlock: Use path_walk_parent()
Message-ID: <20250603.Av6paek5saes@digikod.net>
References: <20250603065920.3404510-1-song@kernel.org>
 <20250603065920.3404510-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603065920.3404510-3-song@kernel.org>
X-Infomaniak-Routing: alpha

Landlock tests with hostfs fail:

ok 126 layout3_fs.hostfs.tag_inode_file
#  RUN           layout3_fs.hostfs.release_inodes ...
# fs_test.c:5555:release_inodes:Expected EACCES (13) == test_open(TMP_DIR, O_RDONLY) (0)

This specific test checks that an access to a (denied) mount point over
an allowed directory is indeed denied.

It's not clear to me the origin of the issue, but it seems to be related
to choose_mountpoint().

You can run these tests with `check-linux.sh build kselftest` from
https://github.com/landlock-lsm/landlock-test-tools

Just in case, please always run clang-format -i security/landlock/*.[ch]


On Mon, Jun 02, 2025 at 11:59:18PM -0700, Song Liu wrote:
> Use path_walk_parent() to walk a path up to its parent.
> 
> No functional changes intended.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/landlock/fs.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6fee7c20f64d..3adac544dc9e 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -837,8 +837,8 @@ static bool is_access_to_paths_allowed(
>  	 * restriction.
>  	 */
>  	while (true) {
> -		struct dentry *parent_dentry;
>  		const struct landlock_rule *rule;
> +		struct path root = {};
>  
>  		/*
>  		 * If at least all accesses allowed on the destination are
> @@ -895,34 +895,23 @@ static bool is_access_to_paths_allowed(
>  		/* Stops when a rule from each layer grants access. */
>  		if (allowed_parent1 && allowed_parent2)
>  			break;
> -jump_up:
> -		if (walker_path.dentry == walker_path.mnt->mnt_root) {
> -			if (follow_up(&walker_path)) {
> -				/* Ignores hidden mount points. */
> -				goto jump_up;
> -			} else {
> -				/*
> -				 * Stops at the real root.  Denies access
> -				 * because not all layers have granted access.
> -				 */
> -				break;
> -			}
> -		}
> +
> +		if (path_walk_parent(&walker_path, &root))
> +			continue;

It would be better to avoid a "continue" statement but to just use an if
block.

> +
>  		if (unlikely(IS_ROOT(walker_path.dentry))) {
>  			/*
> -			 * Stops at disconnected root directories.  Only allows
> -			 * access to internal filesystems (e.g. nsfs, which is
> -			 * reachable through /proc/<pid>/ns/<namespace>).
> +			 * Stops at disconnected or real root directories.
> +			 * Only allows access to internal filesystems
> +			 * (e.g. nsfs, which is reachable through
> +			 * /proc/<pid>/ns/<namespace>).
>  			 */
>  			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
>  				allowed_parent1 = true;
>  				allowed_parent2 = true;
>  			}
> -			break;
>  		}
> -		parent_dentry = dget_parent(walker_path.dentry);
> -		dput(walker_path.dentry);
> -		walker_path.dentry = parent_dentry;
> +		break;
>  	}
>  	path_put(&walker_path);
>  
> -- 
> 2.47.1
> 
> 

