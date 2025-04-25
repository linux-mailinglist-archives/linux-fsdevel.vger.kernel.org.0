Return-Path: <linux-fsdevel+bounces-47415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499F0A9D33C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 22:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7811C016A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDBD1FF7CD;
	Fri, 25 Apr 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mUOahFw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9F22539D;
	Fri, 25 Apr 2025 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614014; cv=none; b=eNELQ1buZLHvwx7a/VVdtVeRBn6BmCfVnwFW+LyINigByo9iI3ysqczVqimCzGssMyg+7PxgCBclpM/WGtmjd7bHWZ3y5gvX2NVppXvo4FJ2fBPhF3If378dLPG53mgvUVHmMU/sixHi5jDDEn1Bygia+I/1IpVPjCqWCeFWb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614014; c=relaxed/simple;
	bh=Q2j8AgYptvGhX1CCldmrMv0sriO+eLrH7eAydpVEGOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/QG1GIsdI7Vv4kRQKfojkX/pyerSuO/5vbNal/CP2daReOwq8wiuInSS11fFZIb0aQ3ODcJNf/HlcSXpXElriOUyQMuJO8CEefOTv62Mpq5We7/n59riqscyMnqSn8ISFRJh7wzXcirjqk37ySjrHnFGEx5Nlg9yYzLY7QE0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mUOahFw2; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745614010; x=1777150010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kTjNtVzivnzTy/oybVUy2SYwiaPHJOJ2MNj6K8muiDk=;
  b=mUOahFw2bRg2/ZZTnK1tgZh4lYHtmLRE1uIeV3SqW2UE8D9mFg1SH+aq
   /wS1k+jppQR6sA1N4LZwzVXed7PNeiyZ8G4N4kG4kx+26NhzMY0XSZhUR
   6j59R164V16tkFrlebzRK3TgrwhkqEPprMpPVumUXNw1lG3EJIrXK4dUT
   g=;
X-IronPort-AV: E=Sophos;i="6.15,240,1739836800"; 
   d="scan'208";a="483805900"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 20:46:46 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:11515]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.20:2525] with esmtp (Farcaster)
 id 6f09c9c8-3454-4d43-892c-532df97ba350; Fri, 25 Apr 2025 20:46:44 +0000 (UTC)
X-Farcaster-Flow-ID: 6f09c9c8-3454-4d43-892c-532df97ba350
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Apr 2025 20:46:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.164.216) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 25 Apr 2025 20:46:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <david@readahead.eu>, <edumazet@google.com>,
	<horms@kernel.org>, <jack@suse.cz>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <me@yhndnzj.com>, <netdev@vger.kernel.org>,
	<oleg@redhat.com>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 2/4] net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid
Date: Fri, 25 Apr 2025 13:46:05 -0700
Message-ID: <20250425204632.44889-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425-work-pidfs-net-v2-2-450a19461e75@kernel.org>
References: <20250425-work-pidfs-net-v2-2-450a19461e75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Apr 2025 10:11:31 +0200
> SO_PEERPIDFD currently doesn't support handing out pidfds if the
> sk->sk_peer_pid thread-group leader has already been reaped. In this
> case it currently returns EINVAL. Userspace still wants to get a pidfd
> for a reaped process to have a stable handle it can pass on.
> This is especially useful now that it is possible to retrieve exit
> information through a pidfd via the PIDFD_GET_INFO ioctl()'s
> PIDFD_INFO_EXIT flag.
> 
> Another summary has been provided by David in [1]:
> 
> > A pidfd can outlive the task it refers to, and thus user-space must
> > already be prepared that the task underlying a pidfd is gone at the time
> > they get their hands on the pidfd. For instance, resolving the pidfd to
> > a PID via the fdinfo must be prepared to read `-1`.
> >
> > Despite user-space knowing that a pidfd might be stale, several kernel
> > APIs currently add another layer that checks for this. In particular,
> > SO_PEERPIDFD returns `EINVAL` if the peer-task was already reaped,
> > but returns a stale pidfd if the task is reaped immediately after the
> > respective alive-check.
> >
> > This has the unfortunate effect that user-space now has two ways to
> > check for the exact same scenario: A syscall might return
> > EINVAL/ESRCH/... *or* the pidfd might be stale, even though there is no
> > particular reason to distinguish both cases. This also propagates
> > through user-space APIs, which pass on pidfds. They must be prepared to
> > pass on `-1` *or* the pidfd, because there is no guaranteed way to get a
> > stale pidfd from the kernel.
> > Userspace must already deal with a pidfd referring to a reaped task as
> > the task may exit and get reaped at any time will there are still many
> > pidfds referring to it.
> 
> In order to allow handing out reaped pidfd SO_PEERPIDFD needs to ensure
> that PIDFD_INFO_EXIT information is available whenever a pidfd for a
> reaped task is created by PIDFD_INFO_EXIT. The uapi promises that reaped
> pidfds are only handed out if it is guaranteed that the caller sees the
> exit information:
> 
> TEST_F(pidfd_info, success_reaped)
> {
>         struct pidfd_info info = {
>                 .mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT,
>         };
> 
>         /*
>          * Process has already been reaped and PIDFD_INFO_EXIT been set.
>          * Verify that we can retrieve the exit status of the process.
>          */
>         ASSERT_EQ(ioctl(self->child_pidfd4, PIDFD_GET_INFO, &info), 0);
>         ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
>         ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
>         ASSERT_TRUE(WIFEXITED(info.exit_code));
>         ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
> }
> 
> To hand out pidfds for reaped processes we thus allocate a pidfs entry
> for the relevant sk->sk_peer_pid at the time the sk->sk_peer_pid is
> stashed and drop it when the socket is destroyed. This guarantees that
> exit information will always be recorded for the sk->sk_peer_pid task
> and we can hand out pidfds for reaped processes.
> 
> Link: https://lore.kernel.org/lkml/20230807085203.819772-1-david@readahead.eu [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

