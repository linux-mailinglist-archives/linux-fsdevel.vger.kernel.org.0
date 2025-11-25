Return-Path: <linux-fsdevel+bounces-69745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C63BC84315
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14CBA4E2BBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616C269B1C;
	Tue, 25 Nov 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI+sfF7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C6846F
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062408; cv=none; b=D3SHf7bAoGW+vQHBLH/FoyBox8M8Xmc7Wd1S71Cr1BNPOsslY7q9nkH/gMyFsDd6Ind0gpTwpTptP1LcBD8F+v3ZgJshAilQs3vUeKCW2UuvoNsuWMo0XFZoEzMLS5pHLqjUxwpEEenPFNYjSkxiUvQERoka6VOvkkHZ45FqiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062408; c=relaxed/simple;
	bh=nVwlnoLibl3qsrLZN/1S21rj+mcRK/zv7JSEiwlrXuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0RCCeLyl4+0slr2dFm76ebUIw+aTA1c5hznnylQU+bNq/z1P502yYQNXXcqyL8XIjEH1IC2JkYM5Sd1SP/eoXERtf96VKSGx4h4fsLwD8PMAX3L9z8sx8CGgxxnqTNF0cDGLuln5Ypw1tp78c9Smj/LclZgs38LyXdVJFzRqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UI+sfF7T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764062403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e18+dlXOUuhyYDJ7hRKWocHc1eXAQtcNtVD1Eal52UI=;
	b=UI+sfF7T+bMICDTf4OLvOHm6W7apkkV/elMGFGvnpOP2XvuvLGCh0u/l536RfJmhCirCSw
	+YzxlXxDiALBFiXB2GSv/RllsSkzqy1A8CAkeXdd2/oz29Q+8C04s5L+pW0BlsjIVFF2cK
	pjemF+Y/OKtupcKEu5sxLYdHKR0XkpE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-UhNJNOjZMYWJOor55cxcZA-1; Tue,
 25 Nov 2025 04:19:58 -0500
X-MC-Unique: UhNJNOjZMYWJOor55cxcZA-1
X-Mimecast-MFC-AGG-ID: UhNJNOjZMYWJOor55cxcZA_1764062397
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 245E51954B17;
	Tue, 25 Nov 2025 09:19:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.210])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3F23180047F;
	Tue, 25 Nov 2025 09:19:50 +0000 (UTC)
Date: Tue, 25 Nov 2025 17:19:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <aSV0sDZGDoS-tLlp@fedora>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <aSP3SG_KaROJTBHx@infradead.org>
 <aSQfC2rzoCZcMfTH@fedora>
 <aSQf6gMFzn-4ohrh@infradead.org>
 <aSUbsDjHnQl0jZde@fedora>
 <db90b7b3-bf94-4531-8329-d9e0dbc6a997@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db90b7b3-bf94-4531-8329-d9e0dbc6a997@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Nov 25, 2025 at 03:26:39PM +0800, Gao Xiang wrote:
> Hi Ming and Christoph,
> 
> On 2025/11/25 11:00, Ming Lei wrote:
> > On Mon, Nov 24, 2025 at 01:05:46AM -0800, Christoph Hellwig wrote:
> > > On Mon, Nov 24, 2025 at 05:02:03PM +0800, Ming Lei wrote:
> > > > On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
> > > > > FYI, with this series I'm seeing somewhat frequent stack overflows when
> > > > > using loop on top of XFS on top of stacked block devices.
> > > > 
> > > > Can you share your setting?
> > > > 
> > > > BTW, there are one followup fix:
> > > > 
> > > > https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/
> > > > 
> > > > I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
> > > > not see stack overflow with the above fix against -next.
> > > 
> > > This was with a development tree with lots of local code.  So the
> > > messages aren't applicable (and probably a hint I need to reduce my
> > > stack usage).  The observations is that we now stack through from block
> > > submission context into the file system write path, which is bad for a
> > > lot of reasons.  journal_info being the most obvious one.
> > > 
> > > > > In other words:  I don't think issuing file system I/O from the
> > > > > submission thread in loop can work, and we should drop this again.
> > > > 
> > > > I don't object to drop it one more time.
> > > > 
> > > > However, can we confirm if it is really a stack overflow because of
> > > > calling into FS from ->queue_rq()?
> > > 
> > > Yes.
> > > 
> > > > If yes, it could be dead end to improve loop in this way, then I can give up.
> > > 
> > > I think calling directly into the lower file system without a context
> > > switch is very problematic, so IMHO yes, it is a dead end.
> I've already explained the details in
> https://lore.kernel.org/r/8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com
> 
> to zram folks why block devices act like this is very
> risky (in brief, because virtual block devices don't
> have any way (unlike the inner fs itself) to know enough
> about whether the inner fs already did something without
> context save (a.k.a side effect) so a new task context
> is absolutely necessary for virtual block devices to
> access backing fses for stacked usage.
> 
> So whether a nested fs can success is intrinsic to
> specific fses (because either they assure no complex
> journal_info access or save all effected contexts before
> transiting to the block layer.  But that is not bdev can
> do since they need to do any block fs.

IMO, task stack overflow could be the biggest trouble.

block layer has current->blk_plug/current->bio_list, which are
dealt with in the following patches:

https://lore.kernel.org/linux-block/20251120160722.3623884-4-ming.lei@redhat.com/
https://lore.kernel.org/linux-block/20251120160722.3623884-5-ming.lei@redhat.com/

I am curious why FS task context can't be saved/restored inside block
layer when calling into new FS IO? Given it is just per-task info.


Thanks,
Ming


