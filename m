Return-Path: <linux-fsdevel+bounces-24833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82147945324
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 21:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B35B28460D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464FA149C5B;
	Thu,  1 Aug 2024 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EgL8OFb1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD4182D8;
	Thu,  1 Aug 2024 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539590; cv=none; b=Q3zVgdcQSolhIN4w5g807Kczuu/O1ImhUHcPhxg6MYHR8wnNqXl7fMTqA9R2jP/OAQihTwXRRUkPXTPuNYzodDP9OtWDbIfy/Nk9+HlVIlWINV8rIB7To+mGAICMqk2+ROCQp6i/hc9nMS2xqqxkB19j5lrw6M+M4Dr8QUyv8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539590; c=relaxed/simple;
	bh=XDHKIQS2hKt/VIC3kaR3SJy6CiSf0xRjkk95/jhdC0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eep+7Yj4WH0eFKiLpAS/6vSZJf1xl+WpYWEsDzwrNd10ME25XnaGotT+9MX5fJSk1pYTgqPX86wXT3UboInwSo5cbl1SrO77sK0Dq9PzVWQfRwrB8uJIZj+ZwdVUML/aDVyybgqOFuDhLVigN0Ea8+rVZNrWsVLv+J4WmipCrog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EgL8OFb1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vdMgM0IDzx9Pa2Ybdg/+Rz2XZS0UlNsT//QW/DTj7Ps=; b=EgL8OFb1rcQzMMJlsES5wXhCDe
	sWI8E5cVaDJY3BSnCOkJVSLMlJHHyD14BSkUMnPzfgscMe5t09/1QluaPOSUgAtwU203SuPwJYDeb
	FBQTq2S9AkH5/+u6Ei3S2tujQUYEBWO57ntRapp8Lteak2z8s1O7h1ZRqd+yyxe0BiuZLs+yMTtAb
	D5BZmeLhZvrvOKcl92y+J1OK3E12lBqwaNRS04Yajz2XTSwKFTNh1NfJamg/Ev6d9jMBgVj8LT1Co
	/aIw8tUdKudQwvSDUx9/UEoecq85HupciyOhngXKVK3CgwXcPbdjwp9HpuxcG1P0xP5Zifi7EOcWe
	+UjSj/6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sZbEW-00000000n3q-11Da;
	Thu, 01 Aug 2024 19:13:04 +0000
Date: Thu, 1 Aug 2024 20:13:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, mjguzik@gmail.com, edumazet@google.com,
	Yu Ma <yu.ma@intel.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, pan.deng@intel.com,
	tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v5 0/3] fs/file.c: optimize the critical section of
 file_lock in
Message-ID: <20240801191304.GR5334@ZenIV>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240722-geliebt-feiern-9b2ab7126d85@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-geliebt-feiern-9b2ab7126d85@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 22, 2024 at 05:02:04PM +0200, Christian Brauner wrote:

> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
> 
> [1/3] fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
>       https://git.kernel.org/vfs/vfs/c/19f4a3f5712a
> [2/3] fs/file.c: conditionally clear full_fds
>       https://git.kernel.org/vfs/vfs/c/b483266658a8
> [3/3] fs/file.c: add fast path in find_next_fd()
>       https://git.kernel.org/vfs/vfs/c/3603a42c8c03

Hmm...   Something fishy's going on - those are not reachable by any branches.
As the matter of fact, none of the branches contain _anything_ recent in
fs/file.c or include/linux/fdtable.h; the only thing I see for include/linux/file.h
is (dubious, IMO) DEFINE_FREE(fput,...) - this IS_ERR_OR_NULL in there needs
a review of potential users.

I'm putting together (in viro/vfs.git) a branch for that area (#work.fdtable)
and I'm going to apply those 3 unless anyone objects.

