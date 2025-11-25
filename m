Return-Path: <linux-fsdevel+bounces-69785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE8C84F14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E201F4E14B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6180E31A81A;
	Tue, 25 Nov 2025 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KN+870vQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70721D5151
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073154; cv=none; b=WLjMKNp4qOb2nVs89DJ0pV6Fna96/x+4qer8onIxdx/NDPmo0e5Mf/cuFvvkbmDg5cEoYUzFYgL/V6O8Qs1fxFMFSkAADxe0iBFzNtDfkmTd8Y/S7CKJPc0PaNDVNG51jBxyM9tUExfile3Xz87638f8wfHDDWYv/ZPvhaIix6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073154; c=relaxed/simple;
	bh=lgoOPaKPXztfjj98p3vcOUq62BZpQ8lIYzng5I9rylM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EknGAMAsUSha/0VaxAy/6qqxSmVTa871+5JnW6m+j7Wa7PFEE+gvSr78kimoeM7T1gXNa+ow/pfbmi0QcysccFuXwUHk7mdXjF6AK94edbtBI5+ajiRr+zvdc+0kmpRlm+TJIDNLfTYA37cnwD5cVvTTYbXZ42zy57xlq30euJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KN+870vQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764073151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rykTlfNsj1/E5Fo/PWign2TZV68m9oO/+87UHCcO/EQ=;
	b=KN+870vQHyO55nxW9FkHQdc6JW5QrbOrAGTqY6BoK034g2HCVuLVK8jD1uZSb0yq/Nd6eH
	RWLa34GvIEB52LOow+IbYQYunPs3RT85UwdkRLvGG3TcfAePOKNSONg8T2Zkg2LF+t9w8D
	YetOEp9u1tL27YlCYcqRg0tJKhfoew8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-opdar_KeMIqiS0Mjt5NOyA-1; Tue,
 25 Nov 2025 07:19:10 -0500
X-MC-Unique: opdar_KeMIqiS0Mjt5NOyA-1
X-Mimecast-MFC-AGG-ID: opdar_KeMIqiS0Mjt5NOyA_1764073149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 113E6180049F;
	Tue, 25 Nov 2025 12:19:08 +0000 (UTC)
Received: from fedora (unknown [10.72.116.210])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15517195608E;
	Tue, 25 Nov 2025 12:19:01 +0000 (UTC)
Date: Tue, 25 Nov 2025 20:18:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <aSWeq4dN69WsH2EI@fedora>
References: <aSQfC2rzoCZcMfTH@fedora>
 <aSQf6gMFzn-4ohrh@infradead.org>
 <aSUbsDjHnQl0jZde@fedora>
 <db90b7b3-bf94-4531-8329-d9e0dbc6a997@linux.alibaba.com>
 <aSV0sDZGDoS-tLlp@fedora>
 <00bc891e-4137-4d93-83a5-e4030903ffab@linux.alibaba.com>
 <aSWHx3ynP9Z_6DeY@fedora>
 <4a5ec383-540b-461d-9e53-15593a22a61a@linux.alibaba.com>
 <aSWXeIVjArYsAbyf@fedora>
 <dbff8d43-3313-459b-9c9f-d431fcae0249@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbff8d43-3313-459b-9c9f-d431fcae0249@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Nov 25, 2025 at 07:58:09PM +0800, Gao Xiang wrote:
