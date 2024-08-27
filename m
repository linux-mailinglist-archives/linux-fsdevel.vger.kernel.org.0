Return-Path: <linux-fsdevel+bounces-27417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE7961532
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C871F24898
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9E1CCB4A;
	Tue, 27 Aug 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPmX820O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5143AD9;
	Tue, 27 Aug 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778709; cv=none; b=TgrIzqVo2AYQqJnXaLO2PkpmSW9VvHuaznIEq33/1f6Y/eyV4hWkMvtZ+EhR0jxfMqfzb/vVlcSq22sZmhpWDEvmYNdWuAsTn+q2WIciJzPlRDj8+9d7dkyJ/jBCrz+4cidKuugjULuuN1dNeW3XNbehafGbayFKjkFWMCSHCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778709; c=relaxed/simple;
	bh=Uj/PSdEkJOo74jf9xmu8V8GJbvLcsYrAK4+lCfwJxXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF6DyOlguwC41+kcgYvXtBdo2InFhgFtkaVHs/iQOMHO4kHUbXuD6gr/pHUQq/MeXKRD9PqwDXloL83sMg5kjfwVbYm0/vR92CpeIY9/EkE2t3TbStU4j1m67ymQU13jV3wPUDtEzcY4xmzDA0rQcGw/ifa80XR6syPNqlHfEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPmX820O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0267C4DDF6;
	Tue, 27 Aug 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724778708;
	bh=Uj/PSdEkJOo74jf9xmu8V8GJbvLcsYrAK4+lCfwJxXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPmX820O2918yilIJofMPcnqcD5EII5EDV2BZZgBcQFzp5R/9CRnuC2N5UUHdxfbE
	 qwMnYZLl8FhDUbPVIr7BGpQAQVIqTqQ8UpUI/aCBh20dtQjG6BTk8cQWGy+yloRuHB
	 Jue+x26nmmCIhlfPtmaMHXXI0OuOxZddSQVUI2/7EvjW4rjjFv/afz1vaBeIPmBLHw
	 oSEsINWMFX4rBsQ2ZvrpmxggSkrqbg7Cj+zf1yUoR+bZprAUD7t5RH26yoaRBftHnL
	 6weYVN58QXJaKmMgDSCKZUt6S7voJsyvWJoJB2N/hYj0DfhNdBiD6fKQZTUhbENgZX
	 Sh/vVfxZUFBxw==
Date: Tue, 27 Aug 2024 10:11:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, jack@suse.cz,
	viro@zeniv.linux.org.uk, gnoack@google.com, mic@digikod.net,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <20240827171148.GN6043@frogsfrogsfrogs>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
 <20240827053712.GL6043@frogsfrogsfrogs>
 <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>

On Tue, Aug 27, 2024 at 11:22:17AM +0200, Christian Brauner wrote:
> On Mon, Aug 26, 2024 at 10:37:12PM GMT, Darrick J. Wong wrote:
> > On Tue, Aug 27, 2024 at 10:32:38AM +0800, Hongbo Li wrote:
> > > 
> > > 
> > > On 2024/8/27 10:13, Darrick J. Wong wrote:
> > > > On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> > > > > Many mainstream file systems already support the GETVERSION ioctl,
> > > > > and their implementations are completely the same, essentially
> > > > > just obtain the value of i_generation. We think this ioctl can be
> > > > > implemented at the VFS layer, so the file systems do not need to
> > > > > implement it individually.
> > > > 
> > > > What if a filesystem never touches i_generation?  Is it ok to advertise
> > > > a generation number of zero when that's really meaningless?  Or should
> > > > we gate the generic ioctl on (say) whether or not the fs implements file
> > > > handles and/or supports nfs?
> > > 
> > > This ioctl mainly returns the i_generation, and whether it has meaning is up
> > > to the specific file system. Some tools will invoke IOC_GETVERSION, such as
> > > `lsattr -v`(but if it's lattr, it won't), but users may not necessarily
> > > actually use this value.
> > 
> > That's not how that works.  If the kernel starts exporting a datum,
> > people will start using it, and then the expectation that it will
> > *continue* to work becomes ingrained in the userspace ABI forever.
> > Be careful about establishing new behaviors for vfat.
> 
> Is the meaning even the same across all filesystems? And what is the
> meaning of this anyway? Is this described/defined for userspace
> anywhere?

AFAICT there's no manpage so I guess we could return getrandom32() if we
wanted to. ;)

But in seriousness, the usual four filesystems return i_generation.
That is changed every time an inumber gets reused so that anyone with an
old file handle cannot accidentally open the wrong file.  In theory one
could use GETVERSION to construct file handles (if you do, UHLHAND!)
instead of using name_to_handle_at, which is why it's dangerous to
implement GETVERSION for everyone without checking if i_generation makes
sense.

--D

