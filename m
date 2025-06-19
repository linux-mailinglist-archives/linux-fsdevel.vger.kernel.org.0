Return-Path: <linux-fsdevel+bounces-52248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06923AE0B0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62615A4CC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2963028BA81;
	Thu, 19 Jun 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZBIPyIW7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159323B612;
	Thu, 19 Jun 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750349021; cv=none; b=bYcvyaDBlCoI8jogszzAK/c24ZSow4Y5vokal1mvuGlrD10S8OgiVYPOrwGsZqqjSFSOYLFBB+M+jZFLFUo3vE5q3GfTtEWTSVU7yMzkZcbUkrNmGAGx3BrBJ8VOdGlVKBbpCXgdL/fWc8Wpk3vKdUSJCQuinI0O8+jbiS/o00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750349021; c=relaxed/simple;
	bh=wiz8yGqKTEbOgLco2H006a97kYe0r5QAI/EETtQfT6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgDnZ8me5J8OE/SMSjy+nnoNqYcSRfAupIPdfrfy4Y8/ByC8WyPUSq0f8qZp7Lt5m7FsXcvw2KHCSkrzfHhIOY/HtpR5I4xtvXds9gNYb+ixZijWWFyX4Y5ScHdnmXS5Gx5SayvosZX+V5fa73VRCf6kXc2iLg8GJEUdUKlU/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZBIPyIW7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OqgTG9bdN8KsCUPIOjEKZnMRxiOerNNgtMPhKjugJzU=; b=ZBIPyIW7OHWA7HpZ/jDa0ZXFT/
	e75q0jndhVd3ufFi+j6zVf/lV+bTF3M4lyTQhNhMa+BME9MosUJgrG1L8nNV2OJwUfRNPrVqyUwcC
	wkvOttZUwiJK7P9yFr2v5+Tqz8nzfpGaZgXgG/qOdExAiSBlFpqE8ydY/GzgM+Xcpogwfs1n01mLu
	LynfUH+cgn8CcH8WzgE2iUNmpQ047OLl4fQGADPyEpRoPwuQSznI+D9C1+dwIXPNtSmaptwVw7bO/
	AZGKqXE2RLW3Ha/1MZWF9FcHxQGSQSQxqmjQRPTVOLQ0+J5mApbCQximHGy6sAuSMmpkXkzNUeTaa
	jI1NEVKA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSHjM-00000009Mqg-03kb;
	Thu, 19 Jun 2025 16:03:12 +0000
Date: Thu, 19 Jun 2025 17:03:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz,
	akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
	vannapurve@google.com, chao.gao@intel.com, bharata@amd.com,
	nikunj@amd.com, michael.day@amd.com, yan.y.zhao@intel.com,
	Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz,
	rppt@kernel.org, hch@infradead.org, cgzones@googlemail.com,
	ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
	kent.overstreet@linux.dev, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, chao.p.peng@intel.com, amit@infradead.org,
	ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
	gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
	papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
	quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH v8 3/7] mm/filemap: Add mempolicy support to the
 filemap layer
Message-ID: <aFQ0v0DfWgUvqK6L@casper.infradead.org>
References: <20250618112935.7629-1-shivankg@amd.com>
 <20250618112935.7629-4-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618112935.7629-4-shivankg@amd.com>

On Wed, Jun 18, 2025 at 11:29:31AM +0000, Shivank Garg wrote:
> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> Add NUMA mempolicy support to the filemap allocation path by introducing
> new APIs that take a mempolicy argument:
> - filemap_grab_folio_mpol()
> - filemap_alloc_folio_mpol()
> - __filemap_get_folio_mpol()

You don't use these APIs in this series, so I can't evaludate whether
any of my suggestiosn for improving this patch would actually work.
NACK.  Introduce the APIs *with a user*.  Come on, this isn't a new
requirement.

