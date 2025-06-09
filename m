Return-Path: <linux-fsdevel+bounces-51061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ACDAD2558
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 20:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4823216BE6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BBF21CC57;
	Mon,  9 Jun 2025 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHoGvhZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F101182BD;
	Mon,  9 Jun 2025 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749492807; cv=none; b=d1tmMGFrwZVoWgHNmsM4AWgLfNFYY4Uo9a/27mPI8rtVfQB5dqAU2hkRdwgWMcjG4+01x1MeLTcJPtaiDMdtoe3YXhZpsODkAzviVf+pVo4YwfpBM947Xu+Ualu5R1+EgtHoSH61sibGgwDLn6GebJBZsU/Q/HpHnE7rJbd1wMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749492807; c=relaxed/simple;
	bh=aobCVpHT46ndsXFydgOluHlrPIMNa+5QUrmVNuOfLVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poJ010/+FhCpPBBDMldZuKbFEQ6U9kC7oVrHdPfkKQD91qVDtmsNZtPrMyjYPLopbLFoI2nfNvwlOsBtv675gs51GehAFJCoUSOFY6Sh/OWbFVpEGq0WlSKyPs34lyUxkJ4HrXXMpZTwBj41L9mczTUiwCECD0+DLrVnVcef7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHoGvhZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C55C4CEEB;
	Mon,  9 Jun 2025 18:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749492807;
	bh=aobCVpHT46ndsXFydgOluHlrPIMNa+5QUrmVNuOfLVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHoGvhZwB1IaxUGWDFHIso17lMET/2DQHFIzoJVffn9EVWVLDvDXJnra+9AFUNdxz
	 eKxDulST3YSF1TaXarCGRg9+fEk4OJo3ONi1PRilTh2w0vGlMbJ1RzX2y7RotsjuLV
	 rgSJoN/6qmgQqQunrved/L4D7VFDFVSKO1Krz60Pe3pR22FDJnj27/z6tUtboDDyIB
	 fa3753KOa1awStvXeHWOaALRBV0RI4WfrS2HfSyGhp7kEnpEiBVYEtWVbmYE2JDgGT
	 NDwh87Gj9y/mUMEBY/tMr/huYRcXgCBJh6xKsA2WQ6GhSyn1iEwdoSrfCSZB9uV772
	 SHYqmimPZDVmw==
Date: Mon, 9 Jun 2025 11:13:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
	linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Subject: Re: [PATCH 01/11] fuse: fix livelock in synchronous file put from
 fuseblk workers
Message-ID: <20250609181326.GC6179@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
 <174787195588.1483178.6811285839793085547.stgit@frogsfrogsfrogs>
 <CAJfpegsn2eBjy27rncxYBQ1heoiA1tme8oExF-d_C9DoFq34ow@mail.gmail.com>
 <20250531010844.GF8328@frogsfrogsfrogs>
 <CAJfpegvwXqL_N0POa95KgPJT5mMXS2xxCojbGWABhFCZy8An+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvwXqL_N0POa95KgPJT5mMXS2xxCojbGWABhFCZy8An+g@mail.gmail.com>

On Fri, Jun 06, 2025 at 03:54:50PM +0200, Miklos Szeredi wrote:
> On Sat, 31 May 2025 at 03:08, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > The best reason that I can think of is that normally the process that
> > owns the fd (and hence is releasing it) should be made to wait for
> > the release, because normally we want processes that generate file
> > activity to pay those costs.
> 
> That argument seems to apply to all fuse variants.  But fuse does get
> away with async release and I don't see why fuseblk would be different
> in this respect.
> 
> Trying to hack around the problems of sync release with a task flag
> that servers might or might not have set does not feel a very robust
> solution.
> 
> > Also: is it a bug that the kernel only sends FUSE_DESTROY on umount for
> > fuseblk filesystems?  I'd have thought that you'd want to make umount
> > block until the fuse server is totally done.  OTOH I guess I could see
> > an argument for not waiting for potentially hung servers, etc.
> 
> It's a potential DoS.  With allow_root we could arguably enable
> FUSE_DESTROY, since the mounter is explicitly acknowledging this DoS
> possibilty.

<nod> Looking deeper at fuse2fs's op_destroy function, I think most of
the slow functionality (writing group descriptors and the primary super
and fsyncing the device) ought to be done via FUSE_SYNCFS, not
FUSE_DESTROY.  If I made that change, I think op_destroy becomes very
fast -- all it does is close the fs and log a message.  The VFS unmount
code calls sync_filesystem (which initiates a FUSE_SYNCFS) which sounds
like it would work for fuse2fs.

Unhappily, libfuse3 doesn't seem to implement it:

$ git grep FUSE_SYNCFS
doc/libfuse-operations.txt:394:50. FUSE_SYNCFS (50)
include/fuse_kernel.h:186: *  - add FUSE_SYNCFS
include/fuse_kernel.h:670:      FUSE_SYNCFS             = 50,

--D

> Thanks,
> Miklos

