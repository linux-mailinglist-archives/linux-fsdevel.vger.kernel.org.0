Return-Path: <linux-fsdevel+bounces-66547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C48C2333E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 04:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2668A4F132C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 03:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9796A27F015;
	Fri, 31 Oct 2025 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XNYpNu1N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B421A9FBF;
	Fri, 31 Oct 2025 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882179; cv=none; b=ToFTs9yo6D0+VGNIEjSFikwHMWQBSbaKMD+Li/fXi8WI00E7c2SzPGaKo9EKZTMgvHLUbXwTAyxuPs84uOCzndia2iHVIFTqAhvE9gkHN+ZzRISSFj5TWU5negQT9Fc3zPkSUHFEJWYOlucOlJhvpvhnihyKlcvpYR3pImfcvh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882179; c=relaxed/simple;
	bh=Y+7+7cmXmpwcMKwAwk6LejI5cq/8Ck1dQ3CuyXnaiaA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q6e/RkCSYL2j82l6I5xs0p77CpJDHqsqJbDK4tYicF4y6/o0pe0KkcC+m9k/N9z9A4jeqO+VglCJBwHHgLiPhUnX2HzWxk09N42TGZMxr/ViBjGb3XeTy0fMdExiQq3yHC0YyQLFJccRglf2d687od4qLmAY4EI7ueCJIvbe4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XNYpNu1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BBEC4CEE7;
	Fri, 31 Oct 2025 03:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761882178;
	bh=Y+7+7cmXmpwcMKwAwk6LejI5cq/8Ck1dQ3CuyXnaiaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XNYpNu1N9e9lUBpNuqq6HIe00uIhOWv8PJP2J3Cu/q5ZZHnD2Wg0z4BGhT9w25MEr
	 VTlMQRpVtXE7bbKOHBHqJz2pXBFNVW2N/hbjlMs1nioljoEGdn0K1Nip08Me+/Fuw/
	 JTMmir3FCXyeiat8GcOLOaogucmgsPaN27tGE1V8=
Date: Thu, 30 Oct 2025 20:42:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
 kernel@pankajraghav.com, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Wei Yang
 <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] Optimize folio split in memory failure
Message-Id: <20251030204257.13590714dfb2deae8c2f193c@linux-foundation.org>
In-Reply-To: <20251030014020.475659-1-ziy@nvidia.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 21:40:17 -0400 Zi Yan <ziy@nvidia.com> wrote:

> This patchset is a follow-up of "[PATCH v3] mm/huge_memory: do not change
> split_huge_page*() target order silently."[1] and
> [PATCH v4] mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split
> to >0 order[2], since both are separated out as hotfixes. It improves how
> memory failure code handles large block size(LBS) folios with
> min_order_for_split() > 0. By splitting a large folio containing HW
> poisoned pages to min_order_for_split(), the after-split folios without
> HW poisoned pages could be freed for reuse. To achieve this, folio split
> code needs to set has_hwpoisoned on after-split folios containing HW
> poisoned pages and it is done in the hotfix in [2].
> 
> This patchset includes:
> 1. A patch adds split_huge_page_to_order(),
> 2. Patch 2 and Patch 3 of "[PATCH v2 0/3] Do not change split folio target
>    order"[3],

Sorry, but best I can tell, none of this tells anyone anything about
this patchset!

Could we please have a [0/N] which provides the usual overview of these
three patches?

Please put yourself in the position of someone reading Linus's tree in
2028 wondering "hm, what does this series do".  All this short-term
transient patch-timing development-time stuff is of no interest to
them and is best placed below the ^---$ separator.

Thanks.

