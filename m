Return-Path: <linux-fsdevel+bounces-30881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C6B98EFF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B8D281642
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34B1993A9;
	Thu,  3 Oct 2024 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kibO6pfN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69F195F28;
	Thu,  3 Oct 2024 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960682; cv=none; b=BFpnJmbHWOdls9y1UvbAJYJcUM5rabXWK8s0Dg7jl3jNhsQ+C2uwxaXqa6NbazCan2IIe3O4XGBZzs4Naq4dHg5SbkyJq/C4C55KjUDFw6OnRasutBWXSdiECFi8SyA2hUfamy0LeQ3oxgJyuERvtIkMRo/QxaUgL+z5SxpQoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960682; c=relaxed/simple;
	bh=OuXz2T0NrQpWbZ7Jk9c77Ap3E2sy6op4v7ru0JzT2PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djv5Uvx2xYYUIFZJ0hp0JsWSQy2DdW4Cf3UXCWPTijXzfFiX+Tx82+jk4Abt19RYTI5ZBDCN39XMGhMbnfdz3fFp4y41oFyaUP02ttEYnZlJSlyZlFGcr2ZAosQru2pjcYnNHBEL/JB77CTPoKhl6VM5myxLotFDODnBTlffA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kibO6pfN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oYaUcLO8JMRpqSUkasAl+Ybp2sMq5sUdcDkXt0Q09ks=; b=kibO6pfNbyfn55UIF91pYo9tWW
	FXz00a+I5HrYc/GZrN6ByxEyxNh+967G8C919tybC4BkWvjdgKfMadu2f7QadYG7tc8nksoSVD0TU
	x8LxdHF0Tthgt0HaNg33of0atKnRo7GtDqdFFT3I2QYzp6gF49a8l1BRWVmtDdsqTubpraRAe9DNX
	t9KyRxfuw33SlaPx7w0t5LUEJx3tFg64sVipVK/UB6wNDPVYJonukbw0mCyyWlpjPDK+1FtrKPo1c
	PLKsu1dEtjCnYGDbwkNJZY9XZUckQANXfTpCVaUpBYg5xwD6Gf0EMnX5Ck/YkONp3J/HVf+2xr8/s
	I4Dp6YrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swLVW-000000096Ly-3AuR;
	Thu, 03 Oct 2024 13:04:38 +0000
Date: Thu, 3 Oct 2024 06:04:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev, torvalds@linux-foundation.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <Zv6WZp1EKVRbrwna@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3>
 <Zv6Qe-9O44g6qnSu@infradead.org>
 <20241003125650.jtkqezmtnzfoysb2@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003125650.jtkqezmtnzfoysb2@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 03, 2024 at 02:56:50PM +0200, Jan Kara wrote:
> > +	if (atomic_read(&inode->i_count)) {
> > +		spin_unlock(&inode->i_lock);
> > +
> > +		/* for each watch, send FS_UNMOUNT and then remove it */
> > +		if (post_unmount && fsnotify_sb_info(sb)) {
> > +			fsnotify_inode(inode, FS_UNMOUNT);
> > +			fsnotify_inode_delete(inode);
> > +		}
> 
> This will not work because you are in unsafe iterator holding
> sb->s_inode_list_lock. To be able to call into fsnotify, you need to do the
> iget / iput dance and releasing of s_inode_list_lock which does not work
> when a filesystem has its own inodes iterator AFAICT... That's why I've
> called it a layering violation.

Ah, yes.  So we'll need to special case it some way either way.  Still
feels saner to do it in one iteration and make the inode eviction not
use the unsafe version, but maybe that's indeed better postponed until
after Dave's series.


