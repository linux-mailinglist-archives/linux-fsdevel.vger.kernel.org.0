Return-Path: <linux-fsdevel+bounces-48121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46922AA9C30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4CF3AD29B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 19:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C5726B95A;
	Mon,  5 May 2025 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z0fUyD5u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312F15E5C2;
	Mon,  5 May 2025 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471867; cv=none; b=R+ux/lOTQezowDyc5p6E9MGHJTS0WWq8PQYRAnVCVRk4O8uyBdPEhb4LX0c0Jw2UB4vrcAS5wvwFFz7N3eybO3wVJrD4gLt8gJW58xFOi+2cU7sOfZh9AfZw8FqhygVGyyd/8gBXlR2iTwF9TASw2/CHUTivazW6QpVOIZCuJc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471867; c=relaxed/simple;
	bh=izSms8sGQYUggHY9S7UnMpJnXxKmpSogXKQNsa3cjNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhfOO2kS2ruMF8FyU/2IoRVFA6NU8aDTaQGS8uNN9HRurjwOVMNModZmma8+6IiaKx/OITausuEfi7ML1BiuwWnYoZ5f8uPAnqxlIiWpbylAROAfvknUuF9t/iD+Nr5uNQAQ0//IVOdCKO+Pvmz2VYqz1L5eTvlZq8gRW/BHnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z0fUyD5u; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746471865; x=1778007865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Td4vvOerswAkNrGkBojxfVVI0SbWMNHg1n7xxwnPCEI=;
  b=Z0fUyD5uNj2OCdXaSjLZLz9JjTYHsQdEVmS0C3P8OC84jASNoWXgIcs1
   0O/Nj4oCQu+DFawYo/NN1krdDyhjHnIAXpZ33pReu1KaKwjnm/VL+w29U
   4Ly6SwVnGtE0/VvHo94eTgxtgx/xGTphBotXxX5ITMuKafiD2H997diSy
   4=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="47006807"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 19:04:23 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:17651]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.224:2525] with esmtp (Farcaster)
 id cc72ab76-5240-4688-ba15-e4cd5000e079; Mon, 5 May 2025 19:04:23 +0000 (UTC)
X-Farcaster-Flow-ID: cc72ab76-5240-4688-ba15-e4cd5000e079
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 19:04:22 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 19:04:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <bluca@debian.org>, <daan.j.demeyer@gmail.com>, <davem@davemloft.net>,
	<david@readahead.eu>, <edumazet@google.com>, <horms@kernel.org>,
	<jack@suse.cz>, <jannh@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <me@yhndnzj.com>, <netdev@vger.kernel.org>,
	<oleg@redhat.com>, <pabeni@redhat.com>, <viro@zeniv.linux.org.uk>,
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH RFC v2 3/6] coredump: support AF_UNIX sockets
Date: Mon, 5 May 2025 12:03:50 -0700
Message-ID: <20250505190410.17360-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503-gegessen-trugen-6474e70e59df@brauner>
References: <20250503-gegessen-trugen-6474e70e59df@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Sat, 3 May 2025 07:17:10 +0200
> On Fri, May 02, 2025 at 10:23:44PM +0200, Jann Horn wrote:
> > On Fri, May 2, 2025 at 10:11 PM Christian Brauner <brauner@kernel.org> wrote:
> > > On Fri, May 02, 2025 at 04:04:32PM +0200, Jann Horn wrote:
> > > > On Fri, May 2, 2025 at 2:42 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > diff --git a/fs/coredump.c b/fs/coredump.c
> > > > [...]
> > > > > @@ -801,6 +841,73 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> > > > >                 }
> > > > >                 break;
> > > > >         }
> > > > > +       case COREDUMP_SOCK: {
> > > > > +               struct file *file __free(fput) = NULL;
> > > > > +#ifdef CONFIG_UNIX
> > > > > +               ssize_t addr_size;
> > > > > +               struct sockaddr_un unix_addr = {
> > > > > +                       .sun_family = AF_UNIX,
> > > > > +               };
> > > > > +               struct sockaddr_storage *addr;
> > > > > +
> > > > > +               /*
> > > > > +                * TODO: We need to really support core_pipe_limit to
> > > > > +                * prevent the task from being reaped before userspace
> > > > > +                * had a chance to look at /proc/<pid>.
> > > > > +                *
> > > > > +                * I need help from the networking people (or maybe Oleg
> > > > > +                * also knows?) how to do this.
> > > > > +                *
> > > > > +                * IOW, we need to wait for the other side to shutdown
> > > > > +                * the socket/terminate the connection.
> > > > > +                *
> > > > > +                * We could just read but then userspace could sent us
> > > > > +                * SCM_RIGHTS and we just shouldn't need to deal with
> > > > > +                * any of that.
> > > > > +                */
> > > >
> > > > I don't think userspace can send you SCM_RIGHTS if you don't do a
> > > > recvmsg() with a control data buffer?
> > >
> > > Oh hm, then maybe just a regular read at the end would work. As soon as
> > > userspace send us anything or we get a close event we just disconnect.
> > >
> > > But btw, I think we really need a recvmsg() flag that allows a receiver
> > > to refuse SCM_RIGHTS/file descriptors from being sent to it. IIRC, right
> > > now this is a real issue that systemd works around by always calling its
> > > cmsg_close_all() helper after each recvmsg() to ensure that no one sent
> > > it file descriptors it didn't want. The problem there is that someone
> > > could have sent it an fd to a hanging NFS server or something and then
> > > it would hang in close() even though it never even wanted any file
> > > descriptors in the first place.
> > 
> > Would a recvmsg() flag really solve that aspect of NFS hangs? By the
> > time you read from the socket, the file is already attached to an SKB
> > queued up on the socket, and cleaning up the file is your task's
> > responsibility either way (which will either be done by the kernel for
> > you if you don't read it into a control message, or by userspace if it
> > was handed off through a control message).

Right.  recvmsg() is too late.  Once sendmsg() is done, the last
fput() responsibility could fall on the receiver.

Btw, I was able to implement the cmsg_close_all() equivalent at
sendmsg() with BPF LSM to completely remove the issue.

I will send a series shortly and hope you like it :)


> > The process that sent the
> > file to you might already be gone, it can't be on the hook for
> > cleaning up the file anymore.
> 
> Hm, I guess the unix_gc() runs in task context? I had thought that it
> might take care of that.

Note that unix_gc() is a garbage collector only for AF_UNIX fds
that have circular dependency:

  1) AF_UNIX sk1 sends its fd to itself

  2) AF_UNIX sk1 sends its fd to AF_UNIX sk2 and
     AF_UNIX sk2 sends its fd to AF_UNIX sk1

In these examples, file refcnts remain even after close() by all
users of fds.

So, the GC is not a mechanism to deligate fput() for fds sent
by SCM_RIGHTS.

