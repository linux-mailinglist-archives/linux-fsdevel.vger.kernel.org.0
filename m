Return-Path: <linux-fsdevel+bounces-57877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ED6B2650A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6FE189E53B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F2F2FCC12;
	Thu, 14 Aug 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peuKMqOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A22EA72D;
	Thu, 14 Aug 2025 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173377; cv=none; b=mo/LGZgsD4fSYTeBcv9EdFYQN57Y40j94gYc6PGc6xyu4t11E/jAmoP+P29y1GwnZMf21Ad2zvYOWO+Nxmyg8r1ILpw6/nHfoBvT/PeAkbz8rFEzdzajDwOdLk+jfFHJA3rIhmEsat6x9/s62lc0I5ydVTIpxthfF8xt6efFedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173377; c=relaxed/simple;
	bh=gpnex3Vd8qVIbIJY0F+J1N3ucXel3F/WTFMjzzOmJyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAVZfdd8R5hNlkApCS3AKliwQfctSr6zDbCBcPfSb7mixKtu6O3w3Hx/w48k0R0tRjogtrhIfPHc4VBROcPyRUNUtfsJONKUfzQfSeFI2F67rhQLHoi5SbgpmWab3yczipqZItBFAR91iON73qjUugy9OEB2bjkwdgAQO6PD5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peuKMqOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1021BC4CEED;
	Thu, 14 Aug 2025 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755173375;
	bh=gpnex3Vd8qVIbIJY0F+J1N3ucXel3F/WTFMjzzOmJyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peuKMqOUACl5UuhoepTx5K9KNtA4V6LwnSzzEQyrFwwHzANVvJ3u3yXnOxbjqblcm
	 ufMGKIIlHSTgJQcdEJ30saGaXUb0vs6aXwA4cOjFAmxwPfRO7Dc87JwZdW8VPUwFFg
	 7LQtN2U8wXq/UYg3jJ5yGK34gZDADjUo2aL5g2NmWqysZeqB420yvaiD5TWZ/YoSjy
	 EgdZnSjMQeAhXebV/ayiBuKBfNsDaNltMwkuU5v4NCWdl/B+D/6NStPhH9PnWLJc9C
	 hBrGbGkv4R/eGxHxVsjMMCzFGME24nsaPUBiHDEN+Ryp0Y/jDnUZC85s4PUXnKYRr2
	 cJx/nlSF3Vxzg==
Date: Thu, 14 Aug 2025 13:09:26 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
	baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
	ziy@nvidia.com, laoar.shao@gmail.com, dev.jain@arm.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
	jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
Message-ID: <47e98636-aace-4a42-b6a4-3c63880f394b@sirena.org.uk>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-8-usamaarif642@gmail.com>
 <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
 <0b7543dd-4621-432c-9185-874963e8a6af@redhat.com>
 <5dce29cc-3fad-416f-844d-d40c9a089a5f@lucifer.local>
 <b433c998-0f7b-4ca4-a867-5d1235149843@sirena.org.uk>
 <eb90eff6-ded8-40a3-818f-fce3331df464@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GHi46nNQCVWNJMJH"
Content-Disposition: inline
In-Reply-To: <eb90eff6-ded8-40a3-818f-fce3331df464@redhat.com>
X-Cookie: This sentence no verb.


--GHi46nNQCVWNJMJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2025 at 02:00:27PM +0200, David Hildenbrand wrote:

> Some people (hello :) ) run tests against distro kernels ... shame that
> prctl just knows one sort of "EINVAL" so we cannot distinguish :(

> But yeah, maybe one has to be more careful of filtering these failures out
> then.

Perhaps this is something that needs considering in the ABI, so
userspace can reasonably figure out if it failed to configure whatever
is being configured due to a missing feature (in which case it should
fall back to not using that feature somehow) or due to it messing
something else up?  We might be happy with the tests being version
specific but general userspace should be able to be a bit more robust.

--GHi46nNQCVWNJMJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmid0fYACgkQJNaLcl1U
h9C9EAf/aEPUAni8qteBGzYVxbP+2fWh24gpZRUzIwMgipxQm2thCmcg68/+dFq4
dstImKXyE21x8t30rJinOCW+RpwSzA1V3b9ZHm6cjQPe2ZDB16BP01neXpXNU4um
v9RalcxQY8+Pfdy++yS1rfUKx6/D9Shag9pDvu4iOyrOv4xeH/MkKD/23OvyB7fE
Ukwx3wKDnx7NAHX/kfqg3P+OQwn7AWGZRhL1hQt2rZqDok7vUEN2lyQQnMsV8L1u
lB4FldRiC0ODiUV+A+BZ4qc/QYvHGz3Lys1VcRcQEVCzODOYyCxsfvQRXdopcULf
wxyiXZpWXsqfM//MSw9F0h7ihG9rnQ==
=O/vD
-----END PGP SIGNATURE-----

--GHi46nNQCVWNJMJH--

