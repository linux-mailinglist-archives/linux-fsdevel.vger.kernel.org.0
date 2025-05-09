Return-Path: <linux-fsdevel+bounces-48652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D568AB1B9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F8198718C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82CD23BF9C;
	Fri,  9 May 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EG8A5YIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F551239090;
	Fri,  9 May 2025 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811953; cv=none; b=AjkPVFLweEjxiT+2XPtUJOvSTd3GAELBOht+qJNSlBKgwp9JDeS8aFYPYAcrkHcoOF5LSDLC5T0dNFiB29MZ4WPmqq1Z3xvFUnsid/5INOuxBugZ2JHeYDN2vHqoUZ68b0eBn5zaIllX+TdVhk+8TiEC04xqhYuh28C2zie2hII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811953; c=relaxed/simple;
	bh=R3XHrj5LgYG9CyDHTHAoHFZHVpFk3t23LN8geisvNxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7TGXcHJZjrdodgjzzHPu1+UE6MEMkD4HsAM8am2KCkDFG5nqhWcdPhEr8sxXwebCElEWq36tcJnDvRAr59hrdFZmNzVa8BpTB9qFKG440FxMjG9k5WGS5lZQJpotnZ4vUdnwEPe156PhIX+NC65xeLXsrsWpTvJB4QYFfjil2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EG8A5YIH; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746811952; x=1778347952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yhpp9QC5ncFxyeHZjaDDxMYBWmdWgq6kB+j0hfRTrj0=;
  b=EG8A5YIHpyPOQFpCTP2oF4kmNz2tNpb3dNyG8eZ7zqNBX8PCw1ebcELE
   i2YiRSItIlUOZ0kLIcGVc+pE0jj8yAcnpOIJpFZsppuAnJtQ4Udi3ajmi
   tfm7q0cixrHe/gBSiVWn6N4p6tVqgTzfkcumvWLQOi1I2SjCz7asUsXKe
   OjO0dVkyEw4JdjNGOYWdKjwK7PW2BM04Y+ZvEG3VtmYVvaUSULqg1+ES0
   kVYwByxhvVzpVpuB8wq+UjPdYSURSZNxJ7riY6stdLBJMksrLqgedCEDz
   Lja8t3gI7bE34Ag7lum3dokP4g03E/ivP8KBPW/sGNs24vGuo93/PbTY4
   A==;
X-IronPort-AV: E=Sophos;i="6.15,275,1739836800"; 
   d="scan'208";a="721297076"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 17:32:27 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:41304]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.68:2525] with esmtp (Farcaster)
 id a919e1f1-8c4f-4e88-b09f-73ac0d9e22d4; Fri, 9 May 2025 17:32:26 +0000 (UTC)
X-Farcaster-Flow-ID: a919e1f1-8c4f-4e88-b09f-73ac0d9e22d4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 9 May 2025 17:32:25 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 9 May 2025 17:32:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <david@readahead.eu>,
	<edumazet@google.com>, <horms@kernel.org>, <jack@suse.cz>,
	<jannh@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH v5 4/9] coredump: add coredump socket
Date: Fri, 9 May 2025 10:30:41 -0700
Message-ID: <20250509173213.36201-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509-querschnitt-fotokopien-6ae91dfdac45@brauner>
References: <20250509-querschnitt-fotokopien-6ae91dfdac45@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 9 May 2025 17:40:14 +0200
> > Userspace can set /proc/sys/kernel/core_pattern to:
> > 
> >         @linuxafsk/coredump_socket
> 
> I have one other proposal that:
> 
> - avoids reserving a specific address
> - doesn't require bpf or lsm to be safe
> - allows for safe restart and crashes of the coredump sever
> 
> To set up a coredump socket the coredump server must allocate a socket
> cookie for the listening socket via SO_COOKIE. The socket cookie must be
> used as the prefix in the abstract address for the coredump socket. It
> can be followed by a \0 byte and then followed by whatever the coredump
> server wants. For example:
> 
> 12345678\0coredump.socket
> 
> When a task crashes and generates a coredump it will find the provided
> address but also compare the prefixed SO_COOKIE value with the socket
> cookie of the socket listening at that address. If they don't match it
> will refuse to connect.
> 
> So even if the coredump server restarts or crashes and unprivileged
> userspace recycles the socket address for an attack the crashing process
> will detect this as the new listening socket will have gotten either a
> new or no SO_COOKIE and the crashing process will not connect.
> 
> The coredump server just sets /proc/sys/kernel/core_pattern to:
> 
>         @SO_COOKIE/whatever
> 
> The "@" at the beginning indicates to the kernel that the abstract
> AF_UNIX coredump socket will be used to process coredumps and the
> indicating the end of the SO_COOKIE and the rest of the name.
> 
> Appended what that would look like.

