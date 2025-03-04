Return-Path: <linux-fsdevel+bounces-43108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA4DA4E053
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987871888D18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADAC206F37;
	Tue,  4 Mar 2025 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTNTnJc7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FD2066FB
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097290; cv=none; b=sxGLowkaN7yYaiyEwnGwq5mQk3ZYm2CcaeTDEudagRgC37tT3A9+RJgIdAFwE5rB82O5J46sSAmxk8eeBiH7es0nVZvr5sYEg8eIKOShvkX/ejIEAagrvzs9HyrqmWan6AOsGAjgGlFVPKt6DgMwSrXerQdMDjMBE25I7x/EqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097290; c=relaxed/simple;
	bh=KAiXbpu15i47EAqRuiSckrsx67fq0CuxF/yuJFF2VvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH3U9/BHZuVRDAEy2KEe7mAWI3cBWjIj5UyGiPOH9ijijdTmeC4iElWg3BcjEF1a5DFryKU4MgXRTOmuvbeiQhmMbAu1oiu2ImpdJp3cRl12HP6swKoZjWfdX0Y87tMJO1bxqaHFpXsk2LIpw2TzXdQSIqX5zlAilulUtKGBX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTNTnJc7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741097287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T0duPupBbKbOBmo+V9m3H3rlnyCP4NMm3QenxG8AfDU=;
	b=HTNTnJc7ahWS253X0OS5cby8dkVPAGQgNMExBsr6EuZnUjO6GBVY0KQCXkzhGgqyY45YXf
	hIMVS39skq6XktM/kWo0O27l6cNZFsX+9qd7GJVMz/G+6nj20+LTySZlEw3Gyy3ztRYdNc
	VBMO4QY5NH5NU5O9i13Nbi/uHLhlQOc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-9JaBw8SLPneBqvKQmQA7ig-1; Tue,
 04 Mar 2025 09:08:03 -0500
X-MC-Unique: 9JaBw8SLPneBqvKQmQA7ig-1
X-Mimecast-MFC-AGG-ID: 9JaBw8SLPneBqvKQmQA7ig_1741097282
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B874119373C4;
	Tue,  4 Mar 2025 14:08:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.246])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6C7891801768;
	Tue,  4 Mar 2025 14:07:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 15:07:31 +0100 (CET)
Date: Tue, 4 Mar 2025 15:07:27 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: torvalds@linux-foundation.org, brauner@kernel.org, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] pipe: drop an always true check in anon_pipe_write()
Message-ID: <20250304140726.GD26141@redhat.com>
References: <20250303230409.452687-1-mjguzik@gmail.com>
 <20250303230409.452687-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303230409.452687-2-mjguzik@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/04, Mateusz Guzik wrote:
>
> @@ -529,10 +529,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  
>  			if (!iov_iter_count(from))
>  				break;
> -		}
>  
> -		if (!pipe_full(head, pipe->tail, pipe->max_usage))
>  			continue;
> +		}

Reviewed-by: Oleg Nesterov <oleg@redhat.com>



It seems that we can also remove the unnecessary signal_pending()
check, but I need to recheck and we need to cleanup the poll_usage
logic first.

This will also remove the unnecessary wakeups when the writer is
interrupted by signal/

diff --git a/fs/pipe.c b/fs/pipe.c
index b0641f75b1ba..ed55a86ca03b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -541,12 +541,6 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				ret = -EAGAIN;
 			break;
 		}
-		if (signal_pending(current)) {
-			if (!ret)
-				ret = -ERESTARTSYS;
-			break;
-		}
-
 		/*
 		 * We're going to release the pipe lock and wait for more
 		 * space. We wake up any readers if necessary, and then
@@ -554,10 +548,11 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		 * become empty while we dropped the lock.
 		 */
 		mutex_unlock(&pipe->mutex);
-		if (was_empty)
+		if (was_empty || pipe->poll_usage)
 			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
-		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
+		if (wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe)) < 0)
+			return ret ?: -ERESTARTSYS;
 		mutex_lock(&pipe->mutex);
 		was_empty = pipe_empty(pipe->head, pipe->tail);
 		wake_next_writer = true;


