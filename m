Return-Path: <linux-fsdevel+bounces-45080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44372A7168D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 13:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA2D17AE2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B34E1E1DFA;
	Wed, 26 Mar 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uzb5c2wB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C1282EB
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991639; cv=none; b=oywfi8PASAss8ykPi0S/jIFmI3wgVBCHnDBT8A4cNMbAVoR1g9TXq3xiJC2IN1uIj46OVWbTi64p+4y4oUzLvGV+Q9Hfo2JrrvA45FJGuwnCI4mRWuS0at2LPGFWdTYzfJCDGqtmvgv8/xnI7er0apGiHr9DiikKp3hxZAAnWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991639; c=relaxed/simple;
	bh=oB97UR995YJidx7mdQ24ry8ekUxJMV2kMRCZzk3UHwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P12h7hLKJayvYxwK8J0QHguOUAayl/I5YAg7ZiDQeZykC0vK0REJnoD5kyHY3P3REGB3pi6ft3Jf/2Mz9iWN7NqiqlrBYLeSlyjmQ9v5WAlQWFLydntS8YWESkNHWFKd4JEwnc3+JqnZoence5VCc8lEeqmFXvGKuP3uIHC5eF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uzb5c2wB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742991637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i8x6UfLnUw1upoXZy33JkZov0HjgV0Ec52Fp2dvYxrg=;
	b=Uzb5c2wBkw8HcfgEi8HSYYQa31XrIHQT+3LIBoGZFIB+IgsF4RYXhh044mhEtXyUQbLx5E
	A1kx9YOKwdfbCeOL+0ks85I7APwYs1QtSs42e09UbpHjGnzAAWtjYTZ7nkFz5FM/XXze6u
	jiYGLLStUmYNU9rPIykGKzodD/b3E0k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-nNCzR81EOFiT5AIR52ennA-1; Wed,
 26 Mar 2025 08:20:31 -0400
X-MC-Unique: nNCzR81EOFiT5AIR52ennA-1
X-Mimecast-MFC-AGG-ID: nNCzR81EOFiT5AIR52ennA_1742991629
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DCE3180025A;
	Wed, 26 Mar 2025 12:20:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0782C180A803;
	Wed, 26 Mar 2025 12:20:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Mar 2025 13:19:55 +0100 (CET)
Date: Wed, 26 Mar 2025 13:19:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250326121946.GC30181@redhat.com>
References: <20250323210251.GD14883@redhat.com>
 <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
 <20250325121526.GA7904@redhat.com>
 <20250325130410.GA10828@redhat.com>
 <f855a988-d5e9-4f5a-8b49-891828367ed7@amd.com>
 <Z-LEsPFE4e7TTMiY@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-LEsPFE4e7TTMiY@codewreck.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/25, Dominique Martinet wrote:
>
> Thanks for the traces.
>
> w/ revert
> K Prateek Nayak wrote on Tue, Mar 25, 2025 at 08:19:26PM +0530:
> >    kworker/100:1-1803    [100] .....   286.618822: p9_fd_poll: p9_fd_poll rd poll
> >    kworker/100:1-1803    [100] .....   286.618822: p9_fd_poll: p9_fd_request wr poll
> >    kworker/100:1-1803    [100] .....   286.618823: p9_read_work: Data read wait 7
>
> new behavior
> >            repro-4076    [031] .....    95.011394: p9_fd_poll: p9_fd_poll rd poll
> >            repro-4076    [031] .....    95.011394: p9_fd_poll: p9_fd_request wr poll
> >            repro-4076    [031] .....    99.731970: p9_client_rpc: Wait event killable (-512)
>
> For me the problem isn't so much that this gets ERESTARTSYS but that it
> nevers gets to read the 7 bytes that are available?

Yes...

OK, lets first recall what the commit aaec5a95d59615523 ("pipe_read:
don't wake up the writer if the pipe is still full") does.
It simply removes the unnecessary/spurious wakeups when the writer
can't add more data to the pipe.

See the "stupid test-cas" in
https://lore.kernel.org/all/20250120144338.GC7432@redhat.com/

In particular this note:

	As you can see, without this patch pipe_read() wakes the writer up
	4095 times for no reason, the writer burns a bit of CPU and blocks
	again after wakeup until the last read(fd[0], &c, 1).

in this test-case the writer sleeps in pipe_write(), but the same is true
for the task sleeping in poll( { .fd = pipe_fd, .events = POLLOUT}, ...).

Now, after some grepping I have found

	static void p9_conn_create(struct p9_client *client)
	{
		...
	
		init_poll_funcptr(&m->pt, p9_pollwait);

		n = p9_fd_poll(client, &m->pt, NULL);

		...
	}

So, iiuc, in this case p9_fd_poll(&m->pt /* != NULL */) -> p9_pollwait()
paths will add the "dummy" pwait->wait entries with ->func = p9_pollwake
to pipe_inode_info.rd_wait and pipe_inode_info.wr_wait.

Hmm... I don't understand why the 2nd vfs_poll(ts->wr) depends on the
ret from vfs_poll(ts->rd), but I assume this is correct.

This means that every time pipe_read() does wake_up(&pipe->wr_wait)
p9_pollwake() is called. This function kicks p9_poll_workfn() which
calls p9_poll_mux() which calls p9_fd_poll() again with pt == NULL.

In this case the conditional vfs_poll(ts->wr) looks more understandable...

So. Without the commit above, p9_poll_mux()->p9_fd_poll() can be called
much more often and, in particular, can report the "additional" EPOLLIN.

Can this somehow explain the problem?

Oleg.


