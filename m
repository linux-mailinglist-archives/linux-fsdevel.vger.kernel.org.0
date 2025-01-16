Return-Path: <linux-fsdevel+bounces-39439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C2A141FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 20:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE4E1886BD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17C522F16E;
	Thu, 16 Jan 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PHHYUO+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AC1547E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054528; cv=none; b=eh0bvBf2rVzv75Bl3YJVBmfXjEEykWeIHeQdpNtgLjBnThXQ82uYA23vickOguTL6nm0RoxIp9AdWqiepz6lTeW30QClpO0c2bIiAxoIqPB83geXqI84F1+5vyKZUJ7OgA1HvnxZCLMtWad/HfrSxLUkbfZOYfUW/RC9qXJaNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054528; c=relaxed/simple;
	bh=42k/0Jd3GCA5yOacH6AKiIGEesv+ylSJBbXS4mjZbRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZS8lwoVUc1vGx4YiCKOq42eC5ZfrF0IGuW6dUxJ8cURXfKAe+tO6u5Ry9MYiOez3e0PdVBUV4/HrXNZsNhv1d9Rtv+DJn93TCKhcbt+4lQZQ7TN+NK/YpuG7FlMknJ6kv4nJrwwsISvGUu/UHA0W0n0ni/8ghtWDgymFOy6Nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PHHYUO+i; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ljVgD/EUSEofm8eEFQ4Hj8fa+0vYKcKj4DfolD1N57w=; b=PHHYUO+iMCB1ukBqxSH43NGlgg
	92dGJueOXOnLd0OTCMCXgro04/3V3FiMSd6HxECIT5bd/MBLYfXk1YnJGGJihgWn5ZROu0nhvpeQm
	9S/EFxhVcTZZdVdlMrvfEZ1rJS+OnwttX5ZA1UuYlKEvAgUuz7WiVrxw6z5RZFclAf5khCus+xDa3
	GQtaOECh0Ef9OCha2emrBeEtg/m/lIygtwmtvhddG4xSEHoGn9K+foRblDsMuyXTambcs/XCzyaN1
	QxQ4EbOWTw/80jS202UJLsijeh/y4JotvJvauzdjlUECQHRrIM6VmE2GMExdScmO8IA/1HdU8QZer
	JB9hV4Pw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYVES-00000002ZKL-2SCZ;
	Thu, 16 Jan 2025 19:08:44 +0000
Date: Thu, 16 Jan 2025 19:08:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH] ufs: convert ufs to the new mount API
Message-ID: <20250116190844.GM1977892@ZenIV>
References: <20250116184932.1084286-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116184932.1084286-1-sandeen@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 16, 2025 at 12:49:32PM -0600, Eric Sandeen wrote:

> +	switch (opt) {
> +	case Opt_type:
> +		if (reconfigure &&
> +		    (ctx->mount_options & UFS_MOUNT_UFSTYPE) != result.uint_32) {
> +			pr_err("ufstype can't be changed during remount\n");
> +			return -EINVAL;
>  		}
> +		ufs_clear_opt(ctx->mount_options, UFS_MOUNT_UFSTYPE);
> +		ufs_set_opt(ctx->mount_options, result.uint_32);
> +		break;

Do we really want to support ufstype=foo,ufstype=bar?

> +static void ufs_free_fc(struct fs_context *fc)
> +{
> +	kfree(fc->fs_private);
> +}

Grr...  That's getting really annoying - we have way too many instances doing
exactly that.  Helper, perhaps?

> -#define ufs_set_opt(o,opt)	o |= UFS_MOUNT_##opt
> -#define ufs_test_opt(o,opt)	((o) & UFS_MOUNT_##opt)
> +#define ufs_clear_opt(o, opt)	(o &= ~(opt))
> +#define ufs_set_opt(o, opt)	(o |= (opt))
> +#define ufs_test_opt(o, opt)	((o) & opt)

I wonder if we would be better off without those macros (note, BTW,
that ufs_test_opt() is not used at all)...

