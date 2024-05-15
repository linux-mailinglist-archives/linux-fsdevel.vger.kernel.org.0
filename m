Return-Path: <linux-fsdevel+bounces-19519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B628C6574
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 13:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61511F2403D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C2D6F077;
	Wed, 15 May 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2+/BI29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C86EB68
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715772061; cv=none; b=uKQPfLkYV17ycP9v7v/3nCHYcdsIQyF1gSUkXn+zG9VTthAu6Fvn6xA2dk/VC+qjp4Opv0U8GxRciB5c2ZOxq0u02B8d7jtli9vCRsjEgKJahsBUwx2SNoc1IFNIBHKW5k9Chzl3zCfEu/9j7ll7HVg3/gRVOlghsEP7S97MAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715772061; c=relaxed/simple;
	bh=zr1CnaLoqVSMzk7K+1heCWhXCxQ9Rz2pG86DBXmZlGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhGUnt4OQjczhBq7h2xu+j/Sdjxo3wD1/6RjIXKA+pBKo1YJhweMluHbASIyQiwMcy5gXaSSqHaSrEaUXGoC5hSm1WNJ6Ed6PZTKLuJMhE1IfoUIt5jiqrZy4U+wf+xjKC/VYh33mn93knHE8V46AHXIr1D+eK4g7FRMzUSTvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2+/BI29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715772058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xb1sVzNBfC6f+qv5BV5/1LiBTZinzT2pJiB886gVfWo=;
	b=Z2+/BI29EcE08sDWf/yOwLwa1uA3mJ0uy4w7B9Dtp9XLUq3xzXQgtOXRzyOqRbA+uW+2sc
	lMjrBD9HYBIHI9PfX/1BOV/rTnDQGqJjRpV1GntQRVq8gKeaVnVrsxGoutghqOsiq8CoPr
	YM4S3gl0PyDGyn5WRemyvOIGqzVqI0M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-vuSAg_TpPFmNlYbMwCy-Yg-1; Wed, 15 May 2024 07:20:55 -0400
X-MC-Unique: vuSAg_TpPFmNlYbMwCy-Yg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C9E7801211;
	Wed, 15 May 2024 11:20:54 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D8193C27;
	Wed, 15 May 2024 11:20:52 +0000 (UTC)
Date: Wed, 15 May 2024 07:20:50 -0400
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] sched/rt: Clean up usage of rt_task()
Message-ID: <20240515112050.GA25724@lorien.usersys.redhat.com>
References: <20240514234112.792989-1-qyousef@layalina.io>
 <20240514235851.GA6845@lorien.usersys.redhat.com>
 <20240515083238.GA40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515083238.GA40213@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Wed, May 15, 2024 at 10:32:38AM +0200 Peter Zijlstra wrote:
> On Tue, May 14, 2024 at 07:58:51PM -0400, Phil Auld wrote:
> > 
> > Hi Qais,
> > 
> > On Wed, May 15, 2024 at 12:41:12AM +0100 Qais Yousef wrote:
> > > rt_task() checks if a task has RT priority. But depends on your
> > > dictionary, this could mean it belongs to RT class, or is a 'realtime'
> > > task, which includes RT and DL classes.
> > > 
> > > Since this has caused some confusion already on discussion [1], it
> > > seemed a clean up is due.
> > > 
> > > I define the usage of rt_task() to be tasks that belong to RT class.
> > > Make sure that it returns true only for RT class and audit the users and
> > > replace them with the new realtime_task() which returns true for RT and
> > > DL classes - the old behavior. Introduce similar realtime_prio() to
> > > create similar distinction to rt_prio() and update the users.
> > 
> > I think making the difference clear is good. However, I think rt_task() is
> > a better name. We have dl_task() still.  And rt tasks are things managed
> > by rt.c, basically. Not realtime.c :)  I know that doesn't work for deadline.c
> > and dl_ but this change would be the reverse of that pattern.
> 
> It's going to be a mess either way around, but I think rt_task() and
> dl_task() being distinct is more sensible than the current overlap.
>

Yes, indeed.

My point was just to call it rt_task() still. 


Cheers,
Phil

> > > Move MAX_DL_PRIO to prio.h so it can be used in the new definitions.
> > > 
> > > Document the functions to make it more obvious what is the difference
> > > between them. PI-boosted tasks is a factor that must be taken into
> > > account when choosing which function to use.
> > > 
> > > Rename task_is_realtime() to task_has_realtime_policy() as the old name
> > > is confusing against the new realtime_task().
> 
> realtime_task_policy() perhaps?
> 

-- 


