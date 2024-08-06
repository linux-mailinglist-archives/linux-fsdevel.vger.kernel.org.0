Return-Path: <linux-fsdevel+bounces-25125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8308A9494E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392711F21B94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184503B182;
	Tue,  6 Aug 2024 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fS6lFzDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB12770B;
	Tue,  6 Aug 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959604; cv=none; b=TjYN7jKWad/nwzBz29fwIZ3hLwbV32B5/OnRP1JGdQZuHEEQTgVtWRTX6NEcKeKnL5oh1MWN3uOGGxEWybUTD2+whA6M77k+ckb9oMNj9cVQRr8TJ72I5CtV98DdazcSrxUVeKThWLbVdX/71ZZ8RyrVrctTMtxOEaPlbPve754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959604; c=relaxed/simple;
	bh=Zvb5WbpWAR3XdY7lR9+hmOGscoXsRhCtNFT/1o1vKh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h92XBoUeCPpsKJgMy9OagC7y4QIqyjDQRur4qAYOWFwzjrQol1qGkhloDZij32twksl0n587FhDrbknJs15Gg8JUEcCulOUKJjgKVtgMRKIqEjNkVHn2daA/3Wm+SGSg3VXLHdN0Ynx13edjHL6g1JiLM4/Ys/BClxtJQIRC4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fS6lFzDc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3VxPttXsv7Kdxw6b65QNfXCHEJt8kkfQKvnPLzvGcgo=; b=fS6lFzDcnP6NtyOBeNZFTJ6kYE
	eQmIOhrlfh76InDhhQqYY7BLrS+ErJf8THUXJPcb0bmn946pocyEA5JR4U90IM7mjXcyBk2uMSdV6
	XFYuiDMrY/RJtmJkk8I+XZCLfFtYmKxutH3dHcIibjec1o4VI3XjUCctbMtw/xChPKrUfZOKkSlTD
	PrZ7UhGKWlGklkABuvIS1z0jxvManT68FAZtYZEiN7yL1UXqUZYgdop+LyNGUW9C/D3tIacCCrKTE
	PO6f2tutZSTD5VhoNCrsF3pDykLiBbc7qvI6rJSWMudR8cgszCKENQtKLpT4YCsMlvUlNsLZ+8E78
	S8viEz6g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbMUx-00000001yoB-2hLV;
	Tue, 06 Aug 2024 15:53:19 +0000
Date: Tue, 6 Aug 2024 16:53:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <20240806155319.GP5334@ZenIV>
References: <20240806144628.874350-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806144628.874350-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 06, 2024 at 04:46:28PM +0200, Mateusz Guzik wrote:

> The flag thing is optional and can be dropped, but I think the general
> direction should be to add *more* asserts and whatnot (even if they are
> to land separately). A debug-only variant would not hurt.

Asserts do *not* clarify anything; if you want your optional flag,
come up with clear description of its semantics.  In terms of state,
_not_ control flow.

> @@ -3683,6 +3685,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  static int do_open(struct nameidata *nd,
>  		   struct file *file, const struct open_flags *op)
>  {
> +	struct vfsmount *mnt;
>  	struct mnt_idmap *idmap;
>  	int open_flag = op->open_flag;
>  	bool do_truncate;
> @@ -3720,11 +3723,22 @@ static int do_open(struct nameidata *nd,
>  		error = mnt_want_write(nd->path.mnt);
>  		if (error)
>  			return error;
> +		/*
> +		 * We grab an additional reference here because vfs_open_consume()
> +		 * may error out and free the mount from under us, while we need
> +		 * to undo write access below.
> +		 */
> +		mnt = mntget(nd->path.mnt);

It's "after vfs_open_consume() we no longer own the reference in nd->path.mnt",
error or no error...

>  		do_truncate = true;


>  	}
>  	error = may_open(idmap, &nd->path, acc_mode, open_flag);
> -	if (!error && !(file->f_mode & FMODE_OPENED))
> -		error = vfs_open(&nd->path, file);
> +	if (!error && !(file->f_mode & FMODE_OPENED)) {
> +		BUG_ON(nd->state & ND_PATH_CONSUMED);
> +		error = vfs_open_consume(&nd->path, file);
> +		nd->state |= ND_PATH_CONSUMED;
> +		nd->path.mnt = NULL;
> +		nd->path.dentry = NULL;

Umm...  The thing that feels wrong here is that you get an extra
asymmetry with ->atomic_open() ;-/  We obviously can't do that
kind of thing there (if nothing else, we have the parent directory's
inode to unlock, error or no error).

I don't hate that patch, but it really feels like the calling
conventions are not right.  Let me try to tweak it a bit and
see if anything falls out...

