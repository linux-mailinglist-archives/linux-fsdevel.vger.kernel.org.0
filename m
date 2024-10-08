Return-Path: <linux-fsdevel+bounces-31307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126A799450D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0261F22559
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CCF192D9E;
	Tue,  8 Oct 2024 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwrbZvKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB719067C;
	Tue,  8 Oct 2024 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381854; cv=none; b=lyoe7KUMXhv/IeJZdo0uVkIm/+g5220A1wpq+sRmZqWT6QgG1BerJ066N9bx7G8CGGIy/bi4uIsli/3DGheBxpwtiZJ2RMd2AWDy0u79yycr79xl+b3czcZjl2fGC+jtcFT1PJNBB9rQyj1vGK4uhbOq0G5EyW6PPQA5fOcTbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381854; c=relaxed/simple;
	bh=JMkuugi7HO5fdB4sigMHknxg7Nlw7No83VzSf/35TWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7x4dp0SoJxxnEFjk9DBoxOlR7ALrgPIZmmSbkgCdzSjOxyB69OTSDeWrbYI4s6F/HOG1kNx1bs+eTSG9gX83fQQ5+qQDx3NRZ4/tn/sNz8idkioVraRotLj+KnDBqhIh9zFy2eJcg0rLgy0D01w4KOdC+AbwiAW5SOhWA3laWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwrbZvKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC52C4CEC7;
	Tue,  8 Oct 2024 10:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381854;
	bh=JMkuugi7HO5fdB4sigMHknxg7Nlw7No83VzSf/35TWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwrbZvKRcS+x1fXtowCxZNwoaY++CZAm/l/rUTTSo0N2hgNSEnMSQgRNNthP7nJHZ
	 +1dQZ3SZDnzhe8oKz+3w5D85a8YhpOvptxcDOpRQLDDLh/6N3p0Xz6GG3RGuNoINs5
	 sJzUsftZFwKn7fmbQ+1cvYYO7a9oMn6+WhWqA6MSvR5dSAz3feazxXlzYwI4spm2+8
	 4/Rori7i0gxNH0U4Y/ET+eSqSDTPFI6X2591NIxBbkGAjD+iEnUQCni2GE3un5yzX5
	 q6/F768YOBRJRMSxDZOvmt/dzuRdALfoedYCYDddQaO6i05Re78+rHM4Mc86ST1pNw
	 jqgvnJ61AXkTA==
Date: Tue, 8 Oct 2024 11:04:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] arm64: Support AT_HWCAP3
Message-ID: <ZwUDmYbXNMede2Ui@finisterre.sirena.org.uk>
References: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
 <20241004-arm64-elf-hwcap3-v2-2-799d1daad8b0@kernel.org>
 <e563980c-9ae9-478e-89a3-819c7dadf85b@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WTiB8ukeVjfjI21M"
Content-Disposition: inline
In-Reply-To: <e563980c-9ae9-478e-89a3-819c7dadf85b@arm.com>
X-Cookie: Editing is a rewording activity.


--WTiB8ukeVjfjI21M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024 at 12:45:42PM +0530, Anshuman Khandual wrote:
> On 10/5/24 01:56, Mark Brown wrote:

> > +unsigned long cpu_get_elf_hwcap3(void)
> > +{
> > +	return elf_hwcap[2];
> > +}
> > +
> >  static void __init setup_boot_cpu_capabilities(void)
> >  {
> >  	/*

> LGTM, but just curious do you have a upcoming feature to be added
> in AT_HWCAP3 soon ?

We've filled AT_HWCAP2 already and are starting on the free bits in
AT_HWCAP, there's only 29 of those remaining and we get things like the
dpISA releases often burning through 15 at a time.  Like the cover says
it's not a pressing issue at this minute but whenever it does become a
pressing issue there's likely to be multiple extensions in flight and
it'll help not to have them all trying to carry the same serieses.

--WTiB8ukeVjfjI21M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcFA5gACgkQJNaLcl1U
h9D+qwf/SUyNYAKmy+NCe280h+F72vT4azcaKqFfSuv8Scqjs+wZI+qV6GbQs2K2
J0CJW34Arq9qcPX18oGoZtrToT2rLie2M3FiJ/FPnGvqQt+JjrRbe/l1HZ8Btz8F
/JiLq4BrJpyzO7c47T0qQKV8Zdf84X+tY9KfMp8SDtJHn98AShA/1Bv9sC2La6p9
Dp54eF9Frs89sO1GnszMgWYmwVn8CcsY7INPWroBvAHUqNke2cZf5rbq2BvoFeir
wkpH5/CFrf1OhvbOb556s8K+mH+o9gq6bQ9ugB5Mprolu0vNxJ/ImpvvN1KnVGu5
hhCJTXjZchFxqVDQLFMe8rTwRLFAdg==
=HU3C
-----END PGP SIGNATURE-----

--WTiB8ukeVjfjI21M--

