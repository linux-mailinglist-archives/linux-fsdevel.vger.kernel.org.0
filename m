Return-Path: <linux-fsdevel+bounces-38455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE81A02DD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58743A59F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D962216F8E9;
	Mon,  6 Jan 2025 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmmuM0RK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B571D88AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181076; cv=none; b=V9YBWTARwjq23yxAkPSaeGDtMoBq18QMLRHFiPmVCJm+u91XJ17BU725FC5XAJ/C4nMb+ISbMLai2/7Jwtwo0b8zwKdZvKZ1GhZuKJi51jdtww9c+n8oqOifI4zUwWyqCWg+ZumFvCjHfqqmpz0grnlFYPcVHV006qyXaVvdIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181076; c=relaxed/simple;
	bh=GeX0kutMv/EdCy0K2uPu4oHGq1fEaCZqteQDEXQHLqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRawDinOkl9RCf6WtbuQk90tqgVMrUkrWcCVrLHfr0RCn7AGjO2Yeft8/NbCXwxMlmc3F8nB3p2PDn49b0ILutiFd8MriT54cEIDyWOIurmZ6hTOKxAZNkOZ96HTjHuAkP/SR2ShmOky7pSYXjxpfD7B9KaIzhVkGt9+dmMFBTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmmuM0RK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736181073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTuka9Zp85oMAGuBjGOvpZrAuQqblqW478yDuQCv4WE=;
	b=CmmuM0RK6bUyCJeJxvRNhCCOfLzwB9D0yrfvHqinj4gf1BOoo3M3CbP9sTlwU8AS30n/nC
	cwlpoV2KPREMHxOGTfJL9xkO51szkRk3Ct1zB1DQredqyGYQ1WZpfOp9B7CvFi0h2OZCHK
	JQmIgDYAtyhhv5mWySRvznKsPw4HD7Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-FYIl9aG_NYuzvaOba38U4A-1; Mon,
 06 Jan 2025 11:31:10 -0500
X-MC-Unique: FYIl9aG_NYuzvaOba38U4A-1
X-Mimecast-MFC-AGG-ID: FYIl9aG_NYuzvaOba38U4A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79AA71956058;
	Mon,  6 Jan 2025 16:31:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.102])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8F4B61956088;
	Mon,  6 Jan 2025 16:31:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  6 Jan 2025 17:30:43 +0100 (CET)
Date: Mon, 6 Jan 2025 17:30:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: wakeup_pipe_readers/writers() && pipe_poll()
Message-ID: <20250106163038.GE7233@redhat.com>
References: <20241229135737.GA3293@redhat.com>
 <20250102163320.GA17691@redhat.com>
 <CAHk-=wj9Hr4PBobc13ZEv3HvFfpiZYrWX2-t5F62TXmMJoL5ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9Hr4PBobc13ZEv3HvFfpiZYrWX2-t5F62TXmMJoL5ZA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/04, Linus Torvalds wrote:
>
> On Thu, 2 Jan 2025 at 08:33, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I was going to send a one-liner patch which adds mb() into pipe_poll()
> > but then I decided to make even more spam and ask some questions first.
>
> poll functions are not *supposed* to need memory barriers.
...
> But no, this is most definitely not a pipe-only thing.

Agreed, that is why I didn't send the patch which adds mb() into pipe_poll().

> They are supposed to do "poll_wait()" and then not need any more
> serialization after that, because we either
>
>  (a) have a NULL wait-address, in which case we're not going to sleep
> and this is just a "check state"

To be honest, I don't understand the wait_address check in poll_wait(),
it seems that wait_address is never NULL.

But ->_qproc can be NULL if do_poll/etc does another iteration after
poll_schedule_timeout(), in this case we can sleep again. But this
case is fine.

>  (b) the waiting function is supposed to do add_wait_queue() (usually
> by way of __pollwait) and that should be a sufficient barrier to
> anybody who does a wakeup

Yes.

> And this makes me think that the whole comment above
> waitqueue_active() is just fundamentally wrong. The smp_mb() is *not*
> sufficient in the sequence
>
>     smp_mb();
>     if (waitqueue_active(wq_head))
>         wake_up(wq_head);
>
> because while it happens to work wrt prepare_to_wait() sequences, is
> is *not* against other users of add_wait_queue().

Well, this comment doesn't look wrong to me, but perhaps it can be
more clear. It should probably explain that this pseudo code is only
correct because the waiter has a barrier before "if (@cond)" which
pairs with smp_mb() above waitqueue_active(). It even says

	prepare_to_wait(&wq_head, &wait, state);
	// smp_mb() from set_current_state()

but perhaps this is not 100% clear.

> But I think this poll() thing is very much an example of this *not*
> being valid, and I don't think it's in any way pipe-specific.

Yes.

> So maybe we really do need to add the memory barrier to
> __add_wait_queue(). That's going to be painful, particularly with lots
> of users not needing it because they have the barrier in all the other
> places.

Yes, that is why I don't really like the idea to add mb() into
__add_wait_queue().

> End result: maybe adding it just to __pollwait() is the thing to do,
> in the hopes that non-poll users all use the proper sequences.

That is what I tried to propose. Will you agree with this change?
We can even use smp_store_mb(), say

	@@ -224,11 +224,12 @@ static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
		if (!entry)
			return;
		entry->filp = get_file(filp);
	-	entry->wait_address = wait_address;
		entry->key = p->_key;
		init_waitqueue_func_entry(&entry->wait, pollwake);
		entry->wait.private = pwq;
		add_wait_queue(wait_address, &entry->wait);
	+	// COMMENT
	+	smp_store_mb(entry->wait_address, wait_address);

Oleg.


