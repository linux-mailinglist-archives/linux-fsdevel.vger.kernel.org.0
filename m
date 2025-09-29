Return-Path: <linux-fsdevel+bounces-62993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95540BA8631
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 10:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568D83BF352
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 08:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFD26F28B;
	Mon, 29 Sep 2025 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blFY6h1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D026335C7;
	Mon, 29 Sep 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134278; cv=none; b=Mj7CR8EFzXIdAr3UFB7i2Uak7Va5ALX2Kez/YgRJD/r9Hu43EbP5KMrsi64tHJjkwyySniVsirB+Oqyuz9FDumkRD+1WIQOtuJEepTAnEWL/Ihkx2UNlfNecZEjzUIKphZUM3YQLGVYeKh4XhRcrRNxf81iZetZHFRWDgMmFmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134278; c=relaxed/simple;
	bh=wkqDBTuQy96Ga/MjWA0klj2NE4K7wgUkUNTBnEXJKrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWneQ2rTkCJHZcbLCMOiFmHR08QoZWFD413PBV6Y/R4qELpTSEOnHKDYcV5wujegirLdRVXnb391vPndYVdG9gezED6t9/+vxiD+NbOCK+2RDfPnp+YwCtFS89RdsdVtISGWL9z6nvbstkOmYcUlIvnGvjKhMaU3sz/88GEEloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blFY6h1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30119C4CEF4;
	Mon, 29 Sep 2025 08:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759134277;
	bh=wkqDBTuQy96Ga/MjWA0klj2NE4K7wgUkUNTBnEXJKrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blFY6h1rokw5yI37N3Z4/j/eyHsR+ObwO2Gh/0Hz6WK4uS3mK7QkWlqGG7thhhh+y
	 x+ykUuWdAlzBNcyPSFZtYLw0CTjghJy5iJ7H+ZCj5ywUtc0TnCCq6b6XW0vq5qGAb3
	 ciGXCUl5BcxtzGTAEk0nJgmP7LXrgttU2T8T2XGWvwBuF0y2IVs21fdfABydGgfLri
	 S7zImcOecVkyXks8QPvq1pcFkYVquR7H7tv/4+tBeQMMZmdeqE+/R2iWrllmEfxrBL
	 hq6n2qI6xt2cUVJ+lE0WQCtpa/kwOwXgEKBS9OMAZmhi/Y17490GhOnpn1LoN02g6+
	 l9LtaHOlqIziQ==
Date: Mon, 29 Sep 2025 10:24:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Windsor <dwindsor@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, kpsingh@kernel.org, john.fastabend@gmail.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
Message-ID: <20250929-mehrverbrauch-taverne-0748c5778163@brauner>
References: <20250924232434.74761-1-dwindsor@gmail.com>
 <20250924232434.74761-2-dwindsor@gmail.com>
 <20250924235518.GW39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924235518.GW39973@ZenIV>

On Thu, Sep 25, 2025 at 12:55:18AM +0100, Al Viro wrote:
> On Wed, Sep 24, 2025 at 07:24:33PM -0400, David Windsor wrote:
> > Add six new BPF kfuncs that enable BPF LSM programs to safely interact
> > with dentry objects:
> > 
> > - bpf_dget(): Acquire reference on dentry
> > - bpf_dput(): Release reference on dentry
> > - bpf_dget_parent(): Get referenced parent dentry
> > - bpf_d_find_alias(): Find referenced alias dentry for inode
> > - bpf_file_dentry(): Get dentry from file
> > - bpf_file_vfsmount(): Get vfsmount from file
> > 
> > All kfuncs are currently restricted to BPF_PROG_TYPE_LSM programs.
> 
> You have an interesting definition of safety.
> 
> We are *NOT* letting random out-of-tree code play around with the
> lifetime rules for core objects.
> 
> Not happening, whatever usecase you might have in mind.  This is
> far too low-level to be exposed.
> 
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

I fully agree.

