Return-Path: <linux-fsdevel+bounces-780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDF67D003A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03011C20F1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC232C76;
	Thu, 19 Oct 2023 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuYT4D0V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C218A2FE2B;
	Thu, 19 Oct 2023 17:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BCAC433C8;
	Thu, 19 Oct 2023 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697735301;
	bh=pG0Qit3AqQuyW6KGy3cTGUjC4taxXCYceYbhQqKPpi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuYT4D0VMaEuj+thGqbHAXol5XSAP+gpQW0FvmhrZUDfxLXv+/ZVEXa7HboYTdjfS
	 6IW13fpGKYOraD3SUYgFKSKngtaiTn4eZnS5/t4No3Bd9JUpA/YN36SlzCfxP3r8Qo
	 GSGIhhQuUcl2bZWr7R2xIlGjz0vg5FexGBIpOTGda3+rKYYtVhgWVsIhxkX6hbI0gm
	 mcLC1qwZc2f1UoNDZu97OVSCneDpDNOnMk0J/9pg1MhLPNaMhehC5h9M8hK61gX85H
	 oCvpdUL6LgDGxSu2UPoMDo+pZMMxQOrswwQOGCVnwHabAhbK25KaSViVEB0JO0/a2D
	 NKmdSxXCL95kQ==
Date: Thu, 19 Oct 2023 18:08:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <8a158486-f0b9-4f25-b673-998726a40528@sirena.org.uk>
References: <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
 <ZOTnL1SDJWZjHPUW@arm.com>
 <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
 <ZOXa98SqwYPwxzNP@arm.com>
 <ZOYFazB1gYjzDRdA@arm.com>
 <ZRWw7aa3C0LlMPTH@arm.com>
 <38edb5c3-367e-4ab7-8cb7-aa1a5c0e330c@sirena.org.uk>
 <ZRvUxLgMse8QYlGS@arm.com>
 <a7d2fd66-c06b-4033-bca2-4b14afc4904f@sirena.org.uk>
 <ZR7w/mr0xZbpIPc5@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kNvCjmZsgc4H4SyY"
Content-Disposition: inline
In-Reply-To: <ZR7w/mr0xZbpIPc5@arm.com>
X-Cookie: Beware of dog.


--kNvCjmZsgc4H4SyY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 05, 2023 at 06:23:10PM +0100, Catalin Marinas wrote:

> I haven't checked how many clone() or clone3() uses outside the libc are
> (I tried some quick search in Debian but did not dig into the specifics
> to see how generic that code is). I agree that having to change valid
> cases outside of libc is not ideal. Even if we have the same clone3()
> interface for x86 and arm64, we'd have other architectures that need
> #ifdef'ing.

FTR the set of Debian source packages that have references to the string
__NR_clone (which picks up clone3 too) is below.  At least some (eg,
kore) just have things that look like a copy of the syscall table rather
than things that look like calls, though equally it's likely we're
missing some.

aflplusplus
android-platform-tools
binutils-avr
box64
brltty
bubblewrap
chromium
chrony
crash
criu
crun
dietlibc
elogind
emscripten
fakeroot-ng
falcosecurity-libs
firefox
firefox-esr
flatpak
gcc-9
gcc-10
gcc-11
gcc-12
gcc-13
gcc-arm-none-eabi
gcc-snapshot
gdb-msp430
glibc
gnumach
hurd
klibc
kore
libpod
libseccomp
linux
llvm-toolchain-14
llvm-toolchain-15
llvm-toolchain-16
lxc
lxcfs
lxd
musl
newlib
notcurses
purelibc
pwntools
qemu
qt6-base
qt6-webengine
qtbase-opensource-src
qtbase-opensource-src-gles
qtwebengine-opensource-src
radare2
rumur
rustc
rust-linux-raw-sys
rust-rustix
strace
stress-ng
swtpm
systemd
systemtap
termpaint
thunderbird
tor
uclibc
umview
valgrind
vsftpd
wasi-libc
webkit2gtk
wpewebkit

--kNvCjmZsgc4H4SyY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUxYnsACgkQJNaLcl1U
h9BPuwf/ckJjx9BnOVP9ZzZPFpa7pKsXZe4D8gbrhkTsTNPX6DKdD77294DX72gh
Q3LR3m5Xdw3nFoR/pP6cUgZ24o8sV/iUz8fLdBvuOOnemVmgoPIRcB/TNueOcq9P
1rIwQ44UzdUfxc/5Ny1QKCvurTnCs4dFc3Llt0GdVvDy+Ec6FK9hX/Wwe48hsvLr
6kDkKqvYz3IF3xnnTmGyHxD7EdaHnYPHrU8mWr33e1j8/MWMn6ywGyCRV6ZgrQxW
VuTTod0EwhsDlW/u8yYNGmLBirZQszpmt3Wp2QCv4vcjHbjxa+xh7SYq8P5BNRj3
ZgUagp/WsyNXXW6iGiQlgqb1YHdFdg==
=ZvaR
-----END PGP SIGNATURE-----

--kNvCjmZsgc4H4SyY--

