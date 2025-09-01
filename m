Return-Path: <linux-fsdevel+bounces-59845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FEAB3E5D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5D57AA748
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D6D335BD5;
	Mon,  1 Sep 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm/3jFxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81430C35F;
	Mon,  1 Sep 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734305; cv=none; b=PVGulJbIZ1ZvpsCuSOrJQeXiwXpOJwJIN4EXIUeI5pnrvRP9btIt0xFd1cUheVFb+zR/QVBLGCuhbdVCh2L7CNAsdlqj3LKXpeDvHKc2tip5uvuKBaJUhGGuOgL9kxnRTwLIKWGIbusTQmn60K+gN+tvCnnPMh92QLwgzNbAusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734305; c=relaxed/simple;
	bh=foGamXMOViIJn4G3j6IQOX71KSnPTeGQ3yBpqoRM1bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4j3kW9sqHQ/m9upVGrn5tGE0ejnsHoZ8Do4sGeOiMS3zbqM8EdX38TLL8YT5scQbiTRY+rA+fihUV3PGROWoqbk6+PAsgqMTPxmGfmheudF6txwSkrmSH0l4ZkrBIOVwe0pfthqc4CtWOB5WiWNIFm8kPnrGdG2je8Cnit2AAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm/3jFxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283D2C4CEF0;
	Mon,  1 Sep 2025 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756734305;
	bh=foGamXMOViIJn4G3j6IQOX71KSnPTeGQ3yBpqoRM1bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bm/3jFxPdO3TDTc6l4dEWpafE4Ax0voh/4zrCE265vf2efYVcM6izsEAOEmBDIw2S
	 6IklfZXNBQmbCcAxXaFtfG23f302OLNHm433bVI0cS1TTbdks5iiBzbvkwgqWvB6ku
	 HGY8M8PREeQTxRGlBV3057vbbTo64F6EtjD4fgVBM5GWMeMxJLUhumLnq3tLxZEkhR
	 wpMoMNL68N++yJvIyqd5dIxCRXt16H5LhD+9LMPR08sNdA8x92A6nyLNNwXY5fYXaW
	 4D2ZlkCKsMQBPurmWa639x6caci0/AyEQAb7tZBzb0NLPuuy2+yfWyPnMLZSEN+iLK
	 QlgLXyxfLq0MA==
Date: Mon, 1 Sep 2025 15:44:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net, 
	jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com, 
	broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au, 
	nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/12] mm: establish const-correctness for pointer
 parameters
Message-ID: <20250901-ungut-geerntet-51b9f03284be@brauner>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>

On Mon, Sep 01, 2025 at 02:30:16PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> This patch series systematically adds const qualifiers to pointer
> parameters throughout the memory management subsystem, establishing a
> foundation for improved const-correctness across the entire Linux
> kernel.
> 
> Const-correctness provides multiple benefits:
> 
> 1. Type Safety: The compiler enforces that functions marked as taking
>    const parameters cannot accidentally modify the data, catching
>    potential bugs at compile time rather than runtime.
> 
> 2. Compiler Optimizations: When the compiler knows data won't be
>    modified, it can generate more efficient code through better
>    register allocation, code motion, and aliasing analysis.
> 
> 3. API Documentation: Const qualifiers serve as self-documenting code,
>    making it immediately clear to developers which functions are
>    read-only operations versus those that modify state.
> 
> 4. Maintenance Safety: Future modifications to const-correct code are
>    less likely to introduce subtle bugs, as the compiler will reject
>    attempts to modify data that should remain unchanged.
> 
> The memory management subsystem is a fundamental building block of the
> kernel.  Most higher-level kernel subsystems (filesystems, drivers,
> networking) depend on mm interfaces.  By establishing
> const-correctness at this foundational level:
> 
> 1. Enables Propagation: Higher-level subsystems can adopt
>    const-correctness in their own interfaces.  Without const-correct
>    mm functions, filesystems cannot mark their own parameters const
>    when they need to call mm functions.
> 
> 2. Maximum Impact: Changes to core mm APIs benefit the entire kernel, as
>    these functions are called from virtually every subsystem.
> 
> 3. Prevents Impedance Mismatch: Without const-correctness in mm, other
>    subsystems must either cast away const (dangerous) or avoid using
>    const altogether (missing optimization opportunities).
> 
> Each patch focuses on a specific header or subsystem component to ease review
> and bisection.
> 
> This work was initially posted as a single large patch:
>  https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/
> 
> Following feedback from Lorenzo Stoakes and David Hildenbrand, it has been
> split into focused, reviewable chunks. The approach was validated with a
> smaller patch that received agreement:
>  https://lore.kernel.org/lkml/20250828130311.772993-1-max.kellermann@ionos.com/
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Seems fine,
Reviewed-by: Christian Brauner <brauner@kernel.org>

