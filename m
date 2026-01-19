Return-Path: <linux-fsdevel+bounces-74376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D74D39F48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCEE7302EB01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6018C2D2381;
	Mon, 19 Jan 2026 07:03:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37AC2D8760;
	Mon, 19 Jan 2026 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806202; cv=none; b=Xd9d7qSK5ok9QE8c+8kGTVofMzYCtuBaYzx9V1/8DTwmehmBi0ZTw8FHR2DrORnmc4o8wVH9NKJxChvunWf9iiBTiWlejx+NQwDdgexzP4Xp2LqLS+EiS/anaTOIHImRJXNKE+/mpv/Ey8IasZOa7MXq0fWlE60s/sCBLk31NBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806202; c=relaxed/simple;
	bh=FtDYNu0goo3WxhPyasUm7pIi42iiXvHKVNX2gmp5zLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq4zFQyxw4hX9McgUURVESFXv/ieh8gO66NA5r9Xxy0/qOpG0Hf7uATsRNoXWDF85Dy+E6s7aVbiiXdeHNGh0yp0pjzNGeRoAUSuMNYLFRz1PMuIDOkFRPeC7jRRJecjXgLAEcBU1mJ5f6jToJ14i3pDH9NjtvvMOq4icOF6c84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40581227AB0; Mon, 19 Jan 2026 08:02:59 +0100 (CET)
Date: Mon, 19 Jan 2026 08:02:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, tytso@mit.edu, willy@infradead.org,
	jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com,
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org,
	dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org,
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v5 00/14] ntfs filesystem remake
Message-ID: <20260119070254.GA1480@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260116093348.GA22781@lst.de> <CAKYAXd9CXj5hZ2zoiyEgrBWA6NB1u2VrBEcOGCwCPCSZODzp6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9CXj5hZ2zoiyEgrBWA6NB1u2VrBEcOGCwCPCSZODzp6w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 18, 2026 at 02:19:51PM +0900, Namjae Jeon wrote:
> > I'm not sure how many tests are actually run for the ntfs variants
> > because they lack features needed for many tests, but how many still
> > fail with this, because with these numbers I suspect there's quite
> > a few left. Do you have any good grasp why they are failing, i.e.
> > assumptions in xfsteasts, or missing feature checks?
> Regarding the xfstests results, many of the 'Not Run' cases are due to
> fundamental differences in the NTFS architecture. For instance, NTFS
> does not support certain advanced features like reflink, which causes
> many tests to be skipped. Also, ntfs does not yet support journaling,
> leading to failures in tests that assume journal-based consistency.
> I am currently categorizing these failures to distinguish between
> NTFS-inherent limitations and areas for future improvement. I will
> provide a detailed breakdown and analysis of these test results in the
> cover letter on next version.

Not run is totally fine.  We have plenty of them even for native
file systems, and having even more for foreign file system support
is just fine.  What I meant to say is the number of failing tests
is the much more interesting metric, so maybe you can share that?


