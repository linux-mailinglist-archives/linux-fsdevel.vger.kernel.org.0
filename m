Return-Path: <linux-fsdevel+bounces-3895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA767F99D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FB2B20CC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE4CD28F;
	Mon, 27 Nov 2023 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F78C113;
	Sun, 26 Nov 2023 22:29:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F9A668AFE; Mon, 27 Nov 2023 07:29:35 +0100 (CET)
Date: Mon, 27 Nov 2023 07:29:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/13] iomap: clear the per-folio dirty bits on all
 writeback failures
Message-ID: <20231127062934.GA27241@lst.de>
References: <20231126124720.1249310-2-hch@lst.de> <87edgbsvr8.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edgbsvr8.fsf@doe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 09:17:07AM +0530, Ritesh Harjani wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > write_cache_pages always clear the page dirty bit before calling into the
> > file systems, and leaves folios with a writeback failure without the
> > dirty bit after return.  We also clear the per-block writeback bits for
> 
> you mean per-block dirty bits, right?

Yes, sorry.

> 		/*
> 		 * Let the filesystem know what portion of the current page
> 		 * failed to map. If the page hasn't been added to ioend, it
> 		 * won't be affected by I/O completion and we must unlock it
> 		 * now.
> 		 */
> The comment to unlock it now becomes stale here.

Indeed.

> Maybe why not move iomap_clear_range_dirty() before?

A few patches down the ->discard_folio call moves into a helper, so
I'd rather avoid the churn here.  I'll move that part of the comment
to thew new check below iomap_clear_range_dirty instead.

