Return-Path: <linux-fsdevel+bounces-50413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E636CACBF63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 06:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF910167812
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 04:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6821B1F3B96;
	Tue,  3 Jun 2025 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B3P8Y2kD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DD139B;
	Tue,  3 Jun 2025 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926348; cv=none; b=qPsagJyIpqTBZtDPcqzqiQ6Veo5YWiAqPz7jXK4tv80rgW7poE8j3vMIfq1UJxraITJhs7azBBHmEKsW/w+87Vm6C7kpsMHqatUwLuz9X+YudlD6L2ejAetTxSF0EkRupLzuwYNbjdRwBoPbuXHtDbu98FMRSMr4r6hGkfWdzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926348; c=relaxed/simple;
	bh=9JfipAlH31/Nfl/rtapCnYoip2jYXWlwbar7ZO14jI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efoI0vzT3xjuqbWkTbKYsJUvnckfd1uwtD1570L62jzsh1yOAJU69dLiYgf0PsjyspZq3TXzKgBR9bIvdDa0ZALn8ZwfRXkC9YTDWIxbGEOhuWYM/EyNgTTfi18MbDAjFrAZ5XMLFHIuDBcizix8dAm/euwaxql7kZuUhCf4RHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B3P8Y2kD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2HXdpwNFEIc5X8bhVnayNQJw7eGMBpc7Yo7s6dM4VOc=; b=B3P8Y2kDHXidjM2mVVCC4kBNNF
	Qz89tdzXTMecebZG7XmRmDmZwVxd749GOy/SzyY/EpmsmfsqSNw/cnSgrpSTVCApUquqkhPfVkAc8
	kieG2QRArS7d2eif4k5WqxYt4D0T0IvW8HLaOTbXkSr40XTEVz8CgyPpGf052cciIXiuAonVHjKp5
	ca8tnKvTKMeAP4pWA1TQQgCniiO5gADuWYcy575ZsQpE9t3qic8U9fIg53T2QtSkg9Caxfp7AVxdf
	qRln17kTFNcHJEKM2R61la51Q5Mz0A+L2g/j3ozbDXhSHyJ/Sl2JQG5pkhq4oDDJmJzkj4ZENkv79
	jz/R5CFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMJdM-00000009izV-3hPv;
	Tue, 03 Jun 2025 04:52:20 +0000
Date: Mon, 2 Jun 2025 21:52:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com,
	ajones@ventanamicro.com, akpm@linux-foundation.org,
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, bfoster@redhat.com,
	binbin.wu@linux.intel.com, brauner@kernel.org,
	catalin.marinas@arm.com, chao.p.peng@intel.com,
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com,
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, graf@amazon.com,
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca,
	jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de,
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com,
	keirf@google.com, kent.overstreet@linux.dev,
	kirill.shutemov@intel.com, liam.merwick@oracle.com,
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name,
	maz@kernel.org, mic@digikod.net, michael.roth@amd.com,
	mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com,
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com,
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com,
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com,
	pvorel@suse.cz, qperret@google.com, quic_cvanscha@quicinc.com,
	quic_eberman@quicinc.com, quic_mnalajal@quicinc.com,
	quic_pderrin@quicinc.com, quic_pheragu@quicinc.com,
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com,
	rientjes@google.com, roypat@amazon.co.uk, rppt@kernel.org,
	seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com,
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz,
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com,
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com,
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com,
	zhiquan1.li@intel.com
Subject: Re: [PATCH 1/2] fs: Provide function that allocates a secure
 anonymous inode
Message-ID: <aD5_hL-caOZjSk8x@infradead.org>
References: <cover.1748890962.git.ackerleytng@google.com>
 <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 02, 2025 at 12:17:54PM -0700, Ackerley Tng wrote:
> +struct inode *alloc_anon_secure_inode(struct super_block *s, const char *name)
> +{
> +	return anon_inode_make_secure_inode(s, name, NULL, true);
> +}
> +EXPORT_SYMBOL_GPL(alloc_anon_secure_inode);

What is "secure" about this inode?

A kerneldoc explaining that would probably help.

> +extern struct inode *alloc_anon_secure_inode(struct super_block *, const char *);

No need for the extern here.  Spelling out the parameter names in
protypes is nice, though. (and fix the long line while you're at it).


