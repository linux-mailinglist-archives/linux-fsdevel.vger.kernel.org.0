Return-Path: <linux-fsdevel+bounces-48525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C494AB0583
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 23:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103541BC54E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F439224235;
	Thu,  8 May 2025 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IC0yX2kZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F425CB8;
	Thu,  8 May 2025 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746740951; cv=none; b=PS3SFVqFA9tz58PfQFgSD4E6qfi64quEwwmBI9xdMWzBXWa8KLWBHnRNfs512kQ4mStrTDTaHQAU4FXFLO6DZFhY6XVXiFOarGXzF7aUZb47Y/WYlxI27CiGdgxA4+pCv9a6KDwDgl/z1SA/mM5CwpE4N5RnSzTVNArdGKVmrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746740951; c=relaxed/simple;
	bh=H0urki9LI3KNRa5Q+wG6DOyvCUCtfMf7YdnpvEjI7T0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBJzI2LgtFhSgqZft0kXJpjA1FsBT7yzecnL5sCbF9CziQQoaP+GWgfo43PWCb24f8p+/rH40hq1iz0AgvtKq9pofPDrpduHf7t5KOR4ex2twZd5lwz+cGvIWQV4OYuWORMIk31dgl4dyelfeMWxSg0iyD42asTVPHDBGnQ9KFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IC0yX2kZ; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746740950; x=1778276950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XMr3FDaYMjbSHc+Mc/4xTQjKYDslKxhh7yEkIw02wOc=;
  b=IC0yX2kZV4gdyzBgWqgvI3hRxa1hF0/wwVgz2f20jrl5YLIzMcBpyJBZ
   j57NLL6K+ytVlBQeB6IwOJNl1wLkM6V4PfxFcPG17MGA7YNLMc+1Obu/P
   rqgNKug2dnxRMarx/w322VM5R9MBjI5PjwvsqLydXD6v2swx9FR/cpvEf
   pkpKJ45V8/2ImRpjWpGy8kanjL3Pe7JmkaYNVPFAk6rIdw8hBdsr/sUm+
   GfRmX5iaXvykO6amPbKZDCByk6ZLHDX3I1xeMSQaWvVzlj8y89uomqjdS
   K+BoVcvKvXIvayaZbGESWpCG0Osh5gInieRVqGXdoF2NP/q/NhyrpYZIl
   A==;
X-IronPort-AV: E=Sophos;i="6.15,273,1739836800"; 
   d="scan'208";a="91374175"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 21:49:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:8301]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id 8e2af0a3-db14-4683-9fa1-2122160a051f; Thu, 8 May 2025 21:49:04 +0000 (UTC)
X-Farcaster-Flow-ID: 8e2af0a3-db14-4683-9fa1-2122160a051f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 21:49:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 21:48:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <david@readahead.eu>, <edumazet@google.com>,
	<horms@kernel.org>, <jack@suse.cz>, <jannh@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <lennart@poettering.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH v4 04/11] net: reserve prefix
Date: Thu, 8 May 2025 14:47:45 -0700
Message-ID: <20250508214850.62973-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508-vorboten-herein-4ee71336e6f7@brauner>
References: <20250508-vorboten-herein-4ee71336e6f7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Thu, 8 May 2025 08:16:29 +0200
> On Wed, May 07, 2025 at 03:45:52PM -0700, Kuniyuki Iwashima wrote:
> > From: Christian Brauner <brauner@kernel.org>
> > Date: Wed, 07 May 2025 18:13:37 +0200
> > > Add the reserved "linuxafsk/" prefix for AF_UNIX sockets and require
> > > CAP_NET_ADMIN in the owning user namespace of the network namespace to
> > > bind it. This will be used in next patches to support the coredump
> > > socket but is a generally useful concept.
> > 
> > I really think we shouldn't reserve address and it should be
> > configurable by users via core_pattern as with the other
> > coredump types.
> > 
> > AF_UNIX doesn't support SO_REUSEPORT, so once the socket is
> > dying, user can't start the new coredump listener until it's
> > fully cleaned up, which adds unnecessary drawback.
> 
> This really doesn't matter.
> 
> > The semantic should be same with other types, and the todo
> > for the coredump service is prepare file (file, process, socket)
> > that can receive data and set its name to core_pattern.
> 
> We need to perform a capability check during bind() for the host's
> coredump socket. Otherwise if the coredump server crashes an
> unprivileged attacker can simply bind the address and receive all
> coredumps from suid binaries.

As I mentioned in the previous thread, this can be better
handled by BPF LSM with more fine-grained rule.

1. register a socket with its name to BPF map
2. check if the destination socket is registered at connect

Even when LSM is not availalbe, the cgroup BPF prog can make
connect() fail if the destination name is not registered
in the map.

> 
> This is also a problem for legitimate coredump server updates. To change
> the coredump address the coredump server must first setup a new socket
> and then update core_pattern and then shutdown the old coredump socket.

So, for completeness, the server should set up a cgroup BPF
prog to route the request for the old name to the new one.

Here, the bpf map above can be reused to check if the socket
name is registered in the map or route to another socket in
the map.

Then, the unprivileged issue below and the non-dumpable issue
mentioned in the cover letter can also be resolved.

The server is expected to have CAP_SYS_ADMIN, so BPF should
play a role.


> 
> Now an unprivileged attacker can rebind the old coredump socket address
> but there's still a crashing task that got scheduled out after it copied
> the old coredump server address but before it connected to the coredump
> server. The new server is now up and the old server's address has been
> reused by the attacker. Now the crashing task gets scheduled back in and
> connects to the unprivileged attacker and forwards its suid dump to the
> attacker.
> 
> The name of the socket needs to be protected. This can be done by prefix
> but the simplest way is what I did in my earlier version and to just use
> a well-known name. The name really doesn't matter and all it adds is
> potential for subtle bugs. I want the coredump code I have to maintain
> to have as little moving parts as possible.
> 
> I'm happy to drop the patch to reserve the prefix as that seems to
> bother you. But the coredump socket name won't be configurable. It'd be
> good if we could just compromise here. Without the capability check on
> bind we can just throw this all out as that's never going to be safe.

