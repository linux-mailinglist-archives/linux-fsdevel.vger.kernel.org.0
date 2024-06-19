Return-Path: <linux-fsdevel+bounces-21923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3351D90EF8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B031C21B22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B6214F9D9;
	Wed, 19 Jun 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee0g8HY1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650B144D3E
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805463; cv=none; b=DiGeNVpZnggp2lq30U0MFWU8ooMkmAfuWxbP0CVxeQPZWdM+MhCGo8IqJywfQdQua+beTG2B85ycaZZ0M0ai+5MjHrJa+Q4uSCB7jTXhdkPLVBW4HmHQNFJelBro8Mh3giak6isYk8j52FkZ/V0jkDRIPHdPctTSzz6qUl4iR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805463; c=relaxed/simple;
	bh=m3JIIi4c2QOEJvKif1eKq1gmq9nKbjJSvj1cDrxumGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cecY2oODY+gmAujyTg9Jq+YcF5kbUW16bxrDjqY65saTrmoiwwqnHcM8813br5bOyHywCBf6ofxE3yHdr75c5kve4SEuFkwmOFQgnKbxP7YG7UW9PJHLlm/xcjV2lRF0geADgE98IsAWL1cE8tYch+kto+BtLZ2LdkgHZVxUDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ee0g8HY1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718805461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=m3JIIi4c2QOEJvKif1eKq1gmq9nKbjJSvj1cDrxumGM=;
	b=ee0g8HY1I70QzB9yeZUuAucZ3sCc4VQb14PHdonInqL0oeUL8eXDohfVQiu3b1VP15TVMV
	59tbzSdx6aD7QF2rNKcFz7vVtYsUBF0bScjcHcG7RfIlgABuxVwRh4HYW6ZPQI8Xrm8pfp
	4k19PyFN5x867Wptc64HURYnExUxXG0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-hEyL_fPNPNOWG_JQkDXnCw-1; Wed,
 19 Jun 2024 09:57:37 -0400
X-MC-Unique: hEyL_fPNPNOWG_JQkDXnCw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87AEC19560B3;
	Wed, 19 Jun 2024 13:57:35 +0000 (UTC)
Received: from localhost (unknown [10.39.192.3])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99E7E19560AF;
	Wed, 19 Jun 2024 13:57:34 +0000 (UTC)
Date: Wed, 19 Jun 2024 09:57:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: dverkamp@chromium.org, linux-fsdevel@vger.kernel.org,
	takayas@chromium.org, tytso@mit.edu, uekawa@chromium.org
Subject: Re: virtio-blk/ext4 error handling for host-side ENOSPC
Message-ID: <20240619135732.GA57867@fedora.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wv8J+0evlB6f2xgi"
Content-Disposition: inline
In-Reply-To: <CAD90Vcbt-GE6gP3tNZAUEd8-eP4NVUfET51oGA-CVvcH4=EAAA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


--wv8J+0evlB6f2xgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> What do you think of this idea? Also, has anything similar been attempted yet?

Hi Keiichi,
Yes, there is an existing approach that is related but not identical to
what you are exploring:

QEMU has an option to pause the guest and raise a notification to the
management tool that ENOSPC has been reached. The guest is unable to
resolve ENOSPC itself and guest applications are likely to fail the disk
becomes unavailable, hence the guest is simply paused.

In systems that expect to hit this condition, this pause behavior can be
combined with an early notification when a free space watermark is hit.
This way guest are almost never paused because free space can be added
before ENOSPC is reached. QEMU has a write watermark feature that works
well on top of qcow2 images (they grow incrementally so it's trivial to
monitor how much space is being consumed).

I wanted to share this existing approach in case you think it would work
nicely for your use case.

The other thought I had was: how does the new ENOSPC error fit into the
block device model? Hopefully this behavior is not virtio-blk-specific
behavior but rather something general that other storage protocols like
NVMe and SCSI support too. That way file systems can handle this in a
generic fashion.

The place I would check is Logical Block Provisioning in SCSI and NVMe.
Perhaps there are features in these protocols for reporting low
resources? (Sorry, I didn't have time to check.)

Stefan

--wv8J+0evlB6f2xgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZy48wACgkQnKSrs4Gr
c8gZXwf9GhgC+qbmqove5vILqMoZHIzyoDa6jH/4FHRvM6XyKqKMQHYkiUkzGJ/q
UM4i0hJJ7dpGiobJl1cnkxdldy4Ljoh8e8+kjlwWEKznLvtYf7FiADgoXH9wSdQE
rrDD6JwV8LYQG37r0auzp+Qa5sHe/vA142RPq7aGiwrFEPhygyvVZKXKO2ltEUmc
Q7fvUgRAlYfSK/UNqreSii9ZlOWCmi3R3Xc66BCWNflo/YEPLf/LuttuuZWFmmAQ
BFpaR4AKPuYJU2R01KzZJ+hUkoMukMP39PaLC4X6H+A7c/GQ5jkGhdIl884Nuq+O
67Ntl8UmClvZIil9zP6uBVGoJ4lg1Q==
=UtBX
-----END PGP SIGNATURE-----

--wv8J+0evlB6f2xgi--


