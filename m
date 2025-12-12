Return-Path: <linux-fsdevel+bounces-71188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2E7CB8377
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 09:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B21EB301D9ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4376830E0D9;
	Fri, 12 Dec 2025 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFeJPvAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C630E0E7;
	Fri, 12 Dec 2025 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527333; cv=none; b=CtFwKedGccDO8hj/1g3m4QoUBjR4sxg8/SG1R51i4Lmmcj97k3LDWKI5SSiEiEyar5DiMYdhTFGjACrPDQEHoM59tyOCcEcn9TWAvFfpuuN8kb0g48keO+rwNCu6q9ApGN7b+5AfDEhj85DPs/zf0Hwtir0bLiC/nxfSFTX+oRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527333; c=relaxed/simple;
	bh=/hrrCjWB7RCTyEWEeMlOdi0WwTl2Sn/DGE23XvsAA1U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SJoCLG+JLozlFKeYZYems+icK32n+OkfybtPTjrYbr4mEKA9teDNHq+lBVwPnrAXlJYY/nwiBz1sm2QqIMc11QEacRY/RiKJiQQ76C9XvmwPKQ/i5czEsTtXcDTJkTuIbFk/Vq0/Lpl0rPcc68MgLMH4BSJnkNQMxu4ApLxyqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFeJPvAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38DDC4CEF1;
	Fri, 12 Dec 2025 08:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765527331;
	bh=/hrrCjWB7RCTyEWEeMlOdi0WwTl2Sn/DGE23XvsAA1U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=nFeJPvAgpE2u+HqSBX8PIxPmMSQ17wJNJelCCJFq1uX7BJ4kkZTE58a4A/8W62uDv
	 8dCoi9GTVmIMujcz+AOuXNHyzOpNdkqYb0DKCTnbVN5TLfcAkHHk4X5GkOY53+fRgD
	 H2vRj24tmoDmCl8w/eVYpZl4Jls0dlJuEvEZknT2PTiKXaOtE9hzu2MBmaeM6kr1j/
	 ogHmwcJaqT9Ixl5mvdquTPY2dsBps1wEREysFISYUzN+OM8KsbYw3C3l1ZIxq/kU5p
	 WRGZq7FJYPTT9l34JbOAyhRb6Au3e9WpMLWJE01Ek738rPu9oBt8WFwFmkHSBIxHo9
	 YRpD801VkVqYw==
Date: Fri, 12 Dec 2025 01:15:11 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
cc: linux-riscv@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
    lorenzo.stoakes@oracle.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
    aou@eecs.berkeley.edu, conor@kernel.org, robh@kernel.org, 
    krzk+dt@kernel.org, arnd@arndb.de, brauner@kernel.org, 
    peterz@infradead.org, oleg@redhat.com, ebiederm@xmission.com, 
    kees@kernel.org, corbet@lwn.net, shuah@kernel.org, jannh@google.com, 
    conor+dt@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
    boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
    a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
    lossin@kernel.org, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
    andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
    atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
    alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
    rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
    zong.li@sifive.com, david@redhat.com, andreas.korb@aisec.fraunhofer.de, 
    valentin.haudiquet@canonical.com, cmirabil@redhat.com
Subject: Re: [PATCH v26 00/28] riscv control-flow integrity for usermode
In-Reply-To: <176551861579.2032148.13920544388182691102.git-patchwork-notify@kernel.org>
Message-ID: <b9991702-44d9-1f0d-e5c8-677c404e2522@kernel.org>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com> <176551861579.2032148.13920544388182691102.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Dec 2025, patchwork-bot+linux-riscv@kernel.org wrote:

> This series was applied to riscv/linux.git (for-next)
> by Paul Walmsley <pjw@kernel.org>:
> 
> On Thu, 11 Dec 2025 09:20:33 -0800 you wrote:
> > v26: CONFIG_RISCV_USER_CFI depends on CONFIG_MMU (dependency of shadow stack
> > on MMU). Used b4 to pick tags, apparantly it messed up some tag picks. Fixing it

This is the Patchwork bot getting things wrong, again.  

What got repushed was a slightly modified version of the v23 series -- 
with the non-code changes described here:

   https://lore.kernel.org/linux-riscv/176551861579.2032148.13920544388182691102.git-patchwork-notify@kernel.org/T/#t

Deepak: as others have pointed out, you shouldn't be sending patch series 
during merge windows.


- Paul

