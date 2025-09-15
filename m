Return-Path: <linux-fsdevel+bounces-61443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26137B582C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 19:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546A216E37F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EFF285CAA;
	Mon, 15 Sep 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/zc5hBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553B26E71B;
	Mon, 15 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757955935; cv=none; b=JlQj332ccC4WI4+5y1R89/ZoMK5VZC7hEenT+W/lw4oJp9Key5xoxewqcdAMDA/G4z5LGfMPw8qI99fkkZOnuLl8IxNsPhkxir+UkJUdUPO5FCscNJ99anzHsuDcVZE/z4vZ70dowak8U/3UXEfAt849LRgSwnB3aLCw5m8aOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757955935; c=relaxed/simple;
	bh=QCcSyLKtRBEpOKVEnWbAIl+bl/ydhsIKcxdyT8tetGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu3flgSJVAneP3khg2nOxsqiWmDVy51M1bjPFebguDBsJRtClIQxHxcdnmiFddIbdiDxlb8+Yr1jDx23EyqsDUpIU7AGoZnmN4IS8OyINOUr2+Y/lhlk14FXsduH8/JevHNG5IzWEVAXGcSO6CCEFjNQTQBQkoJte0p0w8XC9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/zc5hBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836BFC4CEF1;
	Mon, 15 Sep 2025 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757955935;
	bh=QCcSyLKtRBEpOKVEnWbAIl+bl/ydhsIKcxdyT8tetGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/zc5hBL1H1uKA4zJpx6r2zWCbmwpMbns8eHIZm3ik363b1+81TX9PT1Et+dcMVca
	 w5QytMmZb+apJkySW4bNBKMo6lJ3C6r0mxa9HhzqitrKeMYletMYV0wimqQwlVQoXQ
	 N6HxFlT+W1d3WFv+EgRZu2E7FypYIKsgnAr6I8ouQlHTgB7epnj7gUoxW7Zh4VeH4L
	 48iv8rQ0flOx/+9ZQi1ko6TpmEXZAgBJqVM/I5UYFPfiiqr0i+1sQJwdfZ7YYx4dYz
	 /bUezOy7NhnEmdEHrIp8RvW0e8uuL4z1ozgWA0KqTJhdZfbeEkNq5C3Ak9Jr90kdqW
	 vtLU5IWoHfkhQ==
Date: Mon, 15 Sep 2025 18:05:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V12 2/5] mm: userfaultfd: Add pgtable_supports_uffd_wp()
Message-ID: <20250915-borrower-crusher-7a9e9121a1b0@spud>
References: <20250915101343.1449546-1-zhangchunyan@iscas.ac.cn>
 <20250915101343.1449546-3-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/gi+eTVpaGnrTG3f"
Content-Disposition: inline
In-Reply-To: <20250915101343.1449546-3-zhangchunyan@iscas.ac.cn>


--/gi+eTVpaGnrTG3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 06:13:40PM +0800, Chunyan Zhang wrote:
> Some platforms can customize the PTE/PMD entry uffd-wp bit making
> it unavailable even if the architecture provides the resource.
> This patch adds a macro API that allows architectures to define their
> specific implementations to check if the uffd-wp bit is available
> on which device the kernel is running.
>=20
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

According to patchwork CI for riscv, this doesn't build for 32-bit
defconfigs or the no-mmu defconfigs.

--/gi+eTVpaGnrTG3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhHWAAKCRB4tDGHoIJi
0g3AAPYyMr0sKk1q17lwf8rI9IXyUkgSilhSi7k0qTds4n0KAP4iPiualM+L6H88
quoylo0zyBkFOvt7aPxdrFyH/BhuAw==
=Y8mB
-----END PGP SIGNATURE-----

--/gi+eTVpaGnrTG3f--

