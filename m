Return-Path: <linux-fsdevel+bounces-61464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7FB587FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC66A20768C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 23:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024A2D47EB;
	Mon, 15 Sep 2025 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L2YDztaP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898618DF9D;
	Mon, 15 Sep 2025 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977523; cv=none; b=ZHun6Uk9Cnm0woZEn2ai2HeCwO6RmSl8anK8LccTizblcxjMktWwPsH3IxlMX+PgHfVGQ3nUeWx3EjlBBzRb4RvDLUw34DJIrXSZo6xmlBWnVqVKdPVNCdc61dttNrUa7WY3qM4wYUrxiOZw/kBYc1KQyvoxUhHCa0wdg3Pjx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977523; c=relaxed/simple;
	bh=kfTpDcHkGyTFz8CCeqVfzTin2htQ1hc2Z8IdMy7NaAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSZy+U35Fkd4Fw3qI1w/WfM/C6iar9hUrHmSCdknhrPzA7vYSg4E8pbPhi8REsXOv3VNXFvvKe96Vnh2ib7SQ0IQ1Mj4vbYcBgF3FqEKZNRy1ra4l5ZVpVweP79dIszHXosBDfl7HVyP9qtY3X7xmp93Jk3rxP1gbQPttPOeJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L2YDztaP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kFoXd94mYDwzR27iBBzfzAZSuVL+D/rJNjURhWoqhaM=; b=L2YDztaPmKfoJgppdbukM6e4UQ
	PB18/TYsJEduUdrlhYyofd12tFAy4ZmCUt27CKhopQvnMwMxoHay0bqm+znfEhKJOlUWO86+D97Tu
	0oEwcwz/vURZ8eLgnK3R1XUkwh6hLhdBawHh5F8ImAodClbPYV/fQj7L5iSAgYtRJ0RrvkRLLdlgf
	yrxSK+OUjhTBrGuk7892523Yb2Ybtto0mzXRs5KthU6uQu5S+fvHnkHJE4RSmDMKB/AtvtKfekS+F
	zz4IzYfhlv/OVzEQbJ4OPsUS72HV7jrAFyaLGchRYe6+qqqNPdRBajqR9GXWHgr7aCIdv1su6W8o3
	nC34DL5g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyIG4-00000008mBP-2h2g;
	Mon, 15 Sep 2025 23:05:16 +0000
Date: Tue, 16 Sep 2025 00:05:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>, linux-mm@kvack.org,
	mcgrof@kernel.org, p.raghav@samsung.com
Subject: Re: Any way to ensure minimal folio size and alignment for iomap
 based direct IO?
Message-ID: <aMibrFB8_21GQWUD@casper.infradead.org>
References: <9598a140-aa45-4d73-9cd2-0c7ca6e4020a@gmx.com>
 <aMgOtdmxNoYB7_Ye@casper.infradead.org>
 <2h2azgruselzle2roez7umdh5lghtm7kkfxib26pxzsjhmcdja@x3wjdx2r6jeu>
 <fc7da57f-5b11-4056-857c-bb16a4a20bb5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc7da57f-5b11-4056-857c-bb16a4a20bb5@gmx.com>

On Tue, Sep 16, 2025 at 07:16:48AM +0930, Qu Wenruo wrote:
> > Is it very difficult to add multi-shot checksum calls for a data block
> > in btrfs? Does it break certain reliability guarantees?
> 
> I'd say it's not impossible, but still not an easy thing to do.
> 
> E.g. at data read time we need to verify the checksum. Currently we're able
> to do the checksum for one block in one go, then advance the bio iter.
> 
> But with multi-shot one, we have to update the shash several times before we
> can determine if the result is correct.
> 
> There is even compression algorithm which can not support multi-shot
> interface, lzo.
> 
> Thankfully compression is only possible for buffered IO, so it's not
> involved in this case.

Would it be acceptable to vmap() the pages and do the checksum on the
virtual address?

> However then the problem is why the read iov_iter passes the alignment
> check, but we still get the bio not meeting the large folio requirement?

The virtual address _is_ aligned.  It's just not backed with large
folios, for whatever reason.


