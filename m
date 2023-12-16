Return-Path: <linux-fsdevel+bounces-6299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C72815772
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 05:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F000B2324C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1590111A6;
	Sat, 16 Dec 2023 04:30:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028B13FF3;
	Sat, 16 Dec 2023 04:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9597E68B05; Sat, 16 Dec 2023 05:29:57 +0100 (CET)
Date: Sat, 16 Dec 2023 05:29:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 04/14] fs: Reduce stack usage in do_mpage_readpage
Message-ID: <20231216042957.GD9284@lst.de>
References: <20231215200245.748418-1-willy@infradead.org> <20231215200245.748418-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215200245.748418-5-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 15, 2023 at 08:02:35PM +0000, Matthew Wilcox (Oracle) wrote:
> Some architectures support a very large PAGE_SIZE, so instead of the 8
> pointers we see with a 4kB PAGE_SIZE, we can see 128 pointers with 64kB
> or so many on Hexagon that it trips compiler warnings about exceeding
> stack frame size.
> 
> All we're doing with this array is checking for block contiguity, which we
> can as well do by remembering the address of the first block in the page
> and checking this block is at the appropriate offset from that address.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

