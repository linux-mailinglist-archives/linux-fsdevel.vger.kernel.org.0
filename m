Return-Path: <linux-fsdevel+bounces-17213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BAA8A90B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 03:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61999B21D3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 01:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DCA25757;
	Thu, 18 Apr 2024 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4t341uu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3BC3BBD4;
	Thu, 18 Apr 2024 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403850; cv=none; b=CNL4TO4FOzcoJrBMhHHLkmvdQoMQ5hzN3ereiGhAaG26Kv9rC0qdRgZYr2+U1O4A07D3kvoYnvtvGJ5YgoL6RSUwqTJm5kTWY6bM1mspbn11+2tSV6TY/auksVOU8RGGIhRS9hDvegkhJuZ0VoQn9uSBT6Ut247es6XANl24D6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403850; c=relaxed/simple;
	bh=JjynidKEZFAxpHdume9tSkQsH7/8Xm3xZGDHoj+Wf5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLKuMnza7mVgzpVKuTDVZnyi8lqunabDUtzJhK3CaCB/MTKB0cuyvFYLxxLV2sSghJgEWCfVYjWZrhs90eD0GdxmWGpnR+TSli9HQNH93p8VWrHJL6qa3UYaOi1KJew2AAF98F8+gW/Ud4Sph7Z58o95BYzn41JVsT4l97HwExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T4t341uu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f/kljw3WIu9Nyid/c/jp8gr+BElyOPqDQkGlBVNzXGU=; b=T4t341uuJ0iIcv6IObZnoplnuJ
	QvhQzlNIlkOP4kKYvsiTJks0GDoV9FzODjn0K+hp0MPz69D4xaTqXXV9ypP7Sp1Z54hYdySib553E
	ZN625x+8mgnSHU5tHI6U/ky8oq6HQEGea1BvdVtxhK85KcCtRHQpr7Qa8UOx+iiJPBLtOcDf14YM+
	S1rBvQETqdH0jvAnzTCN5iqpFKRwdkDjInBdACC6KlM7ZNZFNyE3kf8Wh8EyoJntAPHb7I2hT6mKv
	Qku9qDciTYw2zgQ8ilYqfd8ByFhUwO82c1DoisITx0u+0pKjW4yAsw9osfl9ZfBz5rPYyI3+ULfch
	3NFXKg5g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxGbW-00000004DjD-3q35;
	Thu, 18 Apr 2024 01:30:23 +0000
Date: Thu, 18 Apr 2024 02:30:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Xiubo Li <xiubli@redhat.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Subject: Re: [PATCH 4/8] ceph: drop usage of page_index
Message-ID: <ZiB3rp6m4oWCdszj@casper.infradead.org>
References: <20240417160842.76665-1-ryncsn@gmail.com>
 <20240417160842.76665-5-ryncsn@gmail.com>
 <fc89e5b9-cfc4-4303-b3ff-81f00a891488@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc89e5b9-cfc4-4303-b3ff-81f00a891488@redhat.com>

On Thu, Apr 18, 2024 at 08:28:22AM +0800, Xiubo Li wrote:
> Thanks for you patch and will it be doable to switch to folio_index()
> instead ?

No.  Just use folio->index.  You only need folio_index() if the folio
might belong to the swapcache instead of a file.

