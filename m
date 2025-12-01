Return-Path: <linux-fsdevel+bounces-70302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A76C963D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532F33A2EAE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3722F3C22;
	Mon,  1 Dec 2025 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H/2ihMPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138BF233128;
	Mon,  1 Dec 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578861; cv=none; b=eIHz/qJe3o4uCRMJl/UXZQKj85SCa0ifBqW5AlO0aGxTkEWD59VS7aARl+SKJKaJR3rzGwFH/Jt8z9+QXWrdeKWgsWDrFPJ6ijgV0u2SeuYKrzWQCGCrDEQWVxfdJcHhtgCowPOFxlDWWYbjiFVRvBj4fK7gZI4PgMnVdcZsjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578861; c=relaxed/simple;
	bh=eUR/UfWhexspUGPYLkYJNcKzqr+YeGmu6snM95qXpCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh0zcCi6ObzA7zewfMqN6AGxOwY4+nJYyWOVIzzfmBwAST2ieEXV0sBLEFV6+rg6WxqGkRuIBvy9i9lJhpPchNKhIav2vBUt0U3fQOJkngIVt3U4tVZJrlZ4ZpQok+hIe3aN8Y3+WFhjZOdKmGbzLYEZaEets3Q6CqwLXKGRJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H/2ihMPS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V58IvmsmzrL9ygn436yJdP5Wn8CCRD9CFPvKYyl+a4Q=; b=H/2ihMPSxtL5VK9QVE/C0+XnLY
	hZTg/NUmSfVH0bKb/Q5EV+mN71Mk/3m7e/thmLEedRHnFX0GWGtffGrI5l1B5c5TzypYyuvzQX4/V
	kV1g9AdJvgrjx3orR2RMp4Q6XAQKNJ+rkNkogBTOzKxS5xz+km+SJ71kG5NeRzXvBJhx60Ei1SzYb
	PhdoB/WTZwZlLhagmassLht9+OKjDCZ+DXmFTpmH4l8bZzudgoIKHoyCJFhtWB+DXGoPRg4KVZcZW
	LOBGbYn7Z3KZ0PTKNGEjUxgQ1EtdyoJv0aBpqbTemErC86tMfEUy31FmtxksANn1EWEEAm3VlfPO7
	RhKnC2Cg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPzZ4-0000000Gy8N-2gzk;
	Mon, 01 Dec 2025 08:47:22 +0000
Date: Mon, 1 Dec 2025 08:47:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@lst.de, tytso@mit.edu, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v2 01/11] ntfsplus: in-memory, on-disk structures and
 headers
Message-ID: <aS1WGgLDIdkI4cfj@casper.infradead.org>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
 <20251127045944.26009-2-linkinjeon@kernel.org>
 <aS1AUP_KpsJsJJ1q@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS1AUP_KpsJsJJ1q@infradead.org>

On Sun, Nov 30, 2025 at 11:14:24PM -0800, Christoph Hellwig wrote:
> > + * ntfs_read_mapping_folio - map a folio into accessible memory, reading it if necessary
> 
> The very long comment for something that is just a trivial wrapper
> around read_mapping_folio is odd.  Also why does ntrfs need the special
> EINTR handling that other file systems don't?

I would presume that this is because NTFS is using the page cache for
metadata and they don't want the metadata read to be interrupted by a
fatal signal.  Of course, this turns into a spinning instead of sleeping
wait, so very bad for CPU usage.


