Return-Path: <linux-fsdevel+bounces-18397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDD68B8513
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F01A2845E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 04:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC1433B9;
	Wed,  1 May 2024 04:41:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3432F875;
	Wed,  1 May 2024 04:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714538514; cv=none; b=uTEEyWrYJ1xKODfAIaiCn2mQU+dWyRXiU6LO6/28aRCdF+/CBalco2qhA15SFjH7fJeB7FQTto5CLtrR87frXnxGZddBUKnqL4fRgxVtddKqAIr0YsvC2h5je7ax0rUEntGNP40PXo8fMMva8xwZHETxwKpPFWVzBrM6AnIRCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714538514; c=relaxed/simple;
	bh=dwZMNq9ToAOW2bLhqXYoUF8XXhEWiQ5Qu+gn4r+E/fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmMEOE5+CcAMbw46K6d+UZFnwgAHdAsRAKSy+GJUltwbCO4kjOJveCJrcHaJNxd0Vw6ZN6iec7nbWmJlkJcVMA4lK6lkL6qLp2YhlHzRITQLvkSQ5cg5edqjPOQwGRxZsJF+htCwwP76lePBg4WbTcm9J3NOHE0AwjsnTn1WD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EEFF67373; Wed,  1 May 2024 06:41:46 +0200 (CEST)
Date: Wed, 1 May 2024 06:41:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, devel@lists.orangefs.org
Subject: Re: [PATCH v2 07/22] mm: Provide a means of invalidation without
 using launder_folio
Message-ID: <20240501044145.GC31252@lst.de>
References: <20240430140056.261997-1-dhowells@redhat.com> <20240430140056.261997-8-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430140056.261997-8-dhowells@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	unmap_mapping_pages(mapping, first, nr, false);

> +}
> +EXPORT_SYMBOL(filemap_invalidate_inode);

unmap_mapping_pages is an EXPORT_SYMBOL_GPL, pleas keep that in
this in thin wrapper.


