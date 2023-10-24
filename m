Return-Path: <linux-fsdevel+bounces-1110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6D7D57C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4811C20C78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F42438BC9;
	Tue, 24 Oct 2023 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9E2C866
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 16:17:05 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CD2118;
	Tue, 24 Oct 2023 09:17:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DCE468AA6; Tue, 24 Oct 2023 18:17:00 +0200 (CEST)
Date: Tue, 24 Oct 2023 18:16:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] xfs: respect the stable writes flag on the RT
 device
Message-ID: <20231024161659.GB20546@lst.de>
References: <20231024064416.897956-1-hch@lst.de> <20231024064416.897956-4-hch@lst.de> <20231024150904.GA3195650@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024150904.GA3195650@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 24, 2023 at 08:09:04AM -0700, Darrick J. Wong wrote:
> > +	/*
> > +	 * Make the stable writes flag match that of the device the inode
> > +	 * resides on when flipping the RT flag.
> > +	 */
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

This is all copy and pasted from a check a few lines above :)

I guess I could clean it up as well or even add a rt_flag_changed local
variable instead of duplicating the check.

> > +	/*
> > +	 * For real-time inodes update the stable write flags to that of the RT
> > +	 * device instead of the data device.
> > +	 */
> > +	if (S_ISREG(inode->i_mode) && XFS_IS_REALTIME_INODE(ip))
> > +		xfs_update_stable_writes(ip);
> 
> I wonder if xfs_update_stable_writes should become an empty function for
> the CONFIG_XFS_RT=n case, to avoid the atomic flags update?
> 
> (The extra code is probably not worth the microoptimization.)

The compiler already eliminates the code because XFS_IS_REALTIME_INODE(ip)
has a stub for CONFIG_XFS_RT=n that always returns 0.

