Return-Path: <linux-fsdevel+bounces-4137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414E37FCF26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F4C1C20961
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA7101EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neOqEUeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28B44383;
	Wed, 29 Nov 2023 04:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F3CC433C7;
	Wed, 29 Nov 2023 04:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701233334;
	bh=pBvgQKSd9+64RhGDoa46W9uYlH2MUoShKpGxzSVXzR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neOqEUeMQpDRlpVCqymQcu1xpAkmzzhERFPs+ECA41C6jsCD9NmdcHLkvRtYD3kNk
	 LoaLq/MxKS/VwIJMtDr4zza4VvUl4GC6ktt5aYPGVjs9LuWpl/ucXVr1D/NUe28atA
	 M0tkd4Gs7mM1eAHmZVscflSJrqVnwErdzIO1yuZhlZeuwQndf7wIBrfp4cDYhOX9O4
	 6Oy1uMpoUZPapHaqHDbLxfCFgdm4BmNzDdtCql0k93wGuQOHNOIMFlZxHdatEbRMBK
	 tDET1qIZSsVWhNt48iahYgE71luHsWacIxoDfDBwTOH1h2OSXl46JZmBj6uRA2oikP
	 ctgtR8jwU1okg==
Date: Tue, 28 Nov 2023 20:48:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/13] iomap: factor out a iomap_writepage_handle_eof
 helper
Message-ID: <20231129044852.GK4167244@frogsfrogsfrogs>
References: <8734wrsmy5.fsf@doe.com>
 <87zfyzr84x.fsf@doe.com>
 <20231127071219.GA28171@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127071219.GA28171@lst.de>

On Mon, Nov 27, 2023 at 08:12:19AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 12:32:38PM +0530, Ritesh Harjani wrote:
> > >
> > > i_size_read(inode) returns loff_t type. Can we make end_pos also as
> > > loff_t type. We anyway use loff_t for
> > > folio_pos(folio) + folio_size(folio), at many places in fs/iomap. It
> > > would be more consistent with the data type then.
> > >
> > > Thoughts?
> > 
> > aah, that might also require to change the types in
> > iomap_writepage_map(). So I guess the data type consistency change
> > should be a follow up change as this patch does only the refactoring.

Separate patch for the cleanup, please.  Then we can more easily target
it for bisection in case there are signed comparison bugs.  I hate C.

> Yes, I'm trying to stay consistent in the writeback code.  IIRC some
> of the u64 use was to better deal with overflows, but I'll have to look
> up the history.

For this patch,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> 

