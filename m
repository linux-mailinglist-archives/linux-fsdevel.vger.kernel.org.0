Return-Path: <linux-fsdevel+bounces-43550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACCA585F6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 18:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0AC16A07E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9541DE88C;
	Sun,  9 Mar 2025 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq6Fgv45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FCE2AE95
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539820; cv=none; b=ZJvPiHTuQ97SwRTOLgIEpxiGhmAwzHpOc7nAYFlGNku8ibZrvlYtaW3a0qg6zPgD8YFuZEgdnX1sqJUf7ylR1DpnEst2bAGpc1N6zw1BExskZZcZhs8s15k3ae1urrY2IjLKYM2GlnmSFATEV17LBeSVZMT1n2P5Dii+K24Xzjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539820; c=relaxed/simple;
	bh=Xebeuqu2NCll/QxTOuP2+yDIrcMb5fDPbvy0SjDDUW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrE+DZhNWEijcbPkT6VwLObfKrF8jwkrSzWO4nqbTlcJ8RJ19yRI3qpemDAHYbvY1ap3YZEtigR+3AJ0mcVNkJqYA9+2kVEAZmFkLR8hkIws8A4i6YH/1BNI87AGjjrC1gVRSkgauo04VlWZG25fFF7nrtDI0N6wP1JaZ7y9kew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cq6Fgv45; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741539817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ktY/l692hvd4FyeZKYppmC3JFEBwvK+7WlKmHAB35/c=;
	b=Cq6Fgv45TPxVAt+naRUDvYJUXVkRXmu/qCUD95UTi9R+XJtPmhjX3sOhKM4cdSWXe3/yuS
	koRE7o08VXA/uLNWzRCGsPV+aW/gZ4+264cmgBnzZVQ6XmvMaw4vzQKRUk7aURS3OsUVkb
	JhtlZ0uUFmkhJcNsfn0SBu5Y/SwgveY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-GrQZytcxN52AONNZWmiozg-1; Sun,
 09 Mar 2025 13:03:34 -0400
X-MC-Unique: GrQZytcxN52AONNZWmiozg-1
X-Mimecast-MFC-AGG-ID: GrQZytcxN52AONNZWmiozg_1741539811
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1C1718004A9;
	Sun,  9 Mar 2025 17:03:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 167D71956095;
	Sun,  9 Mar 2025 17:03:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Mar 2025 18:02:59 +0100 (CET)
Date: Sun, 9 Mar 2025 18:02:55 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250309170254.GA15139@redhat.com>
References: <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
 <20250307104654.3100-1-hdanton@sina.com>
 <20250307112920.GB5963@redhat.com>
 <20250307235645.3117-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307235645.3117-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Well. Prateek has already provide the lengthy/thorough explanation,
but let me add anyway...

On 03/08, Hillf Danton wrote:
>
> On Fri, 7 Mar 2025 13:34:43 +0100 Oleg Nesterov <oleg@redhat.com>
> > On 03/07, Oleg Nesterov wrote:
> > > On 03/07, Hillf Danton wrote:
> > > > On Fri, 7 Mar 2025 11:54:56 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
> > > > >> step-03
> > > > >> 	task-118766 new reader
> > > > >> 	makes pipe empty
> > > > >
> > > > >Reader seeing a pipe full should wake up a writer allowing 118768 to
> > > > >wakeup again and fill the pipe. Am I missing something?
> > > > >
> > > > Good catch, but that wakeup was cut off [2,3]
> >
> > Please note that "that wakeup" was _not_ removed by the patch below.
> >
> After another look, you did cut it.

I still don't think so.

> Link: https://lore.kernel.org/all/20250209150718.GA17013@redhat.com/
...
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -360,29 +360,9 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  			break;
>  		}
>  		mutex_unlock(&pipe->mutex);
> -
>  		/*
>  		 * We only get here if we didn't actually read anything.
>  		 *
> -		 * However, we could have seen (and removed) a zero-sized
> -		 * pipe buffer, and might have made space in the buffers
> -		 * that way.
> -		 *
> -		 * You can't make zero-sized pipe buffers by doing an empty
> -		 * write (not even in packet mode), but they can happen if
> -		 * the writer gets an EFAULT when trying to fill a buffer
> -		 * that already got allocated and inserted in the buffer
> -		 * array.
> -		 *
> -		 * So we still need to wake up any pending writers in the
> -		 * _very_ unlikely case that the pipe was full, but we got
> -		 * no data.
> -		 */
> -		if (unlikely(wake_writer))
> -			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> -		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> -
> -		/*
>  		 * But because we didn't read anything, at this point we can
>  		 * just return directly with -ERESTARTSYS if we're interrupted,
>  		 * since we've done any required wakeups and there's no need
> @@ -391,7 +371,6 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
>  			return -ERESTARTSYS;
>
> -		wake_writer = false;
>  		wake_next_reader = true;
>  		mutex_lock(&pipe->mutex);
>  	}

Please note that in this particular case (hackbench testing)
pipe_write() -> copy_page_from_iter() never fails. So wake_writer is
never true before pipe_reader() calls wait_event(pipe->rd_wait).

So (again, in this particular case) we could apply the patch below
on top of Linus's tree.

So, with or without these changes, the writer should be woken up at
step-03 in your scenario.

Oleg.
---

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -360,27 +360,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		}
 		mutex_unlock(&pipe->mutex);
 
-		/*
-		 * We only get here if we didn't actually read anything.
-		 *
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
+		BUG_ON(wake_writer);
 		/*
 		 * But because we didn't read anything, at this point we can
 		 * just return directly with -ERESTARTSYS if we're interrupted,


