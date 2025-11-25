Return-Path: <linux-fsdevel+bounces-69762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AA2C84876
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF36D34DB7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F5030FF27;
	Tue, 25 Nov 2025 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7jTL2+Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84A30FF1C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067295; cv=none; b=IDTjUqd2zNvd7EBT7krMA9x3ohWwkaKpFiO4mnwL4YtpZw8hW5UJS0zpz1BXd4SPPlzoMQJhSAKNxdzz476eO4t8+qZO0jx9BLeSlZbHt/gznYXny0vhbXAawypL3VM3MRjH8A+k68lgATgIMWgyf9c2JK2iikseVDEJCyuJHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067295; c=relaxed/simple;
	bh=oaA5mMtT4qdHkVNUs7YygRFrqsfI9fgynK0F2pqs5ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw1vKy159qgdN66XABexEwu0YPXT4UDZJa5BTsKo14eYJ/zsYAWHiSlQjUZ7Yd0oyWt5Uh8BF1oVO88wv1114nByC7XibH6JwkmykyoNwjazFxw/hg3RWUJaCkqk3GQ1L/V0h1wabQZOuepSpr4q1akoLinmpM4G6kVhudfGcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7jTL2+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764067292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmy6dxMclL5XSoJiKQCi7YSdWD0f5ZeCMTgWVkqlXps=;
	b=P7jTL2+Q3xoiYTtLb8BrE8+7utXB20CEYtxujzAeaH8GcNArTDQmtecRTF+YncUx3Al3Jy
	CzqQVTLJwsYeZ4XwNoftm39ri0reTuliCSag3uggMb83FttWM1Q8rkkxJ1crY7QSjkYcIt
	02ZURsYjxOXZeL3ItYC0O8Kf28JKb3o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-1NFj2-YkO_uFZYVfLWr7bQ-1; Tue,
 25 Nov 2025 05:41:25 -0500
X-MC-Unique: 1NFj2-YkO_uFZYVfLWr7bQ-1
X-Mimecast-MFC-AGG-ID: 1NFj2-YkO_uFZYVfLWr7bQ_1764067284
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B77C195609E;
	Tue, 25 Nov 2025 10:41:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.210])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5A283003761;
	Tue, 25 Nov 2025 10:41:17 +0000 (UTC)
Date: Tue, 25 Nov 2025 18:41:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <aSWHx3ynP9Z_6DeY@fedora>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <aSP3SG_KaROJTBHx@infradead.org>
 <aSQfC2rzoCZcMfTH@fedora>
 <aSQf6gMFzn-4ohrh@infradead.org>
 <aSUbsDjHnQl0jZde@fedora>
 <db90b7b3-bf94-4531-8329-d9e0dbc6a997@linux.alibaba.com>
 <aSV0sDZGDoS-tLlp@fedora>
 <00bc891e-4137-4d93-83a5-e4030903ffab@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00bc891e-4137-4d93-83a5-e4030903ffab@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 25, 2025 at 05:39:17PM +0800, Gao Xiang wrote:
