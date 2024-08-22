Return-Path: <linux-fsdevel+bounces-26783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA395B9F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB991C23290
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459153D3BF;
	Thu, 22 Aug 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="U+8y7g7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC7182DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340027; cv=none; b=phVXW1dY1C3MyAgMPZE9crGsdIBOvRvtCG5SrbyyuME6xR24bZZ23OmnhwH3Jb0cPqUjtlnL/Dcqjb0Hrdb0Jle6u/q2QdTm9rlis9ZbZFcoEAYsvc7Zmh9udL23Yzu9gyjHBwMo+CiZenfe/lebWq0N0B+AU4RGD4mVfHhRqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340027; c=relaxed/simple;
	bh=5rJxjEJo8luZroawJHYSYN9taAtECAm3Yb0J4151ku0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9CPKZSz16cLNV50eRxYgZnefuKIoRJACRwRqM6hQk7Lz4SGUm1bEPDjXV/k0Ins7RIToGj5VuknpRMI0KEcd84o2TGLT5IxzVj+IjB5OjKklzibTyZyil18PnAzLsTrmXm5GqQjGIVUIwtmMeLiXw2SyaE43fcbpMvrE2uQjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=U+8y7g7m; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=28CByVoDKbmSRRoAthE7OCIveD+kuGlPjlnsnOxE2WQ=; b=U+8y7g7mJU3YIDPNhHd6YX145o
	S6ebhlQ3NAZ6TWcOC6QNny5FyE+2w5iFlzB667o8Jd0g6jScASoWP6RF3M9j0CXqTNW6ON9nH+IEz
	rMscFLTn3peq7N0O81iSD7RDymYz2HpjOoA/CPvfC1xfiHj7iGBe37ULh7jdQtDaJnczCQDL8EN4/
	BBHQl6jENKs8BgTOGztSqgyM+0I14aZ869U3+hXWv2/+zykm225FvgVMQCmjzDwnhBWu1Lx3lDCOo
	XuNzCVorUvEU4e66WLtJI6WQX89u0/ANZBqIdwaJRYsptYazPEx7fe1Vrbs+b5FG+7B1Z4/rtS9p2
	qjWRbB4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sh9bq-00000004FKl-0LTH;
	Thu, 22 Aug 2024 15:20:22 +0000
Date: Thu, 22 Aug 2024 16:20:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] new helper: drm_gem_prime_handle_to_dmabuf()
Message-ID: <20240822152022.GU504335@ZenIV>
References: <20240812065656.GI13701@ZenIV>
 <20240812065906.241398-1-viro@zeniv.linux.org.uk>
 <57520a28-fff2-41ae-850b-fa820d2b0cfa@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57520a28-fff2-41ae-850b-fa820d2b0cfa@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 22, 2024 at 04:41:59PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 12.08.24 um 08:59 schrieb Al Viro:
> > Once something had been put into descriptor table, the only thing you
> > can do with it is returning descriptor to userland - you can't withdraw
> > it on subsequent failure exit, etc.  You certainly can't count upon
> > it staying in the same slot of descriptor table - another thread
> > could've played with close(2)/dup2(2)/whatnot.
> 
> This paragraph appears to refer to the newly added call to fd_install().

It refers to dma_buf_fd() call that had been there all along, actually.
dma_buf_fd() is get_unused_fd_flags() + fd_install().  The reason
for splitting it in new variant and calling get_unused_fd_flags() and
fd_install() separately is that it makes for simpler cleanup; we could
use dma_buf_fd() instead - it would be a bit more clumsy, but that's
it.

The real issue is that drm_gem_prime_handle_to_fd() forces us to make
the thing reachable via descriptor table; it's just what we need when
all we are going to do is returning descriptor to userland, but it's
inherently racy for internal uses - anything put into descriptor table,
be it by fd_install() or by dma_buf_fd(), is fair game for all syscalls
by other threads.
 
> > Add drm_gem_prime_handle_to_dmabuf() - the "set dmabuf up" parts of
> > drm_gem_prime_handle_to_fd() without the descriptor-related ones.
> > Instead of inserting into descriptor table and returning the file
> > descriptor it just returns the struct file.
> > 
> > drm_gem_prime_handle_to_fd() becomes a wrapper for it.  Other users
> > will be introduced in the next commit.

> > -int drm_gem_prime_handle_to_fd(struct drm_device *dev,
> > +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
> 
> If it's exported it should have kernel docs. At least copy-paste the docs
> from drm_gem_prime_handle_to_fd()
> and reword a few bits.

Point...

