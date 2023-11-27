Return-Path: <linux-fsdevel+bounces-3899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B287F9A26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FF21C2091A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94A1FC0C;
	Mon, 27 Nov 2023 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C1812F;
	Sun, 26 Nov 2023 22:41:11 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6138968AFE; Mon, 27 Nov 2023 07:41:07 +0100 (CET)
Date: Mon, 27 Nov 2023 07:41:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] iomap: drop the obsolete PF_MEMALLOC check in
 iomap_do_writepage
Message-ID: <20231127064107.GA27540@lst.de>
References: <20231126124720.1249310-5-hch@lst.de> <875y1nsnsj.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y1nsnsj.fsf@doe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 12:09:08PM +0530, Ritesh Harjani wrote:
> Nice cleanup. As you explained, iomap_do_writepage() never gets called
> from memory reclaim context. So it is unused code which can be removed. 
> 
> However, there was an instance when this WARN was hit by wrong
> usage of PF_MEMALLOC flag [1], which was caught due to WARN_ON_ONCE.
> 
> [1]: https://lore.kernel.org/linux-xfs/20200309185714.42850-1-ebiggers@kernel.org/
> 
> Maybe we can just have a WARN_ON_ONCE() and update the comments?
> We anyway don't require "goto redirty" anymore since we will never
> actually get called from reclaim context.

Well, xfs/iomap never really cared about the flag, just that it didn't
get called from direct reclaim or kswapd.  If we think such a WARN_ON
is still useful, the only caller of it in do_writepages might be a better
place.


