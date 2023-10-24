Return-Path: <linux-fsdevel+bounces-1102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79C7D5505
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DBE1C20BFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399030CF1;
	Tue, 24 Oct 2023 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MP/sNQJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313C2C84D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 15:14:46 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC02EA;
	Tue, 24 Oct 2023 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qpmLAMe3UIUUFs6yiDrqQIACnDygj9UeXkkyfRKdiWA=; b=MP/sNQJ7Oj5bKDcaH/zYzk9b5J
	XJxHdA+lP/zEfA0tHclyq0C6at32laH3EkiCarOa9+mPovCKu8OCXzqk8BZtL9OMuYhylfjQlTEhh
	fpHYd2/nka1it6G++Jm13WWShHNNO81UfVEf7+VWE4VizuayJAQwpsxezeDNdhbBuHs+R/i2HK0O6
	HjnFhzLWlDQdCqjEuLHir5Gwys9wvbLh5wCAeYmKzn9t19zo/ygagFNJaE47wYrpsw0SQBdci6Thp
	EoZPjTGXts/kIbik96TAuyy9mP0JoxWgAKqj21RxKs19czqCODP8ExZelyS/wwtte7Tg4IZuuIjMM
	qJl+Bm8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qvJ79-003Bjb-PR; Tue, 24 Oct 2023 15:14:39 +0000
Date: Tue, 24 Oct 2023 16:14:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] xfs: respect the stable writes flag on the RT device
Message-ID: <ZTffX8jYEsVZTZK6@casper.infradead.org>
References: <20231024064416.897956-1-hch@lst.de>
 <20231024064416.897956-4-hch@lst.de>
 <20231024150904.GA3195650@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024150904.GA3195650@frogsfrogsfrogs>

On Tue, Oct 24, 2023 at 08:09:04AM -0700, Darrick J. Wong wrote:
> > +	if (S_ISREG(VFS_I(ip)->i_mode) &&
> > +	    XFS_IS_REALTIME_INODE(ip) != (fa->fsx_xflags & FS_XFLAG_REALTIME))
> > +		xfs_update_stable_writes(ip);
> 
> Hmm.  Won't the masking operation here result in the if test comparing 0
> or FS_XFLAG_REALTIME to 0 or 1?
> 
> Oh.  FS_XFLAG_REALTIME == 1, so that's not an issue in this one case.
> That's a bit subtle though, I'd have preferred
> 
> 	    XFS_IS_REALTIME_INODE(ip) != !!(fa->fsx_xflags & FS_XFLAG_REALTIME))
> 
> to make it more obvious that the if test isn't comparing apples to
> oranges.

!= !! might be going a bit far.  Would you settle for

XFS_IS_REALTIME_INODE(ip) == !(fa->fsx_xflags & FS_XFLAG_REALTIME)

?  Although none of these read particularly nicely.  Maybe

	XFS_IS_REALTIME_INODE(ip) != ((fa->fsx_xflags & FS_XFLAG_REALTIME) == 0))

Perhaps we need a bool helper for (fa->fsx_xflags & FS_XFLAG_REALTIME)

