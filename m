Return-Path: <linux-fsdevel+bounces-69448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C0C7B5A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A69A3A249B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14CF2F1FD0;
	Fri, 21 Nov 2025 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QEx6H1kx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB22727ED;
	Fri, 21 Nov 2025 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750198; cv=none; b=r539H3ch3sqkyGoLsNkGaVOyEUSb9FrE7unT5VQlzFNdVii7sKMeqwvNiIEjIct6EUDQYp0X5E7Fjd8+09SBtLXYvkv/O7yybv+JKiAIpBOtweSn/98WDSUCjdZgl8nwweHtmTKndmBT/rhETtHJrwOcblrs/QiSBLhSMVHTEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750198; c=relaxed/simple;
	bh=crGPPT0AtAuzG2UEVBlxUERhuPjW93cug8nah7uLwPI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OHAMLCNHIsRaxEHRmmFh8Xd4UBjzFQayvSJdE0BShmdJAUynep95FrouLRh1vj64L89/mLHQGLDnndOFWpm084d3Jr0mxsifJ3yEW9uBDocAtm6VEtoW4xN9VFYIikTYjYw+WyBvPOKCJdXyaO168mRc0NwwJjHel98llgQjBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QEx6H1kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C2AC4CEF1;
	Fri, 21 Nov 2025 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763750197;
	bh=crGPPT0AtAuzG2UEVBlxUERhuPjW93cug8nah7uLwPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QEx6H1kx4LH2VEQuGtG4dDTBfQimoEx6dOPrEkpMfabhu8lvBwbefk1rGdOBtVACD
	 QZKA8vPhUokAEv0JJOZyDEHGcBf++sPmEabuLzPJH1etPYvKiGFWYCxM0l12ChfFsx
	 m1HWtmpBhooqID4D5faCmw1veUK4HRjgPAR6uS0U=
Date: Fri, 21 Nov 2025 10:36:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, Peter Xu
 <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>, David Hildenbrand
 <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, Conor Dooley
 <conor@kernel.org>, Deepak Gupta <debug@rivosinc.com>, Ved Shanbhogue
 <ved@rivosinc.com>, linux-fsdevel@vger.kernel.org, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V15 1/6] mm: softdirty: Add
 pgtable_supports_soft_dirty()
Message-Id: <20251121103636.22321ceb37093370e59cb6e1@linux-foundation.org>
In-Reply-To: <dac6ddfe-773a-43d5-8f69-021b9ca4d24b@lucifer.local>
References: <20251113072806.795029-1-zhangchunyan@iscas.ac.cn>
	<20251113072806.795029-2-zhangchunyan@iscas.ac.cn>
	<dac6ddfe-773a-43d5-8f69-021b9ca4d24b@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 16:57:17 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> This breaks the VMA tests. Don't worry it's not exactly an obvious thing.
> 
> You can test this via:
> 
> $ cd tools/testing/vma
> $ make && ./vma
> 
> (Currently we also have another breakage too which I'll chase up separately.)
> 
> Andrew - Could we simply apply the attached fix-patch?
> 
> I know this is in mm-stable now so ugh maybe we'll have some commits where VMA
> tests are broken (not nice for bisection), but anyway we need to fix this even
> so even if it has to be a follow up patch.

"mm: softdirty: add pgtable_supports_soft_dirty()" is still in
mm-unstable so all is good.


