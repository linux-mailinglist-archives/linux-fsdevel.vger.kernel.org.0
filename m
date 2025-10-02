Return-Path: <linux-fsdevel+bounces-63275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C888BB3CAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 13:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA0AD7AC7B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4BA3101B1;
	Thu,  2 Oct 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW1/86Ro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95921F582B;
	Thu,  2 Oct 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405199; cv=none; b=VBFcsD4jIuOusMdbL1d7J1dx1d411HMDRxChvH8jotp5wpZzGGU7iQiJ4xrapz+yv2pqmSkH7GG5faO4cc7FdP6lfrIm+ZJDxlkxaJNrhkwzYYJtRZr7dqotIm5EjIkXuO/2Dx9TArKTJqcMTDXuMnC96OQGXIHFhKF48QNS+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405199; c=relaxed/simple;
	bh=AqM4M+MGYM63wBzkJdjM+deX6L3r76MLEIOrwOOOwJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5xXjLHQECGHfFW7wtUoGDHJLYZjJdthnESF+9CC29YB5TQsPRe5booLuXRpPU+TmFNw7hiYt3CpIqkd5KqXA8N0pwaCpJRuy2UHrDvsLJahNrpHZrU4iAMoutz4SVvEC235Di78niwzs9fVzo5AH9UAkKOC7ZlyLpxBVBFd50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW1/86Ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB65CC4CEF4;
	Thu,  2 Oct 2025 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759405199;
	bh=AqM4M+MGYM63wBzkJdjM+deX6L3r76MLEIOrwOOOwJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TW1/86RoVUn8qaQrgHMvsQvcXg86d9INUtwu3WmMM1sNr7Nnhsdu5LGDe4wj5Nmcd
	 h3ahbC+1P18XctdTn5Su30qTYLkv7UarZVkeP70mkiGhbyiaB4Tf6m6FHeWhLlYVJv
	 LhShOrKMSXkpVSMXLKYov1x2dryfuR3xlR/mL6dZWVfYhX3Zictu/5mKj4LvKtKxkm
	 Ma7bsVvTVvu3F16nnUTBVa3mDEJ/xjXtgVjwBY+8URYSBCdEXXcChHc80acWuzep8i
	 mXGvMQLTMLWWC7+zGhRkCVamXaRa0GZJHQuGz3SNFpxw4WC4iKaqKbkQ2SmMMevhe3
	 M2PF47W5eCD9A==
Date: Thu, 2 Oct 2025 12:39:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, luto@kernel.org,
	sumit.semwal@linaro.org, gustavo@padovan.org,
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	kevin.brodsky@arm.com, dwmw@amazon.co.uk, shakeel.butt@linux.dev,
	ast@kernel.org, ziy@nvidia.com, yuzhao@google.com,
	baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
	joel.granados@kernel.org, richard.weiyang@gmail.com,
	geert+renesas@glider.be, tim.c.chen@linux.intel.com,
	linux@treblig.org, alexander.shishkin@linux.intel.com,
	lillian@star-ark.net, chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 09/47] arm64, dept: add support
 CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64
Message-ID: <a7f41101-d80a-4cee-ada5-9c591321b1d7@sirena.org.uk>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-10-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KmVT2ZbmJlsEn2vS"
Content-Disposition: inline
In-Reply-To: <20251002081247.51255-10-byungchul@sk.com>
X-Cookie: idleness, n.:


--KmVT2ZbmJlsEn2vS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 05:12:09PM +0900, Byungchul Park wrote:
> dept needs to notice every entrance from user to kernel mode to treat
> every kernel context independently when tracking wait-event dependencies.
> Roughly, system call and user oriented fault are the cases.
>=20
> Make dept aware of the entrances of arm64 and add support
> CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64.

The description of what needs to be tracked probably needs some
tightening up here, it's not clear to me for example why exceptions for
mops or the vector extensions aren't included here, or what the
distinction is with error faults like BTI or GCS not being tracked?

--KmVT2ZbmJlsEn2vS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjeZHIACgkQJNaLcl1U
h9C/NQf6AxgZ6UzPOMzfmL9NSrLltWX75xfq7wx8SUKs1A6RFEWCR/s8jeaJZeCx
834KNHe3AuR4JVKLLGCZS/c26uVb8ee5itMM53Hv9CN8sQFUNuw/xdO1WCQVmZOI
pHaKeDBxXVnmeBO3uxS+3ITFDSNIPz6DOUAhqdFLhC6EhioGurq1dr8EtQu0aL3A
CqG9/M48cKPZRG7a1vLkqKbg8o15SYytfgXtl1kBey51IR89HXUZA4xdNc1CP0Sf
t2jQUg9ne/qxFnWt0CZEL+07IEC/enVs8gcO+mSpVX1r8yRDs496wZ29z7TjDaXB
8wuHMVCoKqwssyLsusjOjgef5XgKoQ==
=Ipx4
-----END PGP SIGNATURE-----

--KmVT2ZbmJlsEn2vS--

