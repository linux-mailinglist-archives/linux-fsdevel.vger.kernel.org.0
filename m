Return-Path: <linux-fsdevel+bounces-43589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D73A591E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 11:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DFE3AF35A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D372A226551;
	Mon, 10 Mar 2025 10:49:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDDD22D4FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603777; cv=none; b=JIbmOkQ0ifKBUyBG0g+/FcQ/uQJVUvMd5RaRdXGscJX9Od+buqvajxGrb7QvWowwkasaQbsBR6/Phcaps8EaNzQJAyCHjlMZd8MjK5g7B0oa3aHURkoWGtlhKsWNBj+FyNKkh/5ATUqgLwuHl95VusAhZESmUcziMZ6eUbh1dYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603777; c=relaxed/simple;
	bh=IZlU5cNa8r4FVNiEVWpS8D09uzeiSeUP7VLyE2PJdmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zheqp7a6ooRnaEDjKTLhEAWd/4tzFQw0nY+V/8M5kQkYM00xS0KDujN/cp+iS+cvVrb093ogNwUk59zhpPPLc47iJQqyxn4qKcpSILFl8IU5qm3W1qD1H6DcMH4Gh3mkInQ2pRAdXgVWpHFW5Fo8XbYvQUL1yvjFurvx0nYGYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.168])
	by sina.com (10.185.250.22) with ESMTP
	id 67CEC3AF00000ACE; Mon, 10 Mar 2025 18:49:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1923207602725
X-SMAIL-UIID: 86346AB2018145879571C55EBA739B9F-20250310-184922-1
From: Hillf Danton <hdanton@sina.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Mon, 10 Mar 2025 18:49:09 +0800
Message-ID: <20250310104910.3232-1-hdanton@sina.com>
In-Reply-To: <20250309170254.GA15139@redhat.com>
References: <20250228163347.GB17761@redhat.com> <20250304050644.2983-1-hdanton@sina.com> <20250304102934.2999-1-hdanton@sina.com> <20250304233501.3019-1-hdanton@sina.com> <20250305045617.3038-1-hdanton@sina.com> <20250305224648.3058-1-hdanton@sina.com> <20250307060827.3083-1-hdanton@sina.com> <20250307104654.3100-1-hdanton@sina.com> <20250307112920.GB5963@redhat.com> <20250307235645.3117-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 9 Mar 2025 18:02:55 +0100 Oleg Nesterov
> 
> Well. Prateek has already provide the lengthy/thorough explanation,
> but let me add anyway...
> 
lengthy != correct

> On 03/08, Hillf Danton wrote:
> > On Fri, 7 Mar 2025 13:34:43 +0100 Oleg Nesterov <oleg@redhat.com>
> > > On 03/07, Oleg Nesterov wrote:
> > > > On 03/07, Hillf Danton wrote:
> > > > > On Fri, 7 Mar 2025 11:54:56 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
> > > > > >> step-03
> > > > > >> 	task-118766 new reader
> > > > > >> 	makes pipe empty
> > > > > >
> > > > > >Reader seeing a pipe full should wake up a writer allowing 118768 to
> > > > > >wakeup again and fill the pipe. Am I missing something?
> > > > > >
> > > > > Good catch, but that wakeup was cut off [2,3]
> > >
> > > Please note that "that wakeup" was _not_ removed by the patch below.
> > >
> > After another look, you did cut it.
> 
> I still don't think so.
> 
> > Link: https://lore.kernel.org/all/20250209150718.GA17013@redhat.com/
> ...
> > --- a/fs/pipe.c
> > +++ b/fs/pipe.c
> > @@ -360,29 +360,9 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >  			break;
> >  		}
> >  		mutex_unlock(&pipe->mutex);
> > -
> >  		/*
> >  		 * We only get here if we didn't actually read anything.
> >  		 *
> > -		 * However, we could have seen (and removed) a zero-sized
> > -		 * pipe buffer, and might have made space in the buffers
> > -		 * that way.
> > -		 *
> > -		 * You can't make zero-sized pipe buffers by doing an empty
> > -		 * write (not even in packet mode), but they can happen if
> > -		 * the writer gets an EFAULT when trying to fill a buffer
> > -		 * that already got allocated and inserted in the buffer
> > -		 * array.
> > -		 *
> > -		 * So we still need to wake up any pending writers in the
> > -		 * _very_ unlikely case that the pipe was full, but we got
> > -		 * no data.
> > -		 */
> > -		if (unlikely(wake_writer))
> > -			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> > -		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> > -
> > -		/*
> >  		 * But because we didn't read anything, at this point we can
> >  		 * just return directly with -ERESTARTSYS if we're interrupted,
> >  		 * since we've done any required wakeups and there's no need
> > @@ -391,7 +371,6 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >  		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
> >  			return -ERESTARTSYS;
> >
> > -		wake_writer = false;
> >  		wake_next_reader = true;
> >  		mutex_lock(&pipe->mutex);
> >  	}
> 
> Please note that in this particular case (hackbench testing)
> pipe_write() -> copy_page_from_iter() never fails. So wake_writer is
> never true before pipe_reader() calls wait_event(pipe->rd_wait).
> 
Given never and the BUG_ON below, you accidentally prove that Prateek's
comment is false, no?

> So (again, in this particular case) we could apply the patch below
> on top of Linus's tree.
> 
> So, with or without these changes, the writer should be woken up at
> step-03 in your scenario.
> 
Fine, before checking my scenario once more, feel free to pinpoint the
line number where writer is woken up, with the change below applied.

> Oleg.
> ---
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

