Return-Path: <linux-fsdevel+bounces-68544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2AAC5F431
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 21:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE6D3ACBF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 20:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9E231BC8F;
	Fri, 14 Nov 2025 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ox9zZpYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242123A99E;
	Fri, 14 Nov 2025 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153096; cv=none; b=p8C079Pv5vLq5GaTqeVsMyJZA1qc81UCfEJ1csUSeQTCGWgrJNKo5EN/fOTt/cXr6Iya2XhgrgT1kdB8rr+kAm7pHkKkjJJUFhAZjtg9lkZkh+yM9iDIDW2fPgriNkJHEu3o02coiw4u1uJletOLrnn+O+47Fgjhz9tAhy8ZVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153096; c=relaxed/simple;
	bh=DX5/dSKrdO98FJcehhnVwXz/bPEbebQaaUwG0mNCd0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD6a4f+5KWBxpRP9TsczX4+t6mqmYBAcUOZ850TT2UJjTMpMuejYxAYGaKlKbjgSVqFQ7p6ZTmn0s1FmCOem9cdhFEa7iPIukSeg8PrGZ86w8oD660b1VI7ciLCspzf13VqUEWPFzD8I8pH9VDZGisEDrlVJdomBlRZfJAWYiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ox9zZpYS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=avhP2BlDV0WsSq481d4QOJ4qj6ZBZ4/qUpQyCVpZucI=; b=ox9zZpYSOeDXSI8JO8p8p0xM9L
	hk+LKitvAWv/vcxVHaSHG4VRyN2HpeglgaFVYC8ij4y9mu0dutl/n3Bl0123uduvNbDUUaQxLeeCQ
	4EOtj11TOd1NgD7gul5dqRT4uiVVbsLIgnj63wtKc720Gqt83valXqg1xSAhYu6aquLE9KJuiFET+
	DZnVDzOSue8dzQW1YSilSNS/4IjyIJSHBZeT+JrBK9TO6PR5s02OrBlmDQqdan/lP/z+E8F7WAcZ0
	IPy6/+Mx2PdD/bKSY6fmbKPbOIOcyWT7JES4G6e9ZlMf/FAd5u7PGoq95gQA0XlNy3MG9BVsfIiij
	mqbMKMIw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK0f2-00000009u54-04RV;
	Fri, 14 Nov 2025 20:44:48 +0000
Date: Fri, 14 Nov 2025 20:44:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: ssrane_b23@ee.vjti.ac.in
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, eddyz87@gmail.com,
	andrii@kernel.org, ast@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in
 do_read_cache_folio()
Message-ID: <aReUv1kVACh3UKv-@casper.infradead.org>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114193729.251892-1-ssranevjti@gmail.com>

On Sat, Nov 15, 2025 at 01:07:29AM +0530, ssrane_b23@ee.vjti.ac.in wrote:
> When read_cache_folio() is called with a NULL filler function on a
> mapping that does not implement read_folio, a NULL pointer
> dereference occurs in filemap_read_folio().
> 
> The crash occurs when:
> 
> build_id_parse() is called on a VMA backed by a file from a
> filesystem that does not implement ->read_folio() (e.g. procfs,
> sysfs, or other virtual filesystems).

Not a fan of this approach, to be honest.  This should be caught at
a higher level.  In __build_id_parse(), there's already a check:

        /* only works for page backed storage  */
        if (!vma->vm_file)
                return -EINVAL;

which is funny because the comment is correct, but the code is not.
I suspect the right answer is to add right after it:

+	if (vma->vm_file->f_mapping->a_ops == &empty_aops)
+		return -EINVAL;

Want to test that out?

