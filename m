Return-Path: <linux-fsdevel+bounces-55643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34874B0D1F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD52189F5B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 06:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B8C2BE7A1;
	Tue, 22 Jul 2025 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Er2pRUpB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECCB28AAE0;
	Tue, 22 Jul 2025 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166185; cv=none; b=t17mswtGS3I22zcVb1ew2BD7q65o740Ec9v7lofRQHvH9kIroFYIRTnYDEAc0t0kVclhE4pB9npbhYTZcrE3Ty9UvTy891hAmpYX18r4LtuMVic9gm8Tdd8E9NyVvPYHQLY1XoZ0ee7I25HNyfACxe104hPXGCcIWJ5mF1CKC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166185; c=relaxed/simple;
	bh=s8lTHEFvqn6O7/obO5tIhJdwAk4Fh5VdIus7RBec4R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCIk2U9hAtsq0eYpDhwz8wc5VTjWDvqooJA9IXxnir9JMBmg73XcOUCg+4wGHIThLevPb5Hz2fdJpwerBcbNGDrDtHJL7U/vY4HkxosexLADUJQbZByJ4HBxVRL7fk1AS1IyrnUp4QG0UwFdmFlPP8V9y4pMmoXBxSUch9VQgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Er2pRUpB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s8lTHEFvqn6O7/obO5tIhJdwAk4Fh5VdIus7RBec4R4=; b=Er2pRUpBe0z6D0cmT0xn3y8LLc
	IKsOLGjRxfEIbcXy3vbLfp0u1cFP0rcUyUeGrmHt+log0tja1KeYBIar8O3xBAJNRCsIVqEP6v6rt
	ZZkaKFQBUta5m0RDl0kUfMXNfXcRIDRZqce6z1aE/nYN33N92Fry0nWk3u2c20ykDYCUfmUF4JnFJ
	KASTC3yw8VNX7FHaU6rx2LGFIyL/xXjJjv9/dXI1f4L8Txpxum8Pf0/xn+GaZaXbiDNDjBN1Picc4
	XfL+aUTPCUzSuQUJegmKGBNjqtZGvsmeETEKcLhJUtstyCa29JmdjDzj2bz+DAl0y++rVsA5h9OaY
	+AvKB/6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6br-00000001RTc-0giI;
	Tue, 22 Jul 2025 06:36:19 +0000
Date: Mon, 21 Jul 2025 23:36:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v5 0/4] add ioctl to query metadata and
 protection info capabilities
Message-ID: <aH8xY3PyejzGdUp7@infradead.org>
References: <CGME20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f@epcas5p4.samsung.com>
 <20250630090548.3317-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630090548.3317-1-anuj20.g@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

What's the status of the fio patches to support PI now that this
has landed?


