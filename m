Return-Path: <linux-fsdevel+bounces-41423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDEA2F51B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C7F188A3D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1732500D4;
	Mon, 10 Feb 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTQSNVrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231724F5A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208163; cv=none; b=ToppuR/Yg1ACfUa2taLEydA2KKBmVLBUCp5JgH4nVjUa0RCfwlvkE7HLVWL2q1BFCxnsfekQNUbYB6zZRtcuYuJI4sEnF1tjd6m0m82mmi3o1ikROWUGisUhmgzbFUCpIpVktcdDicn2kzbqqmFfvuJjdYq+4BlARCq+SlJEbPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208163; c=relaxed/simple;
	bh=OBUrn54ZuwJ2Ac5IBrCTDuMl9kwdrYkDHzjPbEt0yb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G003ZfNeSoEBlVbj6vi6tDmgCOSAIqAw9SMFZHhpi0wDQhsMrftE8G/ca9QakXmE5P9OVWIKj6A/OHyuNFgOr872fT++wecxHJdccBsl6N65kL2cohCR/dQ/mGu8NMlGfzqZp2DOu7SNivkU5IKjrdBNzQ5DNf7QfZBKTVdQ3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTQSNVrr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739208160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFvWPguTuHqCbKoPEVV0UQ0vC4+daAROF/xOyUwpCpI=;
	b=iTQSNVrr8HChxhbDB66pMAibkWGyNEp/tXZM1+2L+1p3i9pnJ0cYN6yV28X3mJxiz1AwId
	KIWCa5H4GAS/97ud31ThTDYnUJDV8ZBJvkItw4KsBrzE8OtEgW9L9qfQjTO5k9DVXcldEy
	gUnUwHN6x3KS4rP9vEn2wzd1m6gs3CU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-XBbZ-sZcOYSVufVWMUG6Ow-1; Mon,
 10 Feb 2025 12:22:34 -0500
X-MC-Unique: XBbZ-sZcOYSVufVWMUG6Ow-1
X-Mimecast-MFC-AGG-ID: XBbZ-sZcOYSVufVWMUG6Ow
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D147F195608E;
	Mon, 10 Feb 2025 17:22:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DF80E1800570;
	Mon, 10 Feb 2025 17:22:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Feb 2025 18:22:06 +0100 (CET)
Date: Mon, 10 Feb 2025 18:22:00 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] pipe: change pipe_write() to never add a zero-sized
 buffer
Message-ID: <20250210172200.GA16955@redhat.com>
References: <20250209150718.GA17013@redhat.com>
 <20250209150749.GA16999@redhat.com>
 <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
 <20250209180214.GA23386@redhat.com>
 <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
 <20250209184427.GA27435@redhat.com>
 <CAHk-=wihBAcJLiC9dxj1M8AKHpdvrRneNk3=s-Rt-Hv5ikqo4g@mail.gmail.com>
 <20250209191510.GB27435@redhat.com>
 <b050f92e-4117-4e93-8ec6-ec595fd8570a@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b050f92e-4117-4e93-8ec6-ec595fd8570a@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Prateek,

On 02/10, K Prateek Nayak wrote:
>
>  1-groups     1.00 [ -0.00]( 7.19)                0.95 [  4.90](12.39)
>  2-groups     1.00 [ -0.00]( 3.54)                1.02 [ -1.92]( 6.55)
>  4-groups     1.00 [ -0.00]( 2.78)                1.01 [ -0.85]( 2.18)
>  8-groups     1.00 [ -0.00]( 1.04)                0.99 [  0.63]( 0.77)
> 16-groups     1.00 [ -0.00]( 1.02)                1.00 [ -0.26]( 0.98)
>
> I don't see any regression / improvements from a performance standpoint

Yes, this patch shouldn't make any difference performance-wise, at least
in this case. Although I was thinking the same thing when I sent "pipe_read:
don't wake up the writer if the pipe is still full" ;)

> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks! Please see v2, I've included you tag.

Any chance you can also test the patch below?

To me it looks like a cleanup which makes the "merge small writes" logic
more understandable. And note that "page-align the rest of the writes"
doesn't work anyway if "total_len & (PAGE_SIZE-1)" can't fit in the last
buffer.

However, in this particular case with DATASIZE=100 this patch can increase
the number of copy_page_from_iter()'s in pipe_write(). And with this change
receiver() can certainly get the short reads, so this can increase the
number of sys_read() calls.

So I am just curious if this change can cause any noticeable regression on
your machine.

Thank you!

Oleg.

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -459,16 +459,16 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	was_empty = pipe_empty(head, pipe->tail);
 	chars = total_len & (PAGE_SIZE-1);
 	if (chars && !was_empty) {
-		unsigned int mask = pipe->ring_size - 1;
-		struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
+		struct pipe_buffer *buf = pipe_buf(pipe, head - 1);
 		int offset = buf->offset + buf->len;
+		int avail = PAGE_SIZE - offset;
 
-		if ((buf->flags & PIPE_BUF_FLAG_CAN_MERGE) &&
-		    offset + chars <= PAGE_SIZE) {
+		if (avail && (buf->flags & PIPE_BUF_FLAG_CAN_MERGE)) {
 			ret = pipe_buf_confirm(pipe, buf);
 			if (ret)
 				goto out;
 
+			chars = min_t(ssize_t, chars, avail);
 			ret = copy_page_from_iter(buf->page, offset, chars, from);
 			if (unlikely(ret < chars)) {
 				ret = -EFAULT;


