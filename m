Return-Path: <linux-fsdevel+bounces-3261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846857F1DA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3993D1F2532F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C337168;
	Mon, 20 Nov 2023 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vHkMkRom"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2697C92;
	Mon, 20 Nov 2023 12:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3tg08O0N/xa4tm5KWlE1PNyfoNc/ZkXyYLUnylHjAQU=; b=vHkMkRomdMQPn56X43PZdq/l4J
	7jiwzi8GVr9bQuhD8+ndaA9VZDq/axrDeZ0YRmpPOjFcxJ890sA5H/ApMDMA+zDpqiFe0bp3X34t4
	K9AAtghz0M2gf88nG8/H2aCYj+kkImYvsnz7cPlJ9XX8OAN6okGHZ6Yhv1MByByVxDCVYnBK2BMT0
	no6rIt3agFIAErR6nRH+OCmj2hzwIWT7mtV93OY3f7ugRwjueE9Z7K3X1ewf7Loync99qawsdt0wr
	UukuwTnSS0MEJw81XU+L5Umdzhf47cRrIXjiP349b0kRcRg+egzLQ9i3TRk5YohFurph8aSszE145
	QW5aMT/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r5ARF-004wNG-54; Mon, 20 Nov 2023 20:00:09 +0000
Date: Mon, 20 Nov 2023 20:00:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZVu6yVlhcb3jzoob@casper.infradead.org>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>

On Tue, Nov 21, 2023 at 12:35:20AM +0530, Ritesh Harjani (IBM) wrote:
> +static void ext2_file_readahead(struct readahead_control *rac)
> +{
> +	return iomap_readahead(rac, &ext2_iomap_ops);

We generally prefer to omit the 'return' when the function returns void
(it's a GCC extension to not warn about it, so not actually a bug)

This all looks marvellously simple.  Good job!

