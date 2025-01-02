Return-Path: <linux-fsdevel+bounces-38335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132E9FFBA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 17:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EEF3A167B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 16:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24C14B08C;
	Thu,  2 Jan 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7f+x0EB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2E70814
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835638; cv=none; b=V213xcuNHyi6hyJe3ptWZ5n5JqOPpvr4EpJ0++UEJfz6zzbvv1V3FNlEwm397tnpAnPV5WZlbHCFTLTqobDCGy//gljtqzPl03tLdHXPto7ZY7PG9l/KIrlH4bKwSiSa3+5zCUBIgGo0LaIg1ImpyuAlSHzEgF+0yZvgkyCXXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835638; c=relaxed/simple;
	bh=GJyV6RC1G9scYkTqmswNWIYnRS9BXqsVCCgr0G/MrlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhjfgJ+OM/MuHaJ01JM67mZWaPZvmgT1LV9t7wAwPHEXqk+kBy6cqvCOjoS6U/plRsPUWjMzQfoH7d0UnvaY3ilYnxixue3SKReA6dYXTZ+LYKVySX68EVxNh7l/UenZ6SDcEKyIY0qqxE6K7j0oJQz9MV51qXaOggOGEOLAkHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7f+x0EB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735835633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pChq+YBV4R1ZsMZryOabHA5VhHF+4Dc111SPJ8z0saY=;
	b=O7f+x0EBtB3YFrDelRT2PlzR3eOCJep7bxEKPoL5sQ+n4k+5kM0OiyeVCUmlPUZ0+OcIzR
	wSFzL24bC6ZZarq9bMJA/epccuP8VYfT5qt9Wsmi3f6CV1Upr//B8YaTJN8/H3Y7+BOnIt
	KZbbVBC33dvxot8i8FYdC/MMP4IjF18=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-a3YmlZkTPuema5eqLEGOfA-1; Thu,
 02 Jan 2025 11:33:50 -0500
X-MC-Unique: a3YmlZkTPuema5eqLEGOfA-1
X-Mimecast-MFC-AGG-ID: a3YmlZkTPuema5eqLEGOfA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F100A1955F08;
	Thu,  2 Jan 2025 16:33:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D03473000197;
	Thu,  2 Jan 2025 16:33:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  2 Jan 2025 17:33:24 +0100 (CET)
Date: Thu, 2 Jan 2025 17:33:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: wakeup_pipe_readers/writers() && pipe_poll()
Message-ID: <20250102163320.GA17691@redhat.com>
References: <20241229135737.GA3293@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241229135737.GA3293@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I was going to send a one-liner patch which adds mb() into pipe_poll()
but then I decided to make even more spam and ask some questions first.

	static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
	{
		smp_mb();
		if (waitqueue_active(&pipe->rd_wait))
			wake_up_interruptible(&pipe->rd_wait);
		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
	}

I think that wq_has_sleeper() + wake_up_interruptible_poll(POLLIN) make more
sense but this is minor.

Either way the waitqueue_active() check is only correct if the waiter has a
barrier between __add_wait_queue() and "check the condition". wait_event()
is fine, but pipe_poll() does:

	// poll_wait()
	__pollwait() -> add_wait_queue(pipe->rd_wait) -> list_add()

	READ_ONCE(pipe->head);
	READ_ONCE(pipe->tail);

In theory these LOAD's can leak into the critical section in add_wait_queue()
and they can happen before list_add(entry, rd_wait.head).

So I think we need the trivial

	--- a/fs/pipe.c
	+++ b/fs/pipe.c
	@@ -680,6 +680,7 @@ pipe_poll(struct file *filp, poll_table *wait)
		 * if something changes and you got it wrong, the poll
		 * table entry will wake you up and fix it.
		 */
	+	smp_mb();
		head = READ_ONCE(pipe->head);
		tail = READ_ONCE(pipe->tail);

and after that pipe_read/pipe_write can use the wq_has_sleeper() check too
(this is what the patch from WangYuli did).

-------------------------------------------------------------------------------
But perhaps this mb() should go into __pollwait() ? We can have more
waitqueue_active() users which do not take .poll() into account...

The are more init_poll_funcptr()'s, but at least epoll looks fine,
epi_fget() in ep_item_poll() provides a full barrier before vfs_poll().

-------------------------------------------------------------------------------
Or really add mb() into __add_wait_queue/__add_wait_queue_entry_tail as
Manfred suggests? Somehow I am not sure about this change.

Oleg.


