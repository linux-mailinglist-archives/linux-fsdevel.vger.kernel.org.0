Return-Path: <linux-fsdevel+bounces-54657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC1EB01EEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DC9174F15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5E12E54BB;
	Fri, 11 Jul 2025 14:20:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B132E4981;
	Fri, 11 Jul 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243605; cv=none; b=FyAALrhLhO8MynQR1SG1Idu+3OJDgnQow4XwNkixM2mwR1ap2XLjnh12itlyEmKX5P+Eo0UGuLc9fgYpUD0/JJKygcxUYoH2k4OUoO1NKxCAoQg9ZZ9hmjgaZ4gwce+GECzcKbfVyja++yCLT34nD95aCl+Oz736DPKQDwl2Mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243605; c=relaxed/simple;
	bh=g0FY8KEhs3+5ZwzMuOJoxWtCZ12e+cotRCpz7ImwO0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scAleIAMIWHSpCO298T0zmcuNRDTuRYdlzk64KwFtOH66yhU5XKV9bfxvhFteXkNsnNjFXyTWRJCzWbA5vpndT8rpchDNwmZ54PUkeBZlZ+8vjSj3TTwtCGqmKuhsbHAW/VyziHcLplTaxtNvVbXDwRfSo6M5tRhAxHPpfI0uPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <n.schier@avm.de>)
	id 68711c0d-037b-7f0000032729-7f000001a796-1
	for <multiple-recipients>; Fri, 11 Jul 2025 16:13:33 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 11 Jul 2025 16:13:33 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 5F78280666;
	Fri, 11 Jul 2025 16:13:34 +0200 (CEST)
Received: from l-nschier-aarch64.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:6472::1])
	by buildd.core.avm.de (Postfix) with ESMTPS id 07985182D09;
	Fri, 11 Jul 2025 16:13:32 +0200 (CEST)
Date: Fri, 11 Jul 2025 16:13:29 +0200
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Shivank Garg <shivankg@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
Message-ID: <20250711-fascinating-dramatic-mongrel-06bb3d@l-nschier-aarch64>
References: <20250711-export_modules-v2-1-b59b6fad413a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vsByBMB2KLXp1vNx"
Content-Disposition: inline
In-Reply-To: <20250711-export_modules-v2-1-b59b6fad413a@suse.cz>
Organization: AVM GmbH
X-purgate-ID: 149429::1752243213-8E7B2EE7-5F8E945F/0/0
X-purgate-type: clean
X-purgate-size: 2145
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean


--vsByBMB2KLXp1vNx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 04:05:16PM +0200, Vlastimil Babka wrote:
> Christoph suggested that the explicit _GPL_ can be dropped from the
> module namespace export macro, as it's intended for in-tree modules
> only. It would be possible to resrict it technically, but it was pointed

s/resrict/restrict/

> out [2] that some cases of using an out-of-tree build of an in-tree
> module with the same name are legitimate. But in that case those also
> have to be GPL anyway so it's unnecessary to spell it out.
>=20
> Link: https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/ [1]
> Link: https://lore.kernel.org/all/CAK7LNATRkZHwJGpojCnvdiaoDnP%2BaeUXgdey=
5sb_8muzdWTMkA@mail.gmail.com/ [2]
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Shivank Garg <shivankg@amd.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me, thanks!

Acked-by: Nicolas Schier <n.schier@avm.de>

--vsByBMB2KLXp1vNx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmhxHAMACgkQiMa8nIia
bbhOGw/6A9j10gjqoU3cU58K0DP3tXeBiNGfbAwaAYMhKF5qqCTZoVXYZnXlkoqx
aonsaV+KHjIcgOP3NchS4R290Y+VexSvnltxjlAPSYn4hJXlkLrkozxkGEs6ptE2
HKyrlo0JPTF5O2XWwVJAcC9bgwdL5N1xxVZPUrOtkjwCt5CP5S6cQVn9F+8E8j24
u3ZdBTVBzUDzvpdWijFja3eJInjGv5dTS7njg66q/xcfn7flOu9Fka0yvwmwV4aG
ClESQCXzKBUohjG+02n1j0x/QJqSn7RVnq+sjG75al9T0ggFKH0FRxpiTbbGMRf/
VTzicAeBesZy+6YdYL5uDUpBdzSUS2xUihzey/xpovKgmbuG9RRx0TK87XAqr/X+
+4R6q4LwREMB7+dezzlh73DY0NJyROWsocmCcyewbDP7BhXmgVy/8bbWrItVmeyG
GoBwZn1jI3jw00fRtxXV1JwwD4i9vAnhP4w3w/HfGB7bTMVUaGLwcUfFzOQ083lu
A41+qAhk71ET9JYF3P6KI5SuINeTX/XzD93F+D5sB//bi4yhVnbjHcWTDgF2n2xT
kfUZ+7i0xs6OUbFwZdHoy2B92zrShyHNeXkKYRnlPvzt9XBiUMKRfJpnlRUX9/H1
ij2ZskGClUCirLzrNp3hSfC4vnBmNAopyo8xPSHYyd7/W5lx+XM=
=XfC4
-----END PGP SIGNATURE-----

--vsByBMB2KLXp1vNx--

