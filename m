Return-Path: <linux-fsdevel+bounces-41388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D5FA2EB8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 12:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF751881B09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63811E376E;
	Mon, 10 Feb 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKQIp2uw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72D1E570A
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187682; cv=none; b=XaYnsUOHwSmkPP6Frp2gpjWvdi8pkA0UeLz/+Yx+KKDm//RqAv7LLJrdfoz1p70JwihkXsYJ/xdp1Kffb0CxUuIdZefYmbMaKTAb/URK5jsGapy9rY7EFlXTq7lVJDBVsk5/aU0+HSlKpp2xBMCkHAf1OWajGQbo8pfeh8LPM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187682; c=relaxed/simple;
	bh=A0Z5p7jAtcJP+bUxNWQBTn+qyqsJKGT8czafy7DAnfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWVxnvbBCwDcY5iaMBfEtpIqrkaKtHuWDRM023zdmXlNdx0Ao5oHXtB29aYBqS+9+lrS/m2OV7sBjil7DZPfX1CAipUDf08Jhu/j3idSu0cfZZHeUh8aNY9LugAWYQcf1L3JbbFUtwW9kNK9wCKJeSyTqz3z24AsSCqfqU5tIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKQIp2uw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739187679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClbELSS8AwfbHSwnhY5LOEfcBwAX2tRaVpjOvrMpwf0=;
	b=iKQIp2uwo8GW9C9N2dIsQFkVeVulyvj5b01DSvYUwGyACyNqHWPE0j2nEogrLWyqpDKHRb
	EzEMvl/Z7hPs5EcN6GaBlcNiNZJ5+ay1BMi2HZtA2dXylXP2BuYejk/bzznTjrlNwghB9f
	Gyc3awx/krqsm3GPN6ScVH2FYTf9ty0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-Qa8SLWEQPIG-s5zBQCTFAw-1; Mon,
 10 Feb 2025 06:41:14 -0500
X-MC-Unique: Qa8SLWEQPIG-s5zBQCTFAw-1
X-Mimecast-MFC-AGG-ID: Qa8SLWEQPIG-s5zBQCTFAw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3E6F1955DB8;
	Mon, 10 Feb 2025 11:41:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 383721800570;
	Mon, 10 Feb 2025 11:41:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Feb 2025 12:40:45 +0100 (CET)
Date: Mon, 10 Feb 2025 12:40:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] pipe: change pipe_write() to never add a zero-sized
 buffer
Message-ID: <20250210114039.GA3588@redhat.com>
References: <20250209150718.GA17013@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209150718.GA17013@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

a194dfe6e6f6 ("pipe: Rearrange sequence in pipe_write() to preallocate slot")
changed pipe_write() to increment pipe->head in advance.  IIUC to avoid the
race with the post_one_notification()-like code which can add another buffer
under pipe->rd_wait.lock without pipe->mutex.

This is no longer necessary after c73be61cede5 ("pipe: Add general notification
queue support"), pipe_write() checks pipe_has_watch_queue() and returns -EXDEV
at the start. And can't help in any case, pipe_write() no longer takes this
rd_wait.lock spinlock.

Change pipe_write() to call copy_page_from_iter() first and do nothing if it
fails. This way pipe_write() can't add a zero-sized buffer and we can simplify
pipe_read() which currently has to take care of this very unlikely case.

Also, with this patch we can probably kill eat_empty_buffer() and more
"is this buffer empty" checks in fs/splice.c later.

Link: https://lore.kernel.org/all/20250209150718.GA17013@redhat.com/
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 fs/pipe.c | 45 +++++++++------------------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 2ae75adfba64..b0641f75b1ba 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -360,29 +360,9 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		}
 		mutex_unlock(&pipe->mutex);
-
 		/*
 		 * We only get here if we didn't actually read anything.
 		 *
-		 * However, we could have seen (and removed) a zero-sized
-		 * pipe buffer, and might have made space in the buffers
-		 * that way.
-		 *
-		 * You can't make zero-sized pipe buffers by doing an empty
-		 * write (not even in packet mode), but they can happen if
-		 * the writer gets an EFAULT when trying to fill a buffer
-		 * that already got allocated and inserted in the buffer
-		 * array.
-		 *
-		 * So we still need to wake up any pending writers in the
-		 * _very_ unlikely case that the pipe was full, but we got
-		 * no data.
-		 */
-		if (unlikely(wake_writer))
-			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
-		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
-
-		/*
 		 * But because we didn't read anything, at this point we can
 		 * just return directly with -ERESTARTSYS if we're interrupted,
 		 * since we've done any required wakeups and there's no need
@@ -391,7 +371,6 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
 			return -ERESTARTSYS;
 
-		wake_writer = false;
 		wake_next_reader = true;
 		mutex_lock(&pipe->mutex);
 	}
@@ -526,33 +505,27 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				pipe->tmp_page = page;
 			}
 
-			/* Allocate a slot in the ring in advance and attach an
-			 * empty buffer.  If we fault or otherwise fail to use
-			 * it, either the reader will consume it or it'll still
-			 * be there for the next write.
-			 */
-			pipe->head = head + 1;
+			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
+			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
+				if (!ret)
+					ret = -EFAULT;
+				break;
+			}
 
+			pipe->head = head + 1;
+			pipe->tmp_page = NULL;
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
 			buf->page = page;
 			buf->ops = &anon_pipe_buf_ops;
 			buf->offset = 0;
-			buf->len = 0;
 			if (is_packetized(filp))
 				buf->flags = PIPE_BUF_FLAG_PACKET;
 			else
 				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;
-			pipe->tmp_page = NULL;
 
-			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
-			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
-				if (!ret)
-					ret = -EFAULT;
-				break;
-			}
-			ret += copied;
 			buf->len = copied;
+			ret += copied;
 
 			if (!iov_iter_count(from))
 				break;
-- 
2.25.1.362.g51ebf55



