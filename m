Return-Path: <linux-fsdevel+bounces-30784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE898E48E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479541C221DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850D217330;
	Wed,  2 Oct 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmwllp6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD4745F4;
	Wed,  2 Oct 2024 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903017; cv=none; b=PbAS9J6uhKL4KPU0wmgnAf18oyUVz8CQRYOFzHfu2uPj6IMkVWV2ErfIb+v32L0Y+qJapSQAPY1xSxIzkOAF8u5xT7J9ausrYdL7S1ttIzPfDf1GGjlmMj1K9S3wa/TQCz+7j03SAEbH4J1sfhDlKWqDwkGEV+/Vwx3SV/hMOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903017; c=relaxed/simple;
	bh=T/J+bsNsUgw22rlBrYHJdcx0PE1m7ec1tmy77h9yuls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZp5MoLle7iAq6YMeasL8eNvzvGo10NY6/NYhyNu/yuIN/wuB3Gt46v9kewfCHp0iFJlTFzOhTh5ltqzpXT6sakDlPT+lW43rqpFjs9JurB0af80MHRKwpr9yAwFcFfuo9l0bwG5e+A2/OpbIjj6Gyfe4nH5yhYwbTp/VqZ7o5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmwllp6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A9FC4CEC2;
	Wed,  2 Oct 2024 21:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727903016;
	bh=T/J+bsNsUgw22rlBrYHJdcx0PE1m7ec1tmy77h9yuls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jmwllp6jzRETuClzX6i3XersBeu6pr5GCmFLlKZUoLVMVYp98nR8I1WBsoziE1zwv
	 EqLtCFWqPGJSD96kzZpm58e3IsTbFS7WDAX/QDivj9IgWJB8G+loz3oUm+b3k+Vvfg
	 5fJ5j6eLgua8KQ7IIkJDZ4frWJ2mmOyEdrVzJL3Mhhg2OGLV7RgIUBMO+k0lqmw0wT
	 nTitMwjJNI14VX3a/mC5weH5VNLpjfvsCpIjvdGAv1Jt3ysB1issay1HQfQxnI0rFp
	 2tniOP6L1zeIj89TM5ZmkNI70CjZOSWSGmwzAhNH9ZgcYj++UnNtpYvJbDk2jxE51K
	 ILXa6mUOgiYBA==
Date: Wed, 2 Oct 2024 16:03:35 -0500
From: Rob Herring <robh@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 07/33] riscv: zicfilp / zicfiss in dt-bindings
 (extensions.yaml)
Message-ID: <20241002210335.GA1307114-robh@kernel.org>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-7-3ba65b6e550f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-v5_user_cfi_series-v1-7-3ba65b6e550f@rivosinc.com>

On Tue, Oct 01, 2024 at 09:06:12AM -0700, Deepak Gupta wrote:
> Make an entry for cfi extensions in extensions.yaml.

Run "git log --oneline" on the file/subsystem and follow the subject 
prefix pattern.

> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index 2cf2026cff57..356c60fd6cc8 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -368,6 +368,20 @@ properties:
>              The standard Zicboz extension for cache-block zeroing as ratified
>              in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
>  
> +        - const: zicfilp
> +          description: |
> +            The standard Zicfilp extension for enforcing forward edge
> +            control-flow integrity as ratified in commit 3f8e450 ("merge
> +            pull request #227 from ved-rivos/0709") of riscv-cfi
> +            github repo.
> +
> +        - const: zicfiss
> +          description: |
> +            The standard Zicfiss extension for enforcing backward edge
> +            control-flow integrity as ratified in commit 3f8e450 ("merge
> +            pull request #227 from ved-rivos/0709") of riscv-cfi
> +            github repo.
> +
>          - const: zicntr
>            description:
>              The standard Zicntr extension for base counters and timers, as
> 
> -- 
> 2.45.0
> 

