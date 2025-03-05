Return-Path: <linux-fsdevel+bounces-43246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0ACA4FCE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439B23A5C50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29413221F07;
	Wed,  5 Mar 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbrRUreF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58C21481E;
	Wed,  5 Mar 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172024; cv=none; b=iDufA7DC7jDUNj5sGLLKl9ra/vNea4BAUQtUVizUN+C/wOiem3iFLraWB7Ig8k1gI9m7qxdccRwMCOQMKx+REkcSFx2Ol6ae3+s+JKa8UR/QYbTd5ivS1hiYJK9LQ8YhmFyL5UdUJDZS2V0wKZ9ZnGLhmfw+3Neo0PKpN0kpcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172024; c=relaxed/simple;
	bh=CyQYA8QT/E8saZLnr8xc7a8hcGKPEF3OXhBq+CgiyV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keGvgSNCXGyN6yKBBbaAZ7SoSvGa5eD4mYyOgfSkderR0RrL9WTSEnRcRRpBo/bEJc8qSTEhh7sPQr6jr+YqFQMdcGui7tOds87cI6OZrLopvNuLgbXmfZJlzQoJvoki6w8EYR+60fbxTtATTzgS5t4aFu7ttQieRvancJ0s4As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbrRUreF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03325C4CEE2;
	Wed,  5 Mar 2025 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172023;
	bh=CyQYA8QT/E8saZLnr8xc7a8hcGKPEF3OXhBq+CgiyV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbrRUreFzF/8gWZ1gw8kq5+1oWNigoTczo7f8761DaHStemr0sBPjIFnQFM6H9Kih
	 fjOtGawlN2afh472awfTFId60JqWqBZohE2cCTk/dVE6WMzcLafLuDPYsoe3LYmkxN
	 +Dndx4cJyzqoeG76eVt0uk+aPh5gJiNwAW02GcofjnDMGNrSESCVrCScpbgE4SMiro
	 MrGLd4o9FPpfmg3V1Vr4Mg0BWZKdl9+WdyuvH5QTUBgzVDzyfTx64UD0n1dmnG/aXp
	 Tw6O9i3pStjmMcvnO84e99rU7s4VzyKe4W8+5OKZDGaE7DMPysM5uXp7V8+fEC2WQe
	 34j/D3gVZi+FA==
Date: Wed, 5 Mar 2025 11:53:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, 
	Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6 - REVISED] fuse: return correct dentry for ->mkdir
Message-ID: <20250305-bannen-zugriff-cd7508258062@brauner>
References: <>
 <CAJfpegtu1xs-FifNfc2VpQuhBjbniTqUcE+H=uNpdYW=cOSGkw@mail.gmail.com>
 <174112490070.33508.15852253149143067890@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174112490070.33508.15852253149143067890@noble.neil.brown.name>

On Wed, Mar 05, 2025 at 08:48:20AM +1100, NeilBrown wrote:
> 
> Subject: [PATCH] fuse: return correct dentry for ->mkdir
> 
> fuse already uses d_splice_alias() to ensure an appropriate dentry is
> found for a newly created dentry.  Now that ->mkdir can return that
> dentry we do so.
> 
> This requires changing create_new_entry() to return a dentry and
> handling that change in all callers.
> 
> Note that when create_new_entry() is asked to create anything other than
> a directory we can be sure it will NOT return an alternate dentry as
> d_splice_alias() only returns an alternate dentry for directories.
> So we don't need to check for that case when passing one the result.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/fuse/dir.c | 48 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
> 
> Thanks for the suggestion Miklos - this looks much better.
> 
> Christian: could you please replace the fuse patch in your tree
> with this version?  Thanks.

Sure, done so now. Thanks!

