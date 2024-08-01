Return-Path: <linux-fsdevel+bounces-24738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3630944530
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 09:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44421C2265C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 07:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1963415820C;
	Thu,  1 Aug 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oS+sPwg8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB216D9BD;
	Thu,  1 Aug 2024 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496223; cv=none; b=kN9lJuxf9RVowb+eBEr9ir4/ZT5xwNnu0rJDpKFoLhb79kMUhjMAPWwA8p39EFXiyPojbyd72g+Eax2Fh1RagQzGsb0jrL+qnhnYYIZCO0dEfcV/rh+k+YLh0awLk4+rjNOMbYwrjmYnOoUYkzC8gEG1BULIEORHF5MiB+xdU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496223; c=relaxed/simple;
	bh=aMjfXeXEC6UootsAZyVk/rPsGbBpGhaaxXIkK8HnfN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD0RUW3gADANIOh2JEBUg3t8WMq0nLkVYtpK4zf3B3DtOlEkkK/Ho+2ljNx9EDUjFRcsTKypTMnwJm3n4j5K//m81leL6dAvhNpHmhbbX1qiVMQewWeZHaQCu7MlYDZtMoEE40so1r95G46HYNvvq8C1U/H4tJhV8DGJGesXtxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oS+sPwg8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3+u/IePx+23HYIcKU4vqAjAChZzr/8w7Kjttwuq7ON4=; b=oS+sPwg8yk6DlU2PKLnTDoBDpE
	wt23eiQeLPvbFf8haXHNuaZo42UR+bDVMmaXZu+EXueEBCs1k47CPKYXCleoNDeDF72R7Zyca1Eb9
	PT+XNg2ZhUg8AD8rr34ln8ZPhL0CO6L/HQhORuo/e4RdRYIzWhjrV+af2yh0DEijynryOXd5433Mf
	vtHjflVSOLaUlfY+/0jbHkKBKmSUI9GPw6YpU9shHR1Qz3KF9a7pAq5NsxAHnMmycZ420hY4lBe0A
	CDrN2HiGmlWYo5QDPBxjHnd/9Oljl2Z3RIv4lD8u6YMSHdWd+2ROmWRcYSDkVKHAhM8NdggG1mQZ5
	CwWwv0yw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sZPx3-00000000f62-07Wa;
	Thu, 01 Aug 2024 07:10:17 +0000
Date: Thu, 1 Aug 2024 08:10:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: Re: [PATCH] filemap: Init the newly allocated folio memory to 0
 for the filemap
Message-ID: <20240801071016.GN5334@ZenIV>
References: <20240801025842.GM5334@ZenIV>
 <20240801052837.3388478-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801052837.3388478-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 01, 2024 at 01:28:37PM +0800, Lizhi Xu wrote:
> > > syzbot report KMSAN: uninit-value in pick_link, this is because the
> > > corresponding folio was not found from the mapping, and the memory was
> > > not initialized when allocating a new folio for the filemap.
> > >
> > > To avoid the occurrence of kmsan report uninit-value, initialize the
> > > newly allocated folio memory to 0.
> > 
> > NAK.
> > 
> > You are papering over the real bug here.
> Did you see the splat? I think you didn't see that.

Sigh...  It is stepping into uninitialized data in pick_link(), and by
the look of traces it's been created by page_get_link().

What page_get_link() does is reading from page cache of symlink;
the contents should have come from ->read_folio() (if it's really
a symlink on squashfs, that would be squashfs_symlink_read_folio()).

Uninit might have happened if
	* ->read_folio() hadn't been called at all (which is an obvios
bug - that's what should've read the symlink contents) or
	* ->read_folio() had been called, it failed and yet we are
still trying to use the resulting page.  Again, an obvious bug - if
trying to read fails, we should _not_ use the results or leave it
in page cache for subsequent callers.
	* ->read_folio() had been called, claimed to have succeeded and
yet it had left something in range 0..inode->i_size-1 uninitialized.
Again, a bug, this time in ->read_folio() instance.

Your patch is basically "fill the page with zeroes before reading anything
into it".  It makes KMSAM warning STFU, but it does not fix anything
in any of those cases.

