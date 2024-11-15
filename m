Return-Path: <linux-fsdevel+bounces-34918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7EA9CE115
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A1728D560
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFAB1CEE9A;
	Fri, 15 Nov 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfV5XcJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7454769;
	Fri, 15 Nov 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680230; cv=none; b=RrlJdOiiKp+yMJKi9/TooSUk5BtxUvyYzGB81yvop/TINrwyePXf0j+MN0TuqmttWFeyC3aoHUYvDI4HF+eVcLThbPzAGKE9LPRPyNDTDVN0/n4Mkat/NO55Flz29VYiZWWMfrweSaflrCi5YJoD26gtxvjamMpuZeSYPHYK9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680230; c=relaxed/simple;
	bh=HP/LLNxTqSLz65CS/4iA5UL8Oz/x3YGp0q3jfnGXKlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZW61cqMZNyp9xit/fF7yQLQQh4P/tHiq8xWDBqlETYjoQIV2d+wk6s1vVfYbha59ORyw38MOJoLKo9beDtmyVjx4pjbh1Ig8dvWtG9bGlf7ySnLomqLLroWtNRDWIq0QZ2YGU0Jcvm3o2hhn/KKtseiEYXdcKoMFvk7KktyGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfV5XcJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B629EC4CECF;
	Fri, 15 Nov 2024 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731680229;
	bh=HP/LLNxTqSLz65CS/4iA5UL8Oz/x3YGp0q3jfnGXKlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfV5XcJKDmGWFh4lkZBC8kBelonPUhXL3drsEkc4Jen9fe7iTXgHxDpveUHYEcULs
	 +fyx5pi3uIWIdnINdrVk01jmjpo4ZRmNkYNW0P8A3g5GgA2oTh48+cTLEChyarf24G
	 sQAjLCDlkU5KrIf3YvhzdImklaTGx18c5+wWdJ1Ldg+9If5ewdYqixwEOfcwgOvodS
	 vILDDn0aUFcB5Zbto3S+YDcNJKOCyj9uiLGkUex+N7cX0YZ2NUu8E7H72jQIK8fpZB
	 brieNpMDEnnjFWFijAIZFnKC3dXmGvIYoxnKYWw5iDlfl5enhHu/F2RAGD6Uc9R8DL
	 gY/GXDaboGlCg==
Date: Fri, 15 Nov 2024 14:17:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC/RFT v2 0/2] Converge common flows for cpu assisted
 shadow stack
Message-ID: <ZzdX4nHHhEXuq_uU@finisterre.sirena.org.uk>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
 <964caf1797be61001901b92e3b71259443d3196f.camel@intel.com>
 <ZzaEnVpBUhZsp7qB@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L9nCg6ar8vnxAdyu"
Content-Disposition: inline
In-Reply-To: <ZzaEnVpBUhZsp7qB@debug.ba.rivosinc.com>
X-Cookie: Editing is a rewording activity.


--L9nCg6ar8vnxAdyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2024 at 03:15:41PM -0800, Deepak Gupta wrote:

> Alternatively I can send a v3 with above patch.

I guess at this point it's probably as well to just rebase onto
v6.13-rc1 when that appears, that should have the GCS series in it and
it's probably worth rebasing/resending when that comes out anyway.

--L9nCg6ar8vnxAdyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc3V+EACgkQJNaLcl1U
h9CfVQf+OAgeFa6MBqjV441HPKid5+FQHo6s2BZCyC9biJb+Vtrcr78aFR99jY8E
atsKuBkZZQrkiuAQFDMRjnwJw+1bKtqjYYZfLLhgqEtSjMBYBK4mjtDrRSwGiMOS
UqK925Duaw3/fG52vAyfBtj5o0/0rL/rWCXXB17j7wucftzw1WlE3Tg49sxAxorn
yKKE2afGpRoLFpX4qNoAwOzineO/T2eSenfpL8byDOhlL1F4vxBqUlzXBI9OdXV7
6c7u21/K6xw4taAKJ4yd0gOANmeWykdPG1m5v1Hffz03DWUPkNp9SEedHcVYoYSD
/qDN1VT+WxTmnsn9g1shd3a1dGuvzg==
=PFAo
-----END PGP SIGNATURE-----

--L9nCg6ar8vnxAdyu--

