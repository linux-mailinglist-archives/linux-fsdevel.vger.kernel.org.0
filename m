Return-Path: <linux-fsdevel+bounces-43105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A3DA4DFB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593173B2CA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A6204874;
	Tue,  4 Mar 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zDJPPi/N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B131C54AA;
	Tue,  4 Mar 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096249; cv=none; b=sMLsVpPsoO8d6J24iQwiNZOio1P3JXFmfOmgR+1SxllqUg+S0Bajd/xg+mPdjMYcGZPNspSDb4ezDf1TOpRjUAY9aC71U/KDCzbBZhramlC0D1BJffKdHwAcQ3ulY4bXjK7WDDZaEPTX+lfL3334BHMFrxq6MFnXYutv3UyCkwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096249; c=relaxed/simple;
	bh=VyUykeqet9JSwQ2KV4Nw7ZT9QByZkDNd9HSOsHXr3g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmpzkXpiZPMRRZORFLWt78LCEKOUT0Yk1JfS9aPZnMzTXFnSj7KO6+rr2lxMbc9mbjZ8lZgxb1UDlVkh1hX6qbP4Z5C8+IVWEV9Oqkco6iibd9L5I6+GuJ41kLZfq30gHkI0O8Q0rIlbjjehAo6RvWTaeotVyfUr1E9ohTrXhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zDJPPi/N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QHF7za52Pu8bMm2/1OlRR3fhMMqh4Nd+PvYp0UdoXMk=; b=zDJPPi/N8Kr9pI+bcXAf2ZO4Io
	5ocf+UZidcYhssKGr4q0v4vIO47+fltH0FFgBz0zlnZSKIornJ09NA4iJ1BUU+c1LZdtMXjQkdR2b
	OqIUvdo0vqUGc6cHgwSYEKM6ewB2wFHZfN3abktWHTR5ZF+/Zt8U5XU7JMbMbNDsnWSy99KMtzoJF
	f2f79QD/FmSdvNtNBbrQMW1iqAqCzi/86TvJ3gMYAcikeCABZnWCLL2yJn64ng/6ZNpfNnUdQpBek
	CEw7fNteP5Qrc/tu+++ZVDKC9L8ihDpXEPFmnm1NXZZWiUlk0rBcd9hWAwutta9i0xI5s5ErqKhDK
	wBTd4EuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpSfW-00000004qUo-1svf;
	Tue, 04 Mar 2025 13:50:46 +0000
Date: Tue, 4 Mar 2025 05:50:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8cFNp1kd-vN8aTW@infradead.org>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
 <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 04, 2025 at 12:18:04PM +0100, Mikulas Patocka wrote:
> I'm not trying to break existing loop.

You are f***cking breaking file system semantics.  Stop it now.

> The Android people concluded that loop is too slow and rather than using 
> loop they want to map a file using a table with dm-linear targets over the 
> image of the host filesystem. So, they are already doing what dm-loop is 
> doing.

I've never seen bug reports from " The Android people".  But maybe they
just need to stop pointlessly using loop devices?


