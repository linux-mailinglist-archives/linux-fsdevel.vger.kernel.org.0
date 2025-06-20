Return-Path: <linux-fsdevel+bounces-52327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559DAE1D74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 16:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A36A1797
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3334528F51C;
	Fri, 20 Jun 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rkcicpSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6F28FD;
	Fri, 20 Jun 2025 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430086; cv=none; b=jnuNDsbvVg3S6Xrvxupw3uI+dqlO8TDlg71cDFFp7tSBChbDPMche7mIWOxGJHGSF/Rk9mD4JUEmHpJblo5cyWKhvXRSqIz6uQpq8P+dvcVT8zQJzd2a6VVyphdakuF21RhsBLKR6s1+FJhNH6ZGQcC0GeA//0W9AAAt3Tu9tFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430086; c=relaxed/simple;
	bh=eQB5eV4iQShXILJeHvcYp/UCB2dfeS5Ieo8zVzXk3Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btMvsgB7XlB+e+vrTDIGnsCJBITk6QU3NlxHTUYw8KLsFUb9SESBzYzQN4Fdq2sh/nL97RMvR2GBaUGQ1DEAxeKCopTkNvyVJWKXQkNWXqmgKAnoTyzL6BrsUdC0dEaF7Nw0K5lvpl6+xC0xAW+JUsQOQCXw8wh0+WWOWf68314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rkcicpSV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d9fw5HN0v/kKWel+rpUYgeRmoN6kOXJkrXAVRSMObCQ=; b=rkcicpSVsY9/iNejtlpkTvRkk+
	f6/CplQO0sPdjeHV9G7GmsVOvMuUl5T0SQtUAUFodvOQ1VcR7uW1ytVPlw/JOs7vwkPZDKoommpRl
	I6uP76BWOwj1oLpFBLxetE8kQg0FMOrTPjZAeO+3ldSzsEBvgFhap2vj7TcpAhdrsmfyNkMO1sjQ4
	qXoHeMfABSqx2hnkXQtTACb4y/KCmK2qNTuAkO/ojr7+VYZEiMiNjYg9U0fWHtUOI4WyzJQG/D/v8
	MhUxXfCo8hGF3VZY56PJDFJXz/IsnK1Lghci6nmJzjUTXkE1EkhKzxgdhSRXZSMFsOJPDoysgcQWp
	BuPx1G8A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uScot-0000000CosM-2xWJ;
	Fri, 20 Jun 2025 14:34:19 +0000
Date: Fri, 20 Jun 2025 15:34:19 +0100
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
Message-ID: <aFVxa-PRavav6pNd@casper.infradead.org>
References: <20250618112935.7629-1-shivankg@amd.com>
 <20250618112935.7629-4-shivankg@amd.com>
 <aFQ0v0DfWgUvqK6L@casper.infradead.org>
 <ce88982b-0a01-4673-a0f2-d490b66d0fa6@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce88982b-0a01-4673-a0f2-d490b66d0fa6@amd.com>

On Fri, Jun 20, 2025 at 11:29:20AM +0530, Shivank Garg wrote:
> filemap_grab_folio_mpol() is used in [Patch 6/7] in kvm_gmem_prepare_folio().
> 
> filemap_alloc_folio_mpol() and __filemap_get_folio_mpol()) are internally used
> to support the filemap_grab_folio_mpol().

That's not better.  We don't add unused functions, and unless there's
something coming that's going to use them, the entire structure of this
is wrong.

filemap_grab_folio() is a convenience function that avoids us having to
specify the other two arguments to __filemap_get_folio().  Since there's
no indication at this point that there are going to be more callers of
it, filemap_grab_folio_mpol() should not even exist.

I'll send a pair of patches which should be sufficient for your needs.

