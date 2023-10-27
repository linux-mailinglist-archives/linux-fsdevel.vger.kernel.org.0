Return-Path: <linux-fsdevel+bounces-1291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95717D8E0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5851C20FE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 05:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3A567D;
	Fri, 27 Oct 2023 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355265249
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 05:18:52 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AA1A5;
	Thu, 26 Oct 2023 22:18:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1436A67373; Fri, 27 Oct 2023 07:18:48 +0200 (CEST)
Date: Fri, 27 Oct 2023 07:18:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, djwong@kernel.org, mcgrof@kernel.org,
	hch@lst.de, da.gomez@samsung.com, gost.dev@samsung.com,
	david@fromorbit.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page
 size
Message-ID: <20231027051847.GA7885@lst.de>
References: <20231026140832.1089824-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026140832.1089824-1-kernel@pankajraghav.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  
> -	__bio_add_page(bio, page, len, 0);
> +	while (len) {
> +		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
> +
> +		__bio_add_page(bio, page, io_len, 0);
> +		len -= io_len;
> +	}

Maybe out of self-interest, but shouldn't we replace ZERO_PAGE with a
sufficiently larger ZERO_FOLIO?  Right now I have a case where I have
to have a zero padding of up to MAX_PAGECACHE_ORDER minus block size,
so having a MAX_PAGECACHE_ORDER folio would have been really helpful
for me, but I suspect there are many other such cases as well.

