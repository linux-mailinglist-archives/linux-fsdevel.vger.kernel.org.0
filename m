Return-Path: <linux-fsdevel+bounces-24704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7E94359B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42FD1C218B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637E4594D;
	Wed, 31 Jul 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZlGIhPW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F4038F83;
	Wed, 31 Jul 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450469; cv=none; b=R7v6onEpQ/8Bjo1DN4mqAabC2j/DrjvIGmaqzE0OQXseXp9uHksNzAiCz1DePFoYXQ4l+Uay4jOwbzP68WhZJxBPiqd59fWgpJKUYeYE10v75HZPK+zfHxOKwqP5BCukFeYQ6dLJVBaTRlENyQ24hLHsfsMmLXBiBjPxe/C13y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450469; c=relaxed/simple;
	bh=J5wQSTzwPjkYLqzmFpXJKZUhk0YviZ10ZHSXagbq2WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3wYxZBqegZcV/uiNamFHUKyFSFrUbhqY2pyapeElB12KgsPTGBKj78hGLdi6ymc9iIssMKu3wbVqsgewTD2M8SdnVK78i03IevBDgeBMtAIfXZgohLqAG3mPHJ1AHYS303eoqxe2T/Cq32ZuAMazcMYJBH3aSgZQAc42QelXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MZlGIhPW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2aQ3rRiMo1IoChPaDuXxMICwK1el9B3aObPku20ECy0=; b=MZlGIhPWm+5MqV3NCZjMvK1Eyt
	SJW+CBGVOK1/5nzx80u7GwPqY8cA5ktrqaOPJycf0j7FzvzhAX3tmK4YLhsN9gJaLNfjnVMaY3u7N
	1kf2XpjBprBVE+GAsWCxzKWivZNd/rm0VfuI6rcudIEXhxD2kAAi09L1DUTIBc+yGep1QSrWRy3Il
	qSsYW3h6gnip6dR1GRx4oC8/PvfBB2ZlbdRVP+HVdhzi4HytIyRmgF9b8L6pQcI2MlqG2Fy1Ayt36
	60ogFustoI6RtKw2UEdG3tVz/tDITmZcjWXsQKec93zG3KVOTlr5x4ROPuyWhEigFhcfXxYARC6Kc
	yHWZXuzw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZE35-0000000GQvH-2dAj;
	Wed, 31 Jul 2024 18:27:43 +0000
Date: Wed, 31 Jul 2024 19:27:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>,
	netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <ZqqCH0wvHjpVrsQl@casper.infradead.org>
References: <20240723104533.mznf3svde36w6izp@quack3>
 <2136178.1721725194@warthog.procyon.org.uk>
 <2147168.1721743066@warthog.procyon.org.uk>
 <20240724133009.6st3vmk5ondigbj7@quack3>
 <20240729-gespickt-negativ-c1ce987e3c07@brauner>
 <20240731181657.dprkkq5jxgatgx2v@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731181657.dprkkq5jxgatgx2v@quack3>

On Wed, Jul 31, 2024 at 08:16:57PM +0200, Jan Kara wrote:
> To fix this, either we'd have to keep the lower cache filesystem private to
> cachefiles (but I don't think that works with the usecases) or we have to
> somehow untangle this mmap_lock knot. This "page fault does quite some fs
> locking under mmap_lock" problem is not causing filesystems headaches for
> the first time. I would *love* to be able to always drop mmap_lock in the
> page fault handler, fill the data into the page cache and then retry the
> fault (so that filemap_map_pages() would then handle the fault without
> filesystem involvement). It would make many things in filesystem locking
> simpler. As far as I'm checking there are now not that many places that
> could not handle dropping of mmap_lock during fault (traditionally the
> problem is with get_user_pages() / pin_user_pages() users). So maybe this
> dream would be feasible after all.

The traditional problem was the array of VMAs which was removed in
commit b2cac248191b -- if we dropped the mmap_lock, any previous
entries in that array would become invalid.  Now that array is gone,
do we have any remaining dependencies on the VMAs remaining valid?

