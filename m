Return-Path: <linux-fsdevel+bounces-43600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D5A594FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 13:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58302188F576
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855E622A80B;
	Mon, 10 Mar 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGWopzI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA722172D
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610666; cv=none; b=pmETXLzriDtpCKLRjU5Hw5FDl2840op+22W7u5OR8LFyjThU7oo+xxeRt3YOWj5Mt4k/MORNq4bz0Gw+m5Mq5xyl1B69+X5deYmkae0Zsew0RW35YYRE8EeVhGHEBZc6wpzsF+O7WQocBHd0+3mUtMbID3oaitedHdNl/0bshJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610666; c=relaxed/simple;
	bh=42bpw7QsJxoPFZyWS63GGnQgVa3DFvQUvEX/6GgwASk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIsAQ5cJ6YRavc4L5pH8e907GMB7ghCFoLXj1gy+j+IqTr+1BY2YohXSx7VNnLahn0XqpAP/+slFaUW3Ii1rRQ1O+CtAagJ6CWDpbBiWVb5xWJFbt6uqMqwjf92J5orcZhuOFFavp7Qq2gYt1ii/7XwRAuJm4ATkY874wGY1pCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGWopzI5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741610663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8DXEg1k9/LkI/RFF7cRqUAYGlbFUNVfNuX3I9mixJac=;
	b=OGWopzI5q+4rPw41Q/WnzxriYdgfNCj3rUI5Ypj2N35YgitXWvkRFn8kItaCgTx0LoJ0qm
	5FaOnjOn/AyQWomR5algDbesdioKxOoaRBlXRUpHZfe3CzkOOuplKkx5t/kmwurVvYLHI4
	tk5kAPPwwuwHjde/CJ/6J4MowbfkDc0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-4Wx9TQohOMe862VXD_Qmdg-1; Mon,
 10 Mar 2025 08:44:19 -0400
X-MC-Unique: 4Wx9TQohOMe862VXD_Qmdg-1
X-Mimecast-MFC-AGG-ID: 4Wx9TQohOMe862VXD_Qmdg_1741610658
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8700A195609F;
	Mon, 10 Mar 2025 12:44:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A1D811956094;
	Mon, 10 Mar 2025 12:44:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Mar 2025 13:43:46 +0100 (CET)
Date: Mon, 10 Mar 2025 13:43:42 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250310124341.GB26382@redhat.com>
References: <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
 <20250307104654.3100-1-hdanton@sina.com>
 <20250307112920.GB5963@redhat.com>
 <20250307235645.3117-1-hdanton@sina.com>
 <20250310104910.3232-1-hdanton@sina.com>
 <20250310113726.3266-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310113726.3266-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 03/10, Hillf Danton wrote:
>
> On Mon, 10 Mar 2025 12:09:15 +0100 Oleg Nesterov
> > On 03/10, Hillf Danton wrote:
> > > On Sun, 9 Mar 2025 18:02:55 +0100 Oleg Nesterov
> > > >
> > > > So (again, in this particular case) we could apply the patch below
> > > > on top of Linus's tree.
> > > >
> > > > So, with or without these changes, the writer should be woken up at
> > > > step-03 in your scenario.
> > > >
> > > Fine, before checking my scenario once more, feel free to pinpoint the
> > > line number where writer is woken up, with the change below applied.
> >
> >     381          if (wake_writer)
> > ==> 382                  wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> >     383          if (wake_next_reader)
> >     384                  wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> >     385          kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> >     386          if (ret > 0)
> >     387                  file_accessed(filp);
> >     388          return ret;
> >
> > line 382, no?
> >
> Yes, but how is the wait loop at line-370 broken?
>
>  360                 }
>  361                 mutex_unlock(&pipe->mutex);
>  362
>  363                 BUG_ON(wake_writer);
>  364                 /*
>  365                  * But because we didn't read anything, at this point we can
>  366                  * just return directly with -ERESTARTSYS if we're interrupted,
>  367                  * since we've done any required wakeups and there's no need
>  368                  * to mark anything accessed. And we've dropped the lock.
>  369                  */
>  370                 if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
>  371                         return -ERESTARTSYS;

Hmm. I don't understand you, again.

OK, once some writer writes at least one byte (this will make the
pipe_empty() condition false) and wakes this reader up.

If you meant something else, say, if you referred to you previous
scenario, please clarify your question.

Oleg.


