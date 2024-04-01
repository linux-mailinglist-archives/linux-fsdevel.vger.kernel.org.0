Return-Path: <linux-fsdevel+bounces-15840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9104F8944C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 20:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3ACF1C214F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC27B4F5ED;
	Mon,  1 Apr 2024 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="J6naoUXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA27F4F60D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995876; cv=none; b=SNYpiDbcHkEm1YfrkeD/DVrE19VsmxcsBjjPGIP0r2dvf3aKgq0B+bmHyuIWhRRT62NXCbNebQGPOOEU3JS7ilbZuA12KyDV+VadJ8ZVkCzHyirDiSiUBGRWPcPREz2majGNi/ZKIGrlM99o/nFgpvbRBd0HaJkxmJ/6EIUZu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995876; c=relaxed/simple;
	bh=8FFkiGqyKLC7TusPHWrWS0p6JoPOjlru1Tjgw6i00lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGUDBVw83yil6cVccA0jsKLIUf6NZ687Kfco9fX9gDy+1n2JUC8kMt8/UrBAH6eI8/uE+GYxM69qvJCevs5iuZU87A2KpwzVRBXwqaF+DZfIzzn+4R/JmZQN57CXCaLocAcuceVm0qeEnq0ll+GCx1S3UFx01kwx8wPQh4+E61U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=J6naoUXY reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3j1RsumzKReKQHeCKGgTf4gQk/tLtxuq9GPTFPhwEqk=; b=J6naoUXY47/kI0ub5HZmzFvEsi
	VeUawuWmGyOfaOubdv0JlSy9T8H7I8T9ZHgZHnyVSzlSrS0wiIqBwXpBuAk70oe22Yrz+Rky6m1d8
	AraTKZ629ztrkc39mqe2zJNNWHqbYKdMSHX+Fz5xPNDprEbp1Ra1S4ghiqG7y2EKv8n0yRn3WOLmg
	tYiytzFPJpxyef+8FA0AQlLPs8mjpZMi2c1+K9Xz8LZm5m75YBDbahGkU5pkPFCES0PeRHWv3kzpH
	V00IP2w4jou6i/S/XskBC/OKWGflkgjnYUtksaeueUWbpwbAEsHNRDGHCWsO3BBq6VGAwWmMcW6rh
	EtQwmtaQ==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rrMKW-003fb8-2m;
	Mon, 01 Apr 2024 18:24:25 +0000
Date: Mon, 1 Apr 2024 11:24:21 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux@yadro.com
Subject: Re: [PATCH 1/2] configfs: reduce memory consumption by symlinks
Message-ID: <Zgr71RfStvjIVkFQ@google.com>
Mail-Followup-To: Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux@yadro.com
References: <20240401082655.31613-1-d.bogdanov@yadro.com>
 <20240401082655.31613-2-d.bogdanov@yadro.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401082655.31613-2-d.bogdanov@yadro.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Mon, Apr 01, 2024 at 11:26:54AM +0300, Dmitry Bogdanov wrote:
> Instead of preallocating PAGE_SIZE for a symlink path, allocate the exact
> size of that path.
> 
> Fixes: e9c03af21cc7 (configfs: calculate the symlink target only once)
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>

Reviewed-by: Joel Becker <jlbec@evilplan.org>

> 
> ---
> I treat this as bugfux due to reducing of enourmous memory consumption.
> ---
>  fs/configfs/symlink.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> index 0623c3edcfb9..224c9e4899d4 100644
> --- a/fs/configfs/symlink.c
> +++ b/fs/configfs/symlink.c
> @@ -54,7 +54,7 @@ static void fill_item_path(struct config_item * item, char * buffer, int length)
>  }
>  
>  static int configfs_get_target_path(struct config_item *item,
> -		struct config_item *target, char *path)
> +		struct config_item *target, char **path)
>  {
>  	int depth, size;
>  	char *s;
> @@ -66,11 +66,16 @@ static int configfs_get_target_path(struct config_item *item,
>  
>  	pr_debug("%s: depth = %d, size = %d\n", __func__, depth, size);
>  
> -	for (s = path; depth--; s += 3)
> +	*path = kzalloc(size, GFP_KERNEL);
> +	if (!*path)
> +		return -ENOMEM;
> +
> +
> +	for (s = *path; depth--; s += 3)
>  		strcpy(s,"../");
>  
> -	fill_item_path(target, path, size);
> -	pr_debug("%s: path = '%s'\n", __func__, path);
> +	fill_item_path(target, *path, size);
> +	pr_debug("%s: path = '%s'\n", __func__, *path);
>  	return 0;
>  }
>  
> @@ -79,27 +84,22 @@ static int create_link(struct config_item *parent_item,
>  		       struct dentry *dentry)
>  {
>  	struct configfs_dirent *target_sd = item->ci_dentry->d_fsdata;
> -	char *body;
> +	char *body = NULL;
>  	int ret;
>  
>  	if (!configfs_dirent_is_ready(target_sd))
>  		return -ENOENT;
>  
> -	body = kzalloc(PAGE_SIZE, GFP_KERNEL);
> -	if (!body)
> -		return -ENOMEM;
> -
>  	configfs_get(target_sd);
>  	spin_lock(&configfs_dirent_lock);
>  	if (target_sd->s_type & CONFIGFS_USET_DROPPING) {
>  		spin_unlock(&configfs_dirent_lock);
>  		configfs_put(target_sd);
> -		kfree(body);
>  		return -ENOENT;
>  	}
>  	target_sd->s_links++;
>  	spin_unlock(&configfs_dirent_lock);
> -	ret = configfs_get_target_path(parent_item, item, body);
> +	ret = configfs_get_target_path(parent_item, item, &body);
>  	if (!ret)
>  		ret = configfs_create_link(target_sd, parent_item->ci_dentry,
>  					   dentry, body);
> -- 
> 2.25.1
> 

-- 

"Can any of you seriously say the Bill of Rights could get through
 Congress today?  It wouldn't even get out of committee."
	- F. Lee Bailey

			http://www.jlbec.org/
			jlbec@evilplan.org

