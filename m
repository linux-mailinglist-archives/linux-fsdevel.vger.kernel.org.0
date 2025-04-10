Return-Path: <linux-fsdevel+bounces-46174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E30A83D4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F04466B6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A81DF97F;
	Thu, 10 Apr 2025 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N3Ua8kfb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E81EEA4B;
	Thu, 10 Apr 2025 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274527; cv=none; b=a+EehgqNkTprEZe/EXMbodEbSwCudPuBwU9Ru0D+DhJVyJqCnRC8nYJtfRukL15zUxxUfbEahQljpXJP3+IeMrbKFNJx0LpbGLQSpnehP8eofBqdpNXX+6tUptwq1gT3GGqeYCfab4jtC8FTp/yN5/EWVQRfDHrPtbRLg+D+VTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274527; c=relaxed/simple;
	bh=SjAHW1JL4xXBOApUK8nyaVu/Fsbko8w9kF/YjYqDoqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjNA+q9It/Z5zk+zIfEhFBKxJaxEokzZL2aB/BYWU5Ci1mSs/f7IXFd4uJc4xs+yMMvdo7jDRhWz/2D09yw0Lk4QVLpGQw3RIb91+OxGgRa7kbkoffBxz6uHK9KVnvdLN7k93stXGPKx2MgI/aFcu/5lCzjOSLg7lQl8ebPEoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N3Ua8kfb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CdU/+uF+1QwwmbOg7lgLdyQsB2ocHXgyQIfpYxGq9qI=; b=N3Ua8kfbKXQSsTiia3Fjjx8Se+
	KvkXrtS7Yyu+JaDA+9J0jEqnfBSpI/VZGPeVPzX3rw3RUrNXjz8hu87tGc+Jzuah1GTKfd+n8AD+S
	oNzYZWySn1r65SV+spNsSSDSnqRrrBnFKsdOGHIZOWn4nlZx/ucoOSYOOokHwpROZJ9nRT6SXiM75
	m0cXSqASn9T9rvU8TB5N+V1uDPZpRwUcnBZ15CXIB3mjmOZwWIPwT8eB12zsKIFrJ0QcrSDTE33Xc
	RDo2Ic/27KAibhFQWRofsYT1msrs5vtYVppIU6sCYeSNHdsg6wZKSawW94fASdAs3kRyH9mcEoNY9
	g98HLiTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nTu-00000009mmb-06hM;
	Thu, 10 Apr 2025 08:41:54 +0000
Date: Thu, 10 Apr 2025 01:41:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz,
	willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
	pbonzini@redhat.com, ackerleytng@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
	michael.day@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com,
	jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH RFC v7 3/8] security: Export
 security_inode_init_security_anon for KVM guest_memfd
Message-ID: <Z_eEUrkyq1NApL1U@infradead.org>
References: <20250408112402.181574-1-shivankg@amd.com>
 <20250408112402.181574-4-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408112402.181574-4-shivankg@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 08, 2025 at 11:23:57AM +0000, Shivank Garg wrote:
> KVM guest_memfd is implementing its own inodes to store metadata for
> backing memory using a custom filesystem. This requires the ability to
> initialize anonymous inode using security_inode_init_security_anon().
> 
> As guest_memfd currently resides in the KVM module, we need to export this
> symbol for use outside the core kernel. In the future, guest_memfd might be
> moved to core-mm, at which point the symbols no longer would have to be
> exported. When/if that happens is still unclear.

This really should be a EXPORT_SYMBOL_GPL, if at all.

But you really should look into a new interface in anon_inode.c that
can be reused instead of duplicating anonymouns inode logic in kvm.ko.


