Return-Path: <linux-fsdevel+bounces-79343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBJHClkTqGnUngAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 12:11:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE61FEBDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 12:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7AAD303E79F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02773A4F26;
	Wed,  4 Mar 2026 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtxESzLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C143A4F25;
	Wed,  4 Mar 2026 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622631; cv=none; b=aZtHzLQpweEt+kh840pINpvzSE+nKnyhcJoOhxo+6R1N7Yw31nPRCynTzOGkPzNmmZJZRYKnQIgwHQsOfoZhbxhnjQv+KKhyj4y/jh6dN9In27WClQl1bg1Awldy4VcrF1MHVjT7ozDtmmCBbM9Y/+sJ3o7kDLmOcFQ97kz4LrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622631; c=relaxed/simple;
	bh=NqNfQqjBGfmbAJo/aZtHMPo7003kq0HNHUa3oLLM9rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOwlADegZNWRm0dv1I4xMg8DdkrRZbC46fUuw/aLiMnSDMLdPP8/cLmuhRe9Vw96PeB0QSAmg+sms6aFjjxTSOFAZjwpi9F7k594FFvGPhAoOOuNfBGe+Fx1beGv1+HxaEnI950JuPzQtAN/CqdL+7qCjmLB4Lo2GwEd3jnJrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtxESzLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64839C19423;
	Wed,  4 Mar 2026 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772622630;
	bh=NqNfQqjBGfmbAJo/aZtHMPo7003kq0HNHUa3oLLM9rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtxESzLTRevMkC0RMT3EArDVMk2FhTkCghz7l84S/Sl/uRFMKbvYjBO6WKTPLXZG2
	 hDd+jtXTkQDCPlsNqrRNNBIS69FSEG3kyCqhhWldcKaA7lgmXmclpmibkTkxFDGx05
	 L1mWc9QOtddQl0a6TEhhiss3l8edtqg3iz0dJiofY0wVH+4yeCbYY1MzoD2oPWrjdR
	 EnDw2NjEjLAGM8p4Zym2vHqMmJuBYJNQQtn7Ix1yH9YiSler1bu8kJQI/BP/hsAWKP
	 HCA4EbtIlLqW3pzKVaXGzu0CeEXA+pozdgRHL7CTE7jTeamnzsicmpnlaw5LC2gU+C
	 eQD2mqeeLI41g==
Date: Wed, 4 Mar 2026 11:10:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Anna Schumaker <anna@kernel.org>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>, Carlos Maiolino <cem@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chao Yu <chao@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ingo Molnar <mingo@redhat.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jaroslav Kysela <perex@perex.cz>, Jens Axboe <axboe@kernel.dk>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Zheng Gu <cengku@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	dm-devel@lists.linux.dev, netdev@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	v9fs@lists.linux.dev, virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 5/8] spi: use rest_of_page() macro where appropriate
Message-ID: <e731e101-bf06-44d7-ac91-0756c5b8bbc8@sirena.org.uk>
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260304012717.201797-6-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MuL6cN1k4g/DbVd2"
Content-Disposition: inline
In-Reply-To: <20260304012717.201797-6-ynorov@nvidia.com>
X-Cookie: Take it easy, we're in a hurry.
X-Rspamd-Queue-Id: 49EE61FEBDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79343-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,davemloft.net,redhat.com,mit.edu,eecs.berkeley.edu,fb.com,linux.ibm.com,zeniv.linux.org.uk,dilger.ca,lunn.ch,kernel.org,opensynergy.com,alien8.de,arm.com,linux.intel.com,gmail.com,codewreck.org,linux.dev,google.com,gondor.apana.org.au,perex.cz,kernel.dk,ionkov.net,ellerman.id.au,szeredi.hu,dabbelt.com,infradead.org,intel.com,ffwll.ch,suse.com,ursulin.net,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[85];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


--MuL6cN1k4g/DbVd2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 08:27:13PM -0500, Yury Norov wrote:
> Switch SPI code to using the macro. No functional changes intended.
>=20

Acked-by: Mark Brown <broonie@kernel.org>

--MuL6cN1k4g/DbVd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmoExQACgkQJNaLcl1U
h9CfwQf+I/XcN+BTYZLFcHPKTZ6Gt21+q3GLOzdkgChqzxOybf6b2qD+OHDN55Te
HvnosWIFzWzrD0ZP4eNe1TE0j1djIs+y2hdX6fElOOuJijsn21UWvVZXuuGdENdA
tPZDWrSzxJ8sU12FFYyBJDxsnWysekc1llPy00e37sfeetOZOLaYg/1jnttOl6oU
a3i0DGlMSVCN0pIYah+1R5Vbe35l4DlrcyOoswdwqqqEAzPLr0ysycWbbVmelm0M
U/y3gvpx6ZZBlMMio/3WWZfu3pM/Kwc8nzHkdzsstdqSIsRHEWru1MF5W4E+IcwO
Id51vK66wgwDVauWcfBpUUDez8/oEA==
=1DSJ
-----END PGP SIGNATURE-----

--MuL6cN1k4g/DbVd2--

