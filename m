Return-Path: <linux-fsdevel+bounces-58116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF90B29902
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 07:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFFC4E16D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 05:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA70227055D;
	Mon, 18 Aug 2025 05:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ofu2p8IH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616AF9D6;
	Mon, 18 Aug 2025 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755495982; cv=none; b=WCRHipJnVL8lq0hkiGbcC4VpcGwR0qV/C29TxjuHqNHDS0XtiNdVLPeMNBmhgdda/RJYfdzyawCFVFFEcgDOWYkJB1xXdZ0c5Ky8ETQinDcMMy8UbxVN8snHSvYsPpx+3GjX+24Gy68ngI2rkUrFdchBj6RHHG24it40xC4+xl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755495982; c=relaxed/simple;
	bh=Qh8AEOLAP5dE4ODWjLt+RQWSlSZSz8XYfojF836Obhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qweygqJCj2ONr3oKdtLhhLk6anJvEmB6RqpEda8+YzjTRC89uY1fcBCT/EKOQyThd1lZn/5ZKrF7rTECt39VERZ9BKp8/Iqa4yZ+H1dgg25i0dP+r9axchSngAwxcNI1UIX85RmhWMajfrB9l1aHqL99faT1WnSmYSGZO5ROrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ofu2p8IH; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c51sz6yYSz9sqf;
	Mon, 18 Aug 2025 07:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755495976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HMM28RAcCoPopV+B/KmIH0dpYjZghZhDsRPoiJoe3U=;
	b=ofu2p8IHiKS/srLSp4JuTAN3BgH+n993RaoKcO96DzdkOCmxRNGaQWl1uyj8kY9XD0sx3y
	VaLQOtdXHxFq0hF30qLgO1cPGZ5Ri8Jwu5XzUAgGJZriF3PlHaUvJY2tO/mM3Tv8uMb76D
	XYQxZDo0XYioh0gIqPpbRhEfwhWQLcVBpiXWlP9Mp83A1zZ9Au7GaS/6ubN8PXnQY83A9d
	PguJocrzFrDI2ve2f+Hqsc2FXEzxqw8Q0CoBx6SmeKKSRUBPchMtxrk8UFRaoSD3IINgKo
	LvKiBcbrKNFKBEWvnn2dWvtn7Wo7b63+N0z0WnI1vRSte8h83Wsie1A59RISNw==
Date: Mon, 18 Aug 2025 15:46:05 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: alx@kernel.org, autofs@vger.kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, g.branden.robinson@gmail.com, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, mtk.manpages@gmail.com, raven@themaw.net, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Message-ID: <2025-08-18.1755493208-minty-roomy-vessel-moisture-2LjJfF@cyphar.com>
References: <2025-08-17.1755446479-rotten-curled-charms-robe-vWOBH5@cyphar.com>
 <20250817185048.302679-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qrslywv37u3fshty"
Content-Disposition: inline
In-Reply-To: <20250817185048.302679-1-safinaskar@zohomail.com>


--qrslywv37u3fshty
Content-Type: text/plain; charset=us-ascii; protected-headers=v1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
MIME-Version: 1.0

On 2025-08-17, Askar Safin <safinaskar@zohomail.com> wrote:
> I just sent to fsdevel fix for that RESOLVE_NO_XDEV bug.

Thanks, I've sent some review comments.

> 	if (!(lookup_flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
> 			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
>=20
> We never return -EISDIR in this "if" if we are in non-final component
> thanks to LOOKUP_PARENT here. We fall to finish_automount instead.

Grr, I re-read this conditional a few times and I still misunderstood
what it was doing. My bad.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--qrslywv37u3fshty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKK+HRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/V6wD/YoQbj4tPRHlDjEHb/OQx
ywcB7eDulYkzVyOOr83XOwgBAK2OMvD5MDyw+msA5wsI7g8wFAsL5ZDWA0Cn61OJ
daYK
=7p79
-----END PGP SIGNATURE-----

--qrslywv37u3fshty--

