Return-Path: <linux-fsdevel+bounces-22415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22141916D80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF5CB24A40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB4170824;
	Tue, 25 Jun 2024 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dsY/v5Sq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ECF16C68B;
	Tue, 25 Jun 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330733; cv=none; b=UwNVIVWbZny/au9OFApt1MwEeHP/7fGSjiZ2Y/pwSI9t4I8oXhD1/YbkIFBWZltFMf/eC0EoqfLWPqN/xSUq4LW2LECWfAgVlkBZTAkDttVhjlb7yWl+dIfUQlO9yLx+ioD6b1Qw0IcNosvkORwyPcRZQoNO/l+zm2dY5Fl3TMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330733; c=relaxed/simple;
	bh=X0jmIyIPh1W9m4kEceQUttmnpBYHpgQNokutD/esj/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl43As/2x5DOIPupy/jyTUAd7JRxbdXu8yqU1nGcwwmtnJfHpEcVnhUCWSMHbfm9QZ5F+V/e++kBGFJ2sYe2K/Fh8fhEjPEwEMG2bitD01LituzukvvvttJwMjrjo+o9MAwQLG42TbDyxXmpxTXIlhuptTSIT7Q7FB7WYS7dh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dsY/v5Sq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YLsgCo5mZCWyV+0LgwK8z9FDMC5L3Jf20O6mHZiQ8gQ=; b=dsY/v5Sq61qwbM7R6F+sukc/5F
	s4pfkym86Ioii1ii/qPd5ZqDZkuY9WsN7UoMvQY4lfJ1lcZzBtW6itoMxdSn5Ub+HH/tx4xHNov6m
	QGudwmzCdubFhgmb0f+BNB+nLfijhUGE5CX9l0G0wAK70y7f8/1WWveqep28w5Zu3ew/qt4OkvZC/
	4T56yO2ivoaK2M419qqC/0vYp92diIr1H9nkDDhhBPQo0X9k2rwoFy02miSlQOzFYWPPtE+rgfVnm
	0kIQUAZN8kOkQq6vmukUW0D/p13DhJ/Bzgwe3O0+9o65RwpCOeNUI6CI/y0C25q4GL0h9fJPjXjbO
	OVf9HL6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM8Si-0000000BHaO-06Hw;
	Tue, 25 Jun 2024 15:52:04 +0000
Date: Tue, 25 Jun 2024 16:52:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 02/10] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <ZnrnozlE0EggQ_w3@casper.infradead.org>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114420.719014-3-kernel@pankajraghav.com>

On Tue, Jun 25, 2024 at 11:44:12AM +0000, Pankaj Raghav (Samsung) wrote:
> Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

after fixing the nits below

> +/**
> + * mapping_align_index() - Align index based on the min
> + * folio order of the page cache.

+ * mapping_align_index - Align index for this mapping.

> @@ -1165,7 +1186,7 @@ static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
>  void folio_wait_bit(struct folio *folio, int bit_nr);
>  int folio_wait_bit_killable(struct folio *folio, int bit_nr);
>  
> -/* 
> +/*
>   * Wait for a folio to be unlocked.
>   *
>   * This must be called with the caller "holding" the folio,

Unnecessary whitespace change


