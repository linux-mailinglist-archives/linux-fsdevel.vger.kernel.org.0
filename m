Return-Path: <linux-fsdevel+bounces-48432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31715AAEEC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 00:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8351BC4E77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 22:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438E291142;
	Wed,  7 May 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gcIF9BzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3351A841B;
	Wed,  7 May 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746658039; cv=none; b=D4x9Df35KkydSCfps6bumKkCQFNdY4e3tOHIjawYoewYdoSN8RIuP/bMKxguS/kbgNiA3ByNhgXX58gAw0IarJzQJ+ePxylkiphRLl3NpwdPlVv7GxneryuCr4nr2ZXwPNCxHwc8taa542qhEVaUQSSdyEftw8kUr8QGofGfkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746658039; c=relaxed/simple;
	bh=HZ2mjWs9C+25tegEBxpz9H+k2QWvOQ/MWmcC1JPzg2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfzwJyarV+66eSLpjlmKoHwar5zC4Z1xP4sW3vSB5KrrrXYw1RZQdsagjTqCylXyrPfpbHv6yic+dSHVOrjpTxx3VGtVE7EA6Muk287JasgHu7KcMlGB/HoZNhpmD3toaLaNbmct5zabTo0jmTTs4yYv/HibejbMkIVI1NAxBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gcIF9BzM; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746658038; x=1778194038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rv48TLMmF+e85KrgXd06hxEVmdhTgHCh9QhcCbrWkqg=;
  b=gcIF9BzMDwgqlglkOYAifoULOEFFA82Y+okEqtfXEExCkW9H6ngU2DNb
   GzePco/XXic5dcbsndFksiMLkRztiyv6XFtblB16WTSJcna2iD5jZAEB0
   W36zqQ/3jJ9ezSPJowgn9MaRA7MpLNltz/Ce4t1ZodbVCLUOoqGMREcsF
   Q+sEQxWThHT8/ALdkZbFGWJ6zoVCTpyzIJKN286+8yc4E0L40rWQVMd/w
   nB0VVjS0vNnovKNsIWLIPxtgLcEg9ZI1bteiKxYFboM2BXY92lRlHqp25
   aWBmuJ/KKYn4xdU0B5MmkY5kNbcYtxrtKBIcPa/dYtSXBmpn9E7WdKSDq
   g==;
X-IronPort-AV: E=Sophos;i="6.15,270,1739836800"; 
   d="scan'208";a="490148119"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 22:47:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:14561]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.231:2525] with esmtp (Farcaster)
 id 8c51b74b-d7bf-4d1f-b139-25c30e4a41e5; Wed, 7 May 2025 22:47:12 +0000 (UTC)
X-Farcaster-Flow-ID: 8c51b74b-d7bf-4d1f-b139-25c30e4a41e5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 22:47:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.46.110) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 7 May 2025 22:47:05 +0000
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
Date: Wed, 7 May 2025 15:45:52 -0700
Message-ID: <20250507224658.47266-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507-work-coredump-socket-v4-4-af0ef317b2d0@kernel.org>
References: <20250507-work-coredump-socket-v4-4-af0ef317b2d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:37 +0200
> Add the reserved "linuxafsk/" prefix for AF_UNIX sockets and require
> CAP_NET_ADMIN in the owning user namespace of the network namespace to
> bind it. This will be used in next patches to support the coredump
> socket but is a generally useful concept.

I really think we shouldn't reserve address and it should be
configurable by users via core_pattern as with the other
coredump types.

AF_UNIX doesn't support SO_REUSEPORT, so once the socket is
dying, user can't start the new coredump listener until it's
fully cleaned up, which adds unnecessary drawback.

The semantic should be same with other types, and the todo
for the coredump service is prepare file (file, process, socket)
that can receive data and set its name to core_pattern.

Also, the abstract socket is namespced by design and there is
no point in enforcing the same restriction to non-initial netns.


