Return-Path: <linux-fsdevel+bounces-35356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E79D4270
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 20:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5129F1F21F59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B291BDA84;
	Wed, 20 Nov 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCnzGdn5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7635715820C;
	Wed, 20 Nov 2024 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130167; cv=none; b=VnL8WITJdAkT/l7vx5WZX2iEomL0zYDJsAKLF4Acq0+taXoDyDZ9ns48OHZeiUxvrpFLQJ9F1DuvmyligaCsqttVDFaN7RJIsCpGfrCpKSXOAs+So8SMGB9BaA4VTtn4dCo6iZ7wSnUTC05+cGTL83q9gbMQwgA0Z9W65b/uhGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130167; c=relaxed/simple;
	bh=PFaks9fXNUj0aLJFNESbShumb8AdVbhevzkOzTwjIWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4JvMdZosbhlQislnd+jJYY8+9aVEY4eaTtBj+HoK9tWJi51H7w3zeS11LIPpX7tVf5DYEssoAGcUNmBwhA/5ZnTjRgBWbfPi5XcBybF1LK2QQ6kKd5pNpQaE/LGwBw1aKUtG4W4LuhKG4aTD4F2ZDwzV5dXKYc+iERwLYKybGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCnzGdn5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732130166; x=1763666166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PFaks9fXNUj0aLJFNESbShumb8AdVbhevzkOzTwjIWE=;
  b=PCnzGdn5Ffe8h0Ph7mBLSzCKEEPx28PdEX0kr6ifjb8rB1KOtWq8na1G
   4h5nwkqf+Ksy18bVBoCaDbSdyvu2p8RYbrsMtSqUlXjPf0dhTcbzIJcFp
   yYU+RZjZRK00XwZXRZRyKG7iT+pMuGR0V67dQUyLVfqHrTmCddFEtOnuh
   FE0uMDrHmB4QBh7QJ5W68ED3RPYZ0HpqWTtd6ZyD3VTEc7gewFhHfXkBD
   MOyt1zx++nxs2Sv/U3/qmLeaiM2WZKJ5yVFUZDvddO3KPjNJjjVl7vyWp
   SRTCXX5e3TC5PK+hs2fJai5352nEG4mvBWOOSyTGrI16DjyCk6jGUDsaE
   Q==;
X-CSE-ConnectionGUID: WVVBGy2dSWaiqlVhwrtGoA==
X-CSE-MsgGUID: b7baHkIRRyehFZY/82lamg==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="57608215"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="57608215"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:16:05 -0800
X-CSE-ConnectionGUID: 6uwrWOb8QsmRBRQNFKzWPw==
X-CSE-MsgGUID: 056/sa7STnqg1YzmOmukiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="89591297"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:16:04 -0800
Date: Wed, 20 Nov 2024 11:14:49 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com,
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
	shuah@kernel.org, vegard.nossum@oracle.com, vattunuru@marvell.com,
	schalla@marvell.com, david@redhat.com, willy@infradead.org,
	osalvador@suse.de, usama.anjum@collabora.com, andrii@kernel.org,
	ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com
Subject: Re: [RFCv1 0/6] Page Detective
Message-ID: <Zz41KbB4b86eQ1jj@tassilo>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <87wmgxvs81.fsf@linux.intel.com>
 <CA+CK2bDTKXuTHq7EOvErWFRe9XRGq9UF5L-LmzX3jhWd40_KbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDTKXuTHq7EOvErWFRe9XRGq9UF5L-LmzX3jhWd40_KbQ@mail.gmail.com>

> - Quickly identify all user processes mapping a given page.

Can be done with /proc/*/pagemap today. Maybe it's not "quick"
because it won't use the rmap chains, but is that a serious
issue?

> - Determine if and where the kernel maps the page, which is also
> important given the opportunity to remove guest memory from the kernel
> direct map (as discussed at LPC'24).

At least x86 already has a kernel page table dumper in debugfs
that can be used for this. The value of a second redundant
one seems low.

> We also plan to extend this functionality to include KVM and IOMMU
> page tables in the future.

Yes dumpers for those would likely be useful.

(at least for the case when one hand is tied behind your back
by security policies forbidding /proc/kcore access)

> <pagemap> provides an interface to traversing through user page
> tables, but the other information cannot be extracted using the
> existing interfaces.

Like what? You mean the reference counts?

/proc/k* doesn't have any reference counts, and no space
for full counts, but I suspect usually all you need to know is a
few states like (>1, 1, 0, maybe negative) which could be mapped to a
few spare kpageflags bits.

That said I thought Willy wanted to move a lot of these
elsewhere anyways with the folio revolution, so it might 
be a short lived interface anyways.

-Andi

