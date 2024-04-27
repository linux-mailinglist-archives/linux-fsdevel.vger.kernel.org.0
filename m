Return-Path: <linux-fsdevel+bounces-17964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBCC8B4444
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 07:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD2F1F235E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 05:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4D143AD4;
	Sat, 27 Apr 2024 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UUfaZcJn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9D43AA2;
	Sat, 27 Apr 2024 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714194726; cv=none; b=qWbyo2sJChzboGyr/alocTccwooJH5tUb/VR9JaultdwXDCvJ6+LNAbg3SRb4quy+Pm81gS7vCnLkmzn6a4LtIO55z19J6IDJ04aKFslDDQ3j7lmdIrKKf3SXMPoGuvxA4iaLHRDxc1linCkJIz31p7fhTa1rXSTxIlj7LeJl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714194726; c=relaxed/simple;
	bh=O7G1N5kUJ42MLKk6C0TENm1uIF0EeIdbs+5O5igP4mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYdJxzRiPrk004a42Nprei8ZdQAQFMVLFe14KYvr8kekyw3qz46DoMQq3yGXVEp1YNlzhZIgIZrHyDLp/yaRYmBzi2TwIWInXH7aOHP2VYxjmBtkqrtgP+T/1v7BozwVbQNk1D0kBuun2SSPpxaXmGLRGdajt3oi+jbEWQEuEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UUfaZcJn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oxXXlnoPot77a+fvQmA9reMneHMSrAR6fk9Rds04GtI=; b=UUfaZcJnJ53B+b0GduvU399iAV
	SCSZcYaAdxoEBh4BPtjZEp314+5gE5ekYonF6kmrewSca1uEJYQr2era5a2qiJekM3/8Qyth9pQPj
	pCOxvaLF+JdOhWoKZ50z4H5tknIoecADa+IxwEpW3T/wRAqUSPEmUsRmMbkg0ddXnpmAD1Xjo//B+
	3BsTusR3PaYkr+a/BtDLSQHrfWWdjVsBrlrqVOavasL0QOV/83uZeoZ7m0CYTWWiTlEEHzrbBqhNx
	Beoedwvj5cIJABy0xyjsnZkJcjaWOJDLE+Ae8J+gBneZEGamVxbUvdgUDo5Zkc78hGmWSzvJuc6vQ
	13wZaVJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0aLx-0000000ErB1-3M92;
	Sat, 27 Apr 2024 05:12:01 +0000
Date: Fri, 26 Apr 2024 22:12:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZiyJITld-KdZeOrC@infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-8-kernel@pankajraghav.com>
 <ZitIK5OnR7ZNY0IG@infradead.org>
 <20240426114301.rtrqsv653a6vkbh6@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426114301.rtrqsv653a6vkbh6@quentin>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 26, 2024 at 11:43:01AM +0000, Pankaj Raghav (Samsung) wrote:
> Because allocating it during runtime will defeat the purpose.

Well, what runtime?  Either way it seems like we have the infrastructure
now based on the comment from willy.

> In anycase, I would like to pursue huge_zero_page folio separately
> from this series. Also iomap_dio_zero() only pads a fs block with
> zeroes, which should never be > 64k for XFS.

Only if you are limited to 64k block size.


