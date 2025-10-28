Return-Path: <linux-fsdevel+bounces-65933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB7C15928
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 16:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF5B583E9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76191346E54;
	Tue, 28 Oct 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJmp6vL6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C381C343201;
	Tue, 28 Oct 2025 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665727; cv=none; b=k39n4KY06rsOaZ0g6bt3JuRtovb9mv8nz7XgVKuKHVB2sBDWa+wifaZOFe+djV5XwGWRazLWtwpQxsktYj2oWqBD50FLq4SZl3AvxPULrBvW77pEU2RVp296hG1UiMiNXyJU4KpATSHpFlMFkhsgQEqA7Qsz+KV2rgaFfXzdZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665727; c=relaxed/simple;
	bh=XDSphA7M0KqEyT9oZXf8qdOBa7UTta4TwmsLygt7ZTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXn1C0LWy4r9HYVocmBHPvg5HEYgrvLSKybXNAQVa2YybLAfPFiqei60XvMSaekRo5CVATZNgHvXqOtKaYOvGZIWAjELUajt/o6w6Tvus1FfHt9L5weF1ysGVrR1SvahEhwrAWmmvSJm8CDCcUoVIeioZacau9gSf7ZO0gqBpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJmp6vL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CE1C4CEE7;
	Tue, 28 Oct 2025 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665727;
	bh=XDSphA7M0KqEyT9oZXf8qdOBa7UTta4TwmsLygt7ZTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJmp6vL6dppxzvX5qFWqUolObLjzw6jDD6PsYBDge2koSgO179wZQjpg53H/YEIwF
	 hQ0rOkVXG38cq/NgEGr2MKN/LKb5Q5qO3o30f32OrvYuMzcHmZQuIHT6vr/LFcpZIm
	 01SrOw3aNABZL1r3Kjh37SxWZ3tnFkpD5T/LmwDFNUHA5++K+Kzb5pVdaJ/CLs8Zn2
	 Z7hUrPOuP+PqfpLDkG0HxK5yQNX6MmAMH9TTly9tJQWAOQ8Y6Px6p6CVbc+QBxZKgY
	 cEEdxRaOiaG1UpTqvwhjp+lvisu/653SH68Z6dT6EMbJh5Bl3Fnor1qnHOA8eMoFcU
	 q2mQjY2ho+OuQ==
Date: Tue, 28 Oct 2025 16:35:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 05/70] nsfs: raise SB_I_NODEV and SB_I_NOEXEC
Message-ID: <20251028-neigen-parken-d722bb0aafc4@brauner>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
 <20251024-work-namespace-nstree-listns-v3-5-b6241981b72b@kernel.org>
 <bbfabc89c545bb7c4bddf48c04408c3d9fc442e7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbfabc89c545bb7c4bddf48c04408c3d9fc442e7.camel@kernel.org>

On Mon, Oct 27, 2025 at 09:13:21AM -0400, Jeff Layton wrote:
> On Fri, 2025-10-24 at 12:52 +0200, Christian Brauner wrote:
> > There's zero need for nsfs to allow device nodes or execution.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/nsfs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/nsfs.c b/fs/nsfs.c
> > index 0e3fe8fda5bf..363be226e357 100644
> > --- a/fs/nsfs.c
> > +++ b/fs/nsfs.c
> > @@ -589,6 +589,8 @@ static int nsfs_init_fs_context(struct fs_context *fc)
> >  	struct pseudo_fs_context *ctx = init_pseudo(fc, NSFS_MAGIC);
> >  	if (!ctx)
> >  		return -ENOMEM;
> > +	fc->s_iflags |= SB_I_NOEXEC;
> > +	fc->s_iflags |= SB_I_NODEV;
> 
> nit: why not do this in one?
> 
> 	fc->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;

done.

