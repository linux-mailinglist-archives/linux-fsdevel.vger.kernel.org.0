Return-Path: <linux-fsdevel+bounces-71554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B324CC749F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FB8A3043D66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDFB261388;
	Wed, 17 Dec 2025 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QimEFByC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F071DEFE7;
	Wed, 17 Dec 2025 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970154; cv=none; b=io5aEk3S9n4d3fjFQ9doIBiPcLNGU4MX8Lm/O02PkTiSQbjQRboLPUzPz+o2RZXQYBmsXgS8cPT7IY/YT5loOzSQBbmgcGqzsbe3B/Dd7k1MOJXfzShFzoxTsEk7Jibf+HhDC5GHBbBKr+z9eychJXewjpCi5xfi0o6e6qyJQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970154; c=relaxed/simple;
	bh=7/9wm8IquDiFTkW8F/0vwak3q+68AByZlRz8ZffaW3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAE2DQAwccAGGLzdZizYPE6IdxHaUCMbxnhaEW9AXFUAZkN8lM1L0Hv1/iMvt0sNdPAIYIq/lALLnyAMgXr7vv7MG7By0v2EvJz6nRG/o/CLe+1k4VtFUhgIH94CjK5V6KZrD4vvQVryhGN0zREnLqHMSfo2fGA1TH40Mxzi3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QimEFByC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FNHtk+yTxVPHdMdnS7jf0nVxggfGrVbSCP9Gow9JZVk=; b=QimEFByC7s2cQ/qSIhdY9nqOt0
	D2t76lSN2njtJvrxRJ0CUPbJjFa3c2mwJd9AH6kwI3KO0D6KtangL055oCyWxUYQwgkKhkXgP6VfF
	YCt23xuQkqCnd2czl/EgFItTstGQ1naFUeLTY0/QWaUFKT6mSpWe6Mnnii+7H+WwzS6jnNLRkeIFX
	ZQucS3q0bN1YylOb9JvcBKUYUjlQuWGmaDAxjxygpyd+GsoR4RbmBt4KOrVu02/sWtBuU+G9Xol2M
	44vtqU5uSFx9bBM7caJ4m4vE+WAIgUX+Dk2ygwHJahiioKX44pCtqZrKOq9oVhdyyot+VaIs1n1Li
	qgG2F4hg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vVpW9-0000000FF0V-2ZVq;
	Wed, 17 Dec 2025 11:16:29 +0000
Date: Wed, 17 Dec 2025 11:16:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, clm@meta.com
Subject: Re: [RFC PATCH] fs: touch up symlink clean up in lookup
Message-ID: <20251217111629.GV1712166@ZenIV>
References: <20251217110105.2337734-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217110105.2337734-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 17, 2025 at 12:01:05PM +0100, Mateusz Guzik wrote:

This is obviously broken.  

> +static void links_cleanup_ref(struct nameidata *nd)
> +{
> +	VFS_BUG_ON(nd->flags & LOOKUP_RCU);
> +
> +	if (likely(!nd->depth))
> +		return;
> +
> +	links_issue_delayed_calls(nd);
> +
> +	path_put(&nd->path);
	^^^^^^^^^^^^^^^^^^^

> +	for (int i = 0; i < nd->depth; i++)
> +		path_put(&nd->stack[i].link);

> +	if (nd->state & ND_ROOT_GRABBED) {
> +		path_put(&nd->root);
		^^^^^^^^^^^^^^^^^^^
> +		nd->state &= ~ND_ROOT_GRABBED;
> +	}

has nothing whatsoever to with links *AND* should not be
skipped even with no symlinks in the vicinity.

NAK.

