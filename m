Return-Path: <linux-fsdevel+bounces-17843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380D18B2D22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 00:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E245D1F21D90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E91745CB;
	Thu, 25 Apr 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LD2BSf+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45102175A5
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084301; cv=none; b=OBbWVTviEDfTBCfi6WiyKFdqlEX6qBnTrY6vynwsy7uOYU+5Tohg3Msoa9+Bshg3S4WFOOx9/JJv1Ju/7j3RZt/7WZtTRtJLJjltBhlu+gMm91KH1PIMTF+ol2oO5HXzekiemvQBNrA6QP7Xxe4KePpKc457bOWleQRsrhJhDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084301; c=relaxed/simple;
	bh=7bOOL9DkiOQOsONHqkqQH9qse9rRmmtpiLi9Q/kdfU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNJoPgG1mndtJni0LFbI4MW9u2P6CJR8pvyBspw5ST73nAFiM0wzN0BpMDNGOlMjQmHGWyLa9ruURMUongRJK/Jj7icgr3eTDSK+25v9GyTy5yPsCtIYcytIkc1I+SqeJ1wD0cBpagpGwQ1JUxZmUrx7rJTUCFnxIS0B5NeBiH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LD2BSf+b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CqNg6mjdqw907cDojuOUDbEcuVOkLfb8eq/ywH8+tPg=; b=LD2BSf+bYb9lDyHHv6rvCSJkQm
	VWPQ8iV5vnf/Mz+v2cKiEInm9h/qSt8O14rKy5Glz2GoH64JxE6OQnL/2715QCc+3nmC9zI+xLsl9
	aRnIPmE7yxtsaTw2psoRHqkz+1gYptpnR7KHYGgMjHR46WGwbm/JJyU9cUSuiTCDiJg8ZkTovftzd
	2Y4ofWYo7FEw+UMZHyjlc0+6zXyD6EHQqhdWcDQ+0CpMVul17AdJ8b8sI1Dt+6Nvp2h793rHu4ns8
	MDJcEiWM99qUeyGQO5Mdtrw+IeqpseQEHkE0vVClWzOfhyaZZTO1ny/ZJYeYq57emlBCSKL3tDHBL
	RGr+j96A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s07cw-004Q4C-2K;
	Thu, 25 Apr 2024 22:31:38 +0000
Date: Thu, 25 Apr 2024 23:31:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dawid Osuchowski <linux@osuchow.ski>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v2] fs: Create anon_inode_getfile_fmode()
Message-ID: <20240425223138.GO2118490@ZenIV>
References: <20240425215803.24267-1-linux@osuchow.ski>
 <20240425220329.GM2118490@ZenIV>
 <022a152f-11c8-404c-8d7f-f7f788f17471@osuchow.ski>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022a152f-11c8-404c-8d7f-f7f788f17471@osuchow.ski>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 26, 2024 at 12:15:52AM +0200, Dawid Osuchowski wrote:
> On 4/26/24 00:03, Al Viro wrote:
> > On Thu, Apr 25, 2024 at 11:58:03PM +0200, Dawid Osuchowski wrote:
> > > +struct file *anon_inode_getfile_fmode(const char *name,
> > > +				const struct file_operations *fops,
> > > +				void *priv, int flags, fmode_t f_mode)
> > 						       ^^^^^^^
> > > +struct file *anon_inode_getfile_fmode(const char *name,
> > > +				const struct file_operations *fops,
> > > +				void *priv, int flags, unsigned int f_mode);
> > 						       ^^^^^^^^^^^^
> > 
> > They ought to match (and fmode_t is the right type here).
> 
> Should I include the <linux/fs.h> header (or a different one) into
> anon_inodes.h to get the fmode_t type or can I copy the typedef directly as
> a sort of "forward declare" instead?
> 
> The latter would mean something like this:
> 
> 	struct inode;
> +	typedef unsigned int fmode_t;

linux/types.h, if anything.

