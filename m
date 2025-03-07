Return-Path: <linux-fsdevel+bounces-43496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC74A5765F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 00:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748F9189592E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 23:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717E82135B5;
	Fri,  7 Mar 2025 23:57:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17121537A7
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741391823; cv=none; b=JaV6OytXuFwfcZRDif1bt9kgvAw5IycBx5SnRmkfYaSOlzSg1bHLuH/rbvP3SZSiN2Hd5OGtKEAed0VS5zmLU1E+QIcrAFwmfCS/uqg++StbY/9qIa9O/kndY9fc2i8cc+O/+wfWzGtPjbf0ngjGyisJusl7oYsgISpA2wS/IWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741391823; c=relaxed/simple;
	bh=cbqO59Mk+i6S1QTdb0JLB7Qdre2NTEo9Q7ERa64Y8OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eiq19ECWrwlapxkHMbeYPrLkevvwm9ERIpvkTvvR2GwqXxcGK2/15ZDa35exnBKu1ru9deUJ/9rbo2UkOXOY2pwZTZGY8drevCtC4GtoduiJt53vHLpaBPSeFiUr5wVfHlIlqw3x17JgRyygzY4IqXxh/tNvnCsXzqmr42jtOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.201])
	by sina.com (10.185.250.22) with ESMTP
	id 67CB87C50000738D; Fri, 8 Mar 2025 07:56:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3463937602705
X-SMAIL-UIID: D289D84087F14E859A4F18EA1CB54F50-20250308-075656-1
From: Hillf Danton <hdanton@sina.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Sat,  8 Mar 2025 07:56:44 +0800
Message-ID: <20250307235645.3117-1-hdanton@sina.com>
In-Reply-To: <20250307123442.GD5963@redhat.com>
References: <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com> <20250304050644.2983-1-hdanton@sina.com> <20250304102934.2999-1-hdanton@sina.com> <20250304233501.3019-1-hdanton@sina.com> <20250305045617.3038-1-hdanton@sina.com> <20250305224648.3058-1-hdanton@sina.com> <20250307060827.3083-1-hdanton@sina.com> <20250307104654.3100-1-hdanton@sina.com> <20250307112920.GB5963@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 7 Mar 2025 13:34:43 +0100 Oleg Nesterov <oleg@redhat.com>
> On 03/07, Oleg Nesterov wrote:
> > On 03/07, Hillf Danton wrote:
> > > On Fri, 7 Mar 2025 11:54:56 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
> > > >> step-03
> > > >> 	task-118766 new reader
> > > >> 	makes pipe empty
> > > >
> > > >Reader seeing a pipe full should wake up a writer allowing 118768 to
> > > >wakeup again and fill the pipe. Am I missing something?
> > > >
> > > Good catch, but that wakeup was cut off [2,3]
> 
> Please note that "that wakeup" was _not_ removed by the patch below.
> 
After another look, you did cut it.

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

> "That wakeup" is another wakeup pipe_read() does before return:
> 
> 	if (wake_writer)
> 		wake_up_interruptible_sync_poll(&pipe->wr_wait, ...);
> 
> And wake_writer must be true if this reader changed the pipe_full()
> condition from T to F.
> 
Could you read Prateek's comment again, then try to work out why he
did so?

> Note also that pipe_read() won't sleep if it has read even one byte.
> 
> > > [2] https://lore.kernel.org/lkml/20250304123457.GA25281@redhat.com/
> > > [3] https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/
> >
> > Why do you think
> >
> > 	[PATCH v2 1/1] pipe: change pipe_write() to never add a zero-sized buffer
> > 	https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/
> >
> > can make any difference ???
> >
> > Where do you think a zero-sized buffer with ->len == 0 can come from?
> 
> Oleg.

