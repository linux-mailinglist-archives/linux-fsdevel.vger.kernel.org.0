Return-Path: <linux-fsdevel+bounces-25355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 406F994B17E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 22:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3CB1C22271
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3833D145FED;
	Wed,  7 Aug 2024 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Hw9Trf38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3B63CB;
	Wed,  7 Aug 2024 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063099; cv=none; b=doOKiVmkWr8QsPSeaLJQuu5mVJysREi/+mTB/yWZw2a19fktyYgg4PwP1XmdSKd+9W5Y9tzx/22OhiZIdrGn7GT5JqtfvyTZWhhF9S2CAqyjwG//bpIKBGXLlCrThm4oezYK2VdbBlnj7HkrrldQjpIM+8ybfKzk8wnAEXW9jAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063099; c=relaxed/simple;
	bh=Sqv9IslJXf3BXh9DGwBPDfLSLTLxUsGj+rW5Q4G5K24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzRHSWaho01bCvkXs5yfotPBKQQgDco40LiPLewg94En0zFBWzmIgiDPSX2sGchWKKnOZhwMscN/FN1zlpcVYl47vfgVcaM1KED0fV9r02dt8671DiJWNlPCo71PN9RpqpnDgslrECWQWPmmwo3XItCbyD5dMXF0vaRtrb1FY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Hw9Trf38; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VFZuFbaSc2pDLf+LYEkVfpRBk/dDolZHk0SlAngvhRI=; b=Hw9Trf38u1+i71260Bg0qyVtip
	pOzhC9bxd7eyGAhloPTfoBez3t36jPdFyLMjidUf2+YYm+ULmXxn1qoCSSdEX/xaounIYW+ADyWKx
	zf1bIf1gmxkOrMiKmSZJP+1vD7SLGn/7CWm4gH46B2o+sCNTwuuM3ADgKRZH0BnoP+iz6MdQA0bmL
	LedhsVM8MBGaUDe8Mt7qdyRbCjOhidgwh60rebBtZpG4SAMlArj2ZRGNX2lXpiasQyKTyWTqFtIHA
	SzxKzqLnrvkoIjtA3L5FvNV3fB+CtqwLlDiX+gz2McG6Zfay/u4EUT70rW7OXxAF4PlCj4m/0ci06
	8+p72icQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbnQE-00000002Tl3-1IHa;
	Wed, 07 Aug 2024 20:38:14 +0000
Date: Wed, 7 Aug 2024 21:38:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <20240807203814.GA5334@ZenIV>
References: <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
 <20240807062300.GU5334@ZenIV>
 <20240807063350.GV5334@ZenIV>
 <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
 <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807124348.GY5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 07, 2024 at 01:43:48PM +0100, Al Viro wrote:
> On Wed, Aug 07, 2024 at 11:50:50AM +0200, Mateusz Guzik wrote:
> 
> > tripping ip:
> > vfs_tmpfile+0x162/0x230:
> > fsnotify_parent at include/linux/fsnotify.h:81
> > (inlined by) fsnotify_file at include/linux/fsnotify.h:131
> > (inlined by) fsnotify_open at include/linux/fsnotify.h:401
> > (inlined by) vfs_tmpfile at fs/namei.c:3781
> 
> Try this for incremental; missed the fact that finish_open() is
> used by ->tmpfile() instances, not just ->atomic_open().
> 
> Al, crawling back to sleep...

I _really_ hate ->atomic_open() calling conventions; FWIW, I suspect
that in the current form this series is OK, but only because none
of the existing instances call finish_open() on a preexisting
aliases found by d_splice_alias().  And control flow in the
instances (especially the cleanup paths) is bloody awful...

We never got it quite right, and while the previous iterations of
the calling conventions for that methods had been worse, it's still
nasty in the current form ;-/

Oh, well - review of those has been long overdue.

