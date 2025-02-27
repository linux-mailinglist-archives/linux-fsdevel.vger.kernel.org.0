Return-Path: <linux-fsdevel+bounces-42763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6379AA484F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E067A4F61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C01B4155;
	Thu, 27 Feb 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EASzs+oW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36091A8F89
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673756; cv=none; b=D/EPX9VbVEvNHDwon7bOSZ0Nk/leuTMbx488QHWW1wxJbgJqa//DTFfioYa873kOn28cWGMakaBnhnvMbzFcKWfKrE2iQ+D1o6GG2q/iSQ0S0XKT3M5Y50EEX764JVS8QHGD5L6Dwcc4qmz5futjiaxMzmyWIdWM8xLfMmrsX24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673756; c=relaxed/simple;
	bh=yrMuOSjm/jqiKg0lhnawuMT9c85TQRcYVvXqCxieIUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDnpq5myrtwVXCjujKjjNmrnyt38wb4bhvWmksDl4xlUILdU77CdsVH5yAmihCbQuLvwNb9zRAKCJH+mPHiCuMPnNXWhXJprn+kckXW3sg07g8aIn7d5mg4IpGIhxGZLsej2FdsoLaJmIudvXLFDE4FySsq8hXZxbx6w/bTdUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EASzs+oW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740673753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmLTV3AzY05mWRUecIUfKc1ZwM7Hko7ZFa2ydUcdbps=;
	b=EASzs+oW7l28uGAm/awdxLhaiWpQrv2TrbQ9wWcy5FbhNguIWlPcX8vJ9Cd9jiOLL1sMyN
	mdtIkrJdn5E0r8ymWyCHRoOc9ZacSfZ8Cl6nywQIub7qJN3gpu/90/mZs5R7b0vTMS0DYt
	cp7sJe7RpH6yXGeNz6C3OGTQLPkFxb4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-2jbdCydEN-CDxZIecaeR2g-1; Thu,
 27 Feb 2025 11:29:10 -0500
X-MC-Unique: 2jbdCydEN-CDxZIecaeR2g-1
X-Mimecast-MFC-AGG-ID: 2jbdCydEN-CDxZIecaeR2g_1740673749
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83C4A1800878;
	Thu, 27 Feb 2025 16:29:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.102])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 020461944D02;
	Thu, 27 Feb 2025 16:29:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 27 Feb 2025 17:28:38 +0100 (CET)
Date: Thu, 27 Feb 2025 17:28:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250227162831.GC25639@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250227125040.GA25639@redhat.com>
 <CAGudoHHKf_FXrrNJQCqvC50QSV87u+8sRaPQwm6rWvPeirO2_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHKf_FXrrNJQCqvC50QSV87u+8sRaPQwm6rWvPeirO2_A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 02/27, Mateusz Guzik wrote:
>
> On Thu, Feb 27, 2025 at 1:51 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Sapkal, I don't think this can explain the hang, receiver()->read()
> > should wake this writer later anyway. But could you please retest
> > with the patch below?
> >
> > Thanks,
> >
> > Oleg.
> > ---
> >
> > diff --git a/fs/pipe.c b/fs/pipe.c
> > index b0641f75b1ba..222881559c30 100644
> > --- a/fs/pipe.c
> > +++ b/fs/pipe.c
> > @@ -455,6 +455,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
> >          * page-aligns the rest of the writes for large writes
> >          * spanning multiple pages.
> >          */
> > +again:
> >         head = pipe->head;
> >         was_empty = pipe_empty(head, pipe->tail);
> >         chars = total_len & (PAGE_SIZE-1);
> > @@ -559,8 +560,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
> >                 kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> >                 wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
> >                 mutex_lock(&pipe->mutex);
> > -               was_empty = pipe_empty(pipe->head, pipe->tail);
> >                 wake_next_writer = true;
> > +               goto again;
> >         }
> >  out:
> >         if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
> >
>
> I think this is buggy.
>
> You get wakeups also when the last reader goes away. The for loop you
> are jumping out of makes sure to check for the condition, same for the
> first mutex acquire. With this goto you can get a successful write
> instead of getting SIGPIPE. iow this should goto few lines higher.

Yes, yes, and then we need to remove another pipe->readers check
in the main loop.

> I am not sure about the return value. The for loop bumps ret with each
> write, but the section you are jumping to overwrites it.

Ah, yes, thanks, I missed that.

OK, I'll make another one tomorrow, I need to run away.

Until then, it would be nice to test this patch with hackbench anyway.

> However, I do think something may be going on with the "split" ops,
> which is why I suggested going from 100 bytes where the bug was
> encountered to 128 for testing purposes. If that cleared it, that
> would be nice for sure. :>

Yes, but note that the same scenario can happen with 128 bytes as well.
It doesn't really matter how many bytes < PAGE_SIZE the sleeping writer
needs to write, another writer can steal the buffer released by the
last reader in any case.

Thanks!

Oleg.


