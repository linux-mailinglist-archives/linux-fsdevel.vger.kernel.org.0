Return-Path: <linux-fsdevel+bounces-19093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785F8BFCD9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 14:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C77282927
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7884055;
	Wed,  8 May 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6b9ritU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CD45024;
	Wed,  8 May 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169959; cv=none; b=UtoNHioxFfQko1t0MIcVidCXcjiEhUHdML+01Kpthl0xgVEZam7NhFZowgFh1d5PsLkHS1UF8DWwuLzx/odHiypwhKXF2dp68GnakVp2NJZPIrDNQxcWSz6WNoQ4V9hr1Ybr92+Rxo8Tx+Q1i7AXQZfsdlg3X+th3omSH9o7lic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169959; c=relaxed/simple;
	bh=Nyz1qBX4AhSejr40aGAqB++CiOKmtDB7Y/C9c18/WZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2og/Fi8kG6iXrU125n9a9LtvM09cyg4znz2MZLBfigUG+Ecwd0uny+kCXcw/97MtdD44/07etLiPq3zQStfHq9rpD7gEjYzTiPrViSs/XRIOYpldnQe7WyWwvkSQDSU6AMZpaKghclu7FoZ5ZcUP4DcpSlpnHpohY48H2OvyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6b9ritU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81CBC113CC;
	Wed,  8 May 2024 12:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715169958;
	bh=Nyz1qBX4AhSejr40aGAqB++CiOKmtDB7Y/C9c18/WZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6b9ritU4vQNxnTR7eE3vrl7XyG3xhiGCQ3mm6aJQRCCFjPFC/Q1hWuJjhy4l+Qax
	 oR324+ZD/1B55q8u12dgWy3sRKPw84A6m5/lJMNbU/ZfkzUlIfv9F6M4Qsr74SZluv
	 Ri6pDOnK4BWwAhDMhF58vTUbpuAZdeUXISMowuweeAt6zvNRRwALQPzA5fLGJ57Wbp
	 2OEXRdD82ue1m5gsxJCTrctUxqpi5AwOZDXrAU1DFHkyJAlciUx03FDgas2YXkWL4U
	 Ezxdp3UnYRZZhJByl5oD0Rz2BdBs3ecBvSz1FhVaxAQRSNofS2jvXx6H85WK8jvqHo
	 58Yjy/AMTsjFA==
Date: Wed, 8 May 2024 21:05:55 +0900
From: Mark Brown <broonie@kernel.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Seth Forshee <sforshee@kernel.org>,
	Bongsu Jeon <bongsu.jeon@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-input@vger.kernel.org, iommu@lists.linux.dev,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev,
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org,
	bpf@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/5] selftests: Compile kselftest headers with
 -D_GNU_SOURCE
Message-ID: <Zjtqo6EFyGmSeREQ@finisterre.sirena.org.uk>
Mail-Followup-To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Seth Forshee <sforshee@kernel.org>,
	Bongsu Jeon <bongsu.jeon@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-input@vger.kernel.org, iommu@lists.linux.dev,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev,
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org,
	bpf@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20240507214254.2787305-1-edliaw@google.com>
 <20240507214254.2787305-2-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fwllAq8yEacRp/F5"
Content-Disposition: inline
In-Reply-To: <20240507214254.2787305-2-edliaw@google.com>
X-Cookie: Accuracy, n.:


--fwllAq8yEacRp/F5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 09:38:26PM +0000, Edward Liaw wrote:
> Add the -D_GNU_SOURCE flag to KHDR_INCLUDES so that it is defined in a
> central location.
>=20
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs
> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.

Reviewed-by: Mark Brown <broonie@kernel.org>

This does mean we define _GNU_SOURCE for nolibc (and I guess any other
libc people use like bionic) but hopefully nobody's using the same
define with a different meaning so should be fine.

--fwllAq8yEacRp/F5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY7aqIACgkQJNaLcl1U
h9DCxAf+M+eUS9Sr8Cy7bCTOxGv4sZGiJ7AeEEoR5TzBm5SOC6mKe/M0t4SexFRB
5nAjL3TO9i8cfMtUMh6LMvciaa5sGVNRFhpTIgljvO7ND7Dv+WKpJyiicl/1DYIK
DEdpua8OQJ4bz9PQwOZO1kgQzC003JRxY0Gbz9kk8ie58HVAodSSWi7kgNsMc/0t
mKOumN6X7MhAoslboc7h3A6xymN8AHvHeNga3yP+1E84M8mjiR91sc3btIn4Wa/w
6LIqTSCun/wuxeQnkz0Rlk1LdA1F0KQPzQAriWxju8K9dqc3prqYkWuDtRVYN+Li
LJAemrTmdlcOF/7uoi1Z7s4wZajT2A==
=IlWr
-----END PGP SIGNATURE-----

--fwllAq8yEacRp/F5--

