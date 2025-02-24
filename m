Return-Path: <linux-fsdevel+bounces-42382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D87A413C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 03:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370903B653D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 02:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64781A4F09;
	Mon, 24 Feb 2025 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LkyZhZLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4E4430;
	Mon, 24 Feb 2025 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365628; cv=none; b=nSNiTDvZDdAZv/7LA90MKIGSIBKhRBI5ugA2Yrobb6yhvRL+4E+CYflvnxCyj/taETLnJ7At4lN2rv9yVi10uOgYftnMvFRUFkOpU5uNet8l+oE6k+4w/ooM5F9TwLLZJ5RZ3nhsHu01IPC2XyfTuaV5u7n6yv+H5rcy1dRNzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365628; c=relaxed/simple;
	bh=17wvvY4LRENvNf5O3baSJqghRVJz6A7V+PUg40s3ZsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+7VVHZRhrO6TMW00418ip/Qmgn0ePJKTwUdbHZvWZ+wBodvWQo7o+QRCHYJvT9xhWiWnYiRSWmEIb4JW3wVq90EnVAbjVNJJfMd908atBRutNilCB+WHvgE0pVazOrZfxUVoKIIhlh2/YkgaDPTUVIxJI80OaXhvn/kDzu4/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LkyZhZLo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cWXFKPf926VJJcQwfoughMuI6A4RSR+t+lfCQtUUhuQ=; b=LkyZhZLoeJ8FJVwaMHQP3yt0JZ
	vUicAmWY1WE0fG5qRelvgFrpLS2DhAbO/mWxPlFHY+v26Ni6SnRhPHVXR2oVn3EehvMZ4Rv7H7ByS
	fed6xx12fWXbQb2XAOykHBOmaRbLm5c5j8XoFX0u/8MDeqFKYe5b+7YlLFE5/HoQ+crR/jKcS0jql
	qIggXENPEaDarE1h7DnG3zSPi6Aq9c+3CiOfMVUmbydTvH6opX6cafl0SKJxzqk4F4JI+PvwTa8Hn
	h5aQGYsoFYXDoszTosOSULJIPtw4dQIZiBA/lIOikECMEaeZmVchiuIqz0+hO+9Bkry/4t+1GWIQR
	8eujRs/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmOb4-00000006c7z-3gIl;
	Mon, 24 Feb 2025 02:53:30 +0000
Date: Mon, 24 Feb 2025 02:53:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: Re: [PATCH 4/6] fuse: return correct dentry for ->mkdir
Message-ID: <20250224025330.GW1977892@ZenIV>
References: <>
 <20250222042402.GN1977892@ZenIV>
 <174036397835.74271.9038146946135155196@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174036397835.74271.9038146946135155196@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 24, 2025 at 01:26:18PM +1100, NeilBrown wrote:

> Probably now.  It would require S_IFDIR to be passed in the mode to
> vfs_mknod().  I don't think any current callers do that, but I don't see
> any code in vfs_mknod() to prevent it.

Not allowed (and that's caller's responsibility to enforce).  Local filesystems
would break horribly if that ever happened.

->mknod() instance _may_ be a convenient helper for ->mkdir() et.al. to call,
but even for ramfs it won't coincide with ->mkdir() (wrong i_nlink, for one
thing).

If that's not documented, it really should be.

vfs_mknod() may be called for block devices, character devices, FIFOs and
sockets.  Nothing else is allowed.

