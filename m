Return-Path: <linux-fsdevel+bounces-32990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF139B1216
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 23:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950F6B2193A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69620EA27;
	Fri, 25 Oct 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1jKf998"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC200217F57;
	Fri, 25 Oct 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893491; cv=none; b=N71GOIavKAFJmSrcFIMFHzAK5rNijoKSZxTbM5pP/iFPofpiWA8h/Nlxzyp+/TFbdkX/VYiaNHVCNtfuUcTMZ34vP0sBRyEDg4Ovt3AnsuTbfPIKPSFHu4wkSK2dYCM1ySB+mdRVkNZ8MjZHalK0F6mRZiEljg/Fzy4+0iYpFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893491; c=relaxed/simple;
	bh=WaXT3N54W0je/Mf9JECHTQKvU4XqvFR6omMZdeIU/jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJyPP39CgeLPU/LpMH8iSIvBlQUesOnEm5/0VLn/EeP5I1VxqNH3QUsRWBhopkYTZbqP7rmWiptuJ81/z/ejDtCyE6pMg0SLma0QJatp2j+lwjyFYXnYEhnS+0ixsAUbyH8jQtlk0cx++CPbX/6yHGgxq1WMhkHYF1YwEypQWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1jKf998; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F67CC4CEC3;
	Fri, 25 Oct 2024 21:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729893491;
	bh=WaXT3N54W0je/Mf9JECHTQKvU4XqvFR6omMZdeIU/jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1jKf998y+TKcDBxoZWO7Srjy5BxeZPsExybQKizrFgk+PpkacomWzjgPfi2gZX0k
	 GcV3gQnWT1lPzWgsffOADNQ1fYIQqY51/TGmJnqELBkll4fPmWTI5e8Y0irEkljl8i
	 3ufBer3vuNsxiQZ3DWkt1yCS+hMNJjqOy5hix5omzsjZAPm2qtwTme6k4zLUXmlZlK
	 tnEN7HjR0+nGbi7IG5otQ1P8q9KQsFiBwNi6CLKgl3q/Gt0ALdaYMOK3MwWLwGbGux
	 UHsSQXY2PXI2ef+EUxp/i2+s5Wa2PGwfakGdpyOee8kEE8274hT53ajG44fJdG2gOq
	 L7RL4siXZj7ZA==
Date: Fri, 25 Oct 2024 16:58:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, rick.p.edgecombe@intel.com,
	richard.henderson@linaro.org, cleger@rivosinc.com,
	alexghiti@rivosinc.com, Eric Biederman <ebiederm@xmission.com>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	samitolvanen@google.com, linux-doc@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, atishp@rivosinc.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, evan@rivosinc.com,
	x86@kernel.org, Shuah Khan <shuah@kernel.org>,
	devicetree@vger.kernel.org, alistair.francis@wdc.com,
	broonie@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kselftest@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	linux-riscv@lists.infradead.org, charlie@rivosinc.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Albert Ou <aou@eecs.berkeley.edu>,
	Kees Cook <kees@kernel.org>, andybnac@gmail.com,
	linux-fsdevel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, kito.cheng@sifive.com,
	Borislav Petkov <bp@alien8.de>, jim.shu@sifive.com
Subject: Re: [PATCH v6 07/33] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Message-ID: <172989348946.964081.3884883100574600652.robh@kernel.org>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-7-60d9fe073f37@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-v5_user_cfi_series-v6-7-60d9fe073f37@rivosinc.com>


On Tue, 08 Oct 2024 15:36:49 -0700, Deepak Gupta wrote:
> Make an entry for cfi extensions in extensions.yaml.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


