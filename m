Return-Path: <linux-fsdevel+bounces-43164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A067CA4ED66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AEBD7A93CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F6525F78A;
	Tue,  4 Mar 2025 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3tVnVrx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD22517AB
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116773; cv=none; b=YnbQGUpysQGAB3CizA7kq7q1+pb05iBDv4XHfCRj9hGpw7QmfuTppetIq+N3xA5fOUuMVV/6KzMoUxebg3BgOMygENXCg2tgXhI/lZJwhsbU+BtuxJF+Ph5qZkEm9HS9yrCmkD/1WsDCKlye1lzkCrFB4Jvg/s2lypN878Tm9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116773; c=relaxed/simple;
	bh=OQA+2QFOcgjj6uSfiTcIy6Fu6+7/+zNnoI9reAWPQSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLiD2vl3SRKZQYHmzCV+GV9Iv344B8K443iux9OuGgVNkU1S+mjsi4D4YPRCgxXdnPTGwH7DPRgu8eDKXHiBB6epFZSpm1iZTYbtISPxQRibA1uCcxyN/6+dRIwVo/Dqi7xOu+pqeA4AwAYXxGXxNLpXYN/dGc4MEwROp8bdazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3tVnVrx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741116770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXl4nfp4fR0Yavdrh2eSsQ01fUfNdG7jydctAhRfRE8=;
	b=Y3tVnVrx0OkUinbCf0Z7t6LCyf0xY/QBqAiybQMP1QR4xXBfGmNCS24x0kKWVuUhlzaF9l
	2EzKjrRENR6K/3UHZlo73hRmMDYMPmX28HslZBRxhwUIVAkOUmgq9BGnN8MJbYCys5zIpf
	OA/s2amEr8nltBRHjjkd8oYLujrcv/s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-ozIiO8-vN66lw4xfV_wuPA-1; Tue,
 04 Mar 2025 14:32:37 -0500
X-MC-Unique: ozIiO8-vN66lw4xfV_wuPA-1
X-Mimecast-MFC-AGG-ID: ozIiO8-vN66lw4xfV_wuPA_1741116756
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B75F71801A1A;
	Tue,  4 Mar 2025 19:32:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 802B9300018D;
	Tue,  4 Mar 2025 19:32:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 20:32:04 +0100 (CET)
Date: Tue, 4 Mar 2025 20:32:00 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: pipes && EPOLLET, again
Message-ID: <20250304193137.GE5756@redhat.com>
References: <20250303230409.452687-1-mjguzik@gmail.com>
 <20250303230409.452687-2-mjguzik@gmail.com>
 <20250304140726.GD26141@redhat.com>
 <20250304154410.GB5756@redhat.com>
 <CAHk-=wj1V4wQBPUuhWRwmQ7Nfp2WJrH=yAv-v0sP-jXBKGoPdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj1V4wQBPUuhWRwmQ7Nfp2WJrH=yAv-v0sP-jXBKGoPdw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/04, Linus Torvalds wrote:
>
> On Tue, 4 Mar 2025 at 05:45, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Don't we need the trivial one-liner below anyway?
>
> See this email of mine:
>
>   https://lore.kernel.org/all/CAHk-=wiCRwRFi0kGwd_Uv+Xv4HOB-ivHyUp9it6CNSmrKT4gOA@mail.gmail.com/
>
> and the last paragraph in particular.
>
> The whole "poll_usage" thing is a kernel *hack* to deal with broken
> user space that expected garbage semantics that aren't real, and were
> never real.

Yes agreed. But we can make this hack more understandable. But as I said,
this is off-topic right now.

> introduced that completely bogus hack to say "ok, we'll send these
> completely wrong extraneous events despite the fact that nothing has
> changed, because some broken user space program was written to expect
> them".

Yes, but since we already have this hack:

> That program is buggy, and we're not adding new hacks for new bugs.

Yes, but see below...

> If you ask for an edge-triggered EPOLL event, you get an *edge*
> triggered EPOLL event. And there is no edge - the pipe was already
> readable, no edge anywhere in sight.

Yes, the pipe was already readable before before fork, but this condition
was already "consumed" by the 1st epoll_wait(EPOLLET). Please see below.

> If anything, we might consider removing the crazy "poll_usage" hack in
> the (probably futile) hope that user space has been fixed.

This would be the best option ;) Until then:

I agree that my test case is "buggy", but afaics it is not buggier than
userspace programs which rely on the unconditional kill_fasync()'s in
pipe_read/pipe_write?

So. anon_pipe_write() does

	if (was_empty)
		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);

before wait_event(pipe->wr_wait), but before return it does

	if (was_empty || pipe->poll_usage)
		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);

and this looks confusing to me.

If pipe_write() doesn't take poll_usage into account before wait_event(wr_wait),
then it doesn't need kill_fasync() too?

So I won't argue, but why not make both cases more consistent?

Oleg.


