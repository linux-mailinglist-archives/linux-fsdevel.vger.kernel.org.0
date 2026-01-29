Return-Path: <linux-fsdevel+bounces-75841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLDeN4kde2msBQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 09:42:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC1ADA38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 09:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2829300C0E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13D37C0ED;
	Thu, 29 Jan 2026 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPGl94Lh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0937AA72;
	Thu, 29 Jan 2026 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676159; cv=none; b=JOqBNDweiYnyEi/uWCR9Obj25G1gBnr2jUku80xc9FTZTh4ItzOi/AEqrxKWEgEcn2yetsBmtAYuO01sKEdVaCcPBE6XXHYEnCIAp5iLQ9UNgwmAUVQC7IQCa14GqTO2FpBcrBLnlwSIN0aXjCdlhHodNqw0Jv5ofuEx0dv+Tu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676159; c=relaxed/simple;
	bh=9QMEWB+yM4NRpFfl8KXrYJ8s8e6vKN8iej0DvKpGhcU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S0dGkj1AU3ofGA5BA5UTTz0Ig297wrdKvKaKrEMRLwzEx4PexW0zgvkFBuFPzYgSsGUBHOoT7mBppgHcNaNPPo7X1umx1wkeeWeAPBizeY1GAE+yp5AgOwDbXDvrsoGKa41+pbAIUHctt6Q92CxGKkaMUSFNwcX4LJxzgpo9rzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPGl94Lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4C1C4CEF7;
	Thu, 29 Jan 2026 08:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769676158;
	bh=9QMEWB+yM4NRpFfl8KXrYJ8s8e6vKN8iej0DvKpGhcU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WPGl94Lhk/NCi3lEfZ8z65ulZBNKDA6CREUcGelyPWHfzLrK37HGMuOwr6ymnAWbq
	 zMZw49VV3aaXfUo4RySMTADkUQE8+HOyxLnDUbS9p1QK1M0ZRy5dZoytzUnUWxQCiV
	 JuT7cNRWclddUiuwl9xVh/+NdZ+rP0tENaakniujZDuQet4Cq/5STEjla2SU6a7q9W
	 IS3R+R9rKQilV6AEDsD1IY1uaYb3R1j1y6rd5wzC3bsdxi84+lYX8JX2lPdhLlHGdW
	 /cUwi/rw/43gTiJJkns0weSNlVwB+8yl7oSzYqr3Zf2SXhbeJgLk9oPQYFHNifZxf3
	 yKjt2ycaK4QFQ==
Date: Thu, 29 Jan 2026 01:42:32 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    Christian Brauner <brauner@kernel.org>, 
    Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
    Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
    Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
    Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
    Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
    =?ISO-8859-15?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
    Andreas Hindborg <a.hindborg@kernel.org>, 
    Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
    Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
    linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
    richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
    kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
    evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
    samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
    rust-for-linux@vger.kernel.org, Zong Li <zong.li@sifive.com>, 
    Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
    Valentin Haudiquet <valentin.haudiquet@canonical.com>
Subject: Re: [PATCH v26 10/28] riscv/mm: Implement map_shadow_stack()
 syscall
In-Reply-To: <aXfRPJvoSsOW8AwM@debug.ba.rivosinc.com>
Message-ID: <190df1c1-feb2-ae5d-7fdc-dd0c3d780b21@kernel.org>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com> <20251211-v5_user_cfi_series-v26-10-f0f419e81ac0@rivosinc.com> <aXfRPJvoSsOW8AwM@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,linux.intel.com,kernel.org,zytor.com,linux-foundation.org,oracle.com,suse.cz,sifive.com,dabbelt.com,eecs.berkeley.edu,arndb.de,infradead.org,xmission.com,lwn.net,google.com,gmail.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,kvack.org,lists.infradead.org,wdc.com,linaro.org,rivosinc.com,intel.com,aisec.fraunhofer.de,canonical.com];
	TAGGED_FROM(0.00)[bounces-75841-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[61];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjw@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ACC1ADA38
X-Rspamd-Action: no action

Hi, 

On Mon, 26 Jan 2026, Deepak Gupta wrote:

> Can you apply following diff on `allocate_shadow_stack` function in this
> patch.
> This fixes the bug that I earlier mentioned. We shouldn't be returning
> location
> to token and instead return base address of shadow stack. Userspace consumer
> should be determining token location itself. This matches the ABI of other
> arches. Sorry for being late on this.
> 
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> index 27b36034ea85..a8530e6afb1e 100644
> --- a/arch/riscv/kernel/usercfi.c
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -232,7 +232,7 @@ static unsigned long allocate_shadow_stack(unsigned long
> addr, unsigned long siz
>  {
>         int flags = MAP_ANONYMOUS | MAP_PRIVATE;
>         struct mm_struct *mm = current->mm;
> -       unsigned long populate, tok_loc = 0;
> +       unsigned long populate;
> 
>         if (addr)
>                 flags |= MAP_FIXED_NOREPLACE;
> @@ -245,13 +245,11 @@ static unsigned long allocate_shadow_stack(unsigned long
> addr, unsigned long siz
>         if (!set_tok || IS_ERR_VALUE(addr))
>                 goto out;
> 
> -       if (create_rstor_token(addr + token_offset, &tok_loc)) {
> +       if (create_rstor_token(addr + token_offset, NULL)) {
>                 vm_munmap(addr, size);
>                 return -EINVAL;
>         }
> 
> -       addr = tok_loc;
> -
>  out:
>         return addr;
>  }

Thanks, this fix has been rolled into the queued patch.  The Reviewed-by:s 
and Tested-by:s have been dropped.


- Paul

