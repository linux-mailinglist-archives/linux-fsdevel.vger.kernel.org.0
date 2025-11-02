Return-Path: <linux-fsdevel+bounces-66683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A98C28AC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 08:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B471891E3E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC46262FD8;
	Sun,  2 Nov 2025 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjI9akxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8C21420B;
	Sun,  2 Nov 2025 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762070105; cv=none; b=frhqGSUbak69Q31qdaxJKG24iYZ9Acryjuh+6aap1fCvRJyNgFv+27PpHFvL+W7l0SXrSaHKCS62cfT488gqV/mDXky8+EHCAL3m5W3ocqXpIcw1rPbcCVeI3HgPtldqZuEFDokteE+oPnqNAGzO6ZLSq2aHfmgegjekjY/s4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762070105; c=relaxed/simple;
	bh=LlgUpsO61kbnzvZFYvuKOYMhH74tjyorDBNhHylD6qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTI6YdzofvUhgNyCXGIXgd6gB3cHz4PpNpn67foa3P7lJLOqQJT/pjh943GnKBeMSQAdhyYz+1e4kSIv85DKvkinKSBZV6Z+HukZqE8xPvYMwsrO6zdt+Hsop4sTVpHWNxcUArY5vOsyBZKPPpuBCx2agXy7hGkMtRO8dUXUDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjI9akxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B15C4CEF7;
	Sun,  2 Nov 2025 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762070103;
	bh=LlgUpsO61kbnzvZFYvuKOYMhH74tjyorDBNhHylD6qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjI9akxuoyIk5MzuLGcowIIu08zFrz4FdgkZO9p4RdtRHZwa6o63rlunr01esQvPS
	 EUR/i7fO7kCf2Z2uiXroDA7qI4ketheAujNtrTiPqCRRBP75WqyGVLbY0lpKXGPYiA
	 fXCi0b/cuzg4D/vzOc4VQWA9uWz3mYVLwb6TNWvCNoD4ioze4SPZ4/q8Sapbj4u69c
	 lKP3DW7Ws2ghNnKzEJykPpLsi4lb1dd60g1Ix0gDVyKWzh5mo2KEVs+XGbi/tQsAQ4
	 eghaEwbLfKut/KgDBCsPzB2ZRWSEbZr80TPIfGY4CZYUlmZIYgWvTVLB+Vqi4hhvFJ
	 PpSMc6Fj+x6mA==
Date: Sun, 2 Nov 2025 08:54:46 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] sysctl: Move jiffies converters to
 kernel/time/jiffies.c
Message-ID: <2kjr6dfppy55j54isxxpusuhrbx2vovo2svico5w5k4vqwgadn@xgiza635ugbk>
References: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
 <20251017-jag-sysctl_jiffies-v1-4-175d81dfdf82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oezjmypfczi54fqe"
Content-Disposition: inline
In-Reply-To: <20251017-jag-sysctl_jiffies-v1-4-175d81dfdf82@kernel.org>


--oezjmypfczi54fqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 10:32:14AM +0200, Joel Granados wrote:
> Move integer jiffies converters (proc_dointvec{_,_ms_,_userhz_}jiffies
> and proc_dointvec_ms_jiffies_minmax) to kernel/time/jiffies.c. Error
> stubs for when CONFIG_PRCO_SYSCTL is not defined are not reproduced
> because all the jiffies converters go through proc_dointvec_conv which
> is already stubbed. This is part of the greater effort to move sysctl
> logic out of kernel/sysctl.c thereby reducing merge conflicts in
> kernel/sysctl.c.

Had a warning on linux-next with this. Going to fix it with this

  diff --git i/include/linux/jiffies.h w/include/linux/jiffies.h
  index 57da8eff94d3..fdef2c155c27 100644
  --- i/include/linux/jiffies.h
  +++ w/include/linux/jiffies.h
  @@ -611,6 +611,7 @@ extern unsigned long nsecs_to_jiffies(u64 n);

   #define TIMESTAMP_SIZE 30

  +struct ctl_table;
   int proc_dointvec_jiffies(const struct ctl_table *table, int dir, void *=
buffer,
                            size_t *lenp, loff_t *ppos);
   int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int d=
ir,
  lines 1-12/12 (END)

Will not resend a V2 since it is such a small change.

Best

--=20

Joel Granados

--oezjmypfczi54fqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmkHDjQACgkQupfNUreW
QU9JiAv+IPmi2e+etp5uYg1o4pPNKWT/6JU1oqbM3Va3vvb4PEWgaFj5FwZ3laka
/dXq+scwuLOD1uqfhbkHZL+FgFn3f9VonlLhiDavAZ4Cl4AfQgQNrHtjY2YyBEUL
kbk3hRG+7b6S5AXd0W9hMZdrSeqqoLtzAvAXfsCt42ONiIiixPYchgW3LoYLbwa3
M+laB8ccUafuoXRE5WSN2Lza7/uyIW6jmT4V9CBYubR3GXbrcFHdqjrNl7OQe+zJ
4EFcVa4sOZsPqdfYPCqVg+pOqtCaaMc1PN7+7i62PDYgq+isptmH5UIU8BPa1+mz
uxq/LDIs0AzUwKROYyaGDDog1bl4A5FjhsG/M8uvWQnHa7QEG9dUQIOBNgP6L1/K
5v0zcpNLZQ2mMN9AGA1l5BB4jT2X5F+i+zoO28LIucjLJrXPVRjc9a6ZqEEaRLM5
UTWdhGNqu6t8jPUTJ0fMP+bL93UFAmPC4WJs4DaCsToRg51kMXo1r5jP0c+oe20n
0+dY7uxj
=Tqc9
-----END PGP SIGNATURE-----

--oezjmypfczi54fqe--

