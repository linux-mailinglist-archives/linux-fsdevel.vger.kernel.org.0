Return-Path: <linux-fsdevel+bounces-62020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B560CB81CF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3747BC627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541512E0406;
	Wed, 17 Sep 2025 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NNss7U4D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635B34BA47;
	Wed, 17 Sep 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141724; cv=none; b=nM0OcTMaEhYKwT2y1PHHq9I7zteg3KRLZ8zIrJs7jSRBvJxab05gUGC35CQXiLxWCDS5m3PfU5WWR9AEmZdtPWKrfeQWkwZz+mHfKn/RRV7SmOoPq/J7xMHHeOmzBTeAurwdms1cSDG0V5KoZnE92tsV3Jc8I2j78F6W5pEbh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141724; c=relaxed/simple;
	bh=GkCmDPW/1syrsYw1G+YvayDwOfOwzuCS/5C5ZTGXcbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDWGR9Pr+G9Xn5BsuUGv2RuKJlkBf8xnuveUYJnZnKRz/+INDxpRmJUWOQgyO1HXMpaQauarnnTvDAW4jCDAABNFirizmUuZhIp9J/76ohx/8etj/MIAMnjkHiuvcqVPv2rYJdPNdUaMGPpY5VT41uC357sRvkYygml91n/j8SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NNss7U4D; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rNKB4VtExzuPbc4Hd37NwogNpAaP97VYa9OnljT/b9E=; b=NNss7U4DEBakFnvQygITpcjDWe
	12Ciy5WVlrHsRsn5cI32Mba/U4Z9Rbntizwj0kkYXgGSWcLQo6+zchYqjpsrAzdczp09xuT7oolf5
	gzkhmdrW/Yr2LXKjEQtC+uQ+PtHtZtfk7RDX22uyyNpyYLAodm2UZiC92b2GJ9STuuZ9D7z+dlpnz
	umGb7+gGwvjPzi92nuT08LPP/oL+1m1/PoUwoWcq6mhCtWh11QcB+i9H6YnIED7zLvkIpmkI1RFwG
	dkzqPG7hRkICMHY57abE/CYGb7BfvsN7WRXgoQ4CjgRRd8OicK9TQtwfz0uXZ7nSGZcc77IUGIjjD
	ifEixOGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyyyW-000000084Iv-1L50;
	Wed, 17 Sep 2025 20:42:00 +0000
Date: Wed, 17 Sep 2025 21:42:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jakub Acs <acsjakub@amazon.de>,
	linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
Message-ID: <20250917204200.GB39973@ZenIV>
References: <20250915101510.7994-1-acsjakub@amazon.de>
 <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
 <x4q65t5ar5bskvinirqjbrs4btoqvvvdsce2bdygoe33fnwdtm@eqxfv357dyke>
 <CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com>
 <gdovf4egsaqighoig3xg4r2ddwthk2rujenkloqep5kdub75d4@7wkvfnp4xlxx>
 <CAOQ4uxhOMcaVupVVGXV2Srz_pAG+BzDc9Gb4hFdwKUtk45QypQ@mail.gmail.com>
 <scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa>
 <CAOQ4uxgSQPQ6Vx4MLECPPxn35m8--1iL7_rUFEobBuROfEzq_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgSQPQ6Vx4MLECPPxn35m8--1iL7_rUFEobBuROfEzq_A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 01:07:45PM +0200, Amir Goldstein wrote:

> diff --git a/fs/dcache.c b/fs/dcache.c
> index 60046ae23d514..8c9d0d6bb0045 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1999,10 +1999,12 @@ struct dentry *d_make_root(struct inode *root_inode)
> 
>         if (root_inode) {
>                 res = d_alloc_anon(root_inode->i_sb);
> -               if (res)
> +               if (res) {
> +                       root_inode->i_opflags |= IOP_ROOT;
>                         d_instantiate(res, root_inode);

Umm...  Not a good idea - if nothing else, root may end up
being attached someplace (normal with nfs, for example).

But more fundamentally, once we are into ->kill_sb(), let alone
generic_shutdown_super(), nobody should be playing silly buggers
with the filesystem.  Sure, RCU accesses are possible, but messing
around with fhandles?  ->s_root is not the only thing that might
be no longer there.

What the fuck is fsnotify playing at?

