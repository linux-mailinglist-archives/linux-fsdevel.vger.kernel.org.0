Return-Path: <linux-fsdevel+bounces-61670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926E0B58B9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5502F2A56E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549C923312D;
	Tue, 16 Sep 2025 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fs8qO5nX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0A2DC765;
	Tue, 16 Sep 2025 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988034; cv=none; b=eQE6CQcDTgwbCmHyKb/oqCyPWlVCMYmSKT0nUlMy5CjDicKleyWhEWevE+p0IjtGsDWnJvT060HqunkQXeyd4QKGpR75xmrJ7Gd1vQzgQxVGR9MYvDeinsInG3J1KoPIEJLe51BZ3H9QgPcfZGMx9K5iKot9x2V1yJD5vxFCNhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988034; c=relaxed/simple;
	bh=dEAGRAtP8MWvQ01ZcTojl+58fTwwxUGVRfZ5aVBkcYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdVmyz27IW1J8nyphTEX73BgGaHo5eUGBE0Ms0fTKNKtQXSYspuYjvJxYoN3UZcXQAsmrBeKN+mfg+hs6Nb1f5FiBm/a9aLiS06PSFMFoh5Cm7S3dRoBECYNrqZCex4cIIfg9CDdh0senOKgpSk6AK/OseRydYSASGTuf6TE4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fs8qO5nX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1vLbiGQX0AC9H7KluJOU/q9glSrJZnzHnZoclCwUWks=; b=Fs8qO5nXlZ6sLXrQWKCVDzYpAb
	D8rXf2rGYfMLMaQ/39ZY+LeLb8A5U3uUT63WR2SwmCRc5OjcXtuiH9o6Q5heD/6OTRRSybgaSeXcm
	UdPI0elIYFXp4LNQNDiQwn9HKkNmdylzrAf7huSt712ThMHxInXeNNrcdrCC+MdkO++mCoFLjkLvr
	XXPtwewEvN3slr+xBJltB7k8btx2kgWhOcdRrQ5fyyfmSVjFws7nmbW/jVZzalMG5+BrTMvIzF39O
	VurlrYO7JWMpan+hRPOqON+fROn/mOP0ctcNs5l2OJRtniph+xYhlObgtQCaxN8KHHZ9cNGvnpMZr
	lNZBXHAw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKzX-0000000BcoG-1EAX;
	Tue, 16 Sep 2025 02:00:23 +0000
Date: Tue, 16 Sep 2025 03:00:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"tabba@google.com" <tabba@google.com>,
	"vannapurve@google.com" <vannapurve@google.com>,
	"Roy, Patrick" <roypat@amazon.co.uk>,
	"Thomson, Jack" <jackabt@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Subject: Re: [RFC PATCH v6 1/2] mm: guestmem: introduce guestmem library
Message-ID: <aMjEt1JKjf789o24@casper.infradead.org>
References: <20250915161815.40729-1-kalyazin@amazon.com>
 <20250915161815.40729-2-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915161815.40729-2-kalyazin@amazon.com>

On Mon, Sep 15, 2025 at 04:18:27PM +0000, Kalyazin, Nikita wrote:
> From: Nikita Kalyazin <kalyazin@amazon.com>
> 
> Move MM-generic parts of guest_memfd from KVM to MM.  This allows other
> hypervisors to use guestmem code and enables UserfaultFD implementation
> for guest_memfd [1].  Previously it was not possible because KVM (and
> guest_memfd code) might be built as a module.

https://lore.kernel.org/kvm/Z0DOdTRAaK3whZKW@casper.infradead.org/
remains un-addressed.

ie this entire approach is garbage.  throw it away and start again.

