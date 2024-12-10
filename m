Return-Path: <linux-fsdevel+bounces-36897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C49EAA5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 09:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0433C188B732
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE7022F381;
	Tue, 10 Dec 2024 08:12:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC565194C6A;
	Tue, 10 Dec 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818336; cv=none; b=XIGO112UlrwSHZomKsUVgif5oJLXstD6XNa9EZFnVInrgabJj463jkphFzfY1c4XplDVrfPBTHfZEUYUbHNmGjsfD7qByDxHfBBXM/LJpyB7JVc0byTejbsLLgeTD+U21SMx595+UjNk4jgTSkQvfISN5fkVIMnyStx5NhWP0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818336; c=relaxed/simple;
	bh=pIKBvgEBKJeNMpgSymFQ1nB6pah1MI/foJv14Szko8E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN74kJV7/ar47uwKYTXE9YZfd28R8FQs3WfxhEbLzaSoaJeDBs+A9tLylBKZ1Ape89WA9bzQ9OKPMqDQdeOz2YYgu5EYNqaUE4h1tRlrKgxzkKfYEaVJFgR2WMtJNxRvwNYDb6h91aLAJonL+ZEksOKsmxJ8h0OSlrOhymznuwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y6ryC2r51z21mph;
	Tue, 10 Dec 2024 16:10:27 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 1792B140259;
	Tue, 10 Dec 2024 16:12:11 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Dec
 2024 16:12:10 +0800
Date: Tue, 10 Dec 2024 16:09:26 +0800
From: Long Li <leo.lilong@huawei.com>
To: Brian Foster <bfoster@redhat.com>
CC: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [PATCH v6 1/3] iomap: pass byte granular end position to
 iomap_add_to_ioend
Message-ID: <Z1f3NvI6j0tuIU7a@localhost.localdomain>
References: <20241209114241.3725722-1-leo.lilong@huawei.com>
 <20241209114241.3725722-2-leo.lilong@huawei.com>
 <Z1b5Vr96Aysa_JCG@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Z1b5Vr96Aysa_JCG@bfoster>
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Mon, Dec 09, 2024 at 09:06:14AM -0500, Brian Foster wrote:
> On Mon, Dec 09, 2024 at 07:42:39PM +0800, Long Li wrote:
> > This is a preparatory patch for fixing zero padding issues in concurrent
> > append write scenarios. In the following patches, we need to obtain
> > byte-granular writeback end position for io_size trimming after EOF
> > handling.
> > 
> > Due to concurrent writeback and truncate operations, inode size may
> > shrink. Resampling inode size would force writeback code to handle the
> > newly appeared post-EOF blocks, which is undesirable. As Dave
> > explained in [1]:
> > 
> > "Really, the issue is that writeback mappings have to be able to
> > handle the range being mapped suddenly appear to be beyond EOF.
> > This behaviour is a longstanding writeback constraint, and is what
> > iomap_writepage_handle_eof() is attempting to handle.
> > 
> > We handle this by only sampling i_size_read() whilst we have the
> > folio locked and can determine the action we should take with that
> > folio (i.e. nothing, partial zeroing, or skip altogether). Once
> > we've made the decision that the folio is within EOF and taken
> > action on it (i.e. moved the folio to writeback state), we cannot
> > then resample the inode size because a truncate may have started
> > and changed the inode size."
> > 
> > To avoid resampling inode size after EOF handling, we convert end_pos
> > to byte-granular writeback position and return it from EOF handling
> > function.
> > 
> > Since iomap_set_range_dirty() can handle unaligned lengths, this
> > conversion has no impact on it. However, iomap_find_dirty_range()
> > requires aligned start and end range to find dirty blocks within the
> > given range, so the end position needs to be rounded up when passed
> > to it.
> > 
> > LINK [1]: https://lore.kernel.org/linux-xfs/Z1Gg0pAa54MoeYME@localhost.localdomain/
> > Signed-off-by: Long Li <leo.lilong@huawei.com>
> > ---
> >  fs/iomap/buffered-io.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 955f19e27e47..bcc7831d03af 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> ...
> > @@ -1914,6 +1915,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  	struct inode *inode = folio->mapping->host;
> >  	u64 pos = folio_pos(folio);
> >  	u64 end_pos = pos + folio_size(folio);
> > +	u64 end_aligned = 0;
> >  	unsigned count = 0;
> >  	int error = 0;
> >  	u32 rlen;
> > @@ -1955,9 +1957,10 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  	/*
> >  	 * Walk through the folio to find dirty areas to write back.
> >  	 */
> > -	while ((rlen = iomap_find_dirty_range(folio, &pos, end_pos))) {
> > +	end_aligned = round_up(end_pos, i_blocksize(inode));
> 
> So do I follow correctly that the set_range_dirty() path doesn't need
> the alignment because it uses inclusive first_blk/last_blk logic,
> whereas this find_dirty_range() path does the opposite and thus does
> require the round_up? If so, presumably that means if we fixed up the
> find path we wouldn't need end_aligned at all anymore?
> 

Agreed with you.

> If I follow the reasoning correctly, then this looks Ok to me:
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>
>
> ... but as a followup exercise it might be nice to clean up the
> iomap_find_dirty_range() path to either do the rounding itself or be
> more consistent with set_range_dirty().
> 
> Brian

Yes, I think we can handle the cleanup through a separate patch later?                                                                            

Thanks,
Long Li

