Return-Path: <linux-fsdevel+bounces-6165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A0814115
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 06:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E20B1F22E86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 05:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE1E63A9;
	Fri, 15 Dec 2023 04:59:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C253A5;
	Fri, 15 Dec 2023 04:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2584568D05; Fri, 15 Dec 2023 05:59:44 +0100 (CET)
Date: Fri, 15 Dec 2023 05:59:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara <jack@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Bob Copeland <me@bobcopeland.com>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [PATCH 4/9] hfs: remove ->writepage
Message-ID: <20231215045943.GA16040@lst.de>
References: <20221113162902.883850-1-hch@lst.de> <20221113162902.883850-5-hch@lst.de> <ZXtRBarvgSVN5zPx@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXtRBarvgSVN5zPx@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 14, 2023 at 07:01:25PM +0000, Matthew Wilcox wrote:
> Was there a reason you only did this for hfs_aops and not for
> hfs_btree_aops?  It feels like anything that just calls
> block_write_full_page() in the writepage handler should be converted
> to just calling mpage_writepages() in the writepages handler.
> I have a few of those conversions done, but obviously they're in
> filesystems that are basically untestable.

Probably.  I remember I had a good reason to skip, and the lack of
testability might have been it.  Note that for hfsplus in particular
we should actually be able to test now that the port of the hfs
userspace has returned to distros.  I haven't actually gotten to
see what the test baseline looks like, though.

