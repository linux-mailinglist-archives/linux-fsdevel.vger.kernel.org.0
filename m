Return-Path: <linux-fsdevel+bounces-46390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7CCA88660
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 17:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35033AA6F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2F2957AB;
	Mon, 14 Apr 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb6XnLm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535A27F759;
	Mon, 14 Apr 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640824; cv=none; b=bvN2j2/7M6xI5T5sw7UW5BjSf15gZfX9aAlkUY6SWjJWLV/BVzhKKC/g9i1RptUc96jgDa6+4SZdBL7z90ZMHn1FZq9l5OFv7azWrvumdNbqXtzZ1pEF0BivYaZ3dwuTp6cpyih9+Utr4ljP6Tcze/7EXpd/TrYsbkQbOo001BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640824; c=relaxed/simple;
	bh=jLiMpwfjAhP34pBct7SUNsjIF29sZ2YgJztMNCFrHFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhrVZ4H69wsQeEroVeTyouxEZb1ZmpeRlJ0UBaOOtaIUNKHzyor5pvue0O0PTGrg039YEYGLRQNJpp21DrCIMfPV2neuClPQobnREnSsFKGQe2/P0kbLkxO1goxVobo3ENh/1K326sHBrMbE2WVuwgv6fSHyc352K8aWdA+fjic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb6XnLm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8399C4CEE2;
	Mon, 14 Apr 2025 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744640823;
	bh=jLiMpwfjAhP34pBct7SUNsjIF29sZ2YgJztMNCFrHFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sb6XnLm6FpFtHh7X5vPM1gOLsfXO0TXqz8uXjCxqbIzwg/FU/2scunQTXoLpJQVUy
	 +TLuVEZk/JUR1ixmT1AxKhmV4Ch+fnW5kTSOw8uurqjs64wswoyPMbY5ZIPBZuD8Ex
	 GcjSbxrSyGtoThn4q4ATk51wcU8P07butGxNhlMoscIAOhoQVV3J4ZXONu80h8RqgK
	 9aGCXYA2ckLGN9NjCJu+6KZzKv5yYY2XmlYJFUgpFEGfaMlHtZIXoofcGjQFA2YYvq
	 2lx6U9xJt0gkB+ubXNpO4wmXkmN62+IqqQUrM4M/ZH2J8S9mstgth17T8hiGy3nssy
	 CXE8oR0eOWcMQ==
Date: Mon, 14 Apr 2025 16:26:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Luca Boccassi <luca.boccassi@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] coredump: hand a pidfd to the usermode coredump
 helper
Message-ID: <20250414-gesiegt-zweihundert-3286f895aa3d@brauner>
References: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
 <20250414-work-coredump-v2-3-685bf231f828@kernel.org>
 <20250414141450.GE28345@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414141450.GE28345@redhat.com>

On Mon, Apr 14, 2025 at 04:14:50PM +0200, Oleg Nesterov wrote:
> On 04/14, Christian Brauner wrote:
> >
> > -static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
> > +static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
> >  {
> >  	struct file *files[2];
> >  	struct coredump_params *cp = (struct coredump_params *)info->data;
> >  	int err;
> >
> > +	if (cp->pid) {
> > +		struct file *pidfs_file __free(fput) = NULL;
> > +
> > +		pidfs_file = pidfs_alloc_file(cp->pid, 0);
> > +		if (IS_ERR(pidfs_file))
> > +			return PTR_ERR(pidfs_file);
> > +
> > +		/*
> > +		 * Usermode helpers are childen of either
> > +		 * system_unbound_wq or of kthreadd. So we know that
> > +		 * we're starting off with a clean file descriptor
> > +		 * table. So we should always be able to use
> > +		 * COREDUMP_PIDFD_NUMBER as our file descriptor value.
> > +		 */
> > +		VFS_WARN_ON_ONCE((pidfs_file = fget_raw(COREDUMP_PIDFD_NUMBER)) != NULL);
> > +
> > +		err = replace_fd(COREDUMP_PIDFD_NUMBER, pidfs_file, 0);
> > +		if (err < 0)
> > +			return err;
> 
> Yes, but if replace_fd() succeeds we need to nullify pidfs_file
> to avoid fput from __free(fput) ?

No, since replace_fd() takes its own reference via do_dup2():

replace_fd()
-> do_dup2()
   {
	get_file(file)
	rcu_assign_pointer(fdt->fd[fd], file);
   }

so we always need to call it. I had a comment about this in the previous
patchset so people don't get confused. I can add it back.

Let me know if you're happy with this otherwise.

> 
> And I think in this case __free(fput) doesn't buy too much, but
> up to you.
> 
> Oleg.
> 

