Return-Path: <linux-fsdevel+bounces-31712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D6E99A4F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B0528119E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52FC218D92;
	Fri, 11 Oct 2024 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MG82wZOK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57021859D;
	Fri, 11 Oct 2024 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653030; cv=none; b=rJsn/BUluZZu1kD3Qe2gTnHHlkV2V/FpkKDSmE1LiwC+aZ/UkDpWvL8Mp3l2r9XRULlkQTljif1d8cvnslD8WodQQLrGCPyLw5/Yd/THEqLJvemyhEpWiKPi7yppvU+dDExFtbGIbkkRM7b8aJ/V0bnOJ3NzQ69swwH9GxJt/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653030; c=relaxed/simple;
	bh=OPdi+JkYvfnco2yJ4bi8tslLJXq0lq7HC8Re2rXId2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9MHVZFgL0sHeiu9zt88742HHhxvfiDNeIivGLbXfIELuIjF83JdqLpWLzvFqJQ7eDPDICu/IvhJjByZb1Atyv4IP2rMwuSt6ZdOBHD0N8cuQW+169T6xFOTEwBmeftgD3MPR5qarfgqRZvAG3r4m1q00h9TgvwScSwQGWv9m0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MG82wZOK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=V7+Xqfxxid8hrOCCfSJuGgdRDv22s+bqkfCVccVpG4c=; b=MG82wZOKfeb4GMDSXf5b1+o5Kh
	59Y3g5+dHIKdcL1CtzJPMCSOcKJAKuINbP9jhe82mb1ehRs4xmAYoXESLe9dm4addp4RcW5kzfdlO
	ghzC/m1OB2d5uwcIGtJ7tn/nYjWeOAkYupZr0uow2wZzYkZQhJw6RJO1SmtaJGQkBdBujPFd8bo1E
	QzL/uYFNH+/AgQcxWMIhRBsf+5yUQ8eNdMC+CRa9EmTuJ5KaB6swdrZg+ysqz/rZSD8GIofMzXr7e
	1l0jA76kPTsZvmrcq77DarS37guSqge9wicpCiT5p+ctzEwWeCpRHgfC/s5mWkmMihlaFhSgYHQBm
	L4b+F9cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szFcS-0000000GRLy-2WA7;
	Fri, 11 Oct 2024 13:23:48 +0000
Date: Fri, 11 Oct 2024 06:23:48 -0700
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
Message-ID: <Zwkm5HADvc5743di@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011.yai6KiDa7ieg@digikod.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 11, 2024 at 03:20:30PM +0200, Mickaël Salaün wrote:
> On Fri, Oct 11, 2024 at 05:54:37AM -0700, Christoph Hellwig wrote:
> > On Fri, Oct 11, 2024 at 02:47:14PM +0200, Mickaël Salaün wrote:
> > > How to get the inode number with ->getattr and only a struct inode?
> > 
> > You get a struct kstat and extract it from that.
> 
> Yes, but how do you call getattr() without a path?

You don't because inode numbers are irrelevant without the path.

