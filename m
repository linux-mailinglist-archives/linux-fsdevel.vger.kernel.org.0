Return-Path: <linux-fsdevel+bounces-28084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CB39667B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 19:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16C0281E06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145E1BA88A;
	Fri, 30 Aug 2024 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h73zdqsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63C1B5813;
	Fri, 30 Aug 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037947; cv=none; b=SJ3kQz4ONVTXiCc6sET4GpzxaRmFYp7/TzDD7k8TwFqjaIwmJB9VO9sO5iHrq3EzCXPuFRYzqmQX5JlnLscBQH2G5E9EHZwilp9KWvQwu5cFUV2mk6WUX7jnZlRCdoYLm4ilFc2iV/Fv6XNWQcHDsbjx+hnryBgYqZcvgc9lQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037947; c=relaxed/simple;
	bh=a2uatEhVgpZwxf91mJ1SrRoXwTeCv7Tzua7zSCqbPDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+RmfFl/hK4XKLn7z2+ldbaBT7M5UtTtptdu469/FQdw3ckI/DbC/Vf8U3jxbh8MwKAHwTpTEvJPaDJNpl+ANuhHagPQW8hVUd/iNByw0Ydrcg/Ajrr+rpaDci+SCD8tIILRZCBNicOjUXYzMQhg2n7idCCNwVqENXC2S6IYgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h73zdqsi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xSHx5MF06y4HT7OrzLXzlQLM81Zqol4C2EbQwQuVEjc=; b=h73zdqsibHLWoTYyIuw/1aVeVf
	70hNqDMuLXXelasTAvi6PNImjXva6E2IichGiNdDxsMY6yYilL8r7Goas/DRbYECr05Af7UqSb0fx
	0GW6IuvdhH1CRvQ3WLyMUqtWbkZ+swyxj+iNF1vpGRN/ieSfPuoQgM8JV2FVHTmyexpfssdwrhAiS
	ISKEPv/2asVBfDKnvQ9M+mnrR0WRqucZbdyydPQRBthDEfeEkWQmKWdRfsud/AUuNOCkz2yfSOMn+
	0D/1P8NjvMnMs674/33qXTdy5j+H/93dP0X1fMSdrPi7E/gReuxl/eECafXkwY4lxP4y//SHpiqe5
	FCckFepA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk5Aa-000000079AQ-0LhE;
	Fri, 30 Aug 2024 17:12:20 +0000
Date: Fri, 30 Aug 2024 10:12:20 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
	Sven Schnelle <svens@linux.ibm.com>, brauner@kernel.org,
	akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	john.g.garry@oracle.com, cl@os.amperecomputing.com,
	p.raghav@samsung.com, ryan.roberts@arm.com,
	David Howells <dhowells@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <ZtH9dA7Xe7K5aSwg@bombadil.infradead.org>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <yt9dttf3r49e.fsf@linux.ibm.com>
 <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
 <ZtDSJuI2hYniMAzv@casper.infradead.org>
 <221FAE59-097C-4D31-A500-B09EDB07C285@nvidia.com>
 <ZtEHPAsIHKxUHBZX@bombadil.infradead.org>
 <2477a817-b482-43ed-9fd3-a7f8f948495f@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2477a817-b482-43ed-9fd3-a7f8f948495f@pankajraghav.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Aug 30, 2024 at 04:59:57PM +0200, Pankaj Raghav wrote:
> It feels a bit weird to pass both folio and the page in `split_page_folio_to_list()`.

Agreed..

> How about we extract the code that returns the min order so that we don't repeat.
> Something like this:

Of all solutions I like this the most, Zi, do you have any preference?

  Luis

