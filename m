Return-Path: <linux-fsdevel+bounces-45270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2BAA75697
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F6616E7C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E11CFEC3;
	Sat, 29 Mar 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvJaLT+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074901D5ADE
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743258152; cv=none; b=mC8A6pJdipHU7rpc1oYO+b6IUEdTG0j6vxkPD2EHyGad93vmkoeC/Eh6VBiYFfG74klY7nC/T69jwbBvIc+pu112xkAAxSUPhZ+JGiw7BvQkCkQqvDtzmN/G5ugdCmuACVs2bVLEQU8HRSSddf4pscwEKfgucthodpMlkbpkIjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743258152; c=relaxed/simple;
	bh=/I6H4s9GOaBgLTyzZBibv5a29XVJ28Rr+JwaWuJyJkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJVTymBXw9jfTG/enH+dxEuRUrHtSfpSmS3loGfNllKb+ytuednEO462MISt8psaaDCLH3HXaXWApIiqO6QAsS2+sA4RhQwk5jSRUZfpZe/NeDidfR8U5GlAemRcCMR90lj6mpBQlGxewN4SjhmghAyvkl9+Hjg0dqI+dmTA3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvJaLT+w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743258150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cw4rpcZvmTDlrAmFogt4iV7TrragRM8ByhrNacJd/I4=;
	b=gvJaLT+wFIQMQ1Lh7I2yvqwezmuxSMPTBKVZ/G1ATMFRMg6hK+083PrJCQpQh9JWEgzbu3
	x7l2YdDvmyOXSCSfqlLIdQJMBPh35QxuPBPRU20VuhoD7rYG+cF2SU8fFXx1qN7poTkzP4
	fjxBYQ+Yhzas1q3q+dNJF3i/Gl09+Js=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-xkFppxFqO6CGI1faeSn_QQ-1; Sat,
 29 Mar 2025 10:22:24 -0400
X-MC-Unique: xkFppxFqO6CGI1faeSn_QQ-1
X-Mimecast-MFC-AGG-ID: xkFppxFqO6CGI1faeSn_QQ_1743258142
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D12D19373D7;
	Sat, 29 Mar 2025 14:22:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.25])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D359819560AB;
	Sat, 29 Mar 2025 14:22:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 29 Mar 2025 15:21:47 +0100 (CET)
Date: Sat, 29 Mar 2025 15:21:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: asmadeus@codewreck.org
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, ericvh@kernel.org,
	jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com,
	netfs@lists.linux.dev, swapnil.sapkal@amd.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250329142138.GA9144@redhat.com>
References: <20250328144928.GC29527@redhat.com>
 <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
 <20250328170011.GD29527@redhat.com>
 <Z-c4B7NbHM3pgQOa@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-c4B7NbHM3pgQOa@codewreck.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

First of all, let me remind that I know nothing about 9p or netfs ;)
And I am not sure that my patch is the right solution.

I am not even sure we need the fix, according to syzbot testing the
problem goes away with the fixes from David
https://web.git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes
but I didn't even try to read them, this is not my area.

Now, I'll try to answer some of your questions, but I can be easily
wrong.

On 03/29, asmadeus@codewreck.org wrote:
>
> Right, so your patch sounds better than Prateek's initial blowing
> up workaround, but it's a bit weird anyway so let me recap:
> - that syz repro has this unnatural pattern where the replies are all
> written before the requests are sent

Yes,

> - 9p_read_work() (read worker) has an optimization that if there is no
> in fly request then there obviously must be nothing to read (9p is 100%
> client initiated, there's no way the server should send something
> first), so at this point the reader task is idle

Yes. But note that it does kernel_read() -> pipe_read() before it becomes
idle. See below.

> - p9_fd_request() (sending a new request) has another optimization that
> only checks for tx: at this point if another request was already in
> flight then the rx task should have a poll going on for rx, and if there
> were no in flight request yet then there should be no point in checking
> for rx, so p9_fd_request() only kick in the tx worker if there is room
> to send

Can't comment, but

> - at this point I don't really get the logic that'll wake the rx thread
> up either... p9_pollwake() will trigger p9_poll_workfn()
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Yes, but where this p9_pollwake() can come from? see below.

> - due to the new optimization (aaec5a95d59615 "pipe_read: don't wake up
> the writer if the pipe is still full"), that 'if there is room to send'
> check started failing and tx thread doesn't start?

Again, I can be easily wrong, but no.

With or without the optimization above, it doesn't make sense to start
the tx thread when the pipe is full, p9_fd_poll() can't report EPOLLOUT.

Lets recall that the idle read worker did kernel_read() -> pipe_read().
Before this optimization, pipe_read() did the unnecessary

	wake_up_interruptible_sync_poll(&pipe->wr_wait);

when the pipe was full before the reading _and_ is still full after the
reading.

This wakeup calls p9_pollwake() which kicks p9_poll_workfn().

p9_poll_workfn() calls p9_poll_mux().

p9_poll_mux() does n = p9_fd_poll().

"n & EPOLLOUT" is false, exactly because this wakeup was unnecessary,
so p9_poll_mux() won't do schedule_work(&m->wq), this is fine,

But, "n & EPOLLIN" is true, so p9_poll_mux() does schedule_work(&m->rq)
and wakes the rx thread.

p9_read_work() is called again. It reads more data and (I guess) notices
some problem and does p9_conn_cancel(EIO).

This no longer happens after the optimization. So in some sense the
p9_fd_request() -> p9_poll_mux() hack (which wakes the rx thread in this
case) restores the old behaviour.

But again, again, quite possibly I completely misread this (nontrivial)
code.

Oleg.