> Hi Ming,
> 
> On 2025/11/25 17:19, Ming Lei wrote:
> > On Tue, Nov 25, 2025 at 03:26:39PM +0800, Gao Xiang wrote:
> > > Hi Ming and Christoph,
> > > 
> > > On 2025/11/25 11:00, Ming Lei wrote:
> > > > On Mon, Nov 24, 2025 at 01:05:46AM -0800, Christoph Hellwig wrote:
> > > > > On Mon, Nov 24, 2025 at 05:02:03PM +0800, Ming Lei wrote:
> > > > > > On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
> > > > > > > FYI, with this series I'm seeing somewhat frequent stack overflows when
> > > > > > > using loop on top of XFS on top of stacked block devices.
> > > > > > 
> > > > > > Can you share your setting?
> > > > > > 
> > > > > > BTW, there are one followup fix:
> > > > > > 
> > > > > > https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/
> > > > > > 
> > > > > > I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
> > > > > > not see stack overflow with the above fix against -next.
> > > > > 
> > > > > This was with a development tree with lots of local code.  So the
> > > > > messages aren't applicable (and probably a hint I need to reduce my
> > > > > stack usage).  The observations is that we now stack through from block
> > > > > submission context into the file system write path, which is bad for a
> > > > > lot of reasons.  journal_info being the most obvious one.
> > > > > 
> > > > > > > In other words:  I don't think issuing file system I/O from the
> > > > > > > submission thread in loop can work, and we should drop this again.
> > > > > > 
> > > > > > I don't object to drop it one more time.
> > > > > > 
> > > > > > However, can we confirm if it is really a stack overflow because of
> > > > > > calling into FS from ->queue_rq()?
> > > > > 
> > > > > Yes.
> > > > > 
> > > > > > If yes, it could be dead end to improve loop in this way, then I can give up.
> > > > > 
> > > > > I think calling directly into the lower file system without a context
> > > > > switch is very problematic, so IMHO yes, it is a dead end.
> > > I've already explained the details in
> > > https://lore.kernel.org/r/8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com
> > > 
> > > to zram folks why block devices act like this is very
> > > risky (in brief, because virtual block devices don't
> > > have any way (unlike the inner fs itself) to know enough
> > > about whether the inner fs already did something without
> > > context save (a.k.a side effect) so a new task context
> > > is absolutely necessary for virtual block devices to
> > > access backing fses for stacked usage.
> > > 
> > > So whether a nested fs can success is intrinsic to
> > > specific fses (because either they assure no complex
> > > journal_info access or save all effected contexts before
> > > transiting to the block layer.  But that is not bdev can
> > > do since they need to do any block fs.
> > 
> > IMO, task stack overflow could be the biggest trouble.
> > 
> > block layer has current->blk_plug/current->bio_list, which are
> > dealt with in the following patches:
> > 
> > https://lore.kernel.org/linux-block/20251120160722.3623884-4-ming.lei@redhat.com/
> > https://lore.kernel.org/linux-block/20251120160722.3623884-5-ming.lei@redhat.com/
> 
> I think it's the simplist thing for this because the
> context of "current->blk_plug/current->bio_list" is
> _owned_ by the block layer, so of course the block
> layer knows how to (and should) save and restore
> them.

Strictly speaking, all per-task context data is owned by task, instead
of subsystems, otherwise, it needn't to be stored in `task_struct` except
for some case just wants per-task storage.

For example of current->blk_plug, it is used by many subsystems(io_uring, FS,
mm, block layer, md/dm, drivers, ...).

> 
> > 
> > I am curious why FS task context can't be saved/restored inside block
> > layer when calling into new FS IO? Given it is just per-task info.
> 
> The problem is a block driver don't know what the upper FS
> (sorry about the terminology) did before calling into block
> layer (the task_struct and journal_info side effect is just
> the obvious one), because all FSes (mainly the write path)
> doesn't assume the current context will be transited into
> another FS context, and it could introduce any fs-specific
> context before calling into the block layer.
> 
> So it's the fs's business to save / restore contexts since
> they change the context and it's none of the block layer
> business to save and restore because the block device knows
> nothing about the specific fs behavior, it should deal with
> all block FSes.
> 
> Let's put it into another way, thinking about generic
> calling convention[1], which includes caller-saved contexts
> and callee-saved contexts.  I think the problem is here
> overally similiar, for loop devices, you know none of lower
> or upper FS behaves (because it doesn't directly know either

loop just need to know which data to save/restore.

> upper or lower FS contexts), so it should either expect the
> upper fs to save all the contexts, or to use a new kthread
> context (to emulate userspace requests to FS) for lower FS.
> 
> [1] https://en.wikipedia.org/wiki/Calling_convention

For example of lo_rw_aio_nowait(), I am wondering why the following
save/restore doesn't work if current->journal_info is the only FS
context data?

	curr_journal = current->journal_info;
	current->journal_info = NULL;		/* like handling the IO by schedule wq */
	ret = lo_rw_aio_nowait();			/* call into FS write/read_iter() from .queue_rq() */
	current->journal_info = curr_journal;


Thanks,
Ming


