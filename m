Return-Path: <linux-fsdevel+bounces-17169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6508A88CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339121F21984
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB2F1411E5;
	Wed, 17 Apr 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jtNNgm+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA18494;
	Wed, 17 Apr 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371146; cv=none; b=AdfmbonS+yKx3yTwy24Z5r1K0T2gsd+MSMYvtVHoMQ8NMC5XQAlnHkfpRwDW/SI2SFTCzOfFVajUA/aFdgYEiqlXo3mbHqYBLmfoP2nTqRkgY+LiRaHQlgKAQAZoI1ZEDkTIRtYzuQMCvCja3G9drZQxKBiidoeDBDd5yRtKDyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371146; c=relaxed/simple;
	bh=Cmxd7/+fzAymlG5WKKxHHTnTQ/RwUCLPsgb+KXnXIHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9WOX+eYBAgiJJbaTfzJpiW/aHN5hFiD1voMqHzbF8b5FdRV0J/lLy4CP5seuCBV9Y7t6YywxsghWr7kgp4V4K8/kwwC0AOh4u9t62AhUhsI+wmTAIQuAvL6JiFqlkYh/tajf9nJgKkyX9qKPchmvnrG/ODmLO8LFiHfGW/NEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jtNNgm+1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FNOr1el/BueGEYH9ReRV1YHomFZKKuDkdYF/EDGjHU8=; b=jtNNgm+1Q1LqYI2cxmrIUJ02KX
	cuKxf9DRcotpjx6YqaIlJ4fymrsB4qadMxEWhsdlLa5G8wGM7Lo8s0h+QJQrTHxBLnkgyTOG84kP6
	yqK9xBICWXAns7Hn/iDzVqnwkiBeh8mJVxI8F8BKoTFnkakyWLTmzaCPps7K+anem0en+YLJDC+0z
	lZ8iNCaWkNmfjtSIhxEZqggsTfGqA7wsRa83CJLKl/PVAE9icnZR2IUfXu1drhlmmbx+SNJQnz8uB
	YuemtwEdPZ++E5FwlwFWpQviq+DfouhD3Fc9RsjsMMkeJXevHfbdaix9sGhm1qmhCPBsvx884HXGh
	b5UD0HHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx868-00000003HUI-12g8;
	Wed, 17 Apr 2024 16:25:24 +0000
Date: Wed, 17 Apr 2024 17:25:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: Re: [PATCH 5/8] cifs: drop usage of page_file_offset
Message-ID: <Zh_39JW9Nfrntzme@casper.infradead.org>
References: <20240417160842.76665-1-ryncsn@gmail.com>
 <20240417160842.76665-6-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417160842.76665-6-ryncsn@gmail.com>

On Thu, Apr 18, 2024 at 12:08:39AM +0800, Kairui Song wrote:
> +++ b/fs/smb/client/file.c
> @@ -4749,7 +4749,7 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
>  static int cifs_read_folio(struct file *file, struct folio *folio)
>  {
>  	struct page *page = &folio->page;
> -	loff_t offset = page_file_offset(page);
> +	loff_t offset = page_offset(page);

	loff_t offset = folio_pos(folio);

