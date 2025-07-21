Return-Path: <linux-fsdevel+bounces-55557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BBDB0BD45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE0C3BBD77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178582820AB;
	Mon, 21 Jul 2025 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JTguq6Ei"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6653C463;
	Mon, 21 Jul 2025 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082019; cv=none; b=GpX0Ihf9DKQVf4T3TIluHr1CXoOT/Org/T2Zq5ebMKCgXMa04orESrnJqKZyPj2lNYmhdK1V3mK0KaMZnxF3vzQRnvd9ie1mYSJGeErgoFqHd9Az8KdiLzpViLeO9YQoypqbyr5a05iqkX4oIJgoYsoKegyIBAloqtrWX926A0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082019; c=relaxed/simple;
	bh=a2eoTz6GFasGN1r9ImW9yfkuHNyQ1smd6Pcf6MdGghM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLjAuYgfuwRib3Sq+O3hAeXrNuHuSAtc4JaJP3UOaOeRVa+J6cjSCCrx8zWS3z3w9sKSJzvlPKKlR89/hJtAsLxmugqN2IZRRcdehshMNr/9etHeXl94jjmYbvhWkgD3S4rO9vXwkZP+2plUTsLi+vpzIg1iGhnwVnvEAYfLrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JTguq6Ei; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a2eoTz6GFasGN1r9ImW9yfkuHNyQ1smd6Pcf6MdGghM=; b=JTguq6EiVpASXvUofebdv4kBmT
	6NgK5G3oH4bvnZBbDI39eYN5ZR8g2zNOnQc4wBJgp1RkMADVX1Y1+t3e46nib0525EYqePlBgsHny
	Js6ZwNzJMmUeVtLXKBv+JAqF3Jovt2ip2x5GxW4hvr7jJLsINw59YEjpPtXluWc5h3aEMBpjkcnS0
	LOAxXGCMtzyAoQ4/UA5vyd6DIGu6EsuEetKKxJzG5VdKo0pq9jDxGz2VNnv9znpKghhE8GO7Ns0qx
	0QiSwpT8z5qo6XlQjEIf9B7+reJ2XWyJSAA7EqTZ1lkdk9HQmOJ7dYWdXclfbYNVAX0Z8ulnGGMR+
	c1gheCXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udkiN-0000000GSyG-3WFv;
	Mon, 21 Jul 2025 07:13:35 +0000
Date: Mon, 21 Jul 2025 00:13:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "hy50.seo" <hy50.seo@samsung.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
	kwangwon.min@samsung.com, kwmad.kim@samsung.com, cpgs@samsung.com,
	h10.kim@samsung.com, willdeacon@google.com, jaegeuk@google.com,
	chao@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] writback: remove WQ_MEM_RECLAIM flag in bdi_wq
Message-ID: <aH3on5GBd6AfgJuw@infradead.org>
References: <CGME20250721062037epcas2p25fd6fcf66914a419ceefca3285ea09f3@epcas2p2.samsung.com>
 <20250721064024.113841-1-hy50.seo@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721064024.113841-1-hy50.seo@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 21, 2025 at 03:40:24PM +0900, hy50.seo wrote:
> if it write with the write back option with f2fs, kernel panic occurs.
> Because the write back function uses bdi_wq and WQ_MEM_RECLAIM flag
> is included and created.
> However, this function calls f2fs_do_quota() of f2fs and finally tries to
> perform quota_release_work.
> the quota_release_work is performed in the events_unbound workqueue,
> but the WQ_MEM_RECLAIM flag is not included.

And what makes you assume the WQ_MEM_RECLAIM was added just for fun
and can simply be deleted?


