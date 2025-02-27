Return-Path: <linux-fsdevel+bounces-42754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE222A47E40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 13:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9597A4FB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083F22E3F3;
	Thu, 27 Feb 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACXFmMLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E77270043
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660687; cv=none; b=PSoEzptcsYw3TXFfTZcRWz2KZ0XoRgRItLA0eIxiurziOTlM67dbhClnQSlcXdvPQpiV4xXeGaySeHW1ESm1uCFLRfPNuSexDV/Gt5L2/CawOmAko0e6exoqhwDaimc4upO2U8tX5qmFg2iAeq7C3vPYDYpXgY0Ay31ckNZRZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660687; c=relaxed/simple;
	bh=vdi+8jTWjZYz/RHVgO0M2Zx7hSKBCDbLtDrSTa1rt4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzXTnMCR0rtSTUasXjkW5PwMuVPtTGfO79rGHQV7qz/D3zaYwzgq0r7Hzq0LIfUUkmGaEbZrUBtvL17Qpv3EuU6KosOFMJj5IaaqePxI/O/j3lKoaEOvi6jR7lToBoTvF40GO7R4aQu2A/xefJpxxlj/i78zxBBqr2e1QMbA1TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACXFmMLc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740660684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UbloUz+eJ/WCG3EOzg2ItWNL8OM0MgfqtuYj2xSHwUM=;
	b=ACXFmMLcv4nunVnd1Zm5PC2+M8tpcPxFo3eP5+CQeWWIEWZHNWO37qPLUbopAV2wMH+QjL
	XSa8OUFBBBpgXaveMMvBzIY9AjlR2CxmsLXUSs/Ts/7WVsfyx9GYgTxUaIVOcylPwsdw+e
	ingtp+QH+/V7sEsnM9RbfyaWRwvIcAE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-oS7l12EmP26kW4E-x8fdOg-1; Thu,
 27 Feb 2025 07:51:21 -0500
X-MC-Unique: oS7l12EmP26kW4E-x8fdOg-1
X-Mimecast-MFC-AGG-ID: oS7l12EmP26kW4E-x8fdOg_1740660678
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBB4F1902F59;
	Thu, 27 Feb 2025 12:51:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.102])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4DCA4180035E;
	Thu, 27 Feb 2025 12:51:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 27 Feb 2025 13:50:47 +0100 (CET)
Date: Thu, 27 Feb 2025 13:50:41 +0100
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
Message-ID: <20250227125040.GA25639@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hmm...

Suppose that pipe is full, a writer W tries to write a single byte
and sleeps on pipe->wr_wait.

A reader reads PAGE_SIZE bytes, updates pipe->tail, and wakes W up.

But, before the woken W takes pipe->mutex, another writer comes and
writes 1 byte. This updates ->head and makes pipe_full() true again.

Now, W could happily merge its "small" write into the last buffer,
but it will sleep again, despite the fact the last buffer has room
for 4095 bytes.

Sapkal, I don't think this can explain the hang, receiver()->read()
should wake this writer later anyway. But could you please retest
with the patch below?

Thanks,

Oleg.
---

diff --git a/fs/pipe.c b/fs/pipe.c
index b0641f75b1ba..222881559c30 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -455,6 +455,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	 * page-aligns the rest of the writes for large writes
 	 * spanning multiple pages.
 	 */
+again:
 	head = pipe->head;
 	was_empty = pipe_empty(head, pipe->tail);
 	chars = total_len & (PAGE_SIZE-1);
@@ -559,8 +560,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
 		mutex_lock(&pipe->mutex);
-		was_empty = pipe_empty(pipe->head, pipe->tail);
 		wake_next_writer = true;
+		goto again;
 	}
 out:
 	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))


