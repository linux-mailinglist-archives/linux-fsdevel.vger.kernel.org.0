Return-Path: <linux-fsdevel+bounces-5166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C18808D70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 17:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BB81C209EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 16:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C79F481B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 16:33:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4031128;
	Thu,  7 Dec 2023 07:03:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 04D90227A87; Thu,  7 Dec 2023 16:03:12 +0100 (CET)
Date: Thu, 7 Dec 2023 16:03:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 13/14] iomap: map multiple blocks at a time
Message-ID: <20231207150311.GA18830@lst.de>
References: <20231207072710.176093-1-hch@lst.de> <20231207072710.176093-14-hch@lst.de> <4e4a86a0-5681-210f-0c94-263126967082@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4a86a0-5681-210f-0c94-263126967082@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 07, 2023 at 09:39:44PM +0800, Zhang Yi wrote:
> > +	do {
> > +		unsigned map_len;
> > +
> > +		error = wpc->ops->map_blocks(wpc, inode, pos);
> > +		if (error)
> > +			break;
> > +		trace_iomap_writepage_map(inode, &wpc->iomap);
> > +
> > +		map_len = min_t(u64, dirty_len,
> > +			wpc->iomap.offset + wpc->iomap.length - pos);
> > +		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> 
> While I was debugging this series on ext4, I would suggest try to add map_len
> or dirty_len into this trace point could be more convenient.

That does seem useful, but it means we need to have an entirely new
even class.  Can I offload this to you for inclusion in your ext4
series? :)

> > +		case IOMAP_HOLE:
> > +			break;
> 
> BTW, I want to ask an unrelated question of this patch series. Do you
> agree with me to add a IOMAP_DELAYED case and re-dirty folio here? The
> background is that on ext4, jbd2 thread call ext4_normal_submit_inode_data_buffers()
> submit data blocks in data=ordered mode, but it can only submit mapped
> blocks, now we skip unmapped blocks and re-dirty folios in
> ext4_do_writepages()->mpage_prepare_extent_to_map()->..->ext4_bio_write_folio().
> So we have to inherit this logic when convert to iomap, I suppose ext4's
> ->map_blocks() return IOMAP_DELALLOC for this case, and iomap do something
> like:
> 
> +               case IOMAP_DELALLOC:
> +                       iomap_set_range_dirty(folio, offset_in_folio(folio, pos),
> +                                             map_len);
> +                       folio_redirty_for_writepage(wbc, folio);
> +                       break;

I guess we could add it, but it feels pretty quirky to me, so it would at
least need a very big comment.

But I think Ted mentioned a while ago that dropping the classic
data=ordered mode for ext4 might be a good idea eventually no that ext4
can update the inode size at I/O completion time (Ted, correct me if
I'm wrong).  If that's the case it might make sense to just drop the
ordered mode instead of adding these quirks to iomap.


