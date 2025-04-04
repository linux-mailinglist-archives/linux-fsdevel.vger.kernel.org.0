Return-Path: <linux-fsdevel+bounces-45720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B8A7B7A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626BA3B46C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C62D184540;
	Fri,  4 Apr 2025 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nmuSjNdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4F2E62B3;
	Fri,  4 Apr 2025 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743747389; cv=none; b=ZNSkF/NTgllZZVf/vz8fuxKYZ8oQRXg8FqY9PQtZlTl5837IF3XSI1NAD5ZsLZ9NrgPJm1brsPOqWxPzQnQYf6jfU7RMkfbIvh29mMJYdaqMCpcQVlduL9nVIxY1Bot7pMgIW3GKExCGL3laeoPYSNPpgTYWjNb54Z5yu7q5lf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743747389; c=relaxed/simple;
	bh=82IomvH91OcZamePfDiiuV/noh/a9CS2f8nbNKLAVHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX4v91r4B4O5BjeXwqDzVTNE2Mhrhagq/5QZOkNycFzbyuxD/9Fpaawwuqcu0HiTBvo1WehlXLC9bQLsrnRHDlh0hPPyUaSUob7cgP/+n1HvVZM33ZVXaTDt5D4T0W7FlYWqlYqaKs2Css9BzsjCO8NlySVEA2d4BaChltXcdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nmuSjNdY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V3rmCXxbDuUkBXJXOeoQph2X01YdsX01VESps6gyXrQ=; b=nmuSjNdYwLsK1QnUOfYvyHPNQU
	YMDfcxnM+crPwUw5v3H9Fcdgj3D/W5yXdykGC63/quFDMGYYchzScvie/4npdnknSspTLJVDs1ZMs
	6uc7jZRPHvox9zooE54UGPBMJNZa7RMseuZq3OQ38Jc8i6oe/98+AgUQ/+F802NRgzKuEYpzLnzFW
	l+bqS/ymopZVeYcT8oTNz8IZQB5rrCmWFY/mNnKmFUi/rPvseD8eXTc9z+SgEFDg0KVR1X4Z7gHqe
	34cV8WfAiWUx6HgXcr81YMsGoU0/q/Fl9xzNdwOm2WL/YPLYwO0EzcvX+no2MQtq2RXEgBVJOEf/o
	zZr9cPYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aLk-0000000Aqud-3LLu;
	Fri, 04 Apr 2025 06:16:20 +0000
Date: Thu, 3 Apr 2025 23:16:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Proper way to copy de-compressed data into a bio, in folio style?
Message-ID: <Z-95NPq_JCQb84XZ@infradead.org>
References: <17517804-1c6b-4b96-a608-8c3d80e5f6dd@gmx.com>
 <Z-7I9hOcGzQMV3hq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-7I9hOcGzQMV3hq@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 03, 2025 at 06:44:22PM +0100, Matthew Wilcox wrote:
> > On the other hand, I'm having some internal code to convert a bio_vec
> > into a folio and offset inside the folio already.
> > Thus I'm wondering can we provide something like bio_for_each_folio()?
> > Or is it too niche that only certain fs can benefit from?
> 
> I don't understand your requirements. but doing something different that
> fills in a folio_iter along the lines of bio_for_each_folio_all()
> would make sense.
>

Looking at btrfs_decompress_buf2page it uses bio_iter_iovec, which is
the building block use by bio_for_each_segment to build segments, that
is bvecs that are constrained to PAGE_SIZE boundaries.  In this for
a good reason as it then wants to copy into them with a single kmap
mapping.

This means that bv_offset is always less than PAGE_SIZE for these
generated bio_vecs.

In the short run I'd suggest to just keep using the existing open-coded
bio_for_each_segment-like loop so that each iteration covers a PAGE_SIZE
granularity chunk.  Just stop messing th the bvec fields directly and
use bvec_kmap_local to map the destination and do a plain memcpy into
that instead of using memcpy_to_page.

In the long run it would be great to just rewrite the low-level
decompressors to work on an iov_iter as output and remove the need
for the extra data copy entirely, but if that can't happen we'll
just need for figure out how we can do useful kmaps larger than
PAGE_SIZE or stop allowing highmem pages for btrfs and then switch to
a folio based iterator.

