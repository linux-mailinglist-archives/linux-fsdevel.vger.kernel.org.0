Return-Path: <linux-fsdevel+bounces-71081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B92CB411A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 22:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FC88301132A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD33301498;
	Wed, 10 Dec 2025 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sFMzM11v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34519C54F;
	Wed, 10 Dec 2025 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765402615; cv=none; b=s102ijxxFI5ivc0/ZvgHiN0Ekzy8KfILgB7K93thd+ACTnHaDG6pyQLdOZP1FyB+B+D/eNUtfEHkSW4X0QbGWy9HF0ShpWjL5ayRZ2r/3PTizctOWco2f1U+hKOVnUPAotGBjAn6RWycn+L4DMrzo1V349l5ayzswQlZkrYAtac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765402615; c=relaxed/simple;
	bh=Gi2BOb09W8JSZh9A6n+pX6gTM6J3M7EHlMbCa7pIJOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orrn4rNPRktuiL24GPwgZdMXWt8yHVCb7uUJ/aQeXZqP34O+pXSo9+adV0/rdzYCNZbjbGs3R3NiE1HbGcW51xQpOwS9e4Em1Mdfo9slYao5fXSyT+o6XGSndMYXkr5cd0IEu5Tm7y5Yz7ZZsY2X7lvQ5qCt1pPyXocBqBC8Zd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sFMzM11v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xlOZX50xQnNhB5PiCw1+XOn2uJxjLtZ+AKBHh/CL+V8=; b=sFMzM11vJrI4ZVJ1l5sjMWw1Tm
	+0404zmyBebadt6fVmJfywgZuccDmE0IzMrk9r0iKPC30jFHWaSdPHD9NH3mlAF/bHn6AMoYUhLkv
	i7pvm0VnlkKW1EYAqpzAIekZdx8kwIitn75Tt9A0qgPIP1B0X8NGBuVrYqbyp6D+7GS4i5//dTy1g
	h/6N3oy/iXfZM7/NOXF6azHxiZAX9PE/J54FIOOsGCIrlxwjr9geLbtxxhhd2KelMMZu+TxEHxJmh
	f/9g4uBQDUBw/LWWwnEiYI/p5I2gF09hVqXdT2BK8mrGYEmNxXcqu75CX/eeSn1SYvBMkRsMFLf8z
	FQBdWV/g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTRrX-0000000DN8l-1uUR;
	Wed, 10 Dec 2025 21:36:44 +0000
Date: Wed, 10 Dec 2025 21:36:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Deepakkumar Karn <dkarn@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Liam.Howlett@oracle.com, Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pagemap: Add alert to mapping_set_release_always() for
 mapping with no release_folio
Message-ID: <aTnn68vLGxFxO8kv@casper.infradead.org>
References: <20251210200104.262523-1-dkarn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210200104.262523-1-dkarn@redhat.com>

On Thu, Dec 11, 2025 at 01:31:04AM +0530, Deepakkumar Karn wrote:
>  static inline void mapping_set_release_always(struct address_space *mapping)
>  {
> +	/* Alert while setting the flag with no release_folio callback */

The comment is superfluous.

> +	VM_WARN_ONCE(!mapping->a_ops->release_folio,
> +		     "Setting AS_RELEASE_ALWAYS with no release_folio");

But you haven't said why we need to do this.  Surely the NULL pointer
splat is enough to tell you that you did something stupid?

>  	set_bit(AS_RELEASE_ALWAYS, &mapping->flags);
>  }
>  
> -- 
> 2.52.0
> 
> 

