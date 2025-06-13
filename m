Return-Path: <linux-fsdevel+bounces-51542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4826CAD8125
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 04:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A477B11EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D60224676D;
	Fri, 13 Jun 2025 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WQINv2Fs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335123BD0E;
	Fri, 13 Jun 2025 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749782500; cv=none; b=a5OXqqZTG9kTm04m/QMlpxqmc1/Td63y/B2fOCWWkpOepB+y3Ak+uiBcW+K5P+NW1YG/ahI0XB3Akpq6Jz/icta+WwJfXcdZ8KxEXTm7gLgqY/9H8cRVFvexSsug0pejh/qb7rVQ5Eod8i8456ppRp0AVHOgf3KGEwApi2+DWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749782500; c=relaxed/simple;
	bh=geS8XlZRiHCVw4EwzTvT0372eXrdMKICrknqgpXDSHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y575QFLiX/oyi+RcCaaF2Zjw9vVaI28Pp98vEtZxqOB28UTTbIacGp4mMSKlRJThgqJaxQtWWB4cDyGHRdX3V4Pfburs+NnsyCSwdcsbic8V4MMGLYafHwF7m3X3TCcB3F5fCMizOMyG54FPFZDV37Sz+Z5CLtYe/G6j8zRqf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WQINv2Fs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zOL4rBZFTivw87SF4aKWLQKacaGt47gTX8zDfWyLzn8=; b=WQINv2FskLl4oWiag2Tl4gnunG
	ebY5JG1yfFMoI13Xuyl3SLJpDqv7hjtKQyJGoYTD+dE52gA3e59Btu5PaIBwWmca17P2CiWatCisM
	p9laA2d8s2x/KyPdBydg/CKi24nSo12oDs0kf6+gpgu1B8evDu0o7K68LcOzXMEb/hAlmnNpMt7Ld
	DUbdbKPVYDCNKKuWkXVUF6zZGRINPs7kVqziL5CjsKCKWJ2cat0KjIlQ+caf9J4haEpANoT1nkA7g
	RJjX9+C1Y7FrMcxOQkyaSi0pwxxFYY2QwhCe1L2X8d+Q/kR10f3kTy78sF5wHZuQfCoCxe+2btuMN
	BQsSGuqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPuMI-000000053y9-1t9D;
	Fri, 13 Jun 2025 02:41:34 +0000
Date: Fri, 13 Jun 2025 03:41:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc_sysctl: Fix up ->is_seen() handling
Message-ID: <20250613024134.GF1647736@ZenIV>
References: <>
 <20250613020111.GE1647736@ZenIV>
 <174978225309.608730.8864073362569294982@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174978225309.608730.8864073362569294982@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 13, 2025 at 12:37:33PM +1000, NeilBrown wrote:

> If two threads in the same namespace look up the same name at the same
> time (which previously didn't exist), they will both enter
> d_alloc_parallel() where neither will notice the other, so both will
> create and install d_in_lookup() dentries, and then both will call
> ->lookup, creating two identical inodes.
> 
> I suspect that isn't fatal, but it does seem odd.
> 
> Maybe proc_sys_compare should return 0 for d_in_lookup() (aka !inode)
> dentries, and then proc_sys_revalidate() can perform the is_seen test
> and return -EAGAIN if needed, and __lookup_slow() and others could
> interpret that as meaning to "goto again" without calling
> d_invalidate().

Umm...  Not sure it's the best solution; let me think a bit.  Just need
to finish going through the ported rpc_pipefs series for the final look
and posting it; should be about half an hour or so...

