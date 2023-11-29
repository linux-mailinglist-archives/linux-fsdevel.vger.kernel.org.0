Return-Path: <linux-fsdevel+bounces-4162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B317FD109
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 09:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89812B20D5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2118125A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULPuEbG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0994171D
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 23:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701244605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XVJzeZJEEP99YOFg+7LBm3jmK+UXJ6uuy5vlWFPjto=;
	b=ULPuEbG+c6I7GBxd0qMZz1pNHne17c6kbmTf0H01kUp97YP4TXm/LyOMG83vYl84Qb3/yk
	YeK9iooH5IgUcB9WK2gpNRqU3jfjPxI0Y/NSJh8q59t+ZirHOhpf9/6FH7ztdWlJy/BrCt
	aIhsIiOryYBaSbiZDneFFd1L5V7DEjM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-q1J4E3tAN_qM_svTR0TLDg-1; Wed,
 29 Nov 2023 02:56:42 -0500
X-MC-Unique: q1J4E3tAN_qM_svTR0TLDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 889D91C05137;
	Wed, 29 Nov 2023 07:56:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id 5A8EC2166B26;
	Wed, 29 Nov 2023 07:56:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 29 Nov 2023 08:55:36 +0100 (CET)
Date: Wed, 29 Nov 2023 08:55:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231129075532.GE22743@redhat.com>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <20231128140156.GC22743@redhat.com>
 <170121686264.7109.13475581089284671405@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170121686264.7109.13475581089284671405@noble.neil.brown.name>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 11/29, NeilBrown wrote:
>
> On Wed, 29 Nov 2023, Oleg Nesterov wrote:
> > On 11/28, NeilBrown wrote:
> > >
> > > I have evidence from a customer site of 256 nfsd threads adding files to
> > > delayed_fput_lists nearly twice as fast they are retired by a single
> > > work-queue thread running delayed_fput().  As you might imagine this
> > > does not end well (20 million files in the queue at the time a snapshot
> > > was taken for analysis).
> >
> > On a related note... Neil, Al, et al, can you look at
> >
> > 	[PATCH 1/3] fput: don't abuse task_work_add() when possible
> > 	https://lore.kernel.org/all/20150908171446.GA14589@redhat.com/
> >
>
> Would it make sense to create a separate task_struct->delayed_fput
> llist?

Sure, I too thought about this,

> fput() adds the file to this llist and if it was the first item on the
> list, it then adds the task_work.  That would probably request adding a
> callback_head to struct task_struct as well.

Even simpler, but perhaps I missed something...

We can add a "struct file *fput_xxx" into task_struct and f_fput_xxx into
the f_llist/f_rcuhead union in the struct file.

fput:

	if (task->fput_xxx) {
		file->f_fput_xxx = task->fput_xxx;
		task->fput_xxx = file;
	} else {
		task_work_add(...);
		// XXX: file->f_fput_xxx != NULL
		task->fput_xxx = file;
	}

____fput:

	struct file *file = task->fput_xxx;
	struct file *tail = container_of(work, ...);
	// see XXX in fput()
	tail->f_fput_xxx = NULL;
	current->fput_xxx = NULL;

	do {
		next = READ_ONCE(file->f_fput_xxx);
		__fput(file);
		file = next;
		
	} while (file);
	
Again, quite possibly I missed something, but something like this should work.

But I am still trying to find a simpler solution which doesn't need another
member in task_struct...

Oleg.


