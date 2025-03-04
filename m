Return-Path: <linux-fsdevel+bounces-43125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B9A4E60B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F7C424A56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFE22980A3;
	Tue,  4 Mar 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RGcz5KqL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319224C068;
	Tue,  4 Mar 2025 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104270; cv=none; b=S9zVGtX8KdoXggCWe4dsKRfzPeaefd0utdaD+o2ASOySpXnjjz7esMTXqNi19WoCP+UBTagtR3Qyh7E9Uumhce0d5fBVxpi1Po+2qkNfSQfQ0PQZxZcfqe2wto7tWJ+6/VREejJiToilJ6/9f5CWv/EoaLN1ABZZ9i8L4Vpygco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104270; c=relaxed/simple;
	bh=ud1f9gtjRhGurv6nqr2dtZPRMXm/Btg/3VvzbrXikGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpcxpVDOpn/3t3Q1RoeKfOq7W9kuPvScKrRCHVKhvdE+A8GU5Cz5BhWWBYGoKfiMMNEtNtSPB2TER0aGOO3gRfbosM6ou6dadzRQa7Hvyl777rDxuobmIWIvrSoyL/HFUQAl7nfeTMKSq4jTyL+S4BqSmVi4g8J9+kK/lXfZteg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RGcz5KqL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eFi854rHWXf77vFMrT7dM4VCDWhDDka/F/tms7maNYw=; b=RGcz5KqLj1zSKWF2P0i8OeZu68
	Moep0YmW16SdXfmfOCDbMMLWEsvcPgZrXzKKSGz8LIShiyJdOzoNvUExtUJtlnp0P20mRu7dofcd4
	SUSDuwJ/k2hHgFVLKX4GRX7rlBOra+wSCl1XXE/Z0nP4c5wyqQxXN8153Rx3yHyl2U9vFYJrySXzA
	wevTZL+ujwICRbcMydVZUGtD7XxJt+W2fDRzE5ImWzkEp9KAqUFgX06vbs+3WhtQoIr1aQ/VeX1Ky
	gUYOuJvZK3fVK/Q7TLdCe50zbsDeRreSYBTMrueCuVPVOGZyo6NCSPGHSvfDUAbwZ12zqH6j3gIo+
	QZd+8hUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpUkt-00000005LJm-0lBm;
	Tue, 04 Mar 2025 16:04:27 +0000
Date: Tue, 4 Mar 2025 08:04:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Heinz Mauelshagen <heinzm@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8cki-inrku8QIhB@infradead.org>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8cE_4KSKHe5-J3e@infradead.org>
 <CAM23Vxr=fKy-0L1R5P-5h6A95acKT_d=CC1E+TAzAs8v6q9gHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM23Vxr=fKy-0L1R5P-5h6A95acKT_d=CC1E+TAzAs8v6q9gHw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 04, 2025 at 03:50:36PM +0100, Heinz Mauelshagen wrote:
> Seems to have a loop target to add respective mapped device semantics, the
> way to go is to design it using VFS API to get it upstream.
> 
> Won't help the Android use case requested by Google thus they'll have to
> stick to their multi-segment linear mapped approach to achieve their
> performance goals unless they want to support dm-loop OOT to make their
> life easier on immutable file backings.

What are "the performance goals" and what is in the way of achieving
them?  This thread has massively blown up but no one has even tried to
explain what the thing tries to address.


