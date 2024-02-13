Return-Path: <linux-fsdevel+bounces-11306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65D8528E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584661F24E1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371B15EA2;
	Tue, 13 Feb 2024 06:26:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7113AC0;
	Tue, 13 Feb 2024 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805565; cv=none; b=kAWgxmt2EHgh4zNb8VypC7RRwAl3d5TQ8JDquVlfGyLL+RYKX5s+H4Ff1Ktb+Jl1EjAK2bu0KgeBH83pQitcj4zBWdj9Db4fiFObPU2LGhOySVbyCOMbwNWhFXum4mGxJoZnUU5tZUJUzyb7wfq7C2Vee0zsjMYQpTaHB91Mwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805565; c=relaxed/simple;
	bh=kJpB1bbotnZFhqEVg0AeQ/Zsaj38y8uUEDRP5TOzTKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf+DFN32CZpe05bgi31IPMMU+RMnyFxYdwyBiue95R2CzoekkDnY2jsIsg2ber44ArgdSDfiprNqPka9insWzVzwE0fjm+ySJEYSQBUit8wCD7qVtMZDXzHDvOLMl+uKnn7DjBMhljaPm/Wq/jtsYppvKd+whugDydyextCF0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 55410300037E4;
	Tue, 13 Feb 2024 07:25:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 413414F367; Tue, 13 Feb 2024 07:25:59 +0100 (CET)
Date: Tue, 13 Feb 2024 07:25:59 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
Message-ID: <20240213062559.GA27364@wunner.de>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 12, 2024 at 11:30:58AM -0500, Mathieu Desnoyers wrote:
> In preparation for checking whether the architecture has data cache
> aliasing within alloc_dax(), modify the error handling of virtio
> virtio_fs_setup_dax() to treat alloc_dax() -EOPNOTSUPP failure as
> non-fatal.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")

That's a v4.0 commit, yet this patch uses DEFINE_FREE() which is
only available in v6.6 but not any earlier stable kernels.

So the Fixes tag feels a bit weird.

Apart from that,
Reviewed-by: Lukas Wunner <lukas@wunner.de>

