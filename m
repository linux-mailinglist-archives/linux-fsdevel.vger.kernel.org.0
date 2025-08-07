Return-Path: <linux-fsdevel+bounces-57019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1FB1DEAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 23:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960377A7BBD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D523A997;
	Thu,  7 Aug 2025 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0Uza2f2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887C237165;
	Thu,  7 Aug 2025 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601287; cv=none; b=RkNzvuQABy9O89XpwiFoZkOG11qJwwO3QL5hhTSiE1S4UEB5jMTAAm7dYC0au26CF3FbtraN07EXwOLGGlp4vZmH4eayckdv/0xFLZSkcwG4TX2ehLHNb+sAQBxoJ1cEjTEjh5vek4Q7WF/q9kEKotwxzi4Uz4lKXZJr7PSSBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601287; c=relaxed/simple;
	bh=HAI5f935R1NcGS6jxC+XUnRQCfI1j4+QgnE9A5gcjvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1GuU3VQI6Bvu/mBIckchkr6XzXtLdshkIslOqf95CZazD/rBooK/ZPEcrEX0EEJQqK0to2Fe6E3N5ZZmZcPAzwvptMXtBkjFWnhFgCaDIAGUkvyrvqhrxh2Z1RCJGsHtlhtK7sxOEfbXG07QUEl/5oEp0J7dJuRMzMMJspk1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0Uza2f2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B433C4CEEB;
	Thu,  7 Aug 2025 21:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754601286;
	bh=HAI5f935R1NcGS6jxC+XUnRQCfI1j4+QgnE9A5gcjvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0Uza2f2Y0cfOBQOIDPShmRuzwE+/VCihcPmxgI16bYQV+j7022KPaAolF0po2PlE
	 aCVlZYMD8Qq8UGF23DTxD6WhoR+OY4Isq9kXEnA/WDtxvT8x3+HXseLFArZvBjsdM7
	 jBUSUZfzSCNRR5aXCp/p50t1Duc9sfemsH5kzpx3PtLzisuUAme+MaY9vwO5TE4G9r
	 gK4xsHtrlx5vRqCG74r5f+P6jjyQPj/UYmS3Wxy1p/O3ZgLKBteG7OuPay67wMtEB/
	 AonJJIFXC8Eb0/QPKiZhBcwVK+wJzkJ5n1jzqRJlNz0ugcvQH1cO2uVuZvoOHZat6J
	 G//Tq55dlXzlg==
Date: Thu, 7 Aug 2025 14:14:46 -0700
From: Kees Cook <kees@kernel.org>
To: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com
Subject: Re: [RFC RESEND] binfmt_elf: preserve original ELF e_flags in core
 dumps
Message-ID: <202508071414.5A5AB6B2@keescook>
References: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>
 <202508061152.6B26BDC6FB@keescook>
 <e9990237-bc83-4cbb-bab8-013b939a61fb@syntacore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9990237-bc83-4cbb-bab8-013b939a61fb@syntacore.com>

On Thu, Aug 07, 2025 at 07:13:50PM +0600, Svetlana Parfenova wrote:
> On 07/08/2025 00.57, Kees Cook wrote:
> > On Wed, Aug 06, 2025 at 10:18:14PM +0600, Svetlana Parfenova wrote:
> > > Preserve the original ELF e_flags from the executable in the core dump
> > > header instead of relying on compile-time defaults (ELF_CORE_EFLAGS or
> > > value from the regset view). This ensures that ABI-specific flags in
> > > the dump file match the actual binary being executed.
> > > 
> > > Save the e_flags field during ELF binary loading (in load_elf_binary())
> > > into the mm_struct, and later retrieve it during core dump generation
> > > (in fill_note_info()). Use this saved value to populate the e_flags in
> > > the core dump ELF header.
> > > 
> > > Add a new Kconfig option, CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS, to guard
> > > this behavior. Although motivated by a RISC-V use case, the mechanism is
> > > generic and can be applied to all architectures.
> > 
> > In the general case, is e_flags mismatched? i.e. why hide this behind a
> > Kconfig? Put another way, if I enabled this Kconfig and dumped core from
> > some regular x86_64 process, will e_flags be different?
> > 
> 
> The Kconfig option is currently restricted to the RISC-V architecture
> because it's not clear to me whether other architectures need actual e_flags
> value from ELF header. If this option is disabled, the core dump will always
> use a compile time value for e_flags, regardless of which method is
> selected: ELF_CORE_EFLAGS or CORE_DUMP_USE_REGSET. And this constant does
> not necessarily reflect the actual e_flags of the running process (at least
> on RISC-V), which can vary depending on how the binary was compiled. Thus, I
> made a third method to obtain e_flags that reflects the real value. And it
> is gated behind a Kconfig option, as not all users may need it.

Can you check if the ELF e_flags and the hard-coded e_flags actually
differ on other architectures? I'd rather avoid using the Kconfig so we
can have a common execution path for all architectures.

-- 
Kees Cook

