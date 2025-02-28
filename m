Return-Path: <linux-fsdevel+bounces-42861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74279A49EF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 17:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166D01780D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF0276025;
	Fri, 28 Feb 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnHFi/3X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30925DD0F
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760475; cv=none; b=UXw1UxvITku5yR/enQ05/u6kYbiJDIfb898pcV2fwWV0qeNaFN6/JOZsEayqXCMKh41zSuvSzCip2VVhSVZD6n9TJuJaHnVBovNa/8n8YHwQuSJD9JSE6mZYHqELfwJrxpmPIPlOFldJOpoLAenL4AKGhxQarastsYUlJ4ym10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760475; c=relaxed/simple;
	bh=cbAmjOkxGzlGB0vnl36OuBNhdg/uCF4jhOBU7jnRtC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpdXQiDR/hLwCZDNbyBUp/akF7GXSiYgGhYPZXxITuqhctFWDfFrOyhTSoLXFCrkLthRMrVSLcs9aXA10VG5wfl4Q88rGq08RxCTIst24XZDHNsnIR9gwndsi8P1FiBnXBDRaZVkhRhmVaGrbheKazHF7BZHTImQMdoPQlRPn0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnHFi/3X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740760472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNodNjyB5BMBDPR8Ne5FHZKK2te4oF7OXWhGp5jO3xs=;
	b=SnHFi/3X2dOV2npdIhEtjjCiVQs8EyFHf6PoJwppn5qZaKAHLetXt4WDBZ+L6W1DwTGBvJ
	5q3W0kHxbl0dHSaixxiVkH7y+AFLxuHiwcVJsnJi7sCWbVL6vJ4y/AvFKKoGFT58lUplgs
	dJwjjNbWev72kW2TLWL+8D7PeGSNqvs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-3iXaHjlXNrOzj55e-F4uSA-1; Fri,
 28 Feb 2025 11:34:26 -0500
X-MC-Unique: 3iXaHjlXNrOzj55e-F4uSA-1
X-Mimecast-MFC-AGG-ID: 3iXaHjlXNrOzj55e-F4uSA_1740760464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E198180087C;
	Fri, 28 Feb 2025 16:34:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8495F1944D2A;
	Fri, 28 Feb 2025 16:34:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 28 Feb 2025 17:33:54 +0100 (CET)
Date: Fri, 28 Feb 2025 17:33:48 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250228163347.GB17761@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228143049.GA17761@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

And... I know, I know you already hate me ;)

but if you have time, could you check if this patch (with or without the
previous debugging patch) makes any difference? Just to be sure.

Oleg.
---

diff --git a/fs/pipe.c b/fs/pipe.c
index 4336b8cccf84..524b8845523e 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -445,7 +445,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		return 0;
 
 	mutex_lock(&pipe->mutex);
-
+again:
 	if (!pipe->readers) {
 		send_sig(SIGPIPE, current, 0);
 		ret = -EPIPE;
@@ -467,20 +467,24 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		unsigned int mask = pipe->ring_size - 1;
 		struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
 		int offset = buf->offset + buf->len;
+		int xxx;
 
 		if ((buf->flags & PIPE_BUF_FLAG_CAN_MERGE) &&
 		    offset + chars <= PAGE_SIZE) {
-			ret = pipe_buf_confirm(pipe, buf);
-			if (ret)
+			xxx = pipe_buf_confirm(pipe, buf);
+			if (xxx) {
+				if (!ret) ret = xxx;
 				goto out;
+			}
 
-			ret = copy_page_from_iter(buf->page, offset, chars, from);
-			if (unlikely(ret < chars)) {
-				ret = -EFAULT;
+			xxx = copy_page_from_iter(buf->page, offset, chars, from);
+			if (unlikely(xxx < chars)) {
+				if (!ret) ret = -EFAULT;
 				goto out;
 			}
 
-			buf->len += ret;
+			ret += xxx;
+			buf->len += xxx;
 			if (!iov_iter_count(from))
 				goto out;
 		}
@@ -567,6 +571,7 @@ atomic_inc(&WR_SLEEP);
 		mutex_lock(&pipe->mutex);
 		was_empty = pipe_empty(pipe->head, pipe->tail);
 		wake_next_writer = true;
+		goto again;
 	}
 out:
 	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))


