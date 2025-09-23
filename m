Return-Path: <linux-fsdevel+bounces-62515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E06B9701E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 19:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0934D19C5D8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918C327F4D4;
	Tue, 23 Sep 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJWEtBkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D5263F22;
	Tue, 23 Sep 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648090; cv=none; b=DHELD/WukC+q5yDIpivdwOTfZwzABVUfD0xYFIuPHuovrQ3EBg1t5j8II95r5z0Yb4Gv+t/VtV57bhHZNz845l4LU6dIeGVx2lxg39ogIO4MBx3xPcqWD7go1dS6LISNXnKFXCFGSwlxZJ4Ps86Oq6GaBwTfSM82IjIeG8j+lJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648090; c=relaxed/simple;
	bh=oP8tlhraIaWdzTXvEP4dFveNW3qrIDsYFMBZ6ulMe0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtaPGiznPcPnRS2rop9jqrcmMA77uIffnGGjH3qIAQohStYk0MybIru752GCsKl0j3/E0+090aO2mNm01FOdhlMCS6+1Us+OTOU1ke8PdS3An3ChDm3aCx/8yPVlbMAhrzQwOoeEv+dlYQ5SebjWMxVvS+hGDBO9D2TofP5AvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJWEtBkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E84C4CEF7;
	Tue, 23 Sep 2025 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758648089;
	bh=oP8tlhraIaWdzTXvEP4dFveNW3qrIDsYFMBZ6ulMe0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJWEtBkMjpCDsnob1NQxloDk2nadWXEdKJU5RYhXZxKm5+aaNcxaB3+OG8kDNetCY
	 T7wCcEYTACupIV6fHSw069+H8kIX8jTkCsQTL6mOj57ZBCKLvY2Tc/y9sBQ0RzVIqt
	 udtpLnnTqJGUhPjptN/G+5oBQDA2VSymoLJZKmWU0p0LMcX4MhN5MOlT4NYMSssdto
	 rYEDm2yw01Uf76AyvrD7gsqOUWJLlgqr/MdcUJx91YgL4bD8a+SUc1sDWht0HblXP9
	 6IT+osvoTQalXai9IhWEj7IXJaGsKe5bOcz6rvRdccNfQXfIek0AnpziLfn+vZZy6D
	 B1Z3CeojQXEfw==
Date: Tue, 23 Sep 2025 10:21:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	hch@infradead.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com, kernel-team@meta.com
Subject: Re: [PATCH v4 13/15] fuse: use iomap for read_folio
Message-ID: <20250923172128.GD1587915@frogsfrogsfrogs>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
 <20250923002353.2961514-14-joannelkoong@gmail.com>
 <CAJfpegsBRg6hozmZ1-kfYaOTjn3HYcYMJrGVE_z-gtqXWbT_=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsBRg6hozmZ1-kfYaOTjn3HYcYMJrGVE_z-gtqXWbT_=w@mail.gmail.com>

On Tue, Sep 23, 2025 at 05:39:13PM +0200, Miklos Szeredi wrote:
> On Tue, 23 Sept 2025 at 02:34, Joanne Koong <joannelkoong@gmail.com> wrote:
> 
> >  static int fuse_read_folio(struct file *file, struct folio *folio)
> >  {
> >         struct inode *inode = folio->mapping->host;
> > -       int err;
> > +       struct fuse_fill_read_data data = {
> > +               .file = file,
> > +       };
> > +       struct iomap_read_folio_ctx ctx = {
> > +               .cur_folio = folio,
> > +               .ops = &fuse_iomap_read_ops,
> > +               .read_ctx = &data,
> >
> > -       err = -EIO;
> > -       if (fuse_is_bad(inode))
> > -               goto out;
> > +       };
> >
> > -       err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
> > -       if (!err)
> > -               folio_mark_uptodate(folio);
> > +       if (fuse_is_bad(inode)) {
> > +               folio_unlock(folio);
> > +               return -EIO;
> > +       }
> >
> > +       iomap_read_folio(&fuse_iomap_ops, &ctx);
> 
> Why is the return value ignored?

There is no return value:
https://lore.kernel.org/linux-fsdevel/20250923002353.2961514-13-joannelkoong@gmail.com/T/#u

Errors get set on the file/mapping/sb, nobody checks the return value
of ->read_folio.

--D

> Thanks,
> Miklos
> 

