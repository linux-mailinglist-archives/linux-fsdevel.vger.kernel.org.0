Return-Path: <linux-fsdevel+bounces-47322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE12A9C038
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 09:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12E73B1568
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 07:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C249232395;
	Fri, 25 Apr 2025 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8CUcVj6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B8217679;
	Fri, 25 Apr 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567921; cv=none; b=RTwlOqIhD9Or2GXoZ8JSMSDCEpwHqhRLsqFa79UxSe3dJiLKe7DwaDdJudKbLK/nuoyUdFm9S2zIY9mVWAwdbq/eDpV1QSEvI6e03cubDULdeJstOW8EryyaE+AGnjiQ+V20ODY/BF9QnYFkj3ERPuLZGt31zgGgh6LqRpP0OAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567921; c=relaxed/simple;
	bh=MNSoiT5I5qQHlef7awPnIJZm3jU3lLmkkpuLMdWhXxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk420+dwKkpYdXYQ/HP6VClc36zTvSgI04UeXsKD4lPkz8cwMqyZgz7GZhpgPB46j1HaKFuo5bcxZtLA+1HOfc8M9XuMxwHHbc/gOD+S3Q70yc+8U89yLALrcqh2iN07m4tHUuadkJcOwxmUu1KdIef6mlXLwR58oHAEZTEN0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8CUcVj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482A9C4CEE4;
	Fri, 25 Apr 2025 07:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745567921;
	bh=MNSoiT5I5qQHlef7awPnIJZm3jU3lLmkkpuLMdWhXxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8CUcVj6DOdiQ4hQvtV6Z8Qz8+gBpb75eJNx3kv1LFM5U8nTJjM4qdTs1M4O23sPy
	 O7+mxkN6G57LTNv1BxY5QkBvGlQVwPWcUTSBQ7KzBQh6ENRfK6YaVv7YD13r5J62wa
	 cxUIPmoIA68/3o0hwjJyeqH6/o3nYpVf092YyQZzZWC7l7fuSMD1ByrnbuPclsY3B6
	 WDtiKbaNU2exFA+pjNIaF6zoNPMrERj/oFfNg7iFINPh0RqbApeAF2wr1jTD/246/a
	 eprRDy4sLBhGvwp/iNUhVFM2ThqaiUc2bfJgDE1k7JofXpCDwxdYfzmm+j/T8NTPW5
	 TXUS640aW0XCw==
Date: Fri, 25 Apr 2025 09:58:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, bluca@debian.org, daan.j.demeyer@gmail.com, 
	davem@davemloft.net, david@readahead.eu, edumazet@google.com, horms@kernel.org, 
	jack@suse.cz, kuba@kernel.org, lennart@poettering.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, me@yhndnzj.com, 
	netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com
Subject: Re: [PATCH RFC 2/4] net, pidfs: prepare for handing out pidfds for
 reaped sk->sk_peer_pid
Message-ID: <20250425-wegfielen-galaabend-91b1b684cb76@brauner>
References: <20250424-work-pidfs-net-v1-2-0dc97227d854@kernel.org>
 <20250425015911.93197-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425015911.93197-1-kuniyu@amazon.com>

On Thu, Apr 24, 2025 at 06:57:19PM -0700, Kuniyuki Iwashima wrote:
> From: Christian Brauner <brauner@kernel.org>
> Date: Thu, 24 Apr 2025 14:24:35 +0200
> > @@ -734,13 +743,48 @@ static void unix_release_sock(struct sock *sk, int embrion)
> >  		unix_gc();		/* Garbage collect fds */
> >  }
> >  
> > -static void init_peercred(struct sock *sk)
> > +struct af_unix_peercred {
> 
> nit: conventional naming for AF_UNIX is without af_, all structs
> (and most functions) start with unix_.

Done.

> 
> 
> > +	struct pid *peer_pid;
> > +	const struct cred *peer_cred;
> > +};
> > +
> > +static inline int prepare_peercred(struct af_unix_peercred *peercred)
> > +{
> > +	struct pid *pid;
> > +	int err;
> > +
> > +	pid = task_tgid(current);
> > +	err = pidfs_register_pid(pid);
> > +	if (likely(!err)) {
> > +		peercred->peer_pid = get_pid(pid);
> > +		peercred->peer_cred = get_current_cred();
> > +	}
> > +	return err;
> > +}
> > +
> > +static void drop_peercred(struct af_unix_peercred *peercred)
> > +{
> > +	struct pid *pid = NULL;
> > +	const struct cred *cred = NULL;
> 
> another nit: please keep variables in reverse xmas tree order.
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

Done.

> 
> Otherwise looks good to me.

Thanks!

