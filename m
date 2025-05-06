Return-Path: <linux-fsdevel+bounces-48273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4D7AACC2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DA43BCA8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FAF284688;
	Tue,  6 May 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F7QH7Fhl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224E42222D5;
	Tue,  6 May 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552344; cv=none; b=taCnzZTXzhdJSKZdZUSCj4ZeZ/D1c9U9MYI9w62K5FaLLwZBSdL/ylfdftJQy9jsm6Gm4O0umIObS0DBLS1IVXhD4gitG60hoCK39dsPpSecfI0LYXjjCS4FOCBSmOcc8c4HlEWtfpAD9fBHoQmyD+W5DHC+qfhC7JGoCEGycOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552344; c=relaxed/simple;
	bh=/c7AQWNXpTbI8z9dfs40zTXSUYEnNjB0YPSJDuv5xjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9l+qBKILj8zUZv+rnvo6rurzwKlPEa4IF0JOCbYNByP8ZVm1tbgAbCOlbJHrAIw7N3VVKuvfoDrHR9L5s2jKUdMrLE/63knqS9isu5cmoERrDtUzR5HJaiLjox4p1H9jpqSzjN+uglcv5Lr/QsloXmFDBseu+bguTAoldKKQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F7QH7Fhl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1b/uvVJ0tHI5XHV+qU3aSCK5NuxdsE6kCpSJM6zUoTk=; b=F7QH7Fhl7/u6OmW3g1nrkkrEpH
	NRQTUM9Szth80xlghMruVCIm8IoN+ceDOgORXI3oR4rLGsb0nJx7JQYftRZgvdUoNyTD2X7kPrnM2
	eQOwENs0LPlrkMDCV5UOvc8E568eOUDHlrhgFS38rg/Lze35a6KhOFuHbEDMKF8TVL641Vlp1xZhW
	Quebxv6IomRUW1z/lx2VfPxla8jUHHStwKgZn5xYSGIUbFl7mVgXj1JA4b5/XyQgyz8vfpIT/g0bk
	N8mQe+2ZyQ0J5FAoTaUDDpigvcIysGdGe+IFEp5ElIXm2QHlLTM4V9qTVi6Rxox5Bnjp5F0yg6x8A
	nwj5jpUQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCM31-0000000Bkgc-1fxb;
	Tue, 06 May 2025 17:25:39 +0000
Date: Tue, 6 May 2025 18:25:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250506172539.GN2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 06, 2025 at 03:36:03PM +0200, Klara Modin wrote:

>   25:	49 8b 44 24 60       	mov    0x60(%r12),%rax
	rax = fc->root
>   2a:*	48 8b 78 68          	mov    0x68(%rax),%rdi		<-- trapping instruction
	rdi = rax->d_sb, hitting rax == 0

> > -	mnt = fc_mount(dup_fc);
> > -	if (IS_ERR(mnt)) {
> > -		put_fs_context(dup_fc);
> > -		return PTR_ERR(mnt);
> > +	ret = vfs_get_tree(dup_fc);
> > +	if (!ret) {
> > +		ret = btrfs_reconfigure_for_mount(dup_fc);
> > +		up_write(&fc->root->d_sb->s_umount);

... here.  D'oh...  Should be dup_fc, obviously - fc->root hadn't been
set yet.  Make that line
		up_write(&dup_fc->root->d_sb->s_umount);
and see if it helps.  Sorry about the braino...

