Return-Path: <linux-fsdevel+bounces-17608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFDB8B0262
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 08:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA61F2385A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 06:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5B157A42;
	Wed, 24 Apr 2024 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDr+9SRN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0214533E;
	Wed, 24 Apr 2024 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941246; cv=none; b=ascOs0N445PnJEnzKZy1v/y5TrWJ7gu5Tg2udAs/7v4AM/BMKzQo0tPNMkki2ebh5wyiFOEtWnJlat0/dM+c9sM+FqavcojDISndx7bO+5bylXqOHf2QIvZTTqiISmULajZrVKQ4LUIV/tVGCMrMbGZE89h/LsOUBlo+nCTOPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941246; c=relaxed/simple;
	bh=W/nAbB+b80AFZH0E0v4Vhn8d8EpV58x6zd+vDNi02LQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSxzWfwerXhovmxmwtd567GHxhb6S0YflLVw78Hs14nraxpzTtPIU0KHLOvfOP1fNsCnM2Tk+dvMZbR7TGqaCp6tzsBmmJnEsGescIBlkMSjT6lDuxV3GKnUzu1RmO+0ujuMYrhjE7eQrDOzrLE6e3EkojsRCVslvekVx9L2tBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDr+9SRN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713941245; x=1745477245;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=W/nAbB+b80AFZH0E0v4Vhn8d8EpV58x6zd+vDNi02LQ=;
  b=EDr+9SRNGwkrSuzn1lRezU09L2dbwNIRvYwotaVpdmR4i0Fcb/UFKNpZ
   l625NnRpmOeOVeMeHUHUJS5jnZ1XCw9yLH8ey8d2NxFafdoX3ESXmscYh
   kteYSeQDt3o65Y0jo4M2zU9IpXfFBnSg8k9XVVMJTq3cqc5/eCpX3yFx/
   DzxVT132N/I9F4sHMZe2tkZtE3JR0lohjbhr+BYfOl6ggs/nJct/Nwets
   jOaiW3n/pkZfIsd5vBRE0CN58EdEhqgcVfAUDrFaPMnqViEeL+AucePV7
   RgIirruNyaaO+s9F6xM7aLbvRpyo8npTptd5E2i/dGi0Ynx54DUSV2yNH
   g==;
X-CSE-ConnectionGUID: JT/SYKXRRTakwvgndv5KHA==
X-CSE-MsgGUID: r5U4JQimQtqhzbqqpggXlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9665853"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9665853"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 23:47:24 -0700
X-CSE-ConnectionGUID: 4DTLW/iZQMa9jgBXQptp4g==
X-CSE-MsgGUID: Mv/Nni+lSxKpOTiJCM7hgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24581555"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 23:47:19 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kairui Song <ryncsn@gmail.com>,  linux-mm@kvack.org,  Kairui Song
 <kasong@tencent.com>,  Andrew Morton <akpm@linux-foundation.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  Hugh Dickins <hughd@google.com>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-nfs@vger.kernel.org,  Trond Myklebust
 <trond.myklebust@hammerspace.com>,  Anna Schumaker <anna@kernel.org>,
  linux-afs@lists.infradead.org,  David Howells <dhowells@redhat.com>,
  Marc Dionne <marc.dionne@auristor.com>
Subject: Re: [PATCH v2 7/8] mm: drop page_index/page_file_offset and convert
 swap helpers to use folio
In-Reply-To: <ZiiFHTwgu8FGio1k@casper.infradead.org> (Matthew Wilcox's message
	of "Wed, 24 Apr 2024 05:05:49 +0100")
References: <20240423170339.54131-1-ryncsn@gmail.com>
	<20240423170339.54131-8-ryncsn@gmail.com>
	<87sezbsdwf.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZiiFHTwgu8FGio1k@casper.infradead.org>
Date: Wed, 24 Apr 2024 14:45:26 +0800
Message-ID: <87jzkns1h5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Matthew,

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Apr 24, 2024 at 10:17:04AM +0800, Huang, Ying wrote:
>> Kairui Song <ryncsn@gmail.com> writes:
>> >  static inline loff_t folio_file_pos(struct folio *folio)
>> >  {
>> > -	return page_file_offset(&folio->page);
>> > +	if (unlikely(folio_test_swapcache(folio)))
>> > +		return __folio_swap_dev_pos(folio);
>> > +	return ((loff_t)folio->index << PAGE_SHIFT);
>> 
>> This still looks confusing for me.  The function returns the byte
>> position of the folio in its file.  But we returns the swap device
>> position of the folio.
>> 
>> Tried to search folio_file_pos() usage.  The 2 usage in page_io.c is
>> swap specific, we can use swap_dev_pos() directly.
>> 
>> There are also other file system users (NFS and AFS) of
>> folio_file_pos(), I don't know why they need to work with swap
>> cache. Cced file system maintainers for help.
>
> Time for a history lesson!
>
> In d56b4ddf7781 (2012) we introduced page_file_index() and
> page_file_mapping() to support swap-over-NFS.  Writes to the swapfile went
> through ->direct_IO but reads went through ->readpage.  So NFS was changed
> to remove direct references to page->mapping and page->index because
> those aren't right for anon pages (or shmem pages being swapped out).
>
> In e1209d3a7a67 (2022), we stopped using ->readpage in favour of using
> ->swap_rw.  Now we don't need to use page_file_*(); we get the swap_file
> and ki_pos directly in the swap_iocb.  But there are still relics in NFS
> that nobody has dared rip out.  And there are all the copy-and-pasted
> filesystems that use page_file_* because they don't know any better.
>
> We should delete page_file_*() and folio_file_*().  They shouldn't be
> needed any more.

Thanks a lot for your detailed explanation!  Yes, this will simplify the
semantics and improve the readability of the corresponding code.

--
Best Regards,
Huang, Ying

