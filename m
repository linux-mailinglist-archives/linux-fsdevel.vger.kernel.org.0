Return-Path: <linux-fsdevel+bounces-5269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEBA809590
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA641C20ABA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF62157311
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTuLP32Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5284C3B;
	Thu,  7 Dec 2023 13:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AWfjo1FCG0zNp8yVCNT7ypjhavVj3uaSeJIY6fXZW/Q=; b=HTuLP32YvRPL+oDE1a2yf5CShL
	ZnbMwPGwoi+NE6tA3HShRYkj/nFemjITFmj5Ox2jNRUaliUFlLDv9SObg0rJ5oT1WvP7zsjxun+um
	1n3KXNVINV0TCPAQxQN4czj4sTVT9Of4N8CX4cSkmDyuAKQVEgGkD44HDRPlI7QwkZdWumu+qgxyR
	4Q0V0xPz3VUXOTkIqALZfgsxEDxeNab4xoQyhQsDoX1YlLarOB5VF88kzf1zLdrTvw3UPcsPbwiq3
	gQ2O1DcxXwjjfagYLU32Q7kUgRaotlnTsgr99KIFU7JUjVCyTwfXDfsYjgLIdajtZG/qiOgqqpm8d
	CB99jGig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBM1H-004PV4-3e; Thu, 07 Dec 2023 21:34:55 +0000
Date: Thu, 7 Dec 2023 21:34:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 23/59] netfs: Prep to use folio->private for write
 grouping and streaming write
Message-ID: <ZXI6fyO1xJbLNXFg@casper.infradead.org>
References: <20231207212206.1379128-1-dhowells@redhat.com>
 <20231207212206.1379128-24-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207212206.1379128-24-dhowells@redhat.com>

On Thu, Dec 07, 2023 at 09:21:30PM +0000, David Howells wrote:
> +#define NETFS_FOLIO_INFO	0x1UL	/* OR'd with folio->private. */
> +
> +static inline struct netfs_folio *netfs_folio_info(struct folio *folio)
> +{
> +	void *priv = folio_get_private(folio);
> +
> +	if ((unsigned long)priv & NETFS_FOLIO_INFO)
> +		return (struct netfs_folio *)((unsigned long)priv & ~NETFS_FOLIO_INFO);

Often one gets better code by using '-' instead of '& ~', and that's
because 'subtract one, then load four bytes from offset 12' can be
optimised into 'load four bytes from offset 11' in a way that 'clear
the bottom bit, then load four bytes from offset 12' can't be.