Thank you, this looks much nicer to me.


[...]
> Userspace can set /proc/sys/kernel/core_pattern to:
> 
>         @SO_COOKIE/whatever
> 
> The "@" at the beginning indicates to the kernel that the abstract
> AF_UNIX coredump socket will be used to process coredumps.
> 
> When the coredump server sets up a coredump socket it must allocate a
> socket cookie for it and use it as the prefix in the abstract address.
> It may be followed by a zero byte and whatever other name the server may
> want.
[...]
> +
> +		/* Format is @socket_cookie\0whatever. */
> +		p = strchr(addr.sun_path + 1, '/');
> +		if (p)
> +			*p = '\0';

nit: the '\0' seems optional, @SO_COOKIEwhatever\0



> diff --git a/include/linux/net.h b/include/linux/net.h
> index 0ff950eecc6b..3f467786bdc9 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -82,6 +82,8 @@ enum sock_type {
>  #define SOCK_NONBLOCK	O_NONBLOCK
>  #endif
>  
> +#define SOCK_COREDUMP O_NOCTTY
> +
>  #endif /* ARCH_HAS_SOCKET_TYPES */
>  
>  /**
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 472f8aa9ea15..944248d7c5be 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -101,6 +101,7 @@
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>  #include <linux/pidfs.h>
> +#include <linux/kstrtox.h>

nit: please sort in alphabetical order.  It was cleaned up recently.


>  #include <net/af_unix.h>
>  #include <net/net_namespace.h>
>  #include <net/scm.h>
> @@ -1191,7 +1192,7 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  
>  static struct sock *unix_find_abstract(struct net *net,
>  				       struct sockaddr_un *sunaddr,
> -				       int addr_len, int type)
> +				       int addr_len, int type, int flags)
>  {
>  	unsigned int hash = unix_abstract_hash(sunaddr, addr_len, type);
>  	struct dentry *dentry;
> @@ -1201,6 +1202,15 @@ static struct sock *unix_find_abstract(struct net *net,
>  	if (!sk)
>  		return ERR_PTR(-ECONNREFUSED);
>  
> +	if (flags & SOCK_COREDUMP) {
> +		u64 cookie;
> +
> +		if (kstrtou64(sunaddr->sun_path, 0, &cookie))
> +			return ERR_PTR(-ECONNREFUSED);
> +		if (cookie != atomic64_read(&sk->sk_cookie))
> +			return ERR_PTR(-ECONNREFUSED);
> +	}
> +
>  	dentry = unix_sk(sk)->path.dentry;
>  	if (dentry)
>  		touch_atime(&unix_sk(sk)->path);
> @@ -1210,14 +1220,14 @@ static struct sock *unix_find_abstract(struct net *net,
>  
>  static struct sock *unix_find_other(struct net *net,
>  				    struct sockaddr_un *sunaddr,
> -				    int addr_len, int type)
> +				    int addr_len, int type, int flags)
>  {
>  	struct sock *sk;
>  
>  	if (sunaddr->sun_path[0])
>  		sk = unix_find_bsd(sunaddr, addr_len, type);
>  	else
> -		sk = unix_find_abstract(net, sunaddr, addr_len, type);
> +		sk = unix_find_abstract(net, sunaddr, addr_len, type, flags);
>  
>  	return sk;
>  }
> @@ -1473,7 +1483,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
>  		}
>  
>  restart:
> -		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type);
> +		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type, flags);

The flag should be 0 as we don't use SOCK_DGRAM for coredump.


>  		if (IS_ERR(other)) {
>  			err = PTR_ERR(other);
>  			goto out;
> @@ -1620,7 +1630,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>
>  restart:
>  	/*  Find listening sock. */
> -	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type);
> +	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type, flags);
>  	if (IS_ERR(other)) {
>  		err = PTR_ERR(other);
>  		goto out_free_skb;
> @@ -2089,7 +2099,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>  	if (msg->msg_namelen) {
>  lookup:
>  		other = unix_find_other(sock_net(sk), msg->msg_name,
> -					msg->msg_namelen, sk->sk_type);
> +					msg->msg_namelen, sk->sk_type, 0);
>  		if (IS_ERR(other)) {
>  			err = PTR_ERR(other);
>  			goto out_free;
> -- 
> 2.47.2

