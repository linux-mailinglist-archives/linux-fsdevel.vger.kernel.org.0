Return-Path: <linux-fsdevel+bounces-36540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFD59E585C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EBA283495
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918021A43F;
	Thu,  5 Dec 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hNvUabuA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651584A5B;
	Thu,  5 Dec 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408336; cv=none; b=sl5myWjSNrvAes4WLjrmn0m8IobNGhr2uFjBVYLFUaWmIIVfjaokA4wmtIEPhU2aPpN7BEWBjxlr8f6zpEBspS0FOV7aaG7qXOOs503vQKKktc05BNQZOctEtHed/Rc82HGgxtMl/gEZ/ugn7DEHNvnk89bmWxvUyXZ/IQE1QcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408336; c=relaxed/simple;
	bh=a2B2Dj4fWLN39XL0GnueLCtei8vr48XbIOnRCnLUHiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw4pbaX/XwnKI3A2vYyK4GoJ8fHLW0RuW2gN3tmnww3ZrtujrV+os+tvhJZPrShff9bnSgBrpNoLWgtbcKMqr/g+e18CrJvmS50QTLGU0uw40uR0wQpJvWGstmSk11n74mmKgRercaAqZ53x4EowyGRdpSLw2KdhivqrOWSBv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hNvUabuA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1FnD7vYDvYGjn7VoepL9sooEb2SIm6Bnyb1TmQSbVic=; b=hNvUabuAbI1r+JzxLwFqEocFXs
	qPBoCxu++XVo2iuuGcS/xsDVrO0//7vSXAzGFHrqNcNGntH4Tg+RRgBIG2tS4jIlwpMiAs3uH/V5H
	sx7Y2lNy8hybvTlaoA1A2HUs96MeCqvmmQh65+1h5SrrItgJEIukLE8IiWA3/lLcerwdaidSRVtVy
	S29A5xVLzp829hsRb3Zp8Jdt8YJEuRYannbKNePBhK4INt8xqd6KueJL9ik4m9H9iZ17EoTIRgfVB
	IDOk0JeAJ7foEK4h/M8ghvxwSKWsTAUddfrHqye9tR+N8NCgNsCyjuI0wRllfoqYfcpW0RCjURRIn
	9PWZrENg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCgs-000000058ni-0FBh;
	Thu, 05 Dec 2024 14:18:50 +0000
Date: Thu, 5 Dec 2024 14:18:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: paulmck@kernel.org, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Message-ID: <20241205141850.GS3387508@ZenIV>
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205120332.1578562-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 05, 2024 at 01:03:32PM +0100, Mateusz Guzik wrote:
>  void fd_install(unsigned int fd, struct file *file)
>  {
> -	struct files_struct *files = current->files;
> +	struct files_struct *files;
>  	struct fdtable *fdt;
>  
>  	if (WARN_ON_ONCE(unlikely(file->f_mode & FMODE_BACKING)))
>  		return;
>  
> +	/*
> +	 * Synchronized with expand_fdtable(), see that routine for an
> +	 * explanation.
> +	 */
>  	rcu_read_lock_sched();
> +	files = READ_ONCE(current->files);

What are you trying to do with that READ_ONCE()?  current->files
itself is *not* changed by any of that code; current->files->fdtab is.

