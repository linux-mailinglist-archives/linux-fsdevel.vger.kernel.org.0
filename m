Return-Path: <linux-fsdevel+bounces-8018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A9282E376
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 00:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BE4B22312
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05291CD09;
	Mon, 15 Jan 2024 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vhXOYBmz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869081CD27
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jchXI5rRBkRx70I3KYf8zo0qogYmllJxxBUhW/u9CAM=; b=vhXOYBmzZhopfIbHLQw29ZqBsh
	IP7eqbFU9FHCoEeKlejftBOIrHImK/weH88INIqj88J+nngjcPyGP1cxSQ59la9QR/WBu0cpHjitg
	wkOPyhf+qKZ7CvDZDYd068zqdDZyJJDLaN2npz7yOw0CPZ3vgBhKDR9fbD6i7/8lnMbP9peCg/wkA
	EXK3lhGtQ6btDU1eKZgvQStdQSbAwD8usGSdCfZHirzhXvwo77AMEd3Fi2iFhE28Sc0N/W4KhNt/K
	TKUlhZDCZhu6F5qWmXqlv3PwmV+46um6SGodImclHL7mYY1Jt1M1c4cEvAXVrf1e8bJQFBaUbEj/E
	hgXC7mMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rPWKL-003ZiV-2X;
	Mon, 15 Jan 2024 23:25:09 +0000
Date: Mon, 15 Jan 2024 23:25:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Bruno Haible <bruno@clisp.org>, Evgeniy Dushistov <dushistov@mail.ru>,
	linux-fsdevel@vger.kernel.org
Subject: Re: ufs filesystem cannot mount NetBSD/arm64 partition
Message-ID: <20240115232509.GJ1674809@ZenIV>
References: <4014963.3daJWjYHZt@nimes>
 <20240115222220.GH1674809@ZenIV>
 <20240115223300.GI1674809@ZenIV>
 <ZaW6/bFaN9HEANW+@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaW6/bFaN9HEANW+@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 15, 2024 at 11:08:45PM +0000, Matthew Wilcox wrote:

> Wouldn't surprise me if netbsd/arm64 had decided to go with 64kB
> PAGE_SIZE and 8kB fragments ...
> 
> > FWIW, theoretically it might be possible to make that comparison with
> > PAGE_SIZE instead of 4096 and require 16K or 64K pages for the kernel
> > in question; that ought to work, modulo bugs in completely untested
> > cases ;-/
> > 
> > Support with 4K pages is a different story - that would take much
> > more surgery in fs/ufs.
> 
> Possibly not too much more.  With large folios, we're most of the way
> to being able to support this.  If there's real interest, we can look
> at supporting large folios in UFS.

Metadata handling will take some work.  I've done some untangling in
prep to that (see #work.ufs), but that's not all.  And fun around
tail unpacking is also not quite there.

