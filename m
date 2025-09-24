Return-Path: <linux-fsdevel+bounces-62680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803DB9CB8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 01:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224E93AE110
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701E7288C20;
	Wed, 24 Sep 2025 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a94tCqIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09311185;
	Wed, 24 Sep 2025 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758123; cv=none; b=p3G9IDR/MM3YZQm47lfw4LoCuBRPthORde9Hkm4E9aZBkM9soTn2PuSZ0E8veknWCeFrfevq9OQigWUBFtjL91q58um1Vv7+na/v2nDrlflKGUAnztv1G7G5LRtYa8lSWO1yx7M/i3yg+4lVfUXJV1lwFXKd7/nkn/tQA+HzvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758123; c=relaxed/simple;
	bh=AqgK+3cdyTUkEiq2hc1XNqOhnQ51PE4UEFUjn4Ysl6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2GLTldVr7QajjyZPr4VFFvGyp0Bg8XWQLvRmY6bW+2yUp0o1/X+5xUEtv+/P+IVELIK7yTXvFOGK+YEeiAXJJte8zJQKX0Qaojt1HeTurh3N8y3kqKruSCtuNk6iNEd+v3EIeYo1wrWPO/mGQKN8h+a0FiEFyJHBUumKQR+MeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=a94tCqIu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6FvLAqKjgxtoVteG+p8fawzit9/dnULVzKfbMmfB+YE=; b=a94tCqIubabDGAq67I5RIIIP84
	7fQArIpbd65yPbQWNvLICq3OBQUmJnMuSkz7pHeWO9DlybN2Gfr9QCa5eDl27ZFCUknrhPH0o8h6L
	Znb6Z7p4J5IE6mVeq+pGkpYreb9IVMIgeXkxKYR+JZiHI7gQHzBbfyYXvknxmJxQY2EK9Kak0OBk/
	Jaeaol+F8Ce+relQ16LKgaOYK2d9UbxXb09XytyfqIOXOCUd6HvHt9/LO/SnKUGt5hgjv/h8036DY
	jPoYu6RPLk50yUxxYNDl2fQbODrF3ZOOer5iu3Mqr9HyvTnL5nc/UnBap0uAHsOSThwAzC+vJVhmv
	UvaEVOeg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1ZKQ-0000000Djuk-0mL0;
	Wed, 24 Sep 2025 23:55:18 +0000
Date: Thu, 25 Sep 2025 00:55:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Windsor <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	kpsingh@kernel.org, john.fastabend@gmail.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
Message-ID: <20250924235518.GW39973@ZenIV>
References: <20250924232434.74761-1-dwindsor@gmail.com>
 <20250924232434.74761-2-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924232434.74761-2-dwindsor@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 24, 2025 at 07:24:33PM -0400, David Windsor wrote:
> Add six new BPF kfuncs that enable BPF LSM programs to safely interact
> with dentry objects:
> 
> - bpf_dget(): Acquire reference on dentry
> - bpf_dput(): Release reference on dentry
> - bpf_dget_parent(): Get referenced parent dentry
> - bpf_d_find_alias(): Find referenced alias dentry for inode
> - bpf_file_dentry(): Get dentry from file
> - bpf_file_vfsmount(): Get vfsmount from file
> 
> All kfuncs are currently restricted to BPF_PROG_TYPE_LSM programs.

You have an interesting definition of safety.

We are *NOT* letting random out-of-tree code play around with the
lifetime rules for core objects.

Not happening, whatever usecase you might have in mind.  This is
far too low-level to be exposed.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

