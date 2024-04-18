Return-Path: <linux-fsdevel+bounces-17261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D018AA240
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 20:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11F728213F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 18:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C717AD76;
	Thu, 18 Apr 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ecy8tcAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010C168B17;
	Thu, 18 Apr 2024 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465953; cv=none; b=CWLtRfx3qwImfv84U9phP1qnmu2+VQ7PGAXpcLqKxoYC1L2I3DpRXeC4BNI/dk4Zjw9BCSQMG770UmzgmHsrcJRdLCIkGvtqlH3SFhpEeMcGIP9hG6w1FM6OEJO5Z2XNZQ4YeIIiUj5hLoflG1Gs7S7Mny9u3aNTTrW+2K4nV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465953; c=relaxed/simple;
	bh=W8o14b9zqC5o69tPtupPPEamGQd/0JcbwSSq9zR6UjU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o1t9B6Qb8Lj43UqnJf4pMOENekfWdBKsQiXztHYVznvWMdfxHb6cAnToa3E61TQ5QFR8SXLGc0RCvRsCPHYP73e4ieOsfHnXNSu9sun0OjvWLLJzM5BxaH4YqFNPeDGFucn+bNp55wbK/6THAGZJtbhqbcByswFmJkxiBypia3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ecy8tcAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A264EC113CC;
	Thu, 18 Apr 2024 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713465953;
	bh=W8o14b9zqC5o69tPtupPPEamGQd/0JcbwSSq9zR6UjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ecy8tcACaBBZYtTQtaSv4afHuYux6aIVXFJjkdZHQNXsv1P4FKVcCxi3zxl9ID7U9
	 TTpNiY9wrkpOWj2dbyKCiBiZBSqAdj4V0bCxeB9moRcJUvSJqR95JbP13j2ZrcGFbm
	 I6PvgfQlvHk2GOhSxXP9TWAv88o9mCFvM3ceCEVw=
Date: Thu, 18 Apr 2024 11:45:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox
 <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 fstests@vger.kernel.org, kdevops@lists.linux.dev,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, david@redhat.com, linmiaohe@huawei.com,
 muchun.song@linux.dev, osalvador@suse.de
Subject: Re: [PATCH] fstests: add fsstress + compaction test
Message-Id: <20240418114552.37e9cc827d68e3c4781dd61a@linux-foundation.org>
In-Reply-To: <d0d118ed-88dd-4757-8693-f0730dc9727c@suse.cz>
References: <20240418001356.95857-1-mcgrof@kernel.org>
	<ZiB5x-EKrmb1ZPuf@casper.infradead.org>
	<ZiDEYrY479OdZBq2@infradead.org>
	<d0d118ed-88dd-4757-8693-f0730dc9727c@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 11:19:33 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 4/18/24 08:57, Christoph Hellwig wrote:
> > On Thu, Apr 18, 2024 at 02:39:19AM +0100, Matthew Wilcox wrote:
> >>> Running compaction while we run fsstress can crash older kernels as per
> >>> korg#218227 [0], the fix for that [0] has been posted [1] but that patch
> >>> is not yet on v6.9-rc4 and the patch requires changes for v6.9.
> >>
> >> It doesn't require changes, it just has prerequisites:
> >>
> >> https://lore.kernel.org/all/ZgHhcojXc9QjynUI@casper.infradead.org/
> > 
> > How can we expedite getting this fix in?
> 
> It means moving patches 2,4,5 from the above (with their fixups) from
> mm-unstable to mm-hotfixes-unstable so they are on track to mainline
> before 6.9.
> 
> A quick local rebase of mm-unstable with reordering said patches to the
> front (v6.9-rc4) suggests this is possible without causing conflicts,
> and the intermediate result compiles, at least.

Thanks for the reminder, this fell through cracks.

It indeed appears that I can move

mm-create-folio_flag_false-and-folio_type_ops-macros.patch
mm-support-page_mapcount-on-page_has_type-pages.patch
mm-turn-folio_test_hugetlb-into-a-pagetype.patch
mm-turn-folio_test_hugetlb-into-a-pagetype-fix.patch

without merge or build issues.  I added

Fixes: 9c5ccf2db04b ("mm: remove HUGETLB_PAGE_DTOR")
Cc: <stable@vger.kernel.org>

to all patches.

But a question: 9c5ccf2db04b is from August 2023.  Why are we seeing
this issue now?


