Return-Path: <linux-fsdevel+bounces-3907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B92A7F9A94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 08:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162E2280D89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26758FC0E;
	Mon, 27 Nov 2023 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE02135;
	Sun, 26 Nov 2023 23:12:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3042168AFE; Mon, 27 Nov 2023 08:12:19 +0100 (CET)
Date: Mon, 27 Nov 2023 08:12:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/13] iomap: factor out a iomap_writepage_handle_eof
 helper
Message-ID: <20231127071219.GA28171@lst.de>
References: <8734wrsmy5.fsf@doe.com> <87zfyzr84x.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfyzr84x.fsf@doe.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 12:32:38PM +0530, Ritesh Harjani wrote:
> >
> > i_size_read(inode) returns loff_t type. Can we make end_pos also as
> > loff_t type. We anyway use loff_t for
> > folio_pos(folio) + folio_size(folio), at many places in fs/iomap. It
> > would be more consistent with the data type then.
> >
> > Thoughts?
> 
> aah, that might also require to change the types in
> iomap_writepage_map(). So I guess the data type consistency change
> should be a follow up change as this patch does only the refactoring.

Yes, I'm trying to stay consistent in the writeback code.  IIRC some
of the u64 use was to better deal with overflows, but I'll have to look
up the history.


