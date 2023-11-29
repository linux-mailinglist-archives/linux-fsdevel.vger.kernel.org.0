Return-Path: <linux-fsdevel+bounces-4154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7A77FD0F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 09:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC85EB20B0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1D63D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CxWXG8PP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC719B7;
	Tue, 28 Nov 2023 22:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TWq/t0u67v2rmHoA0biAg96aAnVgN6dEVTLzGtd0tU4=; b=CxWXG8PPt4BemfhTFre5zsLu0F
	bsXzraNfKCISHJW9w2B1vELyX1JjscoqQVo2AbqQ6pDlDlnfWpIPBU9tLYsAGGa2YMNT0/MAczYXb
	/1Uibq1gSwa0jX9P9h5znTyj9eI628wOkY61VYdE22YnKQBGxeLUoIgV1FT2amd5NH3SSgwMoquHM
	2B+ZJjKyvC9RCyvkuhNnfca/k5VSqjuPaAB39aQUwjJbUm55mpY4dEkjYLv+hpy4o9+kX9+NwL+uk
	PAW1iGQ2RpX40izmC5Je+A9K+asRhrX3bXb1G/1dIftZKkXGsoZlODjuCj1258k0e6/dUrVAX+zDT
	Jfz+aPIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r8E82-007F1O-15;
	Wed, 29 Nov 2023 06:32:58 +0000
Date: Tue, 28 Nov 2023 22:32:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZWbbGjDKbZjS5Kb0@infradead.org>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
 <20231122122946.wg3jqvem6fkg3tgw@quack3>
 <ZV399sCMq+p57Yh3@infradead.org>
 <ZV6AJHd0jJ14unJn@dread.disaster.area>
 <20231123040944.GB36168@frogsfrogsfrogs>
 <ZV76nfRd6BUzXYqe@infradead.org>
 <20231129053721.GC36168@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129053721.GC36168@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 28, 2023 at 09:37:21PM -0800, Darrick J. Wong wrote:
> TBH I've been wondering what would happen if we bumped i_mappingseq on
> updates of either data or cow fork instead of the shift+or'd thing that
> we use now for writeback and/or pagecache write.
> 
> I suppose the nice thing about the current encodings is that we elide
> revalidations when the cow fork changes but mapping isn't shared.

changed?  But yes.

> 
> > > Anyway, I'll have time to go play with that (and further purging of
> > > function pointers)
> > 
> > Do we have anything where the function pointer overhead is actually
> > hurting us right now?
> 
> Not that I know of, but moving to a direct call model means that the fs
> would know based on the iomap_XXX_iter function signature whether or not
> iomap needs a srcmap; and then it can modify its iomap_begin function
> accordingly.
> 
> Right now all those rules aren't especially obvious or well documented.
> Maybe I can convince myself that improved documentation will suffice to
> eliminate Ted's confusion. :)

Well, with an iter model I think we can actually kill the srcmap
entirely, as we could be doing two separate overlapping iterations at
the same time.  Which would probably be nice for large unaligned writes
as the write size won't be limited by the existing mapping only used
to read in the unaligned blocks at the beginning end end.

> > One thing I'd like to move to is to merge the iomap_begin and iomap_end
> > callbacks into one similar to willy's series from 2020.  The big
> 
> Got a link to that?  I need my memory refreshed, having DROP TABLE MEM2020;
> pretty please.

https://lore.kernel.org/all/20200811205314.GF6107@magnolia/T/


