Return-Path: <linux-fsdevel+bounces-19340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A588C34EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 05:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531F328198F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 03:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C58C142;
	Sun, 12 May 2024 03:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kdp4UaTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B978814
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715484664; cv=none; b=VkVrCeOPg4ZxiWSWepSl9Uf1MrA+FXmBUXs8HETNv0ClCF/uaWX0upRhZXT5m9/0yoV7nfvaxHeK86Er2+Z/yykgWArQVZ/JNExup8KDXBi2cgA6jdbf0jtirlNybkkPxeucvMbgRoP68vRf42Eo35nlnglIYSTVbzAgofOtwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715484664; c=relaxed/simple;
	bh=PKBwt6JbUM8NLS9FbjRj1c3tN5OP8wd+TXom6HdbbRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9hy7sa0uWNvPF6CFEIhJoW2agiQtgYVwJiOEvA3tghQWVtOLvOPoEGsPdTobtysj7uI9XIgpkl7aJ3GdSP8aHK1HA3F93HqfsPuu3q+FGc6xK3bCF9RXwKgAU3lO8c2CkSKTjwEhBL9vs1sbHLK7MsMMxbexdDbzrQXcany6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kdp4UaTw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7lLUXKcJNS69HddQnKTOTIM6I7QH4rM5H0fQ3zh+IaQ=; b=kdp4UaTwAwQOh4fUkSIIwYBxTZ
	chhLR28RnwWVLEMV3sF9Z9RUG0Rk6ruGWy0ERxql/IM9C3UlJc7nvAcauRkqjwAEwd/TFLvG2+kYG
	wu5j1qW2aM9FKzHXclwP53G6nOhgPFCK85Z39ulFWz5G5hs8y7bKT+PDm4VCOpHOgpOoxCBWF9zX2
	j5AUsHX4hQHKc72z9YSRCEh3nM80Ux0Zv11L73ebyBWZgksoBY6RoiQRF6OsTpxRnG+DFjC1sh41/
	pxLNhis8QxRAuKeMIy76cmKJZAZaxiX8hdrYVTmrw7KOPEeu8L4ILpODtA+7szmiNHy09v76zdrPd
	SjdGKa6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5zvJ-0048Ne-3C;
	Sun, 12 May 2024 03:30:54 +0000
Date: Sun, 12 May 2024 04:30:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org, longman@redhat.com,
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Subject: Re: [PATCH v2] vfs: move dentry shrinking outside the inode lock in
 'rmdir()'
Message-ID: <20240512033053.GF2118490@ZenIV>
References: <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511200240.6354-2-torvalds@linux-foundation.org>
 <CALOAHbBSRGViePQm45upEJnUNnOa1=ZjkvAT_tR6jXMTEKUSkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBSRGViePQm45upEJnUNnOa1=ZjkvAT_tR6jXMTEKUSkw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, May 12, 2024 at 11:06:07AM +0800, Yafang Shao wrote:
> This could resolve the secondary concern.
> Tested-by: Yafang Shao <laoar.shao@gmail.com>
> 
> Might it be feasible to execute the vfs_rmdir_cleanup() within a
> kwoker? Such an approach could potentially mitigate the initial
> concern as well.

	I'm honestly not sure I understood you correctly; in case I
have and you really want to make that asynchronous, the answer's "we
can't do that".  What's more, we can not even delay that past the call
of mnt_drop_write() in do_rmdir().

