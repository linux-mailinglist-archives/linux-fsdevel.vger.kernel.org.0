Return-Path: <linux-fsdevel+bounces-17840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855228B2CBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 00:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A961F29AF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E054171069;
	Thu, 25 Apr 2024 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ty6J8OGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C714A0A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082614; cv=none; b=ldCPepTAnOJmBBVa6CAvp9U0lMF/jBTj3CdX3ZwoCREUWbErta8o0IhwWPm5ROT6ULmxa37mUe4/ljNCPNVS80mDxY37V0V6y5xeDGdO4b8NObULGivQWctgyT2JlfwEIcZMJ6kLuYYrLPRQt2XWy10pLbJbXGwWe5XRYP0aYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082614; c=relaxed/simple;
	bh=fqikQ1rGl//RQkI/P0N/Th1BjBj7qDNDe7+8syDTDrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxvxwGXL9uCbVqJjCrxaxKEm+F/0JPiB73NBTk2tfA2i1BLoRybBXYJklX1AaVwtvOsOheMv8Xe7Dh3wbsFRp8+9wLPbK/1UQkqVKRQSrRBR26UXrLxC7DrfzepPZAtsTax2RGbZq+W91M9xgd/1FjF86snE0Ih1K566Cw1uqR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ty6J8OGI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TYHOAf9eMKVWbOU0CoQbhWBinJP29EnRFB9P6jCKY90=; b=ty6J8OGIXbJMMb0lMmZXNo+jD6
	N1wnXemKXrG27RgHdGTR2rTnC5Ud7MscUF9uTiwkzOqfx/GCEVxKgHFxMvNsHx2avsY1j/VOCYSwq
	fiEhk7UJ77j7ceroGH6B9w2YxV+LePkko/0IWu/sCCe1u9K/52Cg7d7LCsKi980fWrfzJ8TdEl5jL
	vypv+Ha99B8u2W/PBbpy2+NiTL+ySJv2gnHEnF0+T94cqh9+qfb18Gn5ZNHOjiroX+y7V6/p+1Hy/
	tlijZFQM/10i1lZ1YQIUXaro4aGMXNbAS+YZFLz37qVqPFnl3pZQdz2LV/vIVvw1Qbabqm4bEYkzX
	hkt2UDjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s07Bh-004PQW-0B;
	Thu, 25 Apr 2024 22:03:29 +0000
Date: Thu, 25 Apr 2024 23:03:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dawid Osuchowski <linux@osuchow.ski>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v2] fs: Create anon_inode_getfile_fmode()
Message-ID: <20240425220329.GM2118490@ZenIV>
References: <20240425215803.24267-1-linux@osuchow.ski>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425215803.24267-1-linux@osuchow.ski>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 25, 2024 at 11:58:03PM +0200, Dawid Osuchowski wrote:
> +struct file *anon_inode_getfile_fmode(const char *name,
> +				const struct file_operations *fops,
> +				void *priv, int flags, fmode_t f_mode)
						       ^^^^^^^
> +struct file *anon_inode_getfile_fmode(const char *name,
> +				const struct file_operations *fops,
> +				void *priv, int flags, unsigned int f_mode);
						       ^^^^^^^^^^^^

They ought to match (and fmode_t is the right type here).

