Return-Path: <linux-fsdevel+bounces-19153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE978C0ADD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 07:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE88285B97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 05:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD6E149C47;
	Thu,  9 May 2024 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQoywBiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165712BEA4;
	Thu,  9 May 2024 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715231702; cv=none; b=M20wBKv1KmPMI2YetKIHte8XdX1oOsLDwQcAV4/kVjGbt7LgdtZpiYBivxWYM6Mb/cUJEvRi0aY2UUtfDo2etnGZruROxlcL8+l6he8JsrW81V+/STuGay6UFLmYnCDKJuS3ShDNYpnJYmF1wltJI8B7rSDqcZTIoFR/Xw8dj5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715231702; c=relaxed/simple;
	bh=dgBpxGC9J1WlBSk7j6Dg82LPiieH8ot79JOBQEcnXq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2X0yRfuJgzYC4GSubvuUR/5Mc+Bz/XX8LWsy43oCV78USf9Uh4j92xsVivWX0kqhbj4GJ/BO21C19tiXwk2NykWKbDTZrv1yhi9vB7FfA1jx8/s+s8AyWaOhf/UcAKOxIkaE8Aj7rR2p4Ycj47Tv1oXF0eztuzz2OEIiDcDgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQoywBiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8AFC116B1;
	Thu,  9 May 2024 05:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715231701;
	bh=dgBpxGC9J1WlBSk7j6Dg82LPiieH8ot79JOBQEcnXq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQoywBiy+PCheZmKhnImt/9BOTJD7sOxdMdOTlOLCfvXUKjgZOA92aRVR4OmcoxF9
	 PTbOPGZF15CWvHBVuEwGeUtVVWmwiTb6FfsEOgf/6RkiKxAdRchyA72tARTMQHHS56
	 7stGdQt7WDteZaEvMke5xN3k6+K3rexu/sDXquvtBr5Y2djj6r0Ay4Odn4nRO45Keu
	 8+zyLIWzfYoyoPvE3xWjoC9Knv0/BRtHDQXiZtyiizSj8iI/Tmkzv636dmxJZptUSp
	 6/rG79xlRkSsK2N27OtXiWF1LNTVKFxU0CRMDW0fjxV0VUp1GCtX3Br/Lr+jHOaIOv
	 Lun/NWWKy0C5Q==
Date: Thu, 9 May 2024 07:14:58 +0200
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
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 3/5] selftests: Include KHDR_INCLUDES in Makefile
Message-ID: <Zjxb0k--qUyZKSg6@finisterre.sirena.org.uk>
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
	bpf@vger.kernel.org
References: <20240507214254.2787305-1-edliaw@google.com>
 <20240507214254.2787305-4-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8TMyWXG1VGLOfNzK"
Content-Disposition: inline
In-Reply-To: <20240507214254.2787305-4-edliaw@google.com>
X-Cookie: Sorry.  Nice try.


--8TMyWXG1VGLOfNzK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2024 at 09:38:28PM +0000, Edward Liaw wrote:

>  tools/testing/selftests/arm64/signal/Makefile          | 2 +-

This is not really using any of the kselftest framework at all to build
so I'm not sure the change makes sense for it.  OTOH it does no harm...

--8TMyWXG1VGLOfNzK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY8W9EACgkQJNaLcl1U
h9Aa4gf9HY7hIlNAryB75Fb1YdATwSHy7EQyKfWsSaobZtWWwgFh6CF0C6J7Wa0o
UmFwVoKos72xm0UCKTtuBAxkIxhk1wupw0K6u0fVcraHpDV579RI/BAsIc1cFgf8
cGvyEy3VRgjGDKorUJnMg9WU7qNTIfRovXGmXewa1WJHz1OFk+ETMSbXQ3rmKPlF
2epuBPaw7gBN4W1nb9nGpZkG+Ub2hUJTN7nBB0IJ5GD+mrREYXyxAHiEk9AWR1Bb
nD5tNG9ZWepZSGtR11j3jdPc2XVNksMJyMCuqG4tmIZbjuaS7mu9vvxBoSDxqD9j
uK6Nqwb0FziTG9MkhW8EMgjvhlCGnA==
=L/hl
-----END PGP SIGNATURE-----

--8TMyWXG1VGLOfNzK--

