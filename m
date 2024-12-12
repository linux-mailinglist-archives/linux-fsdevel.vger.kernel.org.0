Return-Path: <linux-fsdevel+bounces-37122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BAA9EDE1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 05:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873062831DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 04:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0515EFA1;
	Thu, 12 Dec 2024 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pqZ23dfW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C73143759;
	Thu, 12 Dec 2024 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733976879; cv=none; b=u3baqLsj+KDx9hgXyJ7KMvIXP3nj/hytF6N84x7G1nkrghksxQNId9YhMmm0TJLzJWwbnJxwEOtM4kjF6PwgIYw+xYrCPs0dYFRsrejK0QmyXjIOoGTNMVpq93COXyjDLseKVnsepRBof46S8jQZ/5AUBfLLfXJRcb0yBUQFyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733976879; c=relaxed/simple;
	bh=jUFFyhc1k+hr/Dk+MPrfMHne+vTXTAHV4pMr+k/Ptbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUdz/FpG264QnmMhkkzA15rECTE+y0aMKjgmb0qhnyVBo1jGZ2HFyHqNXwTTv8Ra7JnEjUoxt/u44Voq9EYHs5u1C3CSO22YaPPYk9Mmf3iVjRPTEpy7zGJfuZLDefj4JZPIPA5BLyiBf4Z5u1s+BfmGNMcSNy/i8aqPfSVYmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pqZ23dfW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xVwb7dvuSB1Ovf0Os0OG8dDY/GDajdloQ1g92g9UDvI=; b=pqZ23dfWJBACAFfRY90nLyQXWd
	pqusabf21MmcsJsU6M5QlyhPYGmqgUwl/X9YSUwZxlYIZwMpEE0+ASiP5W6WMDNzFnHlUn3lKiBwV
	6rW5rFycAbNKS/HGJQKBoauYHBp5RWz3A2/jUziQKj8SHBRv9UefDwK/2ZHh/P9RjQsu79J6UohqS
	/4Hvyl9FQdNAJOMIMHMX5S9pfZ9zmGB1dBQVt16g9XJhV2kTJtn9SWJBhzI576z5jmUcnelGCnAsA
	RVyOW9o1go9qeUSsWR8bydBsq1RSmumMbxVKpQ9mdbKkUKYKU4N5vRNHftMSfW9r/O/z7Jfb/XMNO
	91tEMRMw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLaar-000000038JS-2y1w;
	Thu, 12 Dec 2024 04:14:29 +0000
Date: Thu, 12 Dec 2024 04:14:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	caiqingfu <baicaiaichibaicai@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <Z1pjJWkheibiaWuV@casper.infradead.org>
References: <20241212035826.GH2091455@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212035826.GH2091455@google.com>

On Thu, Dec 12, 2024 at 12:58:26PM +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> We've got two reports [1] [2] (could be the same person) which
> suggest that ext4 may change page content while the page is under
> write().  The particular problem here the case when ext4 is on
> the zram device.  zram compresses every page written to it, so if
> the page content can be modified concurrently with zram's compression
> then we can't really use zram with ext4.

Do you set BLK_FEAT_STABLE_WRITES on zram?

