Return-Path: <linux-fsdevel+bounces-19522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7E18C667E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 14:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346AC1F223E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D271B84A5E;
	Wed, 15 May 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVcjqQbO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C49D7441E
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777466; cv=none; b=PQSHi0Mq9rywYBugdIrONvs7uLIWyZnGxavITeoUXdNsYyS7/MNRRRYNb9kpJ6SXv8IthkDj6P6nhYoeHrlLpCR+eWzqOFbuxFPR+/WwfTJRgkAxtWyhAHcjN6dKUmhW2OtzE3TfAkUU7G08yfLNZyIOCAHOFW/lelhZTTQDE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777466; c=relaxed/simple;
	bh=YubN0gIftBgJpOTgJByjSOdEkhoFUK066HCDBKY3Hlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPmnQcrLKg9l86FakG253MxL64BylFOk8Rn8ly/X0aFNlQPf1v/KcfnfcS+Ip6JSlPSFt8WZb72XQl3COa862CMtA4Fn6JXxE3nZ2iSXH0xt0F1/vdhf1ezjXzwJSGuqkCx8mWxswiJaZQMxWJyATKNZa665rWD7cvA7yKv2LOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVcjqQbO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715777463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0tRd5oikkwXvkBagrbVtw4/yuIwLwdR1d/3o6srHP1U=;
	b=NVcjqQbOjAITbSaUhYhZZcJS6dHDDQOJCXIvTvpjWHEY6A4rVrNM92QfPLYWv9Eg8K05bQ
	yYEmWYjJt9qDcdX+CQs7G/Synz0WiJ5wee0C6dRHCivEgZZ6IyRq2hRULzJqJXOhXWavkD
	taL91M10z4Z6K96RK0PQ3bwPCli0plc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-POCGVL3zNPmxVDYqGTjeCg-1; Wed, 15 May 2024 08:50:59 -0400
X-MC-Unique: POCGVL3zNPmxVDYqGTjeCg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 221AA101A52C;
	Wed, 15 May 2024 12:50:58 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.194.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 806F2400059;
	Wed, 15 May 2024 12:50:52 +0000 (UTC)
Date: Wed, 15 May 2024 08:50:49 -0400
From: Phil Auld <pauld@redhat.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20240515125049.GA29065@lorien.usersys.redhat.com>
References: <20240514234112.792989-1-qyousef@layalina.io>
 <20240514235851.GA6845@lorien.usersys.redhat.com>
 <20240515083238.GA40213@noisy.programming.kicks-ass.net>
 <20240515112050.GA25724@lorien.usersys.redhat.com>
 <20240515120613.m6ajyxyyxhat7eb5@airbuntu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515120613.m6ajyxyyxhat7eb5@airbuntu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Wed, May 15, 2024 at 01:06:13PM +0100 Qais Yousef wrote:
> On 05/15/24 07:20, Phil Auld wrote:
> > On Wed, May 15, 2024 at 10:32:38AM +0200 Peter Zijlstra wrote:
> > > On Tue, May 14, 2024 at 07:58:51PM -0400, Phil Auld wrote:
> > > > 
> > > > Hi Qais,
> > > > 
> > > > On Wed, May 15, 2024 at 12:41:12AM +0100 Qais Yousef wrote:
> > > > > rt_task() checks if a task has RT priority. But depends on your
> > > > > dictionary, this could mean it belongs to RT class, or is a 'realtime'
> > > > > task, which includes RT and DL classes.
> > > > > 
> > > > > Since this has caused some confusion already on discussion [1], it
> > > > > seemed a clean up is due.
> > > > > 
> > > > > I define the usage of rt_task() to be tasks that belong to RT class.
> > > > > Make sure that it returns true only for RT class and audit the users and
> > > > > replace them with the new realtime_task() which returns true for RT and
> > > > > DL classes - the old behavior. Introduce similar realtime_prio() to
> > > > > create similar distinction to rt_prio() and update the users.
> > > > 
> > > > I think making the difference clear is good. However, I think rt_task() is
> > > > a better name. We have dl_task() still.  And rt tasks are things managed
> > > > by rt.c, basically. Not realtime.c :)  I know that doesn't work for deadline.c
> > > > and dl_ but this change would be the reverse of that pattern.
> > > 
> > > It's going to be a mess either way around, but I think rt_task() and
> > > dl_task() being distinct is more sensible than the current overlap.
> > >
> > 
> > Yes, indeed.
> > 
> > My point was just to call it rt_task() still. 
> 
> It is called rt_task() still. I just added a new realtime_task() to return true
> for RT and DL. rt_task() will return true only for RT now.
> 
> How do you see this should be done instead? I'm not seeing the problem.
>

Right, sorry. I misread your commit message completely and then all the
places where you changed rt_task() to realtime_task() fit my misreading.

rt_task() means rt class and realtime_task does what rt_task() used to do.
That's how I would do it, too :)


(Re)

Reviewed-by: Phil Auld <pauld@redhat.com>

Cheers,
Phil

-- 


