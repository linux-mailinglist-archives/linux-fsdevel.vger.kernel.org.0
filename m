Return-Path: <linux-fsdevel+bounces-31727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558CC99A68C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 16:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D2A286178
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0C4196DA4;
	Fri, 11 Oct 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VpCbsxav"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E288193434;
	Fri, 11 Oct 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657575; cv=none; b=NR8utp8beQDRtXTsW9HM3kCI6473thibhkzEkDLCfCjUFQhRLofTK82mw5p+Y0BZy+q1jc1k0dRlibN7P9fNgyL4dAoQb6Fxx2S572E1+/zwO/jlUx7omDXSDlfsAJVgJJm/Z+OZsTeTXo904t9EbUAbXiDrNwIDYJM8LMDnYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657575; c=relaxed/simple;
	bh=l4HlSzWQeaFpp+9kptbV4lo/b7FEFhH9MSVYAwYDnCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sE+jE0IQxiu3aLUzyKDxlKoTH7UPAn6oYApieOymATIxkai12IyDN/hzs5lbFEclmdBkvbXWH+UlOdK+Q100l+QQW65Z2n37dSnb/qchqZmB56jcviCSj2iJDF/WUferU7uBQ+5DzH/sYkYLV8IwjP8Nu4s7huVwdMbbbOZRT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VpCbsxav; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=aJpxtjCRHAsK8ybbCNSnVPpKKHPQSFFkR4387HJaoGs=; b=VpCbsxavobs5WebXAVNyMY/+xa
	UnyPgIakda9m+TJ0g6joqsyZ4K0ksCwCIgBvdsu8O0ONhGKi+Cy57FGsAn++YpnABXxGYYuZ7IOcC
	sMatzUQV84/+75uhy87ZlnaLfEj+jMfvJQP2IZqkM3d7AriZaig5gomtu82YnfIb1HO8ke6yAKbO0
	MGzSMr4Jo0vnJVxwcs1Tiw3zCoZU5FwELpJG6/j7qj+iF7pB9H0nqGa0PC3sZTJz1R9urbuJjy+FQ
	iWvh1YQ5jHa6mdDGcVXfjSZ/I7gEwMEYB/Vl3B2RePbPW2jqmlMqqYFa6QSJ/OofKkbI9sFoXiUJz
	AHUDVFzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szGnl-0000000GdS9-1j5x;
	Fri, 11 Oct 2024 14:39:33 +0000
Date: Fri, 11 Oct 2024 07:39:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <Zwk4pYzkzydwLRV_@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011.aetou9haeCah@digikod.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 11, 2024 at 03:52:42PM +0200, Mickaël Salaün wrote:
> > > Yes, but how do you call getattr() without a path?
> > 
> > You don't because inode numbers are irrelevant without the path.
> 
> They are for kernel messages and audit logs.  Please take a look at the
> use cases with the other patches.

It still is useless.  E.g. btrfs has duplicate inode numbers due to
subvolumes.

If you want a better pretty but not useful value just work on making
i_ino 64-bits wide, which is long overdue.

