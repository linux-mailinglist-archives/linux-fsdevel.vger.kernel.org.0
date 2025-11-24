Return-Path: <linux-fsdevel+bounces-69628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1FFC7F04B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 07:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AFF6344293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 06:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA822C21D4;
	Mon, 24 Nov 2025 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gB0r2+qY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5B217736;
	Mon, 24 Nov 2025 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763964752; cv=none; b=uSYZpDvuSQ8FDCMVxjbc+Kg3IvPZcfBpGmz344yfrnLD5jMMYHVwdz9nAa1rHGknN6F2i+LK4mnSszq/wJATTqsnwcHuGH2M1Dbanikhuk93N8oKSgfLOoDnDIJedNq8UF4vjYLHdNF8V3/Itp4sPr7m+qvabnK/09Pe7gDUKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763964752; c=relaxed/simple;
	bh=INSVYBbb1E6CIB2V0nuUCar+mTYYmoNlpmuEOEMDuLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Upl47gxXZJJk/0xcbaNAI/5yNKEPtbNwPwvPMoHJN2JIqIQF9ZdKu04pYI3//Mzxk9w80EaqYS/3TcHgD8LsOis9b7EfIihxJj4WVqTwwZpUbcSrcIgrBsNwIGvNTek/jKE+/8GJb2olzWgKaiU69Iu79lDXuIb3H4saXAI+RkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gB0r2+qY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=Z4mpNf1BIRqsb//AvdOD24l+kOdTjNMLa/8oJp+WiNI=; b=gB0r2+qYFrX2fpYnAbAqE6haFb
	RfJMzle8EyHBPLt39T/J1EKj29mR8d3AE1mR3n8CE3Si4nD1HAm45+idOFExtUaIlu16pBvBa86l/
	w96yrlHj5gRKg/WnFqkqueXTXDXBtI1Sp6kB4JZqAjn9XUIv1NBIZ9xi5d1uIXWcsd8xEkVM/kOq4
	3gOkrPC6kf11pS9aRUFka8n4YjJTtj7RiO80SCF7G+/vXP0psKiehJTFTfOt4rcVyHkb+z1uMBUlf
	dJl52wPwBvmQhmlsOs7N6YVAnnw2E91r3cpoDF7S0WRptRczxcPfBTrqwXacK26EkY/ipETMW3YPa
	crnVygFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNPoG-0000000B8JO-3nwL;
	Mon, 24 Nov 2025 06:12:24 +0000
Date: Sun, 23 Nov 2025 22:12:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: calling into file systems directly from ->queue_rq, was Re: [PATCH
 V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <aSP3SG_KaROJTBHx@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015110735.1361261-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

FYI, with this series I'm seeing somewhat frequent stack overflows when
using loop on top of XFS on top of stacked block devices.

This seems to be because this can now issue I/O directly from ->queue_rq
instead of breaking the stack chain, i.e. we can build much deeper call
stacks now.

Also this now means a file systems using current->journal_info can call
into another file system trying to use, making things blow up even worse.

In other words:  I don't think issuing file system I/O from the
submission thread in loop can work, and we should drop this again.


