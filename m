Return-Path: <linux-fsdevel+bounces-69725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80974C832A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 04:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0673AE216
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A75618DB1F;
	Tue, 25 Nov 2025 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RE0rXieC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2D3C38
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039623; cv=none; b=k+eC7Yc7PGvCujM99QXbgm7Cl9xSkQSunHtTHOaY30gKQpMz3xAqyVr7CRVf9v4Dcxck0q2wTmmjJdMlBIeqZukyLVXeYOAkvNLBG0NJNhlNAzAAtkos7mVDrGeDyPvmYhT4g1KsLgNYi7CQQ3Q/GXKOyhh44Eb9UBeG6Av6SEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039623; c=relaxed/simple;
	bh=CXBOFv5E0W/8VeuJx2GyYI3qA8Ap+kQi6fxiDxbI+lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTq/1T6CBgNmDpG0z7vyUwTV+WXsSKhPxlIyHkAjEtHffQXHRZWoL/DhxVcVhaEVcqk7kmAs9TMcnEXkvqMq8f2FPDxinvenfnZ0I4Z8VEgjdgPtBan+aVFUfKuz046xXhmUcIrSxN3WcAIeJhClbXutCP+pGbLp535zYGBFKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RE0rXieC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764039620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b22+7QsDRFeCLadpvkPvdFY550gmWfw5/V4565hkPxU=;
	b=RE0rXieC5gfulqtj+W6YO82AhlR2VP01LBRH43+WCwLyWu5YXk/nwgXLM75YUt+mX8vD/j
	nW7Op26Z/pL2RrRugtRmMz6pUIffv3j59FuoLO4p95CpqskRSI1wYz8aHf9PXKkGNqtigm
	Mxh5PziqK8WzBxZwGoBtLDOaxd8xeGU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-o31QrOWoN_iqYnP4tcoyjA-1; Mon,
 24 Nov 2025 22:00:14 -0500
X-MC-Unique: o31QrOWoN_iqYnP4tcoyjA-1
X-Mimecast-MFC-AGG-ID: o31QrOWoN_iqYnP4tcoyjA_1764039613
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F64C18005A7;
	Tue, 25 Nov 2025 03:00:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.210])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAF781800451;
	Tue, 25 Nov 2025 03:00:05 +0000 (UTC)
Date: Tue, 25 Nov 2025 11:00:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <aSUbsDjHnQl0jZde@fedora>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <aSP3SG_KaROJTBHx@infradead.org>
 <aSQfC2rzoCZcMfTH@fedora>
 <aSQf6gMFzn-4ohrh@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSQf6gMFzn-4ohrh@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Nov 24, 2025 at 01:05:46AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 24, 2025 at 05:02:03PM +0800, Ming Lei wrote:
> > On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
> > > FYI, with this series I'm seeing somewhat frequent stack overflows when
> > > using loop on top of XFS on top of stacked block devices.
> > 
> > Can you share your setting?
> > 
> > BTW, there are one followup fix:
> > 
> > https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/
> > 
> > I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
> > not see stack overflow with the above fix against -next.
> 
> This was with a development tree with lots of local code.  So the
> messages aren't applicable (and probably a hint I need to reduce my
> stack usage).  The observations is that we now stack through from block
> submission context into the file system write path, which is bad for a
> lot of reasons.  journal_info being the most obvious one.
> 
> > > In other words:  I don't think issuing file system I/O from the
> > > submission thread in loop can work, and we should drop this again.
> > 
> > I don't object to drop it one more time.
> > 
> > However, can we confirm if it is really a stack overflow because of
> > calling into FS from ->queue_rq()?
> 
> Yes.
> 
> > If yes, it could be dead end to improve loop in this way, then I can give up.
> 
> I think calling directly into the lower file system without a context
> switch is very problematic, so IMHO yes, it is a dead end.

Hi Jens,

Can you drop or revert the patchset of "loop: improve loop aio perf by IOCB_NOWAIT"
from for-6.19/block?


Thanks,
Ming