> 
> The collision risk is so low that we can just start using it. Userspace
> must already be prepared to retry if a given abstract address isn't
> usable anyway.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/uapi/linux/un.h |  2 ++
>  net/unix/af_unix.c      | 39 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/un.h b/include/uapi/linux/un.h
> index 0ad59dc8b686..bbd5ad508dfa 100644
> --- a/include/uapi/linux/un.h
> +++ b/include/uapi/linux/un.h
> @@ -5,6 +5,8 @@
>  #include <linux/socket.h>
>  
>  #define UNIX_PATH_MAX	108
> +/* reserved AF_UNIX socket namespace. */
> +#define UNIX_SOCKET_NAMESPACE "linuxafsk/"
>  
>  struct sockaddr_un {
>  	__kernel_sa_family_t sun_family; /* AF_UNIX */
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 472f8aa9ea15..148d008862e7 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -114,6 +114,13 @@ static atomic_long_t unix_nr_socks;
>  static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
>  static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
>  
> +static const struct sockaddr_un linuxafsk_addr = {
> +	.sun_family = AF_UNIX,
> +	.sun_path = "\0"UNIX_SOCKET_NAMESPACE,
> +};
> +
> +#define UNIX_SOCKET_NAMESPACE_ADDR_LEN (offsetof(struct sockaddr_un, sun_path) + sizeof(UNIX_SOCKET_NAMESPACE))
> +
>  /* SMP locking strategy:
>   *    hash table is protected with spinlock.
>   *    each socket state is protected by separate spinlock.
> @@ -436,6 +443,30 @@ static struct sock *__unix_find_socket_byname(struct net *net,
>  	return NULL;
>  }
>  
> +static int unix_may_bind_name(struct net *net, struct sockaddr_un *sunname,
> +			      int len, unsigned int hash)
> +{
> +	struct sock *s;
> +
> +	s = __unix_find_socket_byname(net, sunname, len, hash);
> +	if (s)
> +		return -EADDRINUSE;
> +
> +	/*
> +	 * Check whether this is our reserved prefix and if so ensure
> +	 * that only privileged processes can bind it.
> +	 */
> +	if (UNIX_SOCKET_NAMESPACE_ADDR_LEN <= len &&
> +	    !memcmp(&linuxafsk_addr, sunname, UNIX_SOCKET_NAMESPACE_ADDR_LEN)) {
> +		/* Don't bind the namespace itself. */
> +		if (UNIX_SOCKET_NAMESPACE_ADDR_LEN == len)
> +			return -ECONNREFUSED;
> +		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +			return -ECONNREFUSED;
> +	}
> +	return 0;
> +}
> +
>  static inline struct sock *unix_find_socket_byname(struct net *net,
>  						   struct sockaddr_un *sunname,
>  						   int len, unsigned int hash)
> @@ -1258,10 +1289,10 @@ static int unix_autobind(struct sock *sk)
>  	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
>  	unix_table_double_lock(net, old_hash, new_hash);
>  
> -	if (__unix_find_socket_byname(net, addr->name, addr->len, new_hash)) {
> +	if (unix_may_bind_name(net, addr->name, addr->len, new_hash)) {
>  		unix_table_double_unlock(net, old_hash, new_hash);
>  
> -		/* __unix_find_socket_byname() may take long time if many names
> +		/* unix_may_bind_name() may take long time if many names
>  		 * are already in use.
>  		 */
>  		cond_resched();
> @@ -1379,7 +1410,8 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
>  	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
>  	unix_table_double_lock(net, old_hash, new_hash);
>  
> -	if (__unix_find_socket_byname(net, addr->name, addr->len, new_hash))
> +	err = unix_may_bind_name(net, addr->name, addr->len, new_hash);
> +	if (err)
>  		goto out_spin;
>  
>  	__unix_set_addr_hash(net, sk, addr, new_hash);
> @@ -1389,7 +1421,6 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
>  
>  out_spin:
>  	unix_table_double_unlock(net, old_hash, new_hash);
> -	err = -EADDRINUSE;
>  out_mutex:
>  	mutex_unlock(&u->bindlock);
>  out:
> 
> -- 
> 2.47.2

