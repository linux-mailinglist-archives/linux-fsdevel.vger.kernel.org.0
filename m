Return-Path: <linux-fsdevel+bounces-33502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD76C9B9A3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 22:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D321F211A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925191E32BD;
	Fri,  1 Nov 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aQKtWboz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F532487BE;
	Fri,  1 Nov 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496632; cv=none; b=n6G8v7qn0WWDDVf9V4sk4gasUOcVMjyglsF4Fzyk4+J1ksv/y2kvELwWbazSh0Y+hpOFUXyeecrIDOj5CibvpfVxDHYCrJjJLwYY3Lw/JtYYj7PzVNjosAemWsvMdZQGuJIfaOGHLxSgme9hcULWmCn/+01tEqvmKBTkZQhJDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496632; c=relaxed/simple;
	bh=4XXEqFe+awDGK6MZZOMvzpJ1Ocl5W/M0aI/NI1Ytm4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f19zWit4ABwSLy28522Txomy6z7Bdowby2Ijhmko4ZezN3MhLEDwu5Qb11e9vEruHgTiuo4YJxB4yKZYVxtAjLGzqlMJcuaHGLy7T0JYvs5kfhpK+QLrsKw8tPCJAAvCWZyhceupY3xx6UTGq4UxYkP2ocmAwf4lAY1Z7VTcDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aQKtWboz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BJ69mwcrQjbCZcBQ06k2f/aDMOK4/+BOGc+i+AZ1IYs=; b=aQKtWbozKSreyZatoPTL3p2d9i
	gBKBCBGDDwyUq40yVubShCS0zvQa2LWY6K8fZkkQ5/z/nc/qapbWevnSPQK25oDgn5GeB9dfMX113
	FDiKSQPhFLWvjZvynHTdvWe8D7nN7YXUdkHzpfhGKLh4nyq5dOpBJEOLkH+XxqVkri07tHaxG6DSp
	eJFiaRrvC3V5Y388sx+5TlRo1Kau66bpCsb3w5diMzdIi6f8WgA2vZt9VvWUBX+HqEOjZMgrH4oUp
	Olkq1ecq810NA0U0yi02DIpvrusoIewxyrAInYUcaKqAOAL8aAsJpCnRaGd7SWFlmhMdbOOFl3FQB
	e9SRsFAQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6zDt-0000000ADGo-14KH;
	Fri, 01 Nov 2024 21:30:25 +0000
Date: Fri, 1 Nov 2024 21:30:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>,
	Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Simplify getattr interface function checking
 AT_GETATTR_NOSEC flag
Message-ID: <20241101213025.GP1350452@ZenIV>
References: <20241101193703.3282039-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101193703.3282039-1-stefanb@linux.vnet.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 01, 2024 at 03:37:03PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Commit 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface
> function")' introduced the AT_GETATTR_NOSEC flag to ensure that the
> call paths only call vfs_getattr_nosec if it is set instead of vfs_getattr.
> Now, simplify the getattr interface functions of filesystems where the flag
> AT_GETATTR_NOSEC is checked.
> 
> There is only a single caller of inode_operations getattr function and it
> is located in fs/stat.c in vfs_getattr_nosec. The caller there is the only
> one from which the AT_GETATTR_NOSEC flag is passed from.
> 
> Two filesystems are checking this flag in .getattr and the flag is always
> passed to them unconditionally from only vfs_getattr_nosec:
> 
> - ecryptfs:  Simplify by always calling vfs_getattr_nosec in
>              ecryptfs_getattr. From there the flag is passed to no other
>              function and this function is not called otherwise.
> 
> - overlayfs: Simplify by always calling vfs_getattr_nosec in
>              ovl_getattr. From there the flag is passed to no other
>              function and this function is not called otherwise.
> 
> The query_flags in vfs_getattr_nosec will mask-out AT_GETATTR_NOSEC from
> any caller using AT_STATX_SYNC_TYPE as mask so that the flag is not
> important inside this function. Also, since no filesystem is checking the
> flag anymore, remove the flag entirely now, including the BUG_ON check that
> never triggered.
> 
> The net change of the changes here combined with the originan commit is
> that ecryptfs and overlayfs do not call vfs_getattr but only
> vfs_getattr_nosec.
> 
> Fixes: 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface function")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Closes: https://lore.kernel.org/linux-fsdevel/20241101011724.GN1350452@ZenIV/T/#u
> Cc: Tyler Hicks <code@tyhicks.com>
> Cc: ecryptfs@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-unionfs@vger.kernel.org
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Applied (viro/vfs.git#work.statx2)

