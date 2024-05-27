Return-Path: <linux-fsdevel+bounces-20257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061538D0899
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32F628B021
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A715ECF9;
	Mon, 27 May 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kZyC3pE9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E867346C;
	Mon, 27 May 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827390; cv=none; b=TF0kIyuT6VFtpoqt90s35NUH8ohEeWnl26KaKgsy0It0HkhEe8qe6yOFQfiWUEwVIl+w53Z55av0LLToCLbu8WMxF5bXLA1fYzSnDHr7Zp6tnU9O/DU2PkEU2HkjOEU1jH8RqbNgJmPIgLC5utD470QhsI52CDRcfm/Z1h3ksow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827390; c=relaxed/simple;
	bh=aRoI7xtsmkM04Wifif6pMbPQqrT8YiNfoLqdNjPbItA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz8Fs/816Sh6TFN564XctlfwBZ+/wfgJ+e/10Iq9TxXcfYVvU+F2EAFwIGZN1Mu5yWBo+icYw09HN6qsO/rNDBkMmpLFVrj2d/jSIuqRD8DjPTeK/j0nopoPiedNQAeQEq4SOJwxMTCwK93ESwWq+Qqa9AK/0mnuEbk4Pb2D57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kZyC3pE9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Fe3M1WbTvAZeXMfbjuO8H7fTMStHiUlxRCcFwILoi+4=; b=kZyC3pE9swZXYLzz8yt3pUxTp2
	/wqUOtShL76yRoPFsx9iwX/lZDip6D8a2JAF3nE6WkONLGSDL8ETYEQFkPopmvcDWZhvA9ZZXMSLr
	nWTrMyx6ITOcrcba+BCZnbjwJfK2EUrLu3yVC/BN7SweM9X3VBo037kruAppcin61/XenD2n4xu2q
	FGIWh5/RkrV++5MD10M9PWWOWML8/CzcNWqw6R4R/ls6LN7ENFYL9hlycOIlt1wnz3huLCC1T0SNp
	EhYrN47f6vcdD/SxCZMD76gOCQKv7RqTHY1WlVKJiy85arZ1tz4KMXJVApgY7W4AGPbbFLv7b+ps1
	4m6EMf7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBdEK-0000000FrSL-22Qr;
	Mon, 27 May 2024 16:29:48 +0000
Date: Mon, 27 May 2024 09:29:48 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "hch@infradead.org" <hch@infradead.org>, "jack@suse.cz" <jack@suse.cz>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>,
	"cyphar@cyphar.com" <cyphar@cyphar.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlS0_DWzGk24GYZA@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
 <ZlRzNquWNalhYtux@infradead.org>
 <86065f6a4f3d2f3d78f39e7a276a2d6e25bfbc9d.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86065f6a4f3d2f3d78f39e7a276a2d6e25bfbc9d.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 27, 2024 at 03:38:40PM +0000, Trond Myklebust wrote:
> > It
> > does not matter what mount you use to access it.
> 
> Sure. However if you are providing a path argument, then presumably you
> need to know which file system (aka super_block) it eventually resolves
> to.

Except that you can't, at least not without running into potential
races.  The only way to fix a race vs unmount/remount is to include
the fsid part in the kernel generated file handle.

> 
> If your use case isn't NFS servers, then what use case are you
> targeting, and how do you expect those applications to use this API?

The main user of the open by handle syscalls seems to be fanotify
magic.


