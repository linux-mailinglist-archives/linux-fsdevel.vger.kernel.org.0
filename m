Return-Path: <linux-fsdevel+bounces-43094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE03A4DE18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280DF188C9C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DB8202F8C;
	Tue,  4 Mar 2025 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWWw5H0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63F1FFC50
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091741; cv=none; b=e8ZETfyAGYkY5NRtOnJvrKNz5OLp2rXlbjp5tLtpofxST4gq/GXPYwVFWUTIL6UdhMN98EAlFkDIkU8QP3sdDlC+swYH9XDpdJys42GcZhXsIrbRIjgSmUuhhIMw0/JJ50D26af7NzPGI7ImwugIc98SHMsv+syaMKszMvZb0H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091741; c=relaxed/simple;
	bh=uL6+1En3b/0r6PSqeewPiCn4Lwj0G/yUyEUzcoQrjrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa5+f87bHGXXGJa2/LKGQDZfCVynuj4QSpFNFmc1YF3iS/vy+F/z6BKKRfh3NkxhCHzy94X8/9W1UGcTVYbnp7QQKxgc6++2dAyfYMq9y9LFFSDkwmDi5kTdcXcOHBHdzG8ERuW8vfVgkNEgmgd0xSq6ta5kV0X8/38Xpxjraj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWWw5H0E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741091739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+JVw5DKsr+Hmzxs+dTr4dk8FDO+akXXsqYK5kh/OjYE=;
	b=EWWw5H0EMcFIHIeItPCSejT7jnrfvwLMUcXYuVq2MOlU7RbVmzYMP+hAus1olOdjAXYVZW
	Z52sOFbSic5NJ7scHF655aIqooTaSX5zdcfY/TRSoFxTKgimxGl1m2VeK8O/58jlrztu9b
	2XNvSbb4nKbBFMBxvBIMdI7roIuDl+o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-DbaGHIbsOimw9OltjgtE_Q-1; Tue,
 04 Mar 2025 07:35:35 -0500
X-MC-Unique: DbaGHIbsOimw9OltjgtE_Q-1
X-Mimecast-MFC-AGG-ID: DbaGHIbsOimw9OltjgtE_Q_1741091734
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 170041800871;
	Tue,  4 Mar 2025 12:35:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2C01A1800946;
	Tue,  4 Mar 2025 12:35:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 13:35:04 +0100 (CET)
Date: Tue, 4 Mar 2025 13:34:57 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250304123457.GA25281@redhat.com>
References: <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304102934.2999-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/04, Hillf Danton wrote:
>
> On Tue, 4 Mar 2025 11:05:57 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
> >> @@ -573,11 +573,13 @@ pipe_write(struct kiocb *iocb, struct io
> >>   		 * after waiting we need to re-check whether the pipe
> >>   		 * become empty while we dropped the lock.
> >>   		 */
> >> +		tail = pipe->tail;
> >>   		mutex_unlock(&pipe->mutex);
> >>   		if (was_empty)
> >>   			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> >>   		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> >> -		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
> >> +		wait_event_interruptible_exclusive(pipe->wr_wait,
> >> +				!READ_ONCE(pipe->readers) || tail != READ_ONCE(pipe->tail));
> >
> >That could work too for the case highlighted but in case the head too
> >has moved by the time the writer wakes up, it'll lead to an extra
> >wakeup.
> >
> Note wakeup can occur even if pipe is full,

Perhaps I misunderstood you, but I don't think pipe_read() can ever do
wake_up(pipe->wr_wait) if pipe is full...

> 		 * So we still need to wake up any pending writers in the
> 		 * _very_ unlikely case that the pipe was full, but we got
> 		 * no data.
> 		 */

Only if wake_writer is true,

		if (unlikely(wake_writer))
			wake_up_interruptible_sync_poll(...);

and in this case the pipe is no longer full. A zero-sized buffer was
removed.

Of course this pipe can be full again when the woken writer checks the
condition, but this is another story. And in this case, with your
proposed change, the woken writer will take pipe->mutex for no reason.

Note also that the comment and code above was already removed by
https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/

Oleg.


