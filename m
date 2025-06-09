Return-Path: <linux-fsdevel+bounces-50961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9451BAD17A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 06:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A05D1684A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 04:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A2027FB2A;
	Mon,  9 Jun 2025 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TQhULtX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311313AC1;
	Mon,  9 Jun 2025 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749442291; cv=none; b=G0wmneRjAs9dgwL9ndzOm6kDyv8JJ58Lx3/8ZaJpuIjDa3tLMAYXpkHkEPi9/ArCbVcRkxQELmgCQtOD5pmcZfFEoBPLCO813iO8YKClIOgKdug3iV3AW4Wog4BaSOfjMlCiU/+W2/LYEGgY73jXi+SSICJPDElNzTXn8ZjzqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749442291; c=relaxed/simple;
	bh=5k+ptO2Bvp2rDM5eLKk+8ZcnEWW4i7JDYoLWfYvoPec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBMhBdx7VVg7wIv76KQQ8hpe0iGrhH8+gPa1rO1XEoB30VK+LNFtzNU0x8Ft2lnKNgLYYYbcfG85QtXf9bJPUCPOkndVrM0AwXd1EwIqv5+hmnb0VnMDePVdMej6b6qov3ryIInjvfecGiUvEZAwopQqeL4kMj51sScopKJLZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TQhULtX7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+A8m+5Nm/85Oh5Q0q7gkcp2AYf9b7B4/4JKgs+UNNm4=; b=TQhULtX7/+G1d1FixKxwy1CuVQ
	9DRp+JE2XLpCn2Rb8ZZYj6vUXZZztIcDesnSiqcH6bZq3NjIVrZ97PUI9p0h+qoCJKqc0mE3HDgk0
	9llzjZWqNNUdaNB+fQnjyKEQGE+fNjCsX51Ub6xfbPcbFHZTfUVqHUEjbD0Fn8KPm0CXWOHc7lHkF
	NZPUohOf/Z1BZsSw6aGQ4gbYpHzklBa3FdHLUqerTowsNQQez0PNR9keH9YWcNfA2vOon0FFeXao8
	wW0e0mjJU4g1JyePh7Mx4gmhkJOw9IPSc5SeaJc9+nPCo3dhCUZ2NKMSdK8kBVU0kDe0L/lSPwYqt
	97ZKqkhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOTr5-00000003Nk4-1fEs;
	Mon, 09 Jun 2025 04:11:27 +0000
Date: Sun, 8 Jun 2025 21:11:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, vincent.fu@samsung.com, jack@suse.cz,
	anuj1072538@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v2 2/2] fs: add ioctl to query protection info
 capabilities
Message-ID: <aEZe79nes2fmJs6N@infradead.org>
References: <20250605150729.2730-1-anuj20.g@samsung.com>
 <CGME20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70@epcas5p1.samsung.com>
 <20250605150729.2730-3-anuj20.g@samsung.com>
 <yq1a56lbpsc.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a56lbpsc.fsf@ca-mkp.ca.oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 05, 2025 at 10:07:00PM -0400, Martin K. Petersen wrote:
> 
> Hi Anuj!
> 
> > A new structure struct fs_pi_cap is introduced, which contains the
> > following fields:
> 
> Maybe fs_metadata_cap and then fmd_ as prefix in the struct?

Yeah, that does sound better.


