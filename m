Return-Path: <linux-fsdevel+bounces-27272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E395FF5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F458283205
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 02:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D711754B;
	Tue, 27 Aug 2024 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ah0/rz84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56B18037;
	Tue, 27 Aug 2024 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727224; cv=none; b=PuAx7pg0WKkGiYubUDBs356Vzq/fE/xxw87n0E/qzXT2jPFefpmVhuwm+CIl2VIPly/3ySYXdIuVYFV/6xNNkn+wRZHLiEwarUFo2NNYMkpb83sY32Bq+nIoEl7yOOdNxMJ4bjMbkjbub/Yaem1K3tYWYyGkG581ujsevnQouA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727224; c=relaxed/simple;
	bh=RwRMyYN44uYVfmVyo9zbGvysbAtjJmlIIzW63m0EE+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFI4lXduQ/1CSz9PaIV3AHOZzAVwGoy4TbP3TWK2JEjnQ+mKJ5UF5kTttaxVkbj8Rx6Lu3HvZxQtjHeotySoXXMI9YeykFJCQO3pn4u38RWsP8+hfblWyr0tk1HUjJ14ZT/uFq35AdBumWh5vU+3g4h33zFM5HIKKDHS7cKhWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ah0/rz84; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RwRMyYN44uYVfmVyo9zbGvysbAtjJmlIIzW63m0EE+k=; b=Ah0/rz84dCNjfCOfoJ8p81z91z
	g8QxtbOjEf9rW887PQYFHVwN1xoPtXZXyhHoaqx1AfW4ibm41PP0J4hQYsEzWxFSy7A8VD6xn6Km/
	OFD1oUEByXLpzVavpWoCnnTcqqCA1AoemaTpjzK23eq65uCQ3ySX594iX2gVdXOdg7bX+KTzOZ6eA
	d7FBxrcUQWgMJVR8jFhoPslVi8TAHQn2sZUqgzV76nrFHTBt0BWEGA7o38tqOWf0JLP1zSTzeJ4Y8
	BPiYy8080jNa0v4CAUXJoFWzyvAgPX3GQ1Xg4ibddYlLpmFN5f+7wkKDODvyn8CZIwHnmGn/KwQqw
	BWqVP0sA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1simKn-0000000GIn5-1ggB;
	Tue, 27 Aug 2024 02:53:29 +0000
Date: Tue, 27 Aug 2024 03:53:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	gnoack@google.com, mic@digikod.net, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <Zs0_qeIPppYYLTac@casper.infradead.org>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827014108.222719-1-lihongbo22@huawei.com>

On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> Many mainstream file systems already support the GETVERSION ioctl,
> and their implementations are completely the same, essentially
> just obtain the value of i_generation. We think this ioctl can be
> implemented at the VFS layer, so the file systems do not need to
> implement it individually.

... then you should also remove the implementation from every
filesystem, not just add it to the VFS.


