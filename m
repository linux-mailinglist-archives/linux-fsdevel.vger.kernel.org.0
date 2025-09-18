Return-Path: <linux-fsdevel+bounces-62144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A730B85837
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA54D7C5F78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39309233721;
	Thu, 18 Sep 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyx37ooM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D1221546;
	Thu, 18 Sep 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208460; cv=none; b=hfUHdO5hnmYO5Iyd/P9X2tpcHd8icd/TUJ5upNRXNpU+GolBhEATRQg8T5of3+5pSxd+U+gmya1KyK3b2ClRe/eBT1hErePZp0Eiq0K/DWtgbeHhKQkweU4kWDHuSQFKw8We+pB39iygWpf+NqD58ebCAFxqgqmrAXSOJBp+ucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208460; c=relaxed/simple;
	bh=e37jPrqR9E8heaYU5Fw0c1p4mhM/UmeLs+VMIVzgSZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLaCu2uquGQIapodVA+EL5J+NoWDa0vrUMNlln3aVojr3QXLF5MeQiZ08MY/hNLp77DPx76AuJ+WIrx5cHFQU249zbR2sy956+oewHrupsxSMqwWRaqpi01w4XOz0dsgtv3LN4UhtVb2GNb3fTETvSGSwwpf77eNAnt4R/eSYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyx37ooM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84D7C4CEE7;
	Thu, 18 Sep 2025 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208460;
	bh=e37jPrqR9E8heaYU5Fw0c1p4mhM/UmeLs+VMIVzgSZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyx37ooMvHHb8c2sv5ewsfpuJtmCBzSabR83O1NgTFpdz8Z/WZ2OJfpZPLSHPAOTj
	 f26qGMh6giX3o7w25KYRJjZZlZYAyKI0w5E4csToLEmUKG7ymqX5vZN4kNtOYsYJuK
	 aZiouhU6Yheg0iQC0Kqk/TbZpTdCBCJde0+fOjJONutiDEGcx6nB/8KQCOoBrM62Ex
	 ucKITNtFN4+nAw1QHFF5cbsY2wcvDQhIcOpoK14AEFv1j+ymWVNhIR2tgVKTv4pbxf
	 FsrwjSN8lBpLrKgUDlWA0P1+wfg0R10wopAEqZCgvdRgEsox15caWrQjvlsmO/FROT
	 3hY+hk1liNTfg==
Date: Thu, 18 Sep 2025 16:14:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH V14 6/6] dt-bindings: riscv: Add Svrsw60t59b extension
 description
Message-ID: <20250918-hamburger-dyslexia-4f28f632ba2e@spud>
References: <20250918083731.1820327-1-zhangchunyan@iscas.ac.cn>
 <20250918083731.1820327-7-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FffgZ+UbWyVNp4c4"
Content-Disposition: inline
In-Reply-To: <20250918083731.1820327-7-zhangchunyan@iscas.ac.cn>


--FffgZ+UbWyVNp4c4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--FffgZ+UbWyVNp4c4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMwhxAAKCRB4tDGHoIJi
0iAsAQD7ScZJcmETkRnAWwXKaeLSK+AK6nQi41/FAWzfFHlGdwEA7piCtUIt1/yB
fVjprhuNZVfc3qSe20i1DS2O+/jVCgw=
=VlWO
-----END PGP SIGNATURE-----

--FffgZ+UbWyVNp4c4--

