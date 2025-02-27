Return-Path: <linux-fsdevel+bounces-42757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E44A47FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 14:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56857A69BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9622F177;
	Thu, 27 Feb 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcnkIGR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558201BF24
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664411; cv=none; b=E9U/aXaXWQyyqbUmcFRmv4PKzpgJxzmDn3ZLasfWZvRCrB0gwdjzVTRuaYPQiJm6D52ddSXTf/Ihvvrhz1ossQrVikVLwVYYo9icRpzwUPSDm2hb1a8aQrgEDnnDsy8dA4Q1Fg+nXAa1FPLeuSOvYVORLeaz9fX75+k63yamZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664411; c=relaxed/simple;
	bh=T1CaZpJQma5SSl9LTn/59DpYxDdZIFxagXEuc5TvuQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOw5bLDqEkrB8hYpnkpBQAoqNcNf3pt3R+84QXaKqWhEw/8N7KV9Q+9bMxnmdFHy0YzE7AhHxSP5hqcxldbelP+Zd/q4wDUarqdLzFKeltusGXEu416Mnz+yFeNvjNGhbk3RKlp1wHSoJc8T28WPAx73TsXc0ylSO7T+/jokZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcnkIGR3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740664408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RL6Y5H30649Urq1xqWEDkjGFFeWUivLSNvhpjDkGyQQ=;
	b=LcnkIGR3cdH3z039Ej6VjyNGS5DnGtxBKPMI8NAvOY0ZVBHcR+4MbwpLEA7SWEAUc69+/5
	fcgqYPm5A5uURyVLJ7evYfM/YMzvtpDPHMs2YwjCkytBktTBatzLLCkluCy6szHR9bYW3Z
	Dc3u3QoVxqwAEKIHfr/xrhqDltMSntw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-XqlCnelDNpCzSIWsExUyTw-1; Thu,
 27 Feb 2025 08:53:25 -0500
X-MC-Unique: XqlCnelDNpCzSIWsExUyTw-1
X-Mimecast-MFC-AGG-ID: XqlCnelDNpCzSIWsExUyTw_1740664403
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 136181954B20;
	Thu, 27 Feb 2025 13:53:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.102])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2014519560AE;
	Thu, 27 Feb 2025 13:53:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 27 Feb 2025 14:52:52 +0100 (CET)
Date: Thu, 27 Feb 2025 14:52:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250227135240.GB25639@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250227125040.GA25639@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227125040.GA25639@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Forgot to mention...

Even if this patch is likely "offtopic", it probably makes sense.
However, it is "incomplete" in that there are other scenarious.

Again, the pipe is full. A writer W1 tries to write 4096 bytes and
sleeps. A writer W2 tries to write 1 byte and sleeps too.

A reader reads 4096 bytes, updates pipe->tail and wakes W1.

Another writer comes, writes 1 byte and "steals" the buffer released
by the reader.

W1 sleeps again, this is correct. But nobody will wake W2 which could
succeed.

This (and the previous more simple scenario) means that

	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
		wake_next_writer = false;

before return in anon_pipe_write() is not really right in this sense.

Oleg.

On 02/27, Oleg Nesterov wrote:
>
> Hmm...
> 
> Suppose that pipe is full, a writer W tries to write a single byte
> and sleeps on pipe->wr_wait.
> 
> A reader reads PAGE_SIZE bytes, updates pipe->tail, and wakes W up.
> 
> But, before the woken W takes pipe->mutex, another writer comes and
> writes 1 byte. This updates ->head and makes pipe_full() true again.
> 
> Now, W could happily merge its "small" write into the last buffer,
> but it will sleep again, despite the fact the last buffer has room
> for 4095 bytes.
> 
> Sapkal, I don't think this can explain the hang, receiver()->read()
> should wake this writer later anyway. But could you please retest
> with the patch below?
> 
> Thanks,
> 
> Oleg.
> ---
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index b0641f75b1ba..222881559c30 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -455,6 +455,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  	 * page-aligns the rest of the writes for large writes
>  	 * spanning multiple pages.
>  	 */
> +again:
>  	head = pipe->head;
>  	was_empty = pipe_empty(head, pipe->tail);
>  	chars = total_len & (PAGE_SIZE-1);
> @@ -559,8 +560,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>  		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
>  		mutex_lock(&pipe->mutex);
> -		was_empty = pipe_empty(pipe->head, pipe->tail);
>  		wake_next_writer = true;
> +		goto again;
>  	}
>  out:
>  	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))


