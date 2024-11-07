Return-Path: <linux-fsdevel+bounces-33914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C309C09AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A11283B12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01314213149;
	Thu,  7 Nov 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GuCmWcel"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A1F12B63;
	Thu,  7 Nov 2024 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992216; cv=none; b=FTHZ7lg7LDu/ENe3v7PmB0O/yP+DHcvTtu4M9rsWltYa/RkIprtfuFTk8HGoK0s55GCgh3bUV+YUUMC/Py0SjW8i2JAZ9ZiQFgRM3q5TYIXERJf5vGRuM2s9K/Yi9sTwSFI4Fi80eHSRmdwGZnT9ESsvZ7xU1/Al+Ae9YQwD0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992216; c=relaxed/simple;
	bh=dF5XVTxIII6iMggWIEemDLIC7Cxe07E6GULEaQ+Lc60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQndNuMuedmJb3dtHuc5qNGRgVUZQgieh2pbZil1a3vCBve3TYcpocqTzhLIub8j+9w12MGcdbLQuiYo404AhihM7qTlwwZeR/Iw++bnrr3jAKd2ypu8twMjrR5qfklDq5ll4OP8idqbvUGpBLVvfzBRjuY6qNqe86TL4YmSxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GuCmWcel; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vom1WJYdLvjku2r/Xl0EhIhQ5E31YZkW3BtO+U5Dsek=; b=GuCmWcelHu3QNDVTgzwIceTERX
	/vZoa+fZx0pT+5jVIJzTCv4ZeGycAXKZ3WwH8ZIMz+UT6M09CyrfQf1dpKHT0h9TQDt7wIIwZFQMR
	jqTi79AogfM+fEMudUmIdznL/18LTQnR5GyxB3te8KLOPk2/tBUc41LuSKeak40E/SdOtz73JCu6G
	XqwMJZZPYY+Ahs8ZDynRIykD5DX82jInNorF8DV35Rroz+gdSejfsjnLsw+r9X9jP0LPRRRbCHyyU
	BTuDrcnLXh+iFBOFnLbAulo4+xDfmkRer56WnCT4YEvMuRMroRNIuix2qLa2bU/s9nzQ0smuqQsK9
	dgIZeC2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t949B-00000006rdv-0Z6w;
	Thu, 07 Nov 2024 15:10:09 +0000
Date: Thu, 7 Nov 2024 15:10:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Cc: x86@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, kvm@vger.kernel.org, chao.gao@intel.com,
	pgonda@google.com, thomas.lendacky@amd.com, seanjc@google.com,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, arnd@arndb.de, pbonzini@redhat.com,
	kees@kernel.org, bharata@amd.com, nikunj@amd.com,
	michael.day@amd.com, Neeraj.Upadhyay@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] Add fbind() and NUMA mempolicy support for KVM
 guest_memfd
Message-ID: <ZyzYUOX_r3uWin5f@casper.infradead.org>
References: <20241105164549.154700-1-shivankg@amd.com>
 <ZypqJ0e-J3C_K8LA@casper.infradead.org>
 <6004eaa4-934c-48f4-b502-cf7e436462fc@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6004eaa4-934c-48f4-b502-cf7e436462fc@amd.com>

On Thu, Nov 07, 2024 at 02:24:20PM +0530, Shivank Garg wrote:
> The folio allocation path from guest_memfd typically looks like this...
> 
> kvm_gmem_get_folio
>   filemap_grab_folio
>     __filemap_get_folio
>       filemap_alloc_folio
>         __folio_alloc_node_noprof
>           -> goes to the buddy allocator
> 
> Hence, I am trying to have a version of filemap_alloc_folio() that takes an mpol.

It only takes that path if cpuset_do_page_mem_spread() is true.  Is the
real problem that you're trying to solve that cpusets are being used
incorrectly?

Backing up, it seems like you want to make a change to the page cache,
you've had a long discussion with people who aren't the page cache
maintainer, and you all understand the pros and cons of everything,
and here you are dumping a solution on me without talking to me, even
though I was at Plumbers, you didn't find me to tell me I needed to go
to your talk.

So you haven't explained a damned thing to me, and I'm annoyed at you.
Do better.  Starting with your cover letter.

