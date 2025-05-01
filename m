Return-Path: <linux-fsdevel+bounces-47791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11299AA590D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 02:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F28B463406
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8491AAA29;
	Thu,  1 May 2025 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="o0aguuBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CE19F421;
	Thu,  1 May 2025 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746059465; cv=none; b=qQMr2z4ww06CptxGAXDZxWQpH/g0uaJ11g5+mvVrNQoHhc9DzyWhOa5X8EC7JxA3AC30jhb8mV+R1T5DDtl598tnfglHcMiyFxX5yEVTYdYlaCqeNmjzzP1ryl+jfPfwb1hesQvVhPeqf3tnpDQiReB8EKFDgBABJRpcNx8dPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746059465; c=relaxed/simple;
	bh=Ci0DwSkdku8GewOdySf7cTEu3of/g50Vqk+aMKizZGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QE0NxB8BdtXS7WbJOwPwNvt8/H1hgRl5gN2h5ZIg38KAWvJ+bCASbJL9Y3Kh6TpHzuhxbYWE0rXR8pM4xDTXPAjZnyoFXyPYczDZLLzc/SVjQmpPEPzhqgHsK6DVxshHjmkKBA5EzZg64emitLfwbKpFUssYfoJrj7L/YpQ/fOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=o0aguuBk; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746059463; x=1777595463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9S7Rq8JOZsTFJ9lLP4FliEFT/hASyEX4dw+STGpWrg4=;
  b=o0aguuBkifPhu0e+YKdkVC23huP9c2CT+g5XqR2uW4azrUcP9cx58+W3
   ng8gquh3tgJOac24dT/6j15pyrh2OqfEHz7Ei+myBvnVQQL9kHArQ2tc4
   wfi3Zj7c3hHe0Dm75bFau/VxCW6vuKbkz1cqg9Cbuf4Cyeg4s9jfbK1rP
   g=;
X-IronPort-AV: E=Sophos;i="6.15,253,1739836800"; 
   d="scan'208";a="196066862"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 00:31:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:64656]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.114:2525] with esmtp (Farcaster)
 id 0c9374d3-d797-4853-a843-2daf2ecffefa; Thu, 1 May 2025 00:31:01 +0000 (UTC)
X-Farcaster-Flow-ID: 0c9374d3-d797-4853-a843-2daf2ecffefa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 00:31:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 00:30:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <bluca@debian.org>, <daan.j.demeyer@gmail.com>, <davem@davemloft.net>,
	<david@readahead.eu>, <edumazet@google.com>, <horms@kernel.org>,
	<jack@suse.cz>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <me@yhndnzj.com>, <netdev@vger.kernel.org>,
	<oleg@redhat.com>, <pabeni@redhat.com>, <viro@zeniv.linux.org.uk>,
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH RFC 3/3] coredump: support AF_UNIX sockets
Date: Wed, 30 Apr 2025 17:25:19 -0700
Message-ID: <20250501003048.49502-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430-work-coredump-socket-v1-3-2faf027dbb47@kernel.org>
References: <20250430-work-coredump-socket-v1-3-2faf027dbb47@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Apr 2025 13:05:03 +0200
> @@ -801,6 +837,49 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		}
>  		break;
>  	}
> +	case COREDUMP_SOCK: {
> +		struct file *file __free(fput) = NULL;
> +		struct sockaddr_un unix_addr = {
> +			.sun_family = AF_UNIX,
> +		};
> +		struct sockaddr_storage *addr;
> +
> +		retval = strscpy(unix_addr.sun_path, cn.corename, sizeof(unix_addr.sun_path));
> +		if (retval < 0)
> +			goto close_fail;
> +
> +		file = __sys_socket_file(AF_UNIX, SOCK_STREAM, 0);
> +		if (IS_ERR(file))
> +			goto close_fail;
> +
> +		/*
> +		 * It is possible that the userspace process which is
> +		 * supposed to handle the coredump and is listening on
> +		 * the AF_UNIX socket coredumps. This should be fine
> +		 * though. If this was the only process which was
> +		 * listen()ing on the AF_UNIX socket for coredumps it
> +		 * obviously won't be listen()ing anymore by the time it
> +		 * gets here. So the __sys_connect_file() call will
> +		 * often fail with ECONNREFUSED and the coredump.
> +		 *
> +		 * In general though, userspace should just mark itself
> +		 * non dumpable and not do any of this nonsense. We
> +		 * shouldn't work around this.
> +		 */
> +		addr = (struct sockaddr_storage *)(&unix_addr);
> +		retval = __sys_connect_file(file, addr, sizeof(unix_addr), O_CLOEXEC);

The 3rd argument should be offsetof(struct sockaddr_un, sun_path)
+ retval of strscpy() above ?

I guess you could see an unexpected error when
CONFIG_INIT_STACK_NONE=y and cn.corename has garbage at tail.

