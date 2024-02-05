Return-Path: <linux-fsdevel+bounces-10306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3E849A41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250D11C22C40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228361CAA2;
	Mon,  5 Feb 2024 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REMqb2Lt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779651B962;
	Mon,  5 Feb 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136194; cv=none; b=AgLZmijsOmceEZaYUd0Lp9o8cuzTsk3fg5vY6nTpPfPN6MxhXbJflfOlTS/yBGM03MOvHOeqg0sZ7z8evNiwqC3I/tIlm5s1f/2bOcd5osA4avy9uNqxIrZGFvsHaOWv/J53aftqdFOugSpu04jc61AiCQGmrnywQDOJ/Q9uJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136194; c=relaxed/simple;
	bh=F1ZPv8iXr0v3pj/spD+XNF6peVFOc8du21L981Dyh/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/UYGdEC6jLmhjb5pz19A8fbsqNvM4cU/t/mafXrSMBuTFp2xrpQFmrYNA58h6j5z3F4O7ZJjOqqxCsCb8GW1TdxszFS6xMTkfroroq6ORkhE0/gFGUpALpQX0gUW6sAoM3sHXRQeG4OkHff6ZCD1e6zPvNwJu/a29Cn0P8Tzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REMqb2Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A72C433C7;
	Mon,  5 Feb 2024 12:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136193;
	bh=F1ZPv8iXr0v3pj/spD+XNF6peVFOc8du21L981Dyh/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REMqb2LtlMU6lRt257sitgcAtTqx2BfLQ1TdawNnQvHJkINa+1KMVGs8B9+y+YvLu
	 djBDKcUnhN9sf8J58TgKDhh//U/FAf0KhqwX/j4ftvJnl4Y/SYEBRKXmhX8M9170Hj
	 fKuYCPFi5FH0i+Pi/UGjWJ18goeHk1CHQEsS1fXqGpuIfmEH7uQdKtGRuzYydcozx9
	 v0hzYaJtwrJ/phkWjbWcn/C8GJv1lhYwKdjldx/MJyx68+V0H+ZIaqogAyi+1yFHfK
	 GOR4TVJzZYqI10RAGxnVARqwYxzveuk7ebwm4fz7LAjH1mPZ7bli1qUE1vyzbczJpK
	 CYyNh4ROUfr3A==
Date: Mon, 5 Feb 2024 13:29:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 08/13] nfs: fix UAF on pathwalk running into umount
Message-ID: <20240205-zieht-zeremonie-8515b74f4d3c@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-8-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:34AM +0000, Al Viro wrote:
> NFS ->d_revalidate(), ->permission() and ->get_link() need to access
> some parts of nfs_server when called in RCU mode:
> 	server->flags
> 	server->caps
> 	*(server->io_stats)
> and, worst of all, call
> 	server->nfs_client->rpc_ops->have_delegation
> (the last one - as NFS_PROTO(inode)->have_delegation()).  We really
> don't want to RCU-delay the entire nfs_free_server() (it would have
> to be done with schedule_work() from RCU callback, since it can't
> be made to run from interrupt context), but actual freeing of
> nfs_server and ->io_stats can be done via call_rcu() just fine.
> nfs_client part is handled simply by making nfs_free_client() use
> kfree_rcu().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

