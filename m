Return-Path: <linux-fsdevel+bounces-49083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A739CAB7B69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 04:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BEC3AEFD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 02:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAB228E5F3;
	Thu, 15 May 2025 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gkb/Py1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367A1A2391;
	Thu, 15 May 2025 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747274962; cv=none; b=a9FrMKFh/qktUlZivn99Dpj/DyvUOdm73BJy5tluQa0YOza5iE0NpAWhk0pRBNKU0yBAkNrOXBzgKwJJbCEXH9jfdpIMegkT9jaBYsbKVvTHFEXrrmXYjcz2VNUuF+c2zYVxftomaDDIADNuuAp7RkmsYUDTKTCl7jk94zXStz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747274962; c=relaxed/simple;
	bh=8NALHghH/1cRfmuWG2BGindcgl8eogceSoeVSCsKcvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCi5TXPhbsl3LbPe7fotmltCP16EXJFcz1iaZjF3FDaKt7DoiPtCdLraqCJbbKd78969I0g7dTsIEYMZysXla9MtBK05ss7sEWW5KkIn3swwSM3WieRIxVbE8nzLr2J6AnxSe1P4Uwq5IRUiOuviPz8Eh7S/etW0hbW2M/WAh6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gkb/Py1b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rcjPKZsckWOuKXk0QifKBxWsi1qc+2jD7wDRi0Ywjjc=; b=Gkb/Py1b7SjqiY1IGeHDhfdcCL
	yvhvtigNLD+QDMU8nTMuug0k4mBcU+NXK6ujLoVDD/sPcE+MKnU3S1ZcfCUbt4KjOvLFTzFsjAiyX
	/H4EhwPE/ersknsH/hoLBaJpJabGHmuveNdCnxSlZ5VqAyrgsF+7BJqJ15iWSmU6edqmvC/1SbV7w
	elk0lR+tJVedxKzMHM4iM4fuOYW4cETrHukFQCvJYId5QDcUI382ItL8qYyerpmlx2FuZOaKxx6iE
	qtaiiKM9R7055aVBDvgMfVciujS9UaGiuUPDIPmcgFB15pOOfwJXCm7R+wOcLyXhG1Km+oFw7N+Fc
	5AS2L9Sw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFO21-0000000DAIW-1QpN;
	Thu, 15 May 2025 02:09:09 +0000
Date: Thu, 15 May 2025 03:09:09 +0100
From: Matthew Wilcox <willy@infradead.org>
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
	thomas.lendacky@amd.com, usama.arif@bytedance.com,
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com,
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v2 16/51] mm: hugetlb: Consolidate interpretation of
 gbl_chg within alloc_hugetlb_folio()
Message-ID: <aCVMxRRTz1d_QyUA@casper.infradead.org>
References: <cover.1747264138.git.ackerleytng@google.com>
 <8548af334e01401a776aae37a0e9f30f9ffbba8c.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8548af334e01401a776aae37a0e9f30f9ffbba8c.1747264138.git.ackerleytng@google.com>

On Wed, May 14, 2025 at 04:41:55PM -0700, Ackerley Tng wrote:
> -static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
> -				struct vm_area_struct *vma,
> -				unsigned long address, long gbl_chg)
> +static struct folio *dequeue_hugetlb_folio(struct hstate *h,
> +					   struct vm_area_struct *vma,
> +					   unsigned long address)

Pleaase don't mess with the indentation unless necessary.  Nobody
cares what your personal style preference is.  You're obscuring the
actual changes.


