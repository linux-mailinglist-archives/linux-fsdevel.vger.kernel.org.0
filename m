Return-Path: <linux-fsdevel+bounces-48119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5998AA9BE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 20:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8F617309D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00C26E15F;
	Mon,  5 May 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l8K2CcGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF4DDC3;
	Mon,  5 May 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470948; cv=none; b=ZYusRfFXLSZzdYZdRXawQujPSD3zf3xVvpSF8R4+TU9JFfodiqxoTcv2TUllhDTURm7mSoJh2OXZYjnC6JxYRUDLXoMdCcn5MECYZhpPh7I1+4DW14FoFmJWn4xJplhVTTCxM746p5QYayhzSdlLEdF7qoaRtG7xnqyDFJ95VGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470948; c=relaxed/simple;
	bh=0khgXCASiHK6JYlqgsdUdNJz4kXf5NEs+mufVRGpI3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgz9OCUcsjqYugVqGCVgq7jRzKdGlIT/TIF+dqiKGujFTh7BT43IVkuE7RLGf8Mw+WHFdlA/axCrVDugcJCYWCCXJBgNhcLShTGozqKjb2oby0/VKPCg7G9RS4JEtkPQuqTdZUUiGXylccKmfopNtW8S+J7s8D/o0VZD1n90pb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=l8K2CcGm; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746470946; x=1778006946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vx0lieCdiisZ+VzesD1JWNDpyrV2ThBTOINQevgKwOE=;
  b=l8K2CcGmawHi51/Rq05j5OfYWNqatpBmub3atQSrby86TULpgS6NwaaJ
   r/ql63G+57P9snl4+1/D35pqY0L0YFJn6IA9XPRS2c1+zPI64DzCspB0I
   vUwPWZPKAyMerazuyP2/xXrfzhg2ogQu1EET0SUYtk24KkPZAQRs4XODk
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="294767473"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 18:49:00 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:55221]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id fe65f5b7-16b4-42d9-a0df-dc3694f4ff37; Mon, 5 May 2025 18:48:59 +0000 (UTC)
X-Farcaster-Flow-ID: fe65f5b7-16b4-42d9-a0df-dc3694f4ff37
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 18:48:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 18:48:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <david@readahead.eu>, <edumazet@google.com>,
	<horms@kernel.org>, <jack@suse.cz>, <jannh@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <lennart@poettering.net>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH RFC v3 04/10] coredump: add coredump socket
Date: Mon, 5 May 2025 11:48:43 -0700
Message-ID: <20250505184847.15534-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505-work-coredump-socket-v3-4-e1832f0e1eae@kernel.org>
References: <20250505-work-coredump-socket-v3-4-e1832f0e1eae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Mon, 05 May 2025 13:13:42 +0200
> @@ -801,6 +846,40 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		}
>  		break;
>  	}
> +	case COREDUMP_SOCK: {
> +		struct file *file __free(fput) = NULL;
> +#ifdef CONFIG_UNIX
> +		struct socket *socket;
> +
> +		/*
> +		 * It is possible that the userspace process which is
> +		 * supposed to handle the coredump and is listening on
> +		 * the AF_UNIX socket coredumps. Userspace should just
> +		 * mark itself non dumpable.
> +		 */
> +
> +		retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
> +		if (retval < 0)
> +			goto close_fail;
> +
> +		file = sock_alloc_file(socket, 0, NULL);
> +		if (IS_ERR(file)) {
> +			sock_release(socket);
> +			retval = PTR_ERR(file);
> +			goto close_fail;
> +		}
> +
> +		retval = kernel_connect(socket,
> +					(struct sockaddr *)(&coredump_unix_socket),
> +					COREDUMP_UNIX_SOCKET_ADDR_SIZE, 0);

This blocks forever if the listener's accept() queue is full.

I think we don't want that and should pass O_NONBLOCK.

To keep the queue clean is userspace responsibility, and we don't
need to care about a weird user.


> +		if (retval)
> +			goto close_fail;
> +
> +		cprm.limit = RLIM_INFINITY;
> +#endif
> +		cprm.file = no_free_ptr(file);
> +		break;
> +	}
>  	default:
>  		WARN_ON_ONCE(true);
>  		retval = -EINVAL;

