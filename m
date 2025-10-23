Return-Path: <linux-fsdevel+bounces-65389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891AFC03770
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 22:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D5D19A0030
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 20:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA24273D9F;
	Thu, 23 Oct 2025 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WA2jRvTN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044FB227E83;
	Thu, 23 Oct 2025 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253006; cv=none; b=U+4zV0TiJGbTvgQjRjbWeyZ6AaTRBfkbi9iFkjnrPsd9SMY78B0ow39pIYEiTNXq8bj4Ol+OzSzRDn6O9JBAdWlYN7LThRk7y+0hCnvv8efS71m7deYtwt8BO+c/pVf/MJHpnLTWxgtw96zrqgFSoES6W1XmIfpOkbXorXoqT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253006; c=relaxed/simple;
	bh=5xFDg5dV3Epc9fNs6C4u+qbcFy3cR4rqvZ/TDFw19JI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NzDKFMiJuW5/JrmPISk6e8+Nz5B7I/AVXzMgAaf+YXL/Zo1LkGsLpFdL63/oK+Bwwh50LG7curQR3uBB7dE76AfTcuSetkAvWP0OJim7lGf3g5cMJCOfs3ZfvhwW33JYX87vkynOyw7kvbe9qtTadOjsuxWwdKsscqC0CqflhZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WA2jRvTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC457C4CEE7;
	Thu, 23 Oct 2025 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761253005;
	bh=5xFDg5dV3Epc9fNs6C4u+qbcFy3cR4rqvZ/TDFw19JI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WA2jRvTNVXhYF2sqTdUzvcRexXVGZOrqy9HS26PolLf2B1UwhdHbxe2zqsQwzhZLk
	 bQk/8YO1Vi4UUK8GfsMdiiqJMIfzRIGxe2a+XTeyefQ7XQZg3AEZMTflztcj/0xptQ
	 nvOlbfef51ri/UG4OhO1137SbjsCpj/EIgTYUjrc=
Date: Thu, 23 Oct 2025 13:56:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCHv2 2/2] mm/truncate: Unmap large folio on split failure
Message-Id: <20251023135644.f955b3aa4b4df23f621087c4@linux-foundation.org>
In-Reply-To: <20251023093251.54146-3-kirill@shutemov.name>
References: <20251023093251.54146-1-kirill@shutemov.name>
	<20251023093251.54146-3-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 10:32:51 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> supposed to generate SIGBUS.
> 
> This behavior might not be respected on truncation.
> 
> During truncation, the kernel splits a large folio in order to reclaim
> memory. As a side effect, it unmaps the folio and destroys PMD mappings
> of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
> are preserved.
> 
> However, if the split fails, PMD mappings are preserved and the user
> will not receive SIGBUS on any accesses within the PMD.
> 
> Unmap the folio on split failure. It will lead to refault as PTEs and
> preserve SIGBUS semantics.

This conflicts significantly with mm-hotfixes's
https://lore.kernel.org/all/20251017013630.139907-1-ziy@nvidia.com/T/#u,
whcih is cc:stable.

What do do here?

