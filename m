Return-Path: <linux-fsdevel+bounces-63546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB95BC153F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 14:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 194164F52B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E5F2DC76B;
	Tue,  7 Oct 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3I1okBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB91E244685
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839325; cv=none; b=VCSlhW8l54gEsdmA4tFVmPzkW6J2Ud3qH5DZRvsFa2FIJJx17THV6voXM70pjTkd77XMzNrO3KzeAaFZ4QyIqrzn52oY2nPHgghqeZVl5dCXFqHoFHmovCfpOm592iplLUhrV3vFD4XH9XxgrEKSnrWPMeAwrIUk5sWXUm0wI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839325; c=relaxed/simple;
	bh=fo6pGF/05nRifFRGjSV3VXNDzv5Fx2eHt3ktwmRtiaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8MSTpyoNQRb4Oj44taLl069fMpT6fMgQ4nlmysoxM2hBydR2XxiFkxLmIk0Yj/DM/0g04fxJNx544IU5kf4mjMjhGo1P5AHqMzO8bx7kQ6LUZ2FosK3xCo9Lz2l6HQgANC79wDFsW30Vf8YQQiJrVjw2JQ8+VvVrAKFfitPJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3I1okBM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759839322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DnkYJLI8htZkMXuJF0q4DWlwEkO+3Xhphxedhtl6T4=;
	b=g3I1okBMRoAQwTsDcXS8KXBsetaUmMkp8G1EsS23I9i+qfY9J5MMNEck80XauC5jdDx0j4
	nSdTrJJeL17g6KqL8JdlGAOVG/eo/55Pm24CKkiST/OLRdJhK3oHM9fPljYpbvuip91vu2
	q5WUyiKRvk71NUifaLYbwReSpgRbVAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-3TEzadJFMhC2jlxP1HdfDQ-1; Tue,
 07 Oct 2025 08:15:19 -0400
X-MC-Unique: 3TEzadJFMhC2jlxP1HdfDQ-1
X-Mimecast-MFC-AGG-ID: 3TEzadJFMhC2jlxP1HdfDQ_1759839318
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3360195608E;
	Tue,  7 Oct 2025 12:15:17 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7583A30002CC;
	Tue,  7 Oct 2025 12:15:10 +0000 (UTC)
Date: Tue, 7 Oct 2025 20:15:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH V4 6/6] loop: add hint for handling aio via IOCB_NOWAIT
Message-ID: <aOUESdhW-joMHvyW@fedora>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
 <20250928132927.3672537-7-ming.lei@redhat.com>
 <aN92BCY1GQZr9YB-@infradead.org>
 <aOPPpEPnClM-4CSy@fedora>
 <aOS0LdM6nMVcLPv_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOS0LdM6nMVcLPv_@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Oct 06, 2025 at 11:33:17PM -0700, Christoph Hellwig wrote:
> On Mon, Oct 06, 2025 at 10:18:12PM +0800, Ming Lei wrote:
> > On Fri, Oct 03, 2025 at 12:06:44AM -0700, Christoph Hellwig wrote:
> > > On Sun, Sep 28, 2025 at 09:29:25PM +0800, Ming Lei wrote:
> > > > - there isn't any queued blocking async WRITEs, because NOWAIT won't cause
> > > > contention with blocking WRITE, which often implies exclusive lock
> > > 
> > > Isn't this a generic thing we should be doing in core code so that
> > > it applies to io_uring I/O as well?
> > 
> > No.
> > 
> > It is just policy of using NOWAIT or not, so far:
> > 
> > - RWF_NOWAIT can be set from preadv/pwritev
> > 
> > - used for handling io_uring FS read/write
> > 
> > Even though loop's situation is similar with io-uring, however, both two are
> > different subsystem, and there is nothing `core code` for both, more importantly
> > it is just one policy: use it or not use it, each subsystem can make its
> > own decision based on subsystem internal.
> 
> I fail to parse what you say here.  You are encoding special magic
> about what underlying file systems do in an upper layer.  I'd much

NOWAIT is obviously interface provided by FS, here loop just wants to try
NOWAIT first in block layer dispatch context for avoiding the extra wq
schedule latency.

But for write on sparse file, trying NOWAIT first may bring extra retry
cost, that is why the hint is added. It is very coarse, but potential
regression can be avoided.

> rather have a flag similar FOP_DIO_PARALLEL_WRITE that makes this
> limitation clear rather then opencoding it in the loop driver while

What is the limitation?

> leabing the primary user of RWF_NOWAIT out in the cold.

FOP_DIO_PARALLEL_WRITE is one static FS feature, but here it is FS
runtime behavior, such as if the write can be blocked because of space
allocation, so it can't be done by one static flag.

io-uring shares nothing with loop in this area, it is just one policy wrt.
use NOWAIT or not. I don't understand why you insist on covering both
from FS internal...



Thanks,
Ming


