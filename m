Return-Path: <linux-fsdevel+bounces-68438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA40C5C22C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF0DB4ED936
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9624E2FFF8D;
	Fri, 14 Nov 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrkF+Pq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1992C326F;
	Fri, 14 Nov 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110857; cv=none; b=q+fG6UhVim+fCjwk17KJFqUDR5xtsyzkF7RglHYzF6yioZivZ/OxPxjUeXXN/Jgw4A8b5vd6Xa8nfr580iKqvISjazN1vB095Rw6fT8atDuVn6SDi/SrIexiE5UhdmUuCStl3xajb8JIcaO32IRK2hBHcGAi5Aml3iiYRVQbO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110857; c=relaxed/simple;
	bh=YVZGVPBXRwz0jhRRw5VhDVjGYlCJhh4rJElgQjEjJGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKlFtJfJAe1liU8z7w8J21s7XIAilUuRFHVK4jI5VjLmUlu+/qfOeZi9x7hLqP7H6Sx7MteBKU4JC03R9BN88JvMo8fs9LrgxcCnph+4KT6uLYT7kYNBNjkLKyW8dZnHiul261qrT08+lI2PjtrK7GA3yHLcaJYNVvtPyKCiZJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrkF+Pq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31540C4CEF1;
	Fri, 14 Nov 2025 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763110856;
	bh=YVZGVPBXRwz0jhRRw5VhDVjGYlCJhh4rJElgQjEjJGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrkF+Pq1i4tLc13CpLCSsr6tj0ok0eKjK/ItVLrCJ4Mh+AOYNbxUdJiFoSnfeweFz
	 xCRxReI6j/GTvqEbU9dLLbUuvPEvZNyW2Zq1SyqEbxiGsrjuNkXztJkagbTMFqirjg
	 nfsi3KNmhbwU7k/nygwOWp2R8Lqb/FnMgKmlFC1Ud3w23mC5FCbsuUh4m6MOdIkXS3
	 r7QiqwkUwEdEE4HN/TqSKyDxoZsN4shyoAZ6iCAnN9whdHVd30zQmbNm7uPickimE3
	 9Yzb6g90eWZ+U4jy3OcE/je0bIyCuL3ymNLAZy9NKDcLuD2/vGDH3okPgR0VFBLC60
	 x2GrtLA6hJgkA==
Date: Fri, 14 Nov 2025 10:00:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 25/42] ovl: refactor ovl_iterate() and port to cred
 guard
Message-ID: <20251114-verblassen-obstgarten-7d88060b7c9a@brauner>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
 <20251113-work-ovl-cred-guard-v3-25-b35ec983efc1@kernel.org>
 <CAJfpeguUirm5Hzrob=pBVgANym9wdJAEN1w7zEEuv-aW3P0ktw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguUirm5Hzrob=pBVgANym9wdJAEN1w7zEEuv-aW3P0ktw@mail.gmail.com>

On Fri, Nov 14, 2025 at 09:40:00AM +0100, Miklos Szeredi wrote:
> On Thu, 13 Nov 2025 at 22:32, Christian Brauner <brauner@kernel.org> wrote:
> 
> > +       /*
> > +        * With xino, we need to adjust d_ino of lower entries.
> > +        * On same fs, if parent is merge, then need to adjust d_ino for '..',
> > +        * and if dir is impure then need to adjust d_ino for copied up entries.
> > +        * Otherwise, we can iterate the real dir directly.
> > +        */
> > +       if (!ovl_xino_bits(ofs) &&
> > +           !(ovl_same_fs(ofs) &&
> > +             (ovl_is_impure_dir(file) ||
> > +              OVL_TYPE_MERGE(ovl_path_type(dir->d_parent)))))
> > +               return iterate_dir(od->realfile, ctx);
> 
> If this condition was confusing before, it's even more confusing now.
>  What about

folded

> 
> static bool ovl_need_adjust_d_ino(struct file *file)
> {
>         struct dentry *dentry = file->f_path.dentry;
>         struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
> 
>         /* If parent is merge, then need to adjust d_ino for '..' */
>         if (ovl_xino_bits(ofs))
>                 return true;
> 
>         /* Can't do consistent inode numbering */
>         if (!ovl_same_fs(ofs))
>                 return false;
> 
>         /* If dir is impure then need to adjust d_ino for copied up entries */
>         if (ovl_is_impure_dir(file) ||
> OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent)))
>                 return true;
> 
>         /* Pure: no need to adjust d_ino */
>         return false;
> }
> 
> >
> > +static int ovl_iterate(struct file *file, struct dir_context *ctx)
> > +{
> > +       struct ovl_dir_file *od = file->private_data;
> > +
> > +       if (!ctx->pos)
> > +               ovl_dir_reset(file);
> > +
> > +       with_ovl_creds(file_dentry(file)->d_sb) {
> > +               if (od->is_real)
> > +                       return ovl_iterate_real(file, ctx);
> 
>         if (od->is_real) {
>                 if (ovl_need_d_ino_adjust(file))
>                         return ovl_iterate_real(file, ctx);
>                 else
>                         return iterate_dir(od->realfile, ctx);
>         }

All sounds good. Done.

