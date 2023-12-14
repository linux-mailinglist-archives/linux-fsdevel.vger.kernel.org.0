Return-Path: <linux-fsdevel+bounces-6131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C25813A6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC42282FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EFB68E86;
	Thu, 14 Dec 2023 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CQjNFKbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8E10E;
	Thu, 14 Dec 2023 11:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BIjDpnSLfy+/JidKOjaXfU4tgr5UOAxujD+5ylQPn00=; b=CQjNFKbGCXrJctffz724MivJGE
	Lz5D8m7LpMuh6Zt0cgfflMlA01k9xaxqraUuyMlp1rGtMm7ldVTJWQSjhWXsvPqaGT50zUFHYikw1
	ifJ5gBmXnpVVAxrYwo3xQ9fkpx4w6OYvwy8QY/p43OKOy+Kb++4u/ioZTy65zPuhfJpmZzmrweW5O
	7eyMywno2bhZeUYhIZMTs/CUflon5q552OQm9a+JOcqQms43Oo7tj0YXEwkWFWB8XYoMSkZo2FtM+
	rnQF+2L4ZoquufjpE2Vq6BDn6VLJNq0/kiZ5cYZuTNZWQ2BJJaBpNjlrVs0LvSuMvV4GSMDAmUO7f
	HhMtULnA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDqxZ-009SqZ-SO; Thu, 14 Dec 2023 19:01:25 +0000
Date: Thu, 14 Dec 2023 19:01:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara <jack@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Bob Copeland <me@bobcopeland.com>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [PATCH 4/9] hfs: remove ->writepage
Message-ID: <ZXtRBarvgSVN5zPx@casper.infradead.org>
References: <20221113162902.883850-1-hch@lst.de>
 <20221113162902.883850-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113162902.883850-5-hch@lst.de>

On Sun, Nov 13, 2022 at 05:28:57PM +0100, Christoph Hellwig wrote:
> ->writepage is a very inefficient method to write back data, and only
> used through write_cache_pages or a a fallback when no ->migrate_folio
> method is present.
> 
> Set ->migrate_folio to the generic buffer_head based helper, and stop
> wiring up ->writepage for hfs_aops.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Was there a reason you only did this for hfs_aops and not for
hfs_btree_aops?  It feels like anything that just calls
block_write_full_page() in the writepage handler should be converted
to just calling mpage_writepages() in the writepages handler.
I have a few of those conversions done, but obviously they're in
filesystems that are basically untestable.

