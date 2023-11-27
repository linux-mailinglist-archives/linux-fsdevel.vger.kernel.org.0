Return-Path: <linux-fsdevel+bounces-3896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E87F99DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E026280F0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475B0DF78;
	Mon, 27 Nov 2023 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC40B93;
	Sun, 26 Nov 2023 22:33:29 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61D8F68AFE; Mon, 27 Nov 2023 07:33:26 +0100 (CET)
Date: Mon, 27 Nov 2023 07:33:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/13] iomap: treat inline data in iomap_writepage_map
 as an I/O error
Message-ID: <20231127063325.GB27241@lst.de>
References: <20231126124720.1249310-3-hch@lst.de> <87bkbfssb8.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkbfssb8.fsf@doe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 10:31:31AM +0530, Ritesh Harjani wrote:
> The code change looks very obvious. But sorry that I have some queries
> which I would like to clarify - 
> 
> The dirty page we are trying to write can always belong to the dirty
> inode with inline data in it right? 

Yes.

> So it is then the FS responsibility to un-inline the inode in the
> ->map_blocks call is it?

I think they way it currently works for gfs2 is that writeback from the
page cache never goes back into the inline area.  

If we ever have a need to actually write back inline data we could
change this code to support it, but right now I just want to make the
assert more consistent.

