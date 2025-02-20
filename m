Return-Path: <linux-fsdevel+bounces-42169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740EEA3DBBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 14:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9658B3A4A67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED941FAC5E;
	Thu, 20 Feb 2025 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PmbD/O09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3B1FAC37;
	Thu, 20 Feb 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059491; cv=none; b=hJkPKga/YwJytIGqY/uhx/jthzWmoZlPpwsDHS7DOOctS7PCRgTTsrQ4fepRw6sp2YyZH68uEa6gDkGPPhc2J1p+W3GDvMbT2ehctGDV5L3C/Lh8i0oC4JdgL3YttCphR8CJ9Y8F82chhrCyNnQv4FIXog/LlW7sr6+flQYl8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059491; c=relaxed/simple;
	bh=YNUMF/m9oha6N5Ylpt4E1pzOq5jR+LZbLVHaKG6ZwfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTqAE0bcnjUJzuKIwrsTovrqarRkpZcFvgREQoKWTs67yy0zUzyr1CnaJz9md5POHsrIwY4QKrBzf1XmC22ujUDHy7KwI2n/DQYiYJgOsNOfUa2c20gb4LfRp3frVcutuKmiQNmbrD2i7NfzfZNjJh0x4a7ZCZkH9o6m4lvJAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PmbD/O09; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zQC6mrSkbfYx44lvHyB8IRuk82Fzs32DJrQal4NY7yw=; b=PmbD/O09acLm8bhC2//MlyiOtS
	k/4u5AAg3B1oqFyI3KjR26iGvhg4p5N3IJszm5L+j+fOGT4ZRb1yuy7Ze/4Dc+RiDs0Yx92NP+f0c
	ssxx/yoaeTxWil1ImOULTvnlM/AqUwU0VFOTRglKCt4otidf9jismMcYqm1t9YMylkF3bqYS7O3Aw
	5kpMKDsupcrAoi4t1sqv/3W5iHlXHbLZYsiHtKBdzZw/FLg24F6hsCB0W67FwpXwZtEeygWcxyfgk
	p8wn3t0zUh45SWxzKLbYyj/tYkrUiDhTQd6UwDazaYRybeSfr5NjMhm0g6SszitCs1zPBi6yv0A8h
	MTAYg4Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tl6xc-00000009mPR-3YwJ;
	Thu, 20 Feb 2025 13:51:28 +0000
Date: Thu, 20 Feb 2025 13:51:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/8] More GFS2 folio conversions
Message-ID: <Z7czYNwTg7l0nu1i@casper.infradead.org>
References: <20250210133448.3796209-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210133448.3796209-1-willy@infradead.org>

On Mon, Feb 10, 2025 at 01:34:38PM +0000, Matthew Wilcox (Oracle) wrote:
> I think this may be the last batch of patches to gfs2 for folio
> conversions.  The only remaining references to struct page that I see are
> for filesystem metadata that isn't stored in the page cache, so those are
> fine to continue using struct page.  The only mild improvement would be if
> we could have different bio completion handlers for gfs2_end_log_write()
> when it's using mempool pages vs folio pages, but that may not even be
> feasible and I like the current solution well enough.
> 
> This all seems fairly straightforward to me, but as usual only
> compile-tested.  I don't anticipate the change to buffer_head.h to have
> any conflicts; removing the last user of page_buffers() is not on the
> cards for the next merge window.

ping

