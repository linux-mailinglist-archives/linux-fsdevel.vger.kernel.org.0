Return-Path: <linux-fsdevel+bounces-56624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE89B19DC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 10:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2783B9D8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726D3242D6E;
	Mon,  4 Aug 2025 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN2Vv6iA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42532356D2;
	Mon,  4 Aug 2025 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296720; cv=none; b=Xoiu5e6uk38TpXIzAc6eg7UrrXG3gAaUHQRF7F1BVELDHd3S2NggYiVPqgz1t6V9rY+AhJrOa6xoERRTYD15OxGLyn3x4Cug7PKEp9ODbdqotlpsGSAxO7hnqA+pMBsO9CoLyp3WltKJ+ORx0TyGPeFgU9TgqcKNElJKOds5gro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296720; c=relaxed/simple;
	bh=LYhxDdmv7WKdVH4JS805mi9rifdSH1ISJELxQdylTt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAl8+xYH2WaZF0p9hpzeqJFDU/NWNeACYXOjVZqMgbqk8wCTfS2Q/eoZmqPDj0Z/HvP2CKeGRht//AjOz9mr6BhvjCfa/L1BJ7LO28uM+kJybhcvuNqNpxL4eHkosPND+NCX71Y+EMUQecFTeI69sbJFRrggjg7AapKv9VMBqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN2Vv6iA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEDCC4CEE7;
	Mon,  4 Aug 2025 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754296720;
	bh=LYhxDdmv7WKdVH4JS805mi9rifdSH1ISJELxQdylTt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CN2Vv6iAH2xHExWYpSQAo0Ti6f8+vt7skh+EI3mk6n0OyVH03PkNxZtmziJzo8kQG
	 rGwty3bYsGLnkzk8EhFdpUhvt9GrH0IX84G1yRBqVir3Q4wqGWf/Ak4i8ZghT9FgX4
	 jar+NcJBpRBxEMIWHsHvyECdD8Do0v9+j1dFKxped4ndPAFDM1WFv64eLLANej9xYL
	 HtaybN8vxFH+ySWaNlz0YHUVlvSQksxuzVHc5oTf6F3GHu7dr1zGEsRekkSX7WsbfW
	 7cQu2uhWYxDUk0CsuYR4I+XNPsl0eBKyZEfvqVGX7ccGSwg2Q/aCuU8xg5IWsXg2io
	 4gZUhS7Ltld0A==
Date: Mon, 4 Aug 2025 10:38:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sargun Dhillon <sargun@sargun.me>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: correctly check for errors from replace_fd() in
 receive_fd_replace()
Message-ID: <20250804-fechten-glukose-1cb2e2b0413a@brauner>
References: <20250801-fix-receive_fd_replace-v1-1-d46d600c74d6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801-fix-receive_fd_replace-v1-1-d46d600c74d6@linutronix.de>

On Fri, Aug 01, 2025 at 09:38:38AM +0200, Thomas Weißschuh wrote:
> replace_fd() returns either a negative error number or the number of the
> new file descriptor. The current code misinterprets any positive file
> descriptor number as an error.
> 
> Only check for negative error numbers, so that __receive_sock() is called
> correctly for valid file descriptors.
> 
> Fixes: 173817151b15 ("fs: Expand __receive_fd() to accept existing fd")
> Fixes: 42eb0d54c08a ("fs: split receive_fd_replace from __receive_fd")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Untested, it stuck out while reading the code.
> ---
>  fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 6d2275c3be9c6967d16c75d1b6521f9b58980926..56c3a045121d8f43a54cf05e6ce1962f896339ac 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1387,7 +1387,7 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
>  	if (error)
>  		return error;
>  	error = replace_fd(new_fd, file, o_flags);
> -	if (error)
> +	if (error < 0)
>  		return error;

What in the holy fsck? Why did the seccomp selftests not fail
horrendously explode because of that.

