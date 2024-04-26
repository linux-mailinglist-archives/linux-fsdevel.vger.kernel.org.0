Return-Path: <linux-fsdevel+bounces-17879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B906B8B3375
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3861F21440
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E0413CF8D;
	Fri, 26 Apr 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duIlAcoE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954D23A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121919; cv=none; b=mTZrHg0lbRzyFh/trOi5KMqm+O6nNrO4Lnz6s1tJYoQ2viCMrz6GY8HOSBdo2EWlds5pVg6gPeAOfpn5yliqCBjPBkcN+FYjz3DS2y12V1tmGQeltqobm/nMKbwrWX8MBnFBSiGfbvLk3L6WHgAj3IkqhIiIppbKuaGceBfSesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121919; c=relaxed/simple;
	bh=0SmOUhVUwWxtwCtv+kK8udGkIddWAy8YYFOJ0of7ixQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtemRPjDAvndldpnyG/W6YG3oxweEx66BHxPqlmx7SRCNzKBCPr7FlaBS3O5E+Fx5hCvHSmab8YwGpvWRGSqVvpBR4R7vnOlgQfpVqUH7Vsca69Zz7PeJuGWSyVazjkOkXLUZhWdu0jCsS4FH6aFwOMZinPIwhfSJD3wso4G1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duIlAcoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6060C113CD;
	Fri, 26 Apr 2024 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714121919;
	bh=0SmOUhVUwWxtwCtv+kK8udGkIddWAy8YYFOJ0of7ixQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=duIlAcoEYKCS5r34BSQ1rAaNU4EWq0TAy5e1qD9vS7aFIv8x2lGaMl4a5qFiiD0Zg
	 sK2MxvWTD2ZGgo+DozovyOvGr++zWrf63pzslLHG83q36ObPanUwvTvRnXdKv1dWWg
	 WepJ5vaWXttkA0V5bVuT7Q+zTdXZVCsJvX51MLkvHOGFMo/6l+E2MN5gkY2vBNpToZ
	 29pSGMkarfyb6pB90wK4mmYk3/+6PQXu07jxqnq5H86b34OVCglXNuzCySj6j6Vf1B
	 bB5NZTbZu0aiaxbXctqdM/2Td2TiLpYDbFSpxwWzYW5fihd7g7KxDwfhQPmTrFAEjr
	 9RjIzrg62cF+w==
Date: Fri, 26 Apr 2024 10:58:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dawid Osuchowski <linux@osuchow.ski>, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH] fs: Create anon_inode_getfile_fmode()
Message-ID: <20240426-achsen-aufnimmt-8ff4ff3933ec@brauner>
References: <20240424233859.7640-1-linux@osuchow.ski>
 <20240425-wohltat-galant-16b3360118d0@brauner>
 <20240425202550.GL2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425202550.GL2118490@ZenIV>

On Thu, Apr 25, 2024 at 09:25:50PM +0100, Al Viro wrote:
> On Thu, Apr 25, 2024 at 11:57:12AM +0200, Christian Brauner wrote:
> > On Thu, Apr 25, 2024 at 01:38:59AM +0200, Dawid Osuchowski wrote:
> > > Creates an anon_inode_getfile_fmode() function that works similarly to
> > > anon_inode_getfile() with the addition of being able to set the fmode
> > > member.
> > 
> > And for what use-case exactly?
> 
> There are several places where we might want that -
> arch/powerpc/platforms/pseries/papr-vpd.c:488:  file = anon_inode_getfile("[papr-vpd]", &papr_vpd_handle_ops,
> fs/cachefiles/ondemand.c:233:   file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
> fs/eventfd.c:412:       file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
> in addition to vfio example Dawid mentions, as well as a couple of
> borderline cases in
> virt/kvm/kvm_main.c:4404:       file = anon_inode_getfile(name, &kvm_vcpu_stats_fops, vcpu, O_RDONLY);
> virt/kvm/kvm_main.c:5092:       file = anon_inode_getfile("kvm-vm-stats",
> 
> So something of that sort is probably a good idea.  Said that,

Ok. It wouldn't be the worst if @Dawid would also sent a follow-patch
converting the obvious cases over to the new helper then.

> what the hell is __anon_inode_getfile_fmode() for?  It's identical

Unrelated to this patch but the other really unpleasant part is that
"make_secure" boolean argument to __anon_inode_getfile() to indicate
allocation of a new inode. That "context_inode" argument is also really
unused for the normal case where the same anon_inode_inode is reused...
IMHO, that should just be split apart. A little more code but it would
make things easier to understand imho...

> to exported variant, AFAICS.  And then there's this:
> 
> 	if (IS_ERR(file))
> 		goto err;
> 
> 	file->f_mode |= f_mode;
> 
> 	return file;
> 
> err:
> 	return file;
> 
> a really odd way to spell
> 
> 	if (!IS_ERR(file))
> 		file->f_mode |= f_mode;
> 	return file;

Yeah.

