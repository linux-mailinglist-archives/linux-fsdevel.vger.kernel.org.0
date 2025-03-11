Return-Path: <linux-fsdevel+bounces-43705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B48A5BFCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52EC3A52AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3C5255E3D;
	Tue, 11 Mar 2025 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD0oZHrH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83EA250BFF
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694057; cv=none; b=ONi08aVtXjzZcG0NmOg0Szm0d2RWLE+u31BbBPfFPJ3znznNUv/knNgSoPaFuRRSIR04vwKr8Lx654YJIcdPnyt/Z8bKzYM68EdkRPucQ/cAKU84NMIcXC6mLdlTAeYsf1yrYqyLyW9V4yXC/o3LDbByT+JGOFBWjPu5Iz3oWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694057; c=relaxed/simple;
	bh=trWid0dAdzDk4Urb65DINNXSCp4HE5Qgrt6rEgTlw40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs2c5kIot91agu6xi0KdifJa/6DvYmx95Nw2OrmTjXm+zy+V/VQFkUcgn9GXis2E5MQ5f8WjPfUZyhn6ZMFyJNTbg9Owei+RtkzHTwLDPtEWH6IpTcxGxyAkmBjk5XiDL7XEcBEJ2UI9z60EN1RgBmIRMJPieQ6rDQ7CU7QMjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dD0oZHrH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741694054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3nIsu8sZ9wwPd0FbImU6JO502ar/N3i2xNxuuWjp75I=;
	b=dD0oZHrH9Ou8W8hbfnW36PQwgkhqNrDh0lFYlRi8jnpmUTG/p9AFf+hPLJS8HiStsmJxAa
	tKxyv58oHVfWE2Y+2leOkv76SrHgLnWBVOE3YW5kHgcGq99HonSV7AT1DIZYEustqEdpVl
	EZNI/leTVqOK6ggYuwHqgm51mM5VYLE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-zBWGmjyFPeC0k0eWz4bq8A-1; Tue,
 11 Mar 2025 07:54:11 -0400
X-MC-Unique: zBWGmjyFPeC0k0eWz4bq8A-1
X-Mimecast-MFC-AGG-ID: zBWGmjyFPeC0k0eWz4bq8A_1741694050
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FC7F180049D;
	Tue, 11 Mar 2025 11:54:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.22.90.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B72CE30001A2;
	Tue, 11 Mar 2025 11:54:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Mar 2025 12:53:38 +0100 (CET)
Date: Tue, 11 Mar 2025 12:53:34 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250311115332.GA3493@redhat.com>
References: <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
 <20250307104654.3100-1-hdanton@sina.com>
 <20250307112920.GB5963@redhat.com>
 <20250307235645.3117-1-hdanton@sina.com>
 <20250310104910.3232-1-hdanton@sina.com>
 <20250310113726.3266-1-hdanton@sina.com>
 <20250310124341.GB26382@redhat.com>
 <20250310233350.3301-1-hdanton@sina.com>
 <20250311112922.3342-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311112922.3342-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/11, Hillf Danton wrote:
>
> On Mon, 10 Mar 2025 14:26:17 -1000 Linus Torvalds wrote:
> > On Mon, 10 Mar 2025 at 13:34, Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > The step-03 in my scenario [1] shows a reader sleeps at line-370 after
> > > making the pipe empty, so after your change that cuts the chance for
> > > waking up writer, who will wake up the sleeping reader? Nobody.
> >
> > But step-03 will wake the writer.
> >
> > And no, nobody will wake readers, because the pipe is empty. Only the
> > next writer that adds data to the pipe should wake any readers.
> >
> > Note that the logic that sets "wake_writer" and "was_empty" is all
> > protected by the pipe semaphore. So there are no races wrt figuring
> > out "should we wake readers/writers".
> >
> > So I really think you need to very explicitly point to what you think
> > the problem is. Not point to some other email. Write out all out in
> > full and explain.
> >
> In the mainline tree, conditional wakeup [2] exists before a pipe writer
> takes a nap, so scenario can be constructed based on the one in commit
> 3d252160b818 to make pipe writer sleep with nobody woken up.
>
> step-00
> 	pipe->head = 36
> 	pipe->tail = 36
>
> step-01
> 	task-118762 is a writer
> 	pipe->head++;
> 	wakes up task-118740 and task-118768
>
> step-02
> 	task-118768 is a writer
> 	makes pipe full;
> 	sleeps without waking up any reader as
> 	pipe was not empty after step-01
>
> Conditional wakeup also exists on the reader side [3], but Oleg cut it off [4].
>
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -360,27 +360,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		}
>  		mutex_unlock(&pipe->mutex);
>
> -		/*
> -		 * We only get here if we didn't actually read anything.
> -		 *
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
> +		BUG_ON(wake_writer);
>  		/*
>  		 * But because we didn't read anything, at this point we can
>  		 * just return directly with -ERESTARTSYS if we're interrupted,
>
>
> step-03
> 	task-118740 is reader
> 	makes pipe empty
> 	sleeps with no writer woken up
>
> After step-03, both reader(task-118740) and writer (task-118768) sleep
> waiting for each other, with Oleg's change.

Well. I have already tried to explain this at least twice :/ Prateek too.

After step-03 task-118740 won't sleep. pipe_read() won't sleep if it has
read even one byte. Since the pipe was full and this reader makes it empty,
"wake_writer" must be true after the main loop before return from pipe_read().
This means that the reader(task-118740) will wake the writer(task-118768)
before it returns from pipe_read().

Oleg.

> PS Oleg, given no seperate reply to you, check the above scenario instead please.
>
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/pipe.c#n576
> [3] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/pipe.c#n381
> [4] https://lore.kernel.org/lkml/20250309170254.GA15139@redhat.com/
>


