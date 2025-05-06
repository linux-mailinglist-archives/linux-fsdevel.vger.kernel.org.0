Return-Path: <linux-fsdevel+bounces-48288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AADFAACE06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322BF1C08947
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5AA205ABB;
	Tue,  6 May 2025 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rqJnXozN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BFD72624;
	Tue,  6 May 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559780; cv=none; b=faWhKhOu5EKqKn5p/Id3CSlau/MajUDow+hs9CkO07+U4Hbdt726BpJs7+pfBwRlFUijmx0z7oS1atIW8iwvYnq+rlkW5gOA7sjs80dKkiwAi13jKXPKwg1NprLbuWUSZXvIOiRTKwpESZKHz5hUdIkQ/DxoHz/y0n+5z15oK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559780; c=relaxed/simple;
	bh=b1VVsab0OH/DxDyZuw5vIf9OGWV1aWvyxGG6Y4CMI48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdFuv/ni8y1Gs8vwIJ8YW57EJFHyURPwT0YRRjj4C6idhPEzpmbL5A2d9qznfa3eCkyQSvg1sNdt7wJ+j+xuQdbMuBs2ro/11KwxYnAox4ueFq/sHVSPNdHXIAKlt+rx73lgK7v2JnRyt83gUa6X8xpoJvYDyW0buLeHQeCPpqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rqJnXozN; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746559779; x=1778095779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eCdDBNAJ30AvlG3uxF4+zSKk9L3XGdJAilQrs6Phzuw=;
  b=rqJnXozNH3EqnifXC+klhiOAIS2EZF3dHwUniQAC9LnfNJV2SKE0wLCK
   1kCEE3PF/VUMAyVDDd6PjQdNkwlumjN7wcvxcUulPKIUR26gBOF3Ho3hN
   dDIV8vHq5UQ/Xyt2aA6EAMSsws1SJZSZw4eLFY6cgUTVli9qINnNp/XvY
   4=;
X-IronPort-AV: E=Sophos;i="6.15,267,1739836800"; 
   d="scan'208";a="487328028"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 19:29:33 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:23426]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.231:2525] with esmtp (Farcaster)
 id e0cbbc4a-76b6-456b-b756-aa36bf60c849; Tue, 6 May 2025 19:29:33 +0000 (UTC)
X-Farcaster-Flow-ID: e0cbbc4a-76b6-456b-b756-aa36bf60c849
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 19:29:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 19:29:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <david@readahead.eu>, <edumazet@google.com>,
	<horms@kernel.org>, <jack@suse.cz>, <jannh@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <lennart@poettering.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping tasks to connect to coredump socket
Date: Tue, 6 May 2025 12:28:44 -0700
Message-ID: <20250506192920.17567-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506-buchmacher-gratulant-9960af036671@brauner>
References: <20250506-buchmacher-gratulant-9960af036671@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Tue, 6 May 2025 17:16:13 +0200
> On Tue, May 06, 2025 at 04:51:25PM +0200, Jann Horn wrote:
> > On Tue, May 6, 2025 at 9:39 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > ("a kernel socket" is not necessarily the same as "a kernel socket
> > > > intended for core dumping")
> > >
> > > Indeed. The usermodehelper is a kernel protocol. Here it's the task with
> > > its own credentials that's connecting to a userspace socket. Which makes
> > > this very elegant because it's just userspace IPC. No one is running
> > > around with kernel credentials anywhere.
> > 
> > To be clear: I think your current patch is using special kernel
> > privileges in one regard, because kernel_connect() bypasses the
> > security_socket_connect() security hook.

Precisely, whether LSM ignores kernel sockets or not depends on LSM.

When we create a socket, kern=0/1 is passed to security_socket_create().
Currently, SELinux always ignore the kernel socket, and AppArmor depends
on another condition.  Other LSM doesn't care.  Especially, BPF LSM is
just a set of functions to attach BPF programs, so it can enfoce whatever.


> I think it is a good thing
> > that it bypasses security hooks in this way; I think we wouldn't want
> > LSMs to get in the way of this special connect(), since the task in
> > whose context the connect() call happens is not in control of this
> > connection; the system administrator is the one who decided that this
> > connect() should happen on core dumps. It is kind of inconsistent
> > though that that separate security_unix_stream_connect() LSM hook will
> > still be invoked in this case, and we might have to watch out to make
> > sure that LSMs won't end up blocking such connections... which I think
> 
> Right, it is the same as for the usermode helper. It calls
> kernel_execve() which invokes at least security_bprm_creds_for_exec()
> and security_bprm_check(). Both of which can be used to make the
> usermodehelper execve fail.
> 
> Fwiw, it's even the case for dumping directly to a file as in that case
> it's subject to all kinds of lookup and open security hooks like
> security_file_open() and then another round in do_truncate().
> 
> All of that happens fully in the task's context as well via
> file_open()/file_open_root() or do_truncate().
> 
> So there's nothing special here.

