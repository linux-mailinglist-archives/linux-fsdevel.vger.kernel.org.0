Return-Path: <linux-fsdevel+bounces-24637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B849421D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 22:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD412864E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 20:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4EE18E030;
	Tue, 30 Jul 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RI1hyjfs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8061AA3C3;
	Tue, 30 Jul 2024 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372334; cv=none; b=hRKAUU5Bl7EreC0CTjDxWxS/MGwxAqqE90Uh2XRLa87IZ/FR8lvG7uSow8EV5BidVx5QTAng0HQh3UKM5U/jlSKV4bAkBxf8pm4jdLgy1GT8Rp63FcBxJU1qV5KIgzJl/Q/rud4dq2GyEwE1fqZ1j2530N5I5rDGqgpuOjVWzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372334; c=relaxed/simple;
	bh=+A/hpdb6LBOE0meQJxsIvfB8c5Y+1SN89gYerEinlqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb/WxahAtHU35lycBll0RB3ps2rpJvzaTaEplt5Sm/AWo/7i6Fq0Fc5mazpEveBVhn8j59moYW9XtRYvly+tnlvdOd/fZPrgKASGNvFLd4CCvZoFiNzLq5KucM9BgfYvqdnkVX7LXVjJm3LLZDXmsFNqh1IFizGMSusw3KcgwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RI1hyjfs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AyIQVJdtiLHxHgkghaVH0Zo2zjyBVZ/zxH2vgQmbZIo=; b=RI1hyjfsEZvD4r7wraHhHkfsYL
	Y50Ck9fa9Li/bReskTkw140s/bHzgRi6YCEUHeKVDGgjrRWvil7956itUqoh1DviZVOVOG35ynmB6
	XOqVe6tPCK0AiInjvfN6RJ9m1zSsYLyzs7amZUBGi+fl2H+srjn9DDSs/R+XZ+uI352jTJPauMOUA
	fwTUV+zOg2tBdryR0XW60jONWCGze0KyA+zYuv+Xhw5srT6uj0dNlncSlXcU5chjJFHUWAU3wN4yJ
	//KM+ng3aAA6uHrQ5YRl8ztSxKpDlkTqIpI9DFZ296kJdLFE/eCGNSKE3XLVgDWeIFJonRIfKjIbY
	dVVQhd6w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sYtir-00000000Jwx-3beI;
	Tue, 30 Jul 2024 20:45:29 +0000
Date: Tue, 30 Jul 2024 21:45:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Olaf Hering <olaf@aepfle.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1] mount: handle OOM on mnt_warn_timestamp_expiry
Message-ID: <20240730204529.GG5334@ZenIV>
References: <20240730085856.32385-1-olaf@aepfle.de>
 <20240730154924.GF5334@ZenIV>
 <20240730215827.77b90c8a.olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730215827.77b90c8a.olaf@aepfle.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 30, 2024 at 09:58:27PM +0200, Olaf Hering wrote:
> Tue, 30 Jul 2024 16:49:24 +0100 Al Viro <viro@zeniv.linux.org.uk>:
> 
> > d_path() is *NOT* going to return NULL.
> 
> The existing documentation does not state that fact.

Needs to be fixed, but as a general rule - mixing NULL and ERR_PTR()
for error reporting is a Very Bad Idea(tm).  There are cases when
there's a legitimate reason for a function to return both, but they
are rare and NULL should not be an error case.  Example: d_splice_alias();
ERR_PTR(-E...) => error; NULL => success, passed candidate had been
accepted and attached to inode; pointer to struct dentry instance
=> success, preexisting alias returned and should be used instead
of the candidate.

Using IS_ERR_OR_NULL for "future-proofing" is obfuscating the things
for no good reason - it confuses the readers, and it tends to spread
when people are copying the code around.

Please, don't do it.

