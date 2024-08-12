Return-Path: <linux-fsdevel+bounces-25673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB7794ECED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4AE5B21008
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4828817A5A2;
	Mon, 12 Aug 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VYdYZB43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6E1E488;
	Mon, 12 Aug 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465518; cv=none; b=fUR48wFD946gWtIPopdN6L0jBCEor1QF5HcCnsNzflBazuzFyhfl8tS7DauwYYGsJSYDQnNIUTwb2fMFQlXd5ku5aG+c5LYYTYq0hSE4kOnAB1ag8Tf+g/D3ONaTwANj1eJpmiTBODjAS7kiywEfnWm28K7Z+iu1n7CAyV8JxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465518; c=relaxed/simple;
	bh=CAGGh6/9hidM3yNSjoFQBeXqOaxJ5PUdZyDIj+1T9wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYwR1KVYrIGS35Db6aD/vbeJ1R6fm1HnE4QwJPrKbFjSn7MQ7ne7e9duNv4iwXVziau2y8V3z8c5XHg6uLTZhoV+4f9aOB7mD6AX/9nyKPQYw6brpWOGS8uz3XbXNd1+Kd1q0oPmBSlbIIs38jhPBrLM/awBSr4fdKFCG4L0/hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VYdYZB43; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tHSSy+8A4ywnuPcu2eKxxY4jQdJdSdqLOG6mbdcZPrY=; b=VYdYZB431a8XnFuJKHYvANwI+F
	vv+07umPLmljAHoeNLd5TobW1ngToTvjjeHiRJJiR3joWwCcOwljkniv+4JahUf+GHBB8xbv+J+Qh
	IEDgUQ3WKzlVGwoQrb4aI0oFyEBsKkvi6CYhQrVW2va1GYUZuMtXrgFcg2iGJE1kPhKodx+QEHcmC
	pfmDH2EaaIPcmXbI/RpI1EtQf3dVebldX+woqU3n4tw3blHdeOW7v+wM12PnHsIumWOddoDwCMDHV
	QBE06pwrQpbyKhOrw+CWmM3+5cz4md2QnESTXmeCxa9mlJDDJjU+ITxN0iZ5cF/j0AxkSZ+df9Uh5
	oqbEDcGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdU6q-0000000Eypq-02PZ;
	Mon, 12 Aug 2024 12:25:12 +0000
Date: Mon, 12 Aug 2024 13:25:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] xarray: add xa_set
Message-ID: <Zrn_J_Yo4-BY-SHc@casper.infradead.org>
References: <20240812063143.3806677-1-hch@lst.de>
 <20240812063143.3806677-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812063143.3806677-2-hch@lst.de>

On Mon, Aug 12, 2024 at 08:31:00AM +0200, Christoph Hellwig wrote:
> Add a convenience wrapper or xa_store that returns an error value when
> there is an existing entry instead of the old entry.  This simplifies
> code that wants to check that it is never overwriting an existing
> entry.

How is that different from xa_insert()?

