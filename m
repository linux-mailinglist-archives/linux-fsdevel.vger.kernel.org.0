Return-Path: <linux-fsdevel+bounces-16295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA089AB13
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 15:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14E0B215A1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B9536120;
	Sat,  6 Apr 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="G0JUCMqg";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="G0JUCMqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4723772
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712409975; cv=none; b=YWOrCn/A8aXpXCEEZIcwzyg4L78MC95ecX7txUeTL3h2bFAip04daoQN0/bljChVp5V9q4tKov2149GSYN51xAfR7RpCj6QzOcbZbtkPiYDj5vvbF1L9T4NloftU1ru8/oSFuoofgx2FSVIHRp/nDC5WDpr7j33A2f85szffJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712409975; c=relaxed/simple;
	bh=iJhE1+x5IcePo8EDN1NQOCRBbbZ4HJE9qcnWCcnmT3A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXrhnFRGlqfkWeuTFamSKUt1YtZjKZSZHokhOQj5Dz8DkYcC7+y4rQAqaUO2iEoJMqyIyKnAv7vXfXujY7hyLS9kfwCW0m7q8IGHXa9o+nTuFn4D56EgRUXgmWpFyCuMECWw9IhHA8XjBA086dFSDa8LDzWwprFcwh9IKRSeIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=G0JUCMqg; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=G0JUCMqg; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1712409972;
	bh=iJhE1+x5IcePo8EDN1NQOCRBbbZ4HJE9qcnWCcnmT3A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=G0JUCMqg8DdGmIebz/ySFn9II/PQsk/Dcyj0GN1QNwV/k2MuuoWwBYMuRxDNhcEyA
	 JMr+CxZarLAhBqVBkUgxPNnJORQFuYaLQEaACq1FkWOQd45eyXZvs/D1u30qI1lWp8
	 F8SHGMreAvenwc+038sAlosA5uMuNXRFZmtrvsZE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6F80112865E8;
	Sat,  6 Apr 2024 09:26:12 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id KtHkT1E2yyuN; Sat,  6 Apr 2024 09:26:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1712409972;
	bh=iJhE1+x5IcePo8EDN1NQOCRBbbZ4HJE9qcnWCcnmT3A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=G0JUCMqg8DdGmIebz/ySFn9II/PQsk/Dcyj0GN1QNwV/k2MuuoWwBYMuRxDNhcEyA
	 JMr+CxZarLAhBqVBkUgxPNnJORQFuYaLQEaACq1FkWOQd45eyXZvs/D1u30qI1lWp8
	 F8SHGMreAvenwc+038sAlosA5uMuNXRFZmtrvsZE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EB06412865E0;
	Sat,  6 Apr 2024 09:26:11 -0400 (EDT)
Message-ID: <ccfe804c63cbc975b567aa79fb37002d50196215.camel@HansenPartnership.com>
Subject: Re: Questions about Unicode Normalization Form
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: HAN Yuwei <hrx@bupt.moe>, linux-fsdevel@vger.kernel.org
Date: Sat, 06 Apr 2024 09:26:09 -0400
In-Reply-To: <AD5CD726D505B53F+46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
References: <AD5CD726D505B53F+46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-kRHBsVVZb7/7R8KXLLHJ"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-kRHBsVVZb7/7R8KXLLHJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2024-04-06 at 17:54 +0800, HAN Yuwei wrote:
> Hi, all.
>=20
> I have encountered someone else's Unicode Normalization Form(NF)
> problem today. And I wonder how Linux process filenames in Unicode.
>=20
> After some search I found that everybody seems like processed it on
> user input level, and nothing is mentioned about how vfs or specific=20
> filesystem treated this problem. ZFS treated it with a option=20
> "normalization" explicitly. Windows (or NTFS?) says "There is no need
> to perform any Unicode normalization on path and file name strings".
>=20
> Unicode have a dedicated FAQ about this:=20
> https://unicode.org/faq/normalization.html
>=20
> Is there any conclusion or discussion I missed?

This question is way to broad to answer.  Why don't you look in

fs/unicode

and see where the helpers are used and then ask a more specific
question.

James


--=-kRHBsVVZb7/7R8KXLLHJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCZhFNcQAKCRDnQslM7pis
hefgAQCsSq+MJ9HeBmb4biaXK8bNmBrQNwxdUAkgH3GgvAlS1AD/d8r7xHJ+dxj0
ryWBaWPV+dkRry2y+3jTwG0IzA8c2H0=
=hZ6H
-----END PGP SIGNATURE-----

--=-kRHBsVVZb7/7R8KXLLHJ--

