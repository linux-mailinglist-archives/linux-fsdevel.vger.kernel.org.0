Return-Path: <linux-fsdevel+bounces-54439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB789AFFB35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 09:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3DB3A83A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBB528B4FA;
	Thu, 10 Jul 2025 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bCmiUOr+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1F28B3E8;
	Thu, 10 Jul 2025 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133461; cv=none; b=KYOoWUYXcR8xalI28elXQM22H/wYHnbTPoODKyu1HY4hjmZcl56y2j68I+tsQjAMx4cTqPSYLEDLv0vJ5pKdeEItt7jpXB9ETuC9xMUVdCsfOi+9p4a/L8EztKukSCgH4SCXwMF43VmBcoDdJ+6rzYIcZR8BeMx6DCjATNTmwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133461; c=relaxed/simple;
	bh=3Vm0VZ3wEkG0QEaQt9fIUezZhLrgJE9wx8IMAceyI44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTSG88687hbJdsDQZ+J9VgoJ+juNnlYpvXOzBgA1ddImnnFhuXBf6CNaQ7MOyMFuoEv1aPQUCZ+uehWPrtNvD0pM0kON7KH7YFuVvj7HAqf3JYywOSYm9//vntSCXMS3xgD3kx+fNc6B3tJ48Zzyu1xVTEI11Q/20AItjgJNVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bCmiUOr+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VYH1DxCcwh7lYgHK/JJ26eAVuS5Jac8v4dkVPNJ3/R4=; b=bCmiUOr+02evOGelfQHFyIrP/a
	ZbDJNVNcahc3+lvk2qHy8JLr3wAfIjuL9Iddq4Z9b7oCYDnj4SCeQ9ot0ZKuSE8KUATkiAQVSDvdj
	qrQMVnejZvHH4tIfXRNpQpAd2CcT6T5p7SWr3Ex/LH3p9xjp0oI9HMDzuiKq0jyJg2+M3oPqmgZ3J
	BXqwFeWvK/TX8KBshVKFw/WEhVDZZg5zmh5i8nA9vkc1ikexLUUKoJKvlVhzQ2ePrqOSRYxXf1g4Y
	AQTI8EFpu9IRiYGI/B5oSIInSeySQIA6Pj0OozJrMoZN9FkoE9pST8socIagcwoCqERRoaQ5UqaLt
	+k1p4Mgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZlx3-0000000B3TH-24Be;
	Thu, 10 Jul 2025 07:44:17 +0000
Date: Thu, 10 Jul 2025 00:44:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 4/8] lib/iov_iter: remove piecewise bvec length
 checking in iov_iter_aligned_bvec
Message-ID: <aG9vUTfMkiT_-uMG@infradead.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-5-snitzer@kernel.org>
 <aG9qtlHCmSztOsFo@infradead.org>
 <aG9scyDn-rxDnwn3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG9scyDn-rxDnwn3@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 10, 2025 at 03:32:03AM -0400, Mike Snitzer wrote:
> The first time I posted this series I did a better job of sending this
> patch to Andrew and Al iirc.  In any case, I can pull this fix out to
> front of series.  But also iov_iter_aligned_iovec() appear to have the
> same issue.

Maybe send a series just addressing the two for now to kick off the
discussion.


