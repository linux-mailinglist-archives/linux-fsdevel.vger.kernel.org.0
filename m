Return-Path: <linux-fsdevel+bounces-54848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71EBB03FBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FE24A4E27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7126224A047;
	Mon, 14 Jul 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W104I8Xg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3424C07F;
	Mon, 14 Jul 2025 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499209; cv=none; b=Ui9f2vdHMlBMfhTCsGFv1WIMm2WYZukjinH+CDvxpLMlRl8UqjRjZfQQ5lhKPTs5rx2o9dX2Pd7pMvp6HrSi8ZwY7gyOavRTxYd8prxPzg4zayfWwU/4rdadClfvfKLkKebrdUYhItoZqekHlubGmeR382jHkHNf8irqFQOvoso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499209; c=relaxed/simple;
	bh=vxvVJmLInnqfnAkGgRx8h+TaUwkzoqgmAd4ZI/enIPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kceZa+WfTmUlDfQ1QYmtJRAfcXFRDALr19vDoI053/gJ3/LuNztBR3HjQrHEgRZm2yBw+jjICDx/2xD7/FslRIuDsTGzw9K6Oq7B91Bbzdurdj/EQcIGdvNGcCt5LCZhkAnrNXkHZiO6W6ni+PGkLxGUNs1AweWqaOc79KqJ0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W104I8Xg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vxvVJmLInnqfnAkGgRx8h+TaUwkzoqgmAd4ZI/enIPo=; b=W104I8XgUHn4nb8S+d8ARvu5Rm
	MF+DFr16QKthEn0jFVNpgQTOL0spakJjV0dcNZZqNs0o+x+aJOuHDRt2hSju9dU7rIhetTROHT6xj
	R8kWYvICnymMO4Qam8WG6kDM6NzAbsSnpQJ0+cVu1O4nBiRwT2Qhnzx4G6NHJYIB+YMy4ba0UOzBe
	Pc1lT4FcsBWTW6al7/xVd+5pqXhfvlrcuRQka2K7cpKxWrPB1CiWGpm9vHTG5gwtfmA3Z8e5kQ2Zw
	3f60tAcTsI9ofJJ70NI9LBftql2iJKuD1fyzE62xbCPlDzVhkHDJDHMdLy1dZ951O17J9/sV+Y/TR
	ddDKR4qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJ6G-00000002GWk-0ZL7;
	Mon, 14 Jul 2025 13:20:08 +0000
Date: Mon, 14 Jul 2025 06:20:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org
Subject: Re: [PATCH v2 2/7] iomap: move pos+len BUG_ON() to after folio lookup
Message-ID: <aHUECH7KsHYBs0Re@infradead.org>
References: <20250714132059.288129-1-bfoster@redhat.com>
 <20250714132059.288129-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714132059.288129-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 14, 2025 at 09:20:54AM -0400, Brian Foster wrote:
> The bug checks at the top of iomap_write_begin() assume the pos/len
> reflect exactly the next range to process. This may no longer be the
> case once the get folio path is able to process a folio batch from
> the filesystem. Move the check a bit further down after the folio
> lookup and range trim to verify everything lines up with the current
> iomap.

The subject line is wrong now that the checks are removed entirely.

The patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


