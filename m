Return-Path: <linux-fsdevel+bounces-61413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BECB57E13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0A47A6708
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF7A31B83A;
	Mon, 15 Sep 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtxXaOW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A8313276;
	Mon, 15 Sep 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944514; cv=none; b=qX4nQjBIXCLTrgie6eFbOo4HhHp1CRWtFNaZbh2CrRBqyt+bEU63i+rEJ9V6rwJvHrTVYPDNkFhQ+2fDdRLAlBsUANMfIqpGpmf3rG7Huxyoe8ZXwfOBwzGy/mgWKvJHU7jjK3w5doa/+298TyB2YX/8k8DA9g7QppvDh0+RE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944514; c=relaxed/simple;
	bh=SqkBMfDzVgXsgPROtjP+BoCmQJ8xB5+m7QOWTr9D1IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l87rp3QpNUf+7IyHImgWKlYyxLCN6kcF9YWEkcLeaWIRYmXQDaOsP+XNHWsalrRSNvR88JLfzcNl/g2lD02QoBzHdyNa6DFP9Mlv+ULLTJuiHBdln/u4ehKeucjDxE48x7CcEEkcRSzGXwXB94JGuI37xGQUgLjcZ4CAk2cgvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtxXaOW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA9CC4CEF7;
	Mon, 15 Sep 2025 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944513;
	bh=SqkBMfDzVgXsgPROtjP+BoCmQJ8xB5+m7QOWTr9D1IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtxXaOW30CbEBJCeNCrF087li2ViBB91z3Iv3OlXdKAAXsPKWRRzBTV1C85Ye2DuE
	 Lngh7cH6caGrMdf/5g/YzGIqc+/+nl/jWZpBvnpdaJAcqXQ62f7yfNdFCBPCknwLcf
	 OgnQzOrteFXDU9ikNGVgU9mfbkdyw2iF5uhRSFGYcRZKP/0RqdQhBt2w5aaW5E/geV
	 jgfQBKkEBBGW23B7cGTwGAAb0Qj5f63sQSqALt/AhYFHWPhBhNCLnPqJEgLkr/AK3e
	 kprRZBMe8dGrF5rVt4+Lw55KXT4ooQhxTMwkuRwARu2/fpq5KdTIJ0mPMM/veMhmHl
	 ViCGIwt59Z5/Q==
Date: Mon, 15 Sep 2025 15:55:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 28/33] nsfs: support file handles
Message-ID: <20250915-laufpass-anraten-b250875c462a@brauner>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-28-1a247645cef5@kernel.org>
 <4gsrbaiqrt3ymcze7rm6ec2oy25ernllidg2i3rkrsqh6q5deu@7bozrym7omj4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4gsrbaiqrt3ymcze7rm6ec2oy25ernllidg2i3rkrsqh6q5deu@7bozrym7omj4>

On Mon, Sep 15, 2025 at 03:25:20PM +0200, Jan Kara wrote:
> On Fri 12-09-25 13:52:51, Christian Brauner wrote:
> > A while ago we added support for file handles to pidfs so pidfds can be
> > encoded and decoded as file handles. Userspace has adopted this quickly
> > and it's proven very useful. Implement file handles for namespaces as
> > well.
> > 
> > A process is not always able to open /proc/self/ns/. That requires
> > procfs to be mounted and for /proc/self/ or /proc/self/ns/ to not be
> > overmounted. However, userspace can always derive a namespace fd from
> > a pidfd. And that always works for a task's own namespace.
> > 
> > There's no need to introduce unnecessary behavioral differences between
> > /proc/self/ns/ fds, pidfd-derived namespace fds, and file-handle-derived
> > namespace fds. So namespace file handles are always decodable if the
> > caller is located in the namespace the file handle refers to.
> > 
> > This also allows a task to e.g., store a set of file handles to its
> > namespaces in a file on-disk so it can verify when it gets rexeced that
> > they're still valid and so on. This is akin to the pidfd use-case.
> > 
> > Or just plainly for namespace comparison reasons where a file handle to
> > the task's own namespace can be easily compared against others.
> > 
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> ...
> 
> > +	switch (ns->ops->type) {
> > +#ifdef CONFIG_CGROUPS
> > +	case CLONE_NEWCGROUP:
> > +		if (!current_in_namespace(to_cg_ns(ns)))
> > +			owning_ns = to_cg_ns(ns)->user_ns;
> > +		break;
> > +#endif
> > +#ifdef CONFIG_IPC_NS
> > +	case CLONE_NEWIPC:
> > +		if (!current_in_namespace(to_ipc_ns(ns)))
> > +			owning_ns = to_ipc_ns(ns)->user_ns;
> > +		break;
> > +#endif
> > +	case CLONE_NEWNS:
> > +		if (!current_in_namespace(to_mnt_ns(ns)))
> > +			owning_ns = to_mnt_ns(ns)->user_ns;
> > +		break;
> > +#ifdef CONFIG_NET_NS
> > +	case CLONE_NEWNET:
> > +		if (!current_in_namespace(to_net_ns(ns)))
> > +			owning_ns = to_net_ns(ns)->user_ns;
> > +		break;
> > +#endif
> > +#ifdef CONFIG_PID_NS
> > +	case CLONE_NEWPID:
> > +		if (!current_in_namespace(to_pid_ns(ns))) {
> > +			owning_ns = to_pid_ns(ns)->user_ns;
> > +		} else if (!READ_ONCE(to_pid_ns(ns)->child_reaper)) {
> > +			ns->ops->put(ns);
> > +			return ERR_PTR(-EPERM);
> > +		}
> > +		break;
> > +#endif
> > +#ifdef CONFIG_TIME_NS
> > +	case CLONE_NEWTIME:
> > +		if (!current_in_namespace(to_time_ns(ns)))
> > +			owning_ns = to_time_ns(ns)->user_ns;
> > +		break;
> > +#endif
> > +#ifdef CONFIG_USER_NS
> > +	case CLONE_NEWUSER:
> > +		if (!current_in_namespace(to_user_ns(ns)))
> > +			owning_ns = to_user_ns(ns);
> > +		break;
> > +#endif
> > +#ifdef CONFIG_UTS_NS
> > +	case CLONE_NEWUTS:
> > +		if (!current_in_namespace(to_uts_ns(ns)))
> > +			owning_ns = to_uts_ns(ns)->user_ns;
> > +		break;
> > +#endif
> 
> Frankly, switches like these are asking for more Generic usage ;) But ok
> for now.
> 
> > +	default:
> > +		return ERR_PTR(-EOPNOTSUPP);
> > +	}
> > +
> > +	if (owning_ns && !ns_capable(owning_ns, CAP_SYS_ADMIN)) {
> > +		ns->ops->put(ns);
> > +		return ERR_PTR(-EPERM);
> > +	}
> > +
> > +	/* path_from_stashed() unconditionally consumes the reference. */
> > +	ret = path_from_stashed(&ns->stashed, nsfs_mnt, ns, &path);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	return no_free_ptr(path.dentry);
> 
> Ugh, so IMO this is very subtle because we declare
> 
> 	struct path path __free(path_put)
> 
> but then do no_free_ptr(path.dentry). I really had to lookup implementation
> of no_free_ptr() to check whether we are leaking mnt reference here or not
> (we are not). But that seems as an implementation detail we shouldn't
> better rely on? Wouldn't be:
> 
> 	return dget(path.dentry);
> 
> much clearer (and sligthly less efficient, I know, but who cares)?

Fine by me as well!

