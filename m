Return-Path: <linux-fsdevel+bounces-52742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E33AE6202
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F026517B222
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344F32857EC;
	Tue, 24 Jun 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PemOZtEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8264C25743D;
	Tue, 24 Jun 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760191; cv=none; b=TQTy9qjtrurQrBiXK72cx8AxflOdOJ7RUuQnJC2LpLcXeEw3LkWs2xxZrsCN3hnWcCBqGhAgH+BbQJk/CJQBxXWz4LDq9xOSMHs0eNa5WzQ0H6YaiqRlxSim5sAvExI9fem/M6bZ42BEMoe0OQxbiqmLC5WDoT8uOM47cBp3dNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760191; c=relaxed/simple;
	bh=tIqh+jeeeHv0BdKtyxBCAEntFbk/YzdIIooy9mny8Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfmuk/dxXGu6S643LHsJHkgv8ZbbNrs+X8YqZisNNAjPXm8RhuVH5OzhhlIZ0nJuhtEmuxVnrSFfvX/H+5moTbfQlfHX39iNVJjTK0Oqn0fY98AAmz+nPe4VO66hZGTw+ZqmmvB3Wp+OPYvLrgGtnqM5Ekbu7uRKBTVu8AIGX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PemOZtEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E485C4CEE3;
	Tue, 24 Jun 2025 10:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750760191;
	bh=tIqh+jeeeHv0BdKtyxBCAEntFbk/YzdIIooy9mny8Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PemOZtEjr/Tc4MCnLvaOzOraShQSTVSFAAAn501Ie9jgVfzdS9A+V8b3xjZK6zAvi
	 1RUDxYdR/wut0fWSAu4U03sF0qlUZjjsBSZc76+lA/n1UK+TXn4xZx/GX7zehSNFjB
	 eHZVtwXBTJzL3Na1pPiUfcJKqw50ieaQABh3rMXP67V1N1jG832k3jmVRlywbhwn6z
	 W39wrFY7gzFQYnqKizspmvsNC68at/usbwxDZoblujhytPEEsDUukYSH1dcviDaMwB
	 iq8AK8If4lk2wtkq8sZE5isgq56fmNShzI/sSkP9OpF/J/HHEM9kiEJLav4WDYcv1X
	 WiellpGWuen8w==
Date: Tue, 24 Jun 2025 12:16:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 05/11] fhandle: reflow get_path_anchor()
Message-ID: <20250624-arztpraxen-verbal-0603f73ec23b@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-5-d02a04858fe3@kernel.org>
 <nem4nldmws4e6cgbnbc4nbbvq53jtadewspcimztbdeikppeda@ss33vygtetxd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nem4nldmws4e6cgbnbc4nbbvq53jtadewspcimztbdeikppeda@ss33vygtetxd>

On Tue, Jun 24, 2025 at 11:16:39AM +0200, Jan Kara wrote:
> On Tue 24-06-25 10:29:08, Christian Brauner wrote:
> > Switch to a more common coding style.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/fhandle.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index d8d32208c621..22edced83e4c 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -170,18 +170,22 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
> >  
> >  static int get_path_anchor(int fd, struct path *root)
> >  {
> > +	if (fd >= 0) {
> > +		CLASS(fd, f)(fd);
> > +		if (fd_empty(f))
> > +			return -EBADF;
> > +		*root = fd_file(f)->f_path;
> > +		path_get(root);
> > +		return 0;
> > +	}
> > +
> >  	if (fd == AT_FDCWD) {
> >  		struct fs_struct *fs = current->fs;
> >  		spin_lock(&fs->lock);
> >  		*root = fs->pwd;
> >  		path_get(root);
> >  		spin_unlock(&fs->lock);
> > -	} else {
> > -		CLASS(fd, f)(fd);
> > -		if (fd_empty(f))
> > -			return -EBADF;
> > -		*root = fd_file(f)->f_path;
> > -		path_get(root);
> > +		return 0;
> >  	}
> 
> This actually introduces a regression that when userspace passes invalid fd
> < 0, we'd be returning 0 whereas previously we were returning -EBADF. I
> think the return below should be switched to -EBADF to fix that.

Whoops. Thanks!

