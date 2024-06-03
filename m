Return-Path: <linux-fsdevel+bounces-20770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 755518D7A11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 04:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B27AB208D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 02:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A125ED29B;
	Mon,  3 Jun 2024 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R6sVr8P8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAEEB644;
	Mon,  3 Jun 2024 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717381303; cv=none; b=j7iKlyZ3Ht3bKxA/+IxFbaLQqIr9C66l5Q552yfEsuZIPBxh24TU2hlr5W0k0pkG6Ll1/djxqVbIbv9uob/gMN7fdx4vkQMUBudoSS+tS3gW/hdImFleYNEEaqGyd9iJEPB2+BobP6uxvCCw2UguBcNRmtwmqlJQV42DcGlFinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717381303; c=relaxed/simple;
	bh=xa0lj1QRhY9X+c344d/dpSi9fKBltznOOgHIfBn+xno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhJ6yi1v1cEsuipv7P1bh7gaNtC1wJzP0YE3/ujkyckpVeyyvkSBboIsqi22ICplmisauP3RSUIZrk6O5cWoWXQFjkJ5tSctPxpTacPt7Jcmqc5RPg/LYVbm8kly60LqskejTn/BsUDFKvNtODrGgaXHFONE7OarcwJjbPWX3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=R6sVr8P8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JyIkUKS0qwODKjELD3JTYlSmIJgRQBkfUKhH8UIdB20=; b=R6sVr8P857hCvSI7wvdpl8VC6J
	oltDFaKQz6xoKV7j8N1NbgemGb+uTdX47Xm1oplZiOpdC3kGjEhgvxFfcvTQQ4pRyDaKykLQbwpcd
	jt/L4WW7bvSt8/MqUMaeLjB9WLyRtnDbkTR2EMZS+rvV9hOXCSzK2It6x5dWQf0eciBf5z5WSQXhh
	NNU04yTuPRXtO4lKxGAelPCLc/fH3fpm0YJ6XRy20ibmzD1afxSX1hnUU8A6BcsTOb5zssaTYN4X0
	2/O3AhTVnqPXZD47CkLEXV94zj2XFlB50ARL22ZJ30CTsscVhxd9Yu8sZMz/t5EcrFOl9tPfwyyND
	dA+ExASg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDxKD-00BGgB-0I;
	Mon, 03 Jun 2024 02:21:29 +0000
Date: Mon, 3 Jun 2024 03:21:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: David Howells <dhowells@redhat.com>, Baokun Li <libaokun1@huawei.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] get rid of close_fd() misuse in cachefiles
Message-ID: <20240603022129.GH1629371@ZenIV>
References: <20240603001128.GG1629371@ZenIV>
 <80e3f7fd-6a1c-4d88-84de-7c34984a5836@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80e3f7fd-6a1c-4d88-84de-7c34984a5836@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 03, 2024 at 09:53:26AM +0800, Gao Xiang wrote:
> Hi Al,
> 
> On 2024/6/3 08:11, Al Viro wrote:
> > 	fd_install() can't be undone by close_fd().  Just delay it
> > until the last failure exit - have cachefiles_ondemand_get_fd()
> > return the file on success (and ERR_PTR() on error) and let the
> > caller do fd_install() after successful copy_to_user()
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> It's a straight-forward fix to me, yet it will have a conflict with
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/fs/cachefiles?h=vfs.fixes&id=4b4391e77a6bf24cba2ef1590e113d9b73b11039
> https://lore.kernel.org/all/20240522114308.2402121-10-libaokun@huaweicloud.com/
> 
> It also moves fd_install() to the end of the daemon_read() and tends
> to fix it for months, does it look good to you?

Looks sane (and my variant lacks put_unused_fd(), so it leaks the
descriptor).  OTOH, I suspect that my variant of calling conventions
makes for less churn - fd is available anyway, so you just need error
or file reference, and for that struct file * with ERR_PTR() for
errors works fine.

Anyway, your variant seems to be correct; feel free to slap my
ACKed-by on it.

