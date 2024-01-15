Return-Path: <linux-fsdevel+bounces-7951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C682DBE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 15:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0847D282032
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA0D199AA;
	Mon, 15 Jan 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ImWYwdwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AA7199A4;
	Mon, 15 Jan 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DMqbdyi4eLyG/P84atg6xw7sLhpYbrXTR+c3A3qjimU=; b=ImWYwdwWIEfyR5eMq3znGWSWKz
	FrW8akY+9YiHOJjUSfxiMSp06YI3QteLOa2bzj+HwYKXKReTMO3l0Bmv/6occdwozYUVUFnSdo05x
	Y+cfLQEvFUcxbhEcv1x37XfDqIGL3z1wSJS+D93PouzIvpUSj7bduOrCIbzTOwkWAyUKaJCqIXUv3
	dDqjuYHJuzWdNs7cOTAs55UW08BeElvHj6qGHGafJq74AeOQvN28RWWQdySvYLgY7rRFX3/bv+VII
	zGFBEA37bAvBoAMspWlIRZilliqsMBBFyaqbltmSX6Q+7aHtjJNfJ2TzjLnMnRJoIobvEb9b9R1rT
	XwYCDuxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPOH9-009yaj-8k; Mon, 15 Jan 2024 14:49:19 +0000
Date: Mon, 15 Jan 2024 14:49:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Anton Altaparmakov <anton@tuxera.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] fs: Remove NTFS classic
Message-ID: <ZaVF72QxQm/cN5yy@casper.infradead.org>
References: <20240115072025.2071931-1-willy@infradead.org>
 <8a5d4fcb-f6dc-4c7e-a26c-0b0e91430104@tuxera.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a5d4fcb-f6dc-4c7e-a26c-0b0e91430104@tuxera.com>

On Mon, Jan 15, 2024 at 11:00:35AM +0000, Anton Altaparmakov wrote:
> Hi Matthew,
> 
> On 15/01/2024 07:20, Matthew Wilcox (Oracle) wrote:
> > The replacement, NTFS3, was merged over two years ago.  It is now time to
> > remove the original from the tree as it is the last user of several APIs,
> > and it is not worth changing.
> 
> It was my impression that people are complaining ntfs3 is causing a whole
> lot of problems including corrupting people's data.  Also, it appears the
> maintainer has basically disappeared after it got merged.

I'm not terribly happy with how the maintainer behaves either, but
you've also been missing in action for nine years (if we're counting
code authored by you) or two years (if a R-b is enough).

According to your documentation, you don't support creating new files
or directories, so I'd suggest that your code has never been put through
the xfstests wringer in the way that ntfs3 has.

> Also, which APIs are you referring to?  I can take a look into those.

The biggest one for me is the folio work.  Everywhere in your code that
use a struct page needs to be converted to a struct folio.  Support for
large folios is optional, and I wouldn't bother trying to add that.
Take a look at, eg, nilfs2, ext4, ext2, iomap, NFS, AFS for some
filesystems which have been (at least mostly) converted.

Any functions in mm/folio-compat.c should no longer be called.

If we're being really ambitious, filesystems should stop using the
buffer cache and switch to using iomap.  There's a lot of work going
on and unmaintained filesystems are holding us back.

