Return-Path: <linux-fsdevel+bounces-71698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A1CCE046
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 01:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E3030319A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 00:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7B2CCC5;
	Fri, 19 Dec 2025 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ou37KOyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1842110;
	Fri, 19 Dec 2025 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766102613; cv=none; b=PT78qDgZPUK1Ixmh2UMqZGz7Ta23y7kobg/jsP7/hs+A/MxyP573T7aZGjmgBxQCkk4tWJ0jbnBoXOOROMD3LNAS5hnwhM5Lb0/cYO2v1Ywajg/x5iCeebHq+okoNO3heN9eWmkcD692yHk+Fj5qC8Wo3MBakb1VPSNJVnefC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766102613; c=relaxed/simple;
	bh=8E6NAIDxQMdp/s3lyLs23U2jDp0pVydVmLy6lig72oo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IjHi0P6qGSSj0hm4uPu2Wqgo8KWR2nevhi34H+vBY0bNcNVY30aR/TFDMf8jxhZlmGqLKmUhpZkLXrYuttj2v2AhaGrsMR2y6+0vYeLv33V/hpNmN+XswemisuV5x2deS60oTTXuN6pOqF4A223ksd0mVsmsT96bBKoM7c1dcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ou37KOyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3873C4CEFB;
	Fri, 19 Dec 2025 00:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766102613;
	bh=8E6NAIDxQMdp/s3lyLs23U2jDp0pVydVmLy6lig72oo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ou37KOyy/qUsRdv+f7A/vXWmM6at3ULcpPNQp4K3dWHw6+WdeucY7orgVLPhNsZWW
	 z5E7EXHQ8MKf/c3U7xANZL0sk27brGRGj1lwDM7M3KRLTsbn9jfywK9s41Uh1wFcBL
	 FVb6B/ynS7thy421b3HjKo0OufktoQsfbOqYJbdA=
Date: Thu, 18 Dec 2025 16:03:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: John Groves <John@groves.net>, David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, John Groves <jgroves@micron.com>,
 "Darrick J . Wong" <djwong@kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Gregory Price <gourry@gourry.net>, Balbir Singh
 <bsingharora@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, Aravind Ramesh
 <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [PATCH] mm/memremap: fix spurious large folio warning for
 FS-DAX
Message-Id: <20251218160332.ee5b1c9b2ac7aebabbabfa45@linux-foundation.org>
In-Reply-To: <74npmrpzagba2bbye7kmwwoguafbpvnkxarprp3txy4wmu6gxp@japia7ysaisi>
References: <20251217211310.98772-1-john@groves.net>
	<74npmrpzagba2bbye7kmwwoguafbpvnkxarprp3txy4wmu6gxp@japia7ysaisi>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 09:58:02 +1100 Alistair Popple <apopple@nvidia.com> wrote:

> On 2025-12-18 at 08:13 +1100, John Groves <John@Groves.net> wrote...
> > From: John Groves <John@Groves.net>
> > 
> > This patch addresses a warning that I discovered while working on famfs,
> > which is an fs-dax file system that virtually always does PMD faults
> > (next famfs patch series coming after the holidays).
> > 
> > However, XFS also does PMD faults in fs-dax mode, and it also triggers
> > the warning. It takes some effort to get XFS to do a PMD fault, but
> > instructions to reproduce it are below.
> > 
> > The VM_WARN_ON_ONCE(folio_test_large(folio)) check in
> > free_zone_device_folio() incorrectly triggers for MEMORY_DEVICE_FS_DAX
> > when PMD (2MB) mappings are used.
> > 
> > FS-DAX legitimately creates large file-backed folios when handling PMD
> > faults. This is a core feature of FS-DAX that provides significant
> > performance benefits by mapping 2MB regions directly to persistent
> > memory. When these mappings are unmapped, the large folios are freed
> > through free_zone_device_folio(), which triggers the spurious warning.
> 
> Yep, and I'm pretty sure devdax can also create large folios so we might need
> a similar fix there. In fact looking at old vs. new code it seems we only ever
> used to have this warning for anon folios, which I think could only ever be true
> for DEVICE_PRIVATE or DEVICE_COHERENT folios.
> 
> So I suspect the proper fix is to just remove the warning entirely now that they
> also support compound sizes.

So I'm assuming we can expect an updated version of this fix.

> > The warning was introduced by commit that added support for large zone
> > device private folios. However, that commit did not account for FS-DAX
> > file-backed folios, which have always supported large (PMD-sized)
> > mappings.
> 
> Right, one of the nice side-effects (other than delaying fam-fs, sorry! :-/) of
> fixing the refcounting was that these started looking like normal large folios.
> 
> > The check distinguishes between anonymous folios (which clear
> > AnonExclusive flags for each sub-page) and file-backed folios. For
> > file-backed folios, it assumes large folios are unexpected - but this
> > assumption is incorrect for FS-DAX.
> > 
> > The fix is to exempt MEMORY_DEVICE_FS_DAX from the large folio warning,
> > allowing FS-DAX to continue using PMD mappings without triggering false
> > warnings.
> 
> As this is a fix you will want a "Fixes:" tag.

Someone (possibly me) already added

Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")



