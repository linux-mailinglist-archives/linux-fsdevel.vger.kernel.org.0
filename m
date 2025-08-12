Return-Path: <linux-fsdevel+bounces-57555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A88B23337
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8607B7032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575A62FF151;
	Tue, 12 Aug 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="nEEu5SR9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750E2FE588;
	Tue, 12 Aug 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023159; cv=none; b=aP5BBL9NOUkVTeTfjdQl3XZCwXB95110OxTE+X0P+Zy+gOxhRgKxLctGBNTLzwKbI1kPobHcDCZM4t9NJ9vfSYNWiECH1BYkj/1EcZbz4gjpjYnCiD9mGKRZOdPGKszFVaUGR306uhkYKcgZiHu2GD1uzltv0yT78bESd3ro698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023159; c=relaxed/simple;
	bh=D2kznNko9H94sUcgP34cPoaWoDFJprxynNhncMVz620=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmKzY2Be9JI0ID5i+hiOqj/mzVL9BI1AgYpuMfVFX8bhtYuuX9fXT9hCf2Z1PkIO81DL0N9aG23TXshBXZAKIBV7YrCBONcRNYnj5TLL9+ZhZ4GlzHfHSIDZx063S89fQDmgYSmHa11qmqhKGvTh0TKrzpKHBMXqOB8gQ6Qtv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=nEEu5SR9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c1g1F4T6Dz9sD9;
	Tue, 12 Aug 2025 20:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755023153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2kznNko9H94sUcgP34cPoaWoDFJprxynNhncMVz620=;
	b=nEEu5SR9dR13EEirK4NOnCeF+VX2yXPD650WplJFp+mshMPIhHLsKkxLY6/aK1xFpFzXj+
	O6q26l80mQFXNcGHyX/HqiDAPN7bIF4gicUakUIIwdbFZ3t3vXo5LeHU51QC1N8CyJw+PE
	s+LhjzukW6iIn2yFnGNnvCXFCkZaaUygaVmoaJruxQeDQHfBvNPlntuIAYtlanUH0Rjo3k
	vf+BMAPMQtn/UU+nusVkqnOD33BvPK2ZUof1aEdWKRU08/hxB5CwQ78LUzU6QPD5miq/vW
	Ct6gkh+U2AOJXUxqhrciksrcGJoHfTvjpckc0k4ajSJBYpweNRi80n0MYd8JMw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 13 Aug 2025 04:25:40 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 06/12] man/man2/fsconfig.2: document "new" mount API
Message-ID: <2025-08-12.1755022847-yummy-native-bandage-dorm-8U46ME@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-6-f61405c80f34@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="37ixlo766hjzmteu"
Content-Disposition: inline
In-Reply-To: <20250809-new-mount-api-v3-6-f61405c80f34@cyphar.com>
X-Rspamd-Queue-Id: 4c1g1F4T6Dz9sD9


--37ixlo766hjzmteu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 06/12] man/man2/fsconfig.2: document "new" mount API
MIME-Version: 1.0

On 2025-08-09, Aleksa Sarai <cyphar@cyphar.com> wrote:
> +Note that the Linux kernel reuses filesystem instances
> +for many filesystems,
> +so (depending on the filesystem being configured and parameters used)
> +it is possible for the filesystem instance "created" by
> +.B \%FSCONFIG_CMD_CREATE
> +to, in fact, be a reference
> +to an existing filesystem instance in the kernel.
> +The kernel will attempt to merge the specified parameters
> +of this filesystem configuration context
> +with those of the filesystem instance being reused,
> +but some parameters may be
> +.IR "silently ignored" .

While looking at this again, I realised this explanation is almost
certainly incorrect in a few places (and was based on a misunderstanding
of how sget_fc() works and how it interacts with vfs_get_tree()).

I'll rewrite this in the next version.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--37ixlo766hjzmteu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJuHJBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/DdAEAmGOUConq3tLwui3YLCqO
oooG4yU8zga+usQs3d46vfkA/1khBf1sU2NIjEjQfxibEU3xXZCn6MtD2JU/ewdU
bFsG
=fkeT
-----END PGP SIGNATURE-----

--37ixlo766hjzmteu--

