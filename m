Return-Path: <linux-fsdevel+bounces-38319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C39FFA02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A61C18805EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3624419D898;
	Thu,  2 Jan 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYoF55Fo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCBD1B3937
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826309; cv=none; b=goVhNOusD+bbQaw/ph7DcvbLpwqe+u+TYMsyyZgQg0EFBN9KBmVHAKSqMPYys4wfWB0q0S70Qe1C279QnlaeIGM2iqqSQZz+eQp2ZNRIZx2buYDVFkZmC2eFCGrpgfQrcI16bZ8OqyS9X19CE0kf8XE0hyEpw8ioOKpTJMqNr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826309; c=relaxed/simple;
	bh=xt44oCgQ3wdgIDCzrQ6eYeRBbu9sOKHcHDSFrghD6yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atsssf/17UPDmatmIkjDclDzPED6n3eVhzlqete9Vg4KIWAiq5d5PqX8BPFaZ0sKViiV2afDyVn7cibY30JIIwE7wHkIu82BAnrSeuLPrWZ+B3Ts6RlYr4eWai5l1Mcme6cUBLsVFZFe/46vzd2oLC3xRfys/zdQrPdT6yintX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYoF55Fo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735826306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=un9btl8Rg7UXJMw/+5VSAnseNGsfYkqoENs0JozTivM=;
	b=VYoF55Fo1Gi6yU7R2y79ZX+t/g9Yh8ri4cPfKsitiPcJ9tGbasHk+AXUgK24cC6BRf6RnY
	PxfOmHRQjHwqQsVahwtCS7MI5sdW0+3lhJ8akH86J5rzCs7a5mW1RsVDdIoXBe42WNr/Mo
	6WpEJ2DO5S1QC7BtmY9wmzBKiL3MXZw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-1F6dtFLiNS6Y0q8UcHDvGA-1; Thu,
 02 Jan 2025 08:58:21 -0500
X-MC-Unique: 1F6dtFLiNS6Y0q8UcHDvGA-1
X-Mimecast-MFC-AGG-ID: 1F6dtFLiNS6Y0q8UcHDvGA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90CF5195608A;
	Thu,  2 Jan 2025 13:58:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 442023000197;
	Thu,  2 Jan 2025 13:58:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  2 Jan 2025 14:57:55 +0100 (CET)
Date: Thu, 2 Jan 2025 14:57:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, 1vier1@web.de
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20250102135750.GA30778@redhat.com>
References: <20241230153844.GA15134@redhat.com>
 <20241231111428.5510-1-manfred@colorfullife.com>
 <CAHk-=wjST86WXn2FRYuL7WVqwvdtXPmmsKKCuJviepeSP2=LPg@mail.gmail.com>
 <20241231202431.GA1009@redhat.com>
 <CAHk-=wiCRwRFi0kGwd_Uv+Xv4HOB-ivHyUp9it6CNSmrKT4gOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiCRwRFi0kGwd_Uv+Xv4HOB-ivHyUp9it6CNSmrKT4gOA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 12/31, Linus Torvalds wrote:
>
> On Tue, 31 Dec 2024 at 12:25, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > But let me ask another question right now. what do you think about another
> > minor change below?
>
> Probably ok. Although I'm not convinced it makes things any more readable.

OK, lets forget it for now.

> > Again, mostly to make this logic more understandable. Although I am not
> > sure I really understand it...
>
> So see commit fe67f4dd8daa ("pipe: do FASYNC notifications for every
> pipe IO, not just state changes") on why that crazy poll_usage thing
> exists.

Ah. Yes, yes, thanks, I have already read this commit/changelog, because
I was confused by the unconditional kill_fasync()'s in pipe_read/write.
So I guess I mostly understand the "edge-triggered" issues.

As for epoll, I even wrote the stupid test-case:

	int main(void)
	{
		int pfd[2], efd;
		struct epoll_event evt = { .events = EPOLLIN | EPOLLET };

		pipe(pfd);
		efd = epoll_create1(0);
		epoll_ctl(efd, EPOLL_CTL_ADD, pfd[0], &evt);

		for (int i = 0; i < 2; ++i) {
			write(pfd[1], "", 1);
			assert(epoll_wait(efd, &evt, 1, 0) == 1);
		}

		return 0;
	}

without the pipe->poll_usage check in pipe_write() assert() fails on the
2nd iteration. BTW, I think pipe_write() needs READ_ONCE(pipe->poll_usage),
KCSAN can complain.

> The
>
>   #ifdef CONFIG_EPOLL
>
> addition is straightforward enough and matches the existing comment.
>
> But you adding the FMODE_READ test should probably get a new comment
> about how we only do this for epoll readability, not for writability..

Agreed. perhaps I'll try to make V2 later...

The unconditional WRITE_ONCE(pipe->poll_usage) in pipe_poll() may hide
some subtle race between pipe_write() and the "normal" select/poll, that
is why I'd like to make ->poll_usage depend on filp->f_ep != NULL.

Thanks!

Oleg.


