Return-Path: <linux-fsdevel+bounces-13632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDE98722C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38851F23FED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544A12AAC2;
	Tue,  5 Mar 2024 15:26:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE212A152;
	Tue,  5 Mar 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652412; cv=none; b=jV3mMGXaGPWd27ULhksLTINqSH0Rss+VknDHfTg/p+JfHa53/jK2T97ADOES00jb8RP1I7pevVpiK+fk1cgz3O7kgKdyg1bWszrj/HrblSuK8Q3EXkzekswpZ07OE4XgOumPNzPX7bQHI7FGdVZRofg64yTkCaVxlTSxG0eUjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652412; c=relaxed/simple;
	bh=GRLqdqtSoP2VvufUGAGP/Ugnj3LtcoOOYKX/7xCkD5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eegI2e9KgZUMiB1wv579kthRsZZEIZ9KvPQdLufmbD7Yy3cQPnZb3bgRjUtOV2TWk5LkoBGtpdva0xsvRkZmDnkt8oMBhUOZpQj3jFpwQn7cY5WVQf9L77gh/k3uuMP77VbIHMFYn4s3qbMujaTjnyAAqpHviNj8EqaHfxcUMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 7336452B; Tue,  5 Mar 2024 09:17:53 -0600 (CST)
Date: Tue, 5 Mar 2024 09:17:53 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] xattr: restrict vfs_getxattr_alloc() allocation size
Message-ID: <20240305151753.GA15883@mail.hallyn.com>
References: <20240305-effekt-luftzug-51913178f6cd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-effekt-luftzug-51913178f6cd@brauner>

On Tue, Mar 05, 2024 at 01:27:06PM +0100, Christian Brauner wrote:
> The vfs_getxattr_alloc() interface is a special-purpose in-kernel api
> that does a racy query-size+allocate-buffer+retrieve-data. It is used by
> EVM, IMA, and fscaps to retrieve xattrs. Recently, we've seen issues
> where 9p returned values that amount to allocating about 8000GB worth of
> memory (cf. [1]). That's now fixed in 9p. But vfs_getxattr_alloc() has
> no reason to allow getting xattr values that are larger than
> XATTR_MAX_SIZE as that's the limit we use for setting and getting xattr
> values and nothing currently goes beyond that limit afaict. Let it check
> for that and reject requests that are larger than that.
> 
> Link: https://lore.kernel.org/r/ZeXcQmHWcYvfCR93@do-x1extreme [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  fs/xattr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 09d927603433..a53c930e3018 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -395,6 +395,9 @@ vfs_getxattr_alloc(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (error < 0)
>  		return error;
>  
> +	if (error > XATTR_SIZE_MAX)
> +		return -E2BIG;
> +
>  	if (!value || (error > xattr_size)) {
>  		value = krealloc(*xattr_value, error + 1, flags);
>  		if (!value)
> -- 
> 2.43.0
> 