> 
> 
> On 2025/11/25 19:48, Ming Lei wrote:
> > On Tue, Nov 25, 2025 at 06:57:15PM +0800, Gao Xiang wrote:
> > > 
> > > 
> > > On 2025/11/25 18:41, Ming Lei wrote:
> > > > On Tue, Nov 25, 2025 at 05:39:17PM +0800, Gao Xiang wrote:
> > > > > Hi Ming,
> > > > > 
> > > > > On 2025/11/25 17:19, Ming Lei wrote:
> > > > > > On Tue, Nov 25, 2025 at 03:26:39PM +0800, Gao Xiang wrote:
> > > > > > > Hi Ming and Christoph,
> > > > > > > 
> > > > > > > On 2025/11/25 11:00, Ming Lei wrote:
> > > > > > > > On Mon, Nov 24, 2025 at 01:05:46AM -0800, Christoph Hellwig wrote:
> > > > > > > > > On Mon, Nov 24, 2025 at 05:02:03PM +0800, Ming Lei wrote:
> > > > > > > > > > On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
> > > > > > > > > > > FYI, with this series I'm seeing somewhat frequent stack overflows when
> > > > > > > > > > > using loop on top of XFS on top of stacked block devices.
> > > > > > > > > > 
> > > > > > > > > > Can you share your setting?
> > > > > > > > > > 
> > > > > > > > > > BTW, there are one followup fix:
> > > > > > > > > > 
> > > > > > > > > > https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/
> > > > > > > > > > 
> > > > > > > > > > I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
> > > > > > > > > > not see stack overflow with the above fix against -next.
> > > > > > > > > 
> > > > > > > > > This was with a development tree with lots of local code.  So the
> > > > > > > > > messages aren't applicable (and probably a hint I need to reduce my
> > > > > > > > > stack usage).  The observations is that we now stack through from block
> > > > > > > > > submission context into the file system write path, which is bad for a
> > > > > > > > > lot of reasons.  journal_info being the most obvious one.
> > > > > > > > > 
> > > > > > > > > > > In other words:  I don't think issuing file system I/O from the
> > > > > > > > > > > submission thread in loop can work, and we should drop this again.
> > > > > > > > > > 
> > > > > > > > > > I don't object to drop it one more time.
> > > > > > > > > > 
> > > > > > > > > > However, can we confirm if it is really a stack overflow because of
> > > > > > > > > > calling into FS from ->queue_rq()?
> > > > > > > > > 
> > > > > > > > > Yes.
> > > > > > > > > 
> > > > > > > > > > If yes, it could be dead end to improve loop in this way, then I can give up.
> > > > > > > > > 
> > > > > > > > > I think calling directly into the lower file system without a context
> > > > > > > > > switch is very problematic, so IMHO yes, it is a dead end.
> > > > > > > I've already explained the details in
> > > > > > > https://lore.kernel.org/r/8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com
> > > > > > > 
> > > > > > > to zram folks why block devices act like this is very
> > > > > > > risky (in brief, because virtual block devices don't
> > > > > > > have any way (unlike the inner fs itself) to know enough
> > > > > > > about whether the inner fs already did something without
> > > > > > > context save (a.k.a side effect) so a new task context
> > > > > > > is absolutely necessary for virtual block devices to
> > > > > > > access backing fses for stacked usage.
> > > > > > > 
> > > > > > > So whether a nested fs can success is intrinsic to
> > > > > > > specific fses (because either they assure no complex
> > > > > > > journal_info access or save all effected contexts before
> > > > > > > transiting to the block layer.  But that is not bdev can
> > > > > > > do since they need to do any block fs.
> > > > > > 
> > > > > > IMO, task stack overflow could be the biggest trouble.
> > > > > > 
> > > > > > block layer has current->blk_plug/current->bio_list, which are
> > > > > > dealt with in the following patches:
> > > > > > 
> > > > > > https://lore.kernel.org/linux-block/20251120160722.3623884-4-ming.lei@redhat.com/
> > > > > > https://lore.kernel.org/linux-block/20251120160722.3623884-5-ming.lei@redhat.com/
> > > > > 
> > > > > I think it's the simplist thing for this because the
> > > > > context of "current->blk_plug/current->bio_list" is
> > > > > _owned_ by the block layer, so of course the block
> > > > > layer knows how to (and should) save and restore
> > > > > them.
> > > > 
> > > > Strictly speaking, all per-task context data is owned by task, instead
> > > > of subsystems, otherwise, it needn't to be stored in `task_struct` except
> > > > for some case just wants per-task storage.
> > > > 
> > > > For example of current->blk_plug, it is used by many subsystems(io_uring, FS,
> > > > mm, block layer, md/dm, drivers, ...).
> > > > 
> > > > > 
> > > > > > 
> > > > > > I am curious why FS task context can't be saved/restored inside block
> > > > > > layer when calling into new FS IO? Given it is just per-task info.
> > > > > 
> > > > > The problem is a block driver don't know what the upper FS
> > > > > (sorry about the terminology) did before calling into block
> > > > > layer (the task_struct and journal_info side effect is just
> > > > > the obvious one), because all FSes (mainly the write path)
> > > > > doesn't assume the current context will be transited into
> > > > > another FS context, and it could introduce any fs-specific
> > > > > context before calling into the block layer.
> > > > > 
> > > > > So it's the fs's business to save / restore contexts since
> > > > > they change the context and it's none of the block layer
> > > > > business to save and restore because the block device knows
> > > > > nothing about the specific fs behavior, it should deal with
> > > > > all block FSes.
> > > > > 
> > > > > Let's put it into another way, thinking about generic
> > > > > calling convention[1], which includes caller-saved contexts
> > > > > and callee-saved contexts.  I think the problem is here
> > > > > overally similiar, for loop devices, you know none of lower
> > > > > or upper FS behaves (because it doesn't directly know either
> > > > 
> > > > loop just need to know which data to save/restore.
> > > 
> > > I've said there is no clear list of which data needs to be
> > > saved/restored.
> > > 
> > > FSes can do _anything_. Maybe something in `current` needs
> > > to be saved, but anything that uses `current`/PID as
> > > a mapping key also needs to be saved, e.g., arbitrary
> > > 
> > > `hash_table[current]` or `context_table[current->pid]`.
> > > 
> > > Again, because not all filesystems allow nesting by design:
> > > Linux kernel doesn't need block filesystem to be nested.
> > 
> > OK, got it, thanks for the sharing.
> > 
> > BTW, block layer actually uses current->bio_list to avoid nested bio
> > submission.
> > 
> > The similar trick could be played on FS ->read_iter/->write_iter() over
> > `kiocb` for avoiding nested FS IO too, but not sure if there is real
> > big use case.
> 
> I don't think it's much similar, `current->bio_list` just deals
> with the single BIO concept, but what nested fses need to deal

No, it is not, it can be one tree of BIOs in case of dm/md.

> with is much complicated.

Care for sharing why/what the complicated is?

Anyway it is just one raw idea, and the devil is always in the details.


Thanks, 
Ming


