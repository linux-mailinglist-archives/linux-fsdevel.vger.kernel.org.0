Return-Path: <linux-fsdevel+bounces-46627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985DAA91B3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD50344523F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 11:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EE123FC61;
	Thu, 17 Apr 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ3CyuY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455B22B594;
	Thu, 17 Apr 2025 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890563; cv=none; b=tASpv+8acqOxO+A2Zkk015m2UkFwwB5i+1ien+f/N3xS70sO26hSR4Aph/Su5fLnbL+Ch07fvbjSfQ308jZnDIoZ2Xxa1c4sD682g59yDiNcmp17+gDamV/bAZ6IpLyFyQh9KdKmiv5hNJO7PBlRzviLq4aBC45v/6KJpSx+/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890563; c=relaxed/simple;
	bh=UQHbMCV1pVuwRR8EBaRm5f0RYdToWlRbJH3rm8yriIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4mcjhw63a2E65TwwYyVC5k1Yhe273zr2t5H8PQ0GPA4YfbLm37dSJdQa5HmUkrGxBuy7ERKNPOMGXv8FefY7eYJlEZBf3jMa7mRiQQ1hVGG20V64XycQV5KfOE6B8FrY1fdFfs8GOCmW9o+emsErxdtc6i6rGcV8h6ky3Z14XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ3CyuY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF9BC4CEE4;
	Thu, 17 Apr 2025 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744890562;
	bh=UQHbMCV1pVuwRR8EBaRm5f0RYdToWlRbJH3rm8yriIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJ3CyuY3uyRrMG6Gn1/DOfvkllW/MQxwup/DS/8VIp3nyRIp0otMsvHfh78OtIXmb
	 lYVq9n+o2NiHmyyR6jSNVg1uOWc37sldfT/F75+uWbX1+/fjobtFcAnVPOCN+V6hQi
	 1IMBSGUQyvNQI7D+UwodjaJLDH0Ui8MilpVuYHd0b/1bDeNoX9m36O1Yo4d7ch5Er2
	 KvnypIqx7Qx17HUZi7AP0f5s61GJg2GdbVptvtlCefA4N1NlSe/6sHe/KTwyFXJKd5
	 0BTd7K0fsgBjir9YJcr27q4slE9UdXBJcm1JPRKE48yVkzXCJvPfSCzwnKT0EEnc1Y
	 zIvDHV9ti09ww==
Date: Thu, 17 Apr 2025 12:49:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Ian Kent <raven@themaw.net>, Eric Chanudet <echanude@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Alexander Larsson <alexl@redhat.com>,
	Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <a9fbb5f4-13a0-40b1-bb11-a9aabb96a5a7@sirena.org.uk>
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6nvKcsWatCsYhwZo"
Content-Disposition: inline
In-Reply-To: <20250417-abartig-abfuhr-40e558b85f97@brauner>
X-Cookie: "Elvis is my copilot."


--6nvKcsWatCsYhwZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 17, 2025 at 01:31:40PM +0200, Christian Brauner wrote:

> I think that the current approach is still salvagable but I need to test
> this and currently LTP doesn't really compile for me.

FWIW there's some rootfs images with LTP used by KernelCI available
here:

    https://storage.kernelci.org/images/rootfs/debian/bookworm-ltp/20240313.0/

Dunno if that's helpful or not.

--6nvKcsWatCsYhwZo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgA6rwACgkQJNaLcl1U
h9BxFAf9GbWFKf4t5X589jUpUUKEM4OsEOetE8LHgL35Prq1Nfe8H7VYJx3OzvLi
s/J3WwLlE9/3XzDuuH4HUCqQf+yr406tq7vCMlto+rzfYKAXDhTq7EEt9Z5HXdMS
jMowdzVhBUx1DwcD3V8WU/y7VBSpGlCFpXfNBhI4ssK2iL5tn60soAyz7JDCwk5p
tcWTF7VeC+aAs+8TIMArvzt8V5wtMM8UF/ed73uwxgvAAj+T4AuRIr/xQVnjwkDP
TPq16nb7L5g1X7tusGmLrrtTyvRJvlgm2KGsgDa7hoXNOzd8R+K3vHS7uT+lTUw2
Itn3e3tqEQ3EgzeXgx8x8oW0KsIqCw==
=hmWP
-----END PGP SIGNATURE-----

--6nvKcsWatCsYhwZo--

