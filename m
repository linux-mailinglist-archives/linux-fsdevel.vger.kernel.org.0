Return-Path: <linux-fsdevel+bounces-55042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA99B069E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 01:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745817B36E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB752C3265;
	Tue, 15 Jul 2025 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="njE2Om+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9249460;
	Tue, 15 Jul 2025 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622288; cv=none; b=dWRKa2+bqahaDcOJ1zioG8EGf2FN6rJQSGKTR2AP+zJ9Ua8ZJYI64Bi7b+cfI9tUyqHWYNPiQibb/BGuz0nDT9Qs6ih7aX6gJ/SX1IEoYz1UkL6ngmafjmrfXXAR53g/S+j9AWVroBc9TZ3FWn3QkYmwm5nr1XgcMVsZplrJZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622288; c=relaxed/simple;
	bh=U39fUGdLgfuWmXMQrKansqzCV/he0S+4iRMuquTPLgE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ksEkgWBLgNya3Syzf4H8sJYE5TZsdDQQjHrY7fuT8xNoKdv43l63BPm98PaQEdTdizece61rkAD+1/345VNckeu+yP8HrJAPArMfJh1mgzOIxCmlkHDLPTz7gC4eWgAF+VdGhXkQdnkesJCwH5zqAz+K+Wra02PxDr5CqfS/ez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=njE2Om+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA551C4CEE3;
	Tue, 15 Jul 2025 23:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752622287;
	bh=U39fUGdLgfuWmXMQrKansqzCV/he0S+4iRMuquTPLgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=njE2Om+U5qOoZlUOcNHAaw5KV8Txr5jep5D4NRYQTxK+LCyfS1ZyTansCOlWs/QTh
	 o483VQOOj5Pbf5Yuy10wFbVwdz9hwu0VyEpSj2VAi4NEcpviRCc64s0V8sqj06MGoR
	 Das6Gqqfd4hmfgzrT+6WuicQTiTx9Ld+Y7D/BROI=
Date: Tue, 15 Jul 2025 16:31:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, Oscar Salvador
 <osalvador@suse.de>, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v1 0/9] mm: vm_normal_page*() improvements
Message-Id: <20250715163126.7bcaca25364dd68835bd9c8b@linux-foundation.org>
In-Reply-To: <20250715132350.2448901-1-david@redhat.com>
References: <20250715132350.2448901-1-david@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 15:23:41 +0200 David Hildenbrand <david@redhat.com> wrote:

> Based on mm/mm-new. I dropped the CoW PFNMAP changes for now, still
> working on a better way to sort all that out cleanly.
> 
> Cleanup and unify vm_normal_page_*() handling, also marking the
> huge zerofolio as special in the PMD. Add+use vm_normal_page_pud() and
> cleanup that XEN vm_ops->find_special_page thingy.
> 
> There are plans of using vm_normal_page_*() more widely soon.
> 
> Briefly tested on UML (making sure vm_normal_page() still works as expected
> without pte_special() support) and on x86-64 with a bunch of tests.

When I was but a wee little bairn, my mother would always tell me
"never merge briefly tested patches when you're at -rc6".  But three
weeks in -next should shake things out.

However the series rejects due to the is_huge_zero_pmd ->
is_huge_zero_pfn changes in Luiz's "mm: introduce snapshot_page() v3"
series, so could we please have a redo against present mm-new?


