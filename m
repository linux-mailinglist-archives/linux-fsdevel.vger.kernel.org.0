Return-Path: <linux-fsdevel+bounces-14896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE0F881224
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 14:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EE2285C36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752DC1A38E6;
	Wed, 20 Mar 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUeELnCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E240847;
	Wed, 20 Mar 2024 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940438; cv=none; b=IBQ28E857yOPIuWcosWbYs2exuZ0XxEJpiVVC90A/7o4bbGXwy3kwLLFriV27Hk2gII/6C8SlG9yvbLr0Ei45r3+w3nwzocal12lb9D0mHpuN/zvJIalcu3iBbTv3dqReUL04kRUoDihyROrusElcSNLJY+bOipJG+nI5rIEtqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940438; c=relaxed/simple;
	bh=ghCN61ofXI0Tf62QAiLIvxh+oQl1kd8cAWHEsmu/bDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HysKZ5mJzoqPt/4t9pGF1nip2Q270uDY8MHF1GqGLQYkbq4tG06woA21N7jxQoKe/4Jh3Vu5ITYQov0EwUXxUjyFuD/0umqntQ3j9btB+vozlqRynFgV0TEk3rkO8xr014ueb8S2Cg+DucTLxDHKWAMt7x7FwmjUMI7Iuqzrpy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUeELnCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9396C433F1;
	Wed, 20 Mar 2024 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710940438;
	bh=ghCN61ofXI0Tf62QAiLIvxh+oQl1kd8cAWHEsmu/bDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUeELnCFnUj3wvloClJuzTNugchOpDzTWWkkMdQaB3sqR8vtfAqyHagXs+H2Xj1mO
	 ecblLQCaISXQFeqgrXi8ZNaf8EaEaC663/0+5jfAcIxV8cMPHlm0QxutNY/nvBG6tE
	 JKq1+g+QgLAXEKFWocsj6dvM2Ps6ybe/+G8AVxC/ncU9GOrG9UN955V8DQHkXrJq4p
	 PDGewkWQ65RfOMJNcTGVS4aCkpd4tRRZfbF01WI4EXaEzbqun2MJLUGyHykPw+frbW
	 65ijs0IFtmvHd685+YoIjn8J+nJ21RtcsMfVqTp/nTG3cTwvBq/boKoJ8KPm3bD92I
	 i6s9gHFkYdo7A==
Date: Wed, 20 Mar 2024 14:13:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC 02/24] filelock: add a lm_set_conflict lease_manager
 callback
Message-ID: <20240320-gaspreis-mitunter-217e0d82f50f@brauner>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-2-a1d6209a3654@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315-dir-deleg-v1-2-a1d6209a3654@kernel.org>

On Fri, Mar 15, 2024 at 12:52:53PM -0400, Jeff Layton wrote:
> The NFSv4.1 protocol adds support for directory delegations, but it
> specifies that if you already have a delegation and try to request a new
> one on the same filehandle, the server must reply that the delegation is
> unavailable.
> 
> Add a new lease_manager callback to allow the lease manager (nfsd in
> this case) to impose extra checks when performing a setlease.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c               |  5 +++++
>  include/linux/filelock.h | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index cb4b35d26162..415cca8e9565 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1822,6 +1822,11 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
>  			continue;
>  		}
>  
> +		/* Allow the lease manager to veto the setlease */
> +		if (lease->fl_lmops->lm_set_conflict &&
> +		    lease->fl_lmops->lm_set_conflict(lease, fl))
> +			goto out;
> +
>  		/*
>  		 * No exclusive leases if someone else has a lease on
>  		 * this file:
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index daee999d05f3..c5fc768087df 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -49,6 +49,16 @@ struct lease_manager_operations {
>  	int (*lm_change)(struct file_lease *, int, struct list_head *);
>  	void (*lm_setup)(struct file_lease *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lease *);
> +
> +	/**
> +	 * lm_set_conflict - extra conditions for setlease
> +	 * @new: new file_lease being set
> +	 * @old: old (extant) file_lease
> +	 *
> +	 * This allows the lease manager to add extra conditions when
> +	 * setting a lease.
> +	 */
> +	bool (*lm_set_conflict)(struct file_lease *new, struct file_lease *old);

Minor, but it seems a bit misnamed to me. I'd recommend calling this
lm_may_set_lease() or lm_may_lease().

