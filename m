Return-Path: <linux-fsdevel+bounces-43597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500FDA592DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 12:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6D97A629F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA588221714;
	Mon, 10 Mar 2025 11:37:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79921E097
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606674; cv=none; b=cDodA/mfj3WPj/9dv/latXq9y/P26qiTdV159BAd1hH9bgsjp2qKIaTpEYddfLAQb0fYJNfOXRtcftnsKC8t5lbTUTaCe8MGEt4S8mNVTLjph6JXxKQSvL3SUnrrn7kBF3yrJEYbvijijVOSOIIfOl6umQtQlVDV6MpcnSPYp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606674; c=relaxed/simple;
	bh=zJaJ/IUKeSO0/6VNJvyQeUCOz6MLN+/kRupMnl3BPCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJlLw1K6N6g/P5RGsRMB1gleTKIXITTHavkkqAFS+885QLmtBJh5OsI083snGHgsdVq1Z2yhtu6orWEBOzCeAW7uVK48KC/oGAbAX8dmricxXy3CXdZbTK670b+dOosSYuddiPsSd565wPCojU5V370WE5UzvnqiUudG0j5suTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.168])
	by sina.com (10.185.250.21) with ESMTP
	id 67CECEFF00002E2D; Mon, 10 Mar 2025 19:37:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8121563408361
X-SMAIL-UIID: A2E896C978EA4DB58A42A1A2E3B2E503-20250310-193737-1
From: Hillf Danton <hdanton@sina.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Mon, 10 Mar 2025 19:37:24 +0800
Message-ID: <20250310113726.3266-1-hdanton@sina.com>
In-Reply-To: <20250310110914.GA26382@redhat.com>
References: <20250304050644.2983-1-hdanton@sina.com> <20250304102934.2999-1-hdanton@sina.com> <20250304233501.3019-1-hdanton@sina.com> <20250305045617.3038-1-hdanton@sina.com> <20250305224648.3058-1-hdanton@sina.com> <20250307060827.3083-1-hdanton@sina.com> <20250307104654.3100-1-hdanton@sina.com> <20250307112920.GB5963@redhat.com> <20250307235645.3117-1-hdanton@sina.com> <20250310104910.3232-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Mar 2025 12:09:15 +0100 Oleg Nesterov
> On 03/10, Hillf Danton wrote:
> > On Sun, 9 Mar 2025 18:02:55 +0100 Oleg Nesterov
> > >
> > > So (again, in this particular case) we could apply the patch below
> > > on top of Linus's tree.
> > >
> > > So, with or without these changes, the writer should be woken up at
> > > step-03 in your scenario.
> > >
> > Fine, before checking my scenario once more, feel free to pinpoint the
> > line number where writer is woken up, with the change below applied.
> 
>     381          if (wake_writer)
> ==> 382                  wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
>     383          if (wake_next_reader)
>     384                  wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
>     385          kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
>     386          if (ret > 0)
>     387                  file_accessed(filp);
>     388          return ret;
> 
> line 382, no?
> 
Yes, but how is the wait loop at line-370 broken?

 360                 }
 361                 mutex_unlock(&pipe->mutex);
 362
 363                 BUG_ON(wake_writer);
 364                 /*
 365                  * But because we didn't read anything, at this point we can
 366                  * just return directly with -ERESTARTSYS if we're interrupted,
 367                  * since we've done any required wakeups and there's no need
 368                  * to mark anything accessed. And we've dropped the lock.
 369                  */
 370                 if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
 371                         return -ERESTARTSYS;
 372
 373                 wake_writer = false;
 374                 wake_next_reader = true;
 375                 mutex_lock(&pipe->mutex);

