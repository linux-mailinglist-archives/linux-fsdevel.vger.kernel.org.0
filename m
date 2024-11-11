Return-Path: <linux-fsdevel+bounces-34254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D649C41D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0646A284DDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509A6158858;
	Mon, 11 Nov 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CCEiEsQa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5153389;
	Mon, 11 Nov 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338870; cv=none; b=lx+/xZWXhjEdT92qUA7dfBElJBW8v3ef2fIOaNRPWhGDjiBobcGA8++UrSkoNxdLiHq05ncsW3dvfhtlREvu7DRER5f8WDeO6In/JNhfUN8tLcov4P4jvglePFBoqOhDVbznyB8P9OL+T9dcdXPHoRJ2XGLHHM5md7AsoU3zpKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338870; c=relaxed/simple;
	bh=Bh5/CN0FK84EGxcPUYpfMhnMYuOqhXdoNN6je9lAwy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8hq89o0ZVylhWwCOvTxtCSWDLfqPwyH28g4Wu4MoOkeSm2bYWLn4hHW0ZoWIc9ipOgE67NUUp8WOI7IdM/rDDqrH3DvvlLLYozBloBC0U7E9FQX40B0Tld7zZ7O/Q8IyhxTlHQDoQnHyBSkyOrvqYPaukK6I7ko/nTNdmaUbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CCEiEsQa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bh5/CN0FK84EGxcPUYpfMhnMYuOqhXdoNN6je9lAwy4=; b=CCEiEsQaxZ5IRjfFc2HARHXt0s
	BqQsN4o30vfmdhKFUQISyLW+zpUcafcUTi9OG4ygIMjDPiIUt7P4lndVHZVQQ/nRWr3PpizTCAAR8
	IIzlF5tiBFR8VMp78RYG47syfC60NZJC6mRoNXei+UQRQYpQu/91BQiqEusu5PzEqlZJ45EtcOzGy
	NcYmuAFTYuycZbWRmlNfIGzdD/TWp6AA9h8oFBetnMd1WIXHfzgVoon2ZZ65Z73cv1WBeDHAissTD
	NMTkyCwdl9OQof6/lg+DLxVYeAUNPVJgZy9O5ZVpu0bpToCcIvZ7p1uip7Fmo28s9GuAwp1stEbtq
	MT0nGTtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAWKS-00000000SMZ-3AGi;
	Mon, 11 Nov 2024 15:27:48 +0000
Date: Mon, 11 Nov 2024 07:27:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 15/15] xfs: flag as supporting FOP_UNCACHED
Message-ID: <ZzIidGR2FDChtCAu@infradead.org>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-16-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110152906.1747545-16-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Nov 10, 2024 at 08:28:07AM -0700, Jens Axboe wrote:
> Read side was already fully supported, for the write side all that's
> needed now is calling generic_uncached_write() when uncached writes
> have been submitted. With that, enable the use of RWF_UNCACHED with XFS
> by flagging support with FOP_UNCACHED.

It also might make sense to default to RWF_UNCACHED for the direct to
buffered I/O fallback for sub-block size writes to reflink files.

Also for the next round you probably want to add the xfs and ext4
lists.

