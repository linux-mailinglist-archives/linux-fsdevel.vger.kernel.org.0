Return-Path: <linux-fsdevel+bounces-46209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4887CA84633
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 16:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC841B604F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61228CF4F;
	Thu, 10 Apr 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0CD1m9e0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E3281529;
	Thu, 10 Apr 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295014; cv=none; b=eqqlwhXAL8vCqGhZ5nd0YpZWdXi9pK8aNOajCOwdEXbrzRLtwN7pQW+bihXTDfTLi4UjBTq3GiGF1qLVM79LVVZ42dwM3PjKswg1JHevioQdf+GNvlBzKL7rfgcqcg6Z21ZDYsUr5cYvkYhlTrrp8ik+O4J2kGkxD7wDi0zkhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295014; c=relaxed/simple;
	bh=F8eq5C2arq6nQ8is5jRPMuJ8H0Gg2faL+GzWh6CxsyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLm+uCdJ8bChxFCnnqVBkP68X3RRBQ2aJxvOenuff3r+LAWu0hP5GJN/mQj6NsLmzO5GZ4oDY/96UF+CkBIjBcXC1lzc3IHaoIQlJNsMB0iyCE1yiHT3tYbxK7Q064Ru8HQCKa+uAmd1Y5cKfaq+/0BUVR/twdlKEjnhQvFRqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0CD1m9e0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Sje0mXCO8uUiowTlFETq7gVVR2y68OmKN7E7RZiwNSw=; b=0CD1m9e04quHGOpw8NHRSXbjD+
	ThjnIJYoOyyFvb/yn27LI6/uJ5XxIl13/WyJQVD/xFCBnpt611XkipXZzfH8fnZK36MVkKtg67O5o
	iQZ38Bj6MOEB/cqasGjSP1WF/wZDPZpkqLoK4eRuT3ejQc4c0EyWcUXD6ZRKm1O7RRqXefFBsT5JB
	iKRtD3y9PxJqDL2zWSvps5l73BVvL+jIa5drSgn20dKKLIjuQW5RADSR4gBG53XeTd/8BqkCRpS3e
	ChbqPUvdkLIymD5FRmHm11UlzJkVWBTQwdOOYqK321HEVrS5xhj0P8DgLwnsMt/TbOmnfeaZUsxN6
	QZQzjGIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2soP-0000000Apj7-062H;
	Thu, 10 Apr 2025 14:23:25 +0000
Date: Thu, 10 Apr 2025 07:23:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Shivank Garg <shivankg@amd.com>,
	seanjc@google.com, david@redhat.com, vbabka@suse.cz,
	willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
	pbonzini@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
	tabba@google.com, vannapurve@google.com, chao.gao@intel.com,
	bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
	yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com,
	jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH RFC v7 5/8] KVM: guest_memfd: Make guest mem use guest
 mem inodes instead of anonymous inodes
Message-ID: <Z_fUXKcvbbUTQO1n@infradead.org>
References: <20250408112402.181574-1-shivankg@amd.com>
 <20250408112402.181574-6-shivankg@amd.com>
 <Z_eEfjrkspAt4ACP@infradead.org>
 <diqz4iyw5dis.fsf@ackerleytng-ctop.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <diqz4iyw5dis.fsf@ackerleytng-ctop.c.googlers.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 10, 2025 at 06:53:15AM -0700, Ackerley Tng wrote:
> > So why do other alloc_anon_inode callers not need
> > security_inode_init_security_anon?
> 
> Thanks for this tip!
> 
> When I did this refactoring, I was just refactoring
> anon_inode_create_getfile(), to set up the guest_memfd inode and file in
> separate stages, and anon_inode_create_getfile() was already using
> security_inode_init_security_anon().
> 
> In the next revision I can remove this call.
> 
> Is it too late to remove the call to security_inode_init_security_anon()
> though? IIUC it is used by LSMs, which means security modules may
> already be assuming this call?

I'd really like to here from the security folks if we need it or not,
both in this case and for other alloc_anon_inode callers.

