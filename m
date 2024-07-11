Return-Path: <linux-fsdevel+bounces-23537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154F692DF05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 06:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97DEBB2197A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 04:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4409374CB;
	Thu, 11 Jul 2024 04:00:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD5882B;
	Thu, 11 Jul 2024 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670410; cv=none; b=jLzMx6PFtNF47vE98on0mycjVVdsT4+t5LIzl/oR9CZipiLRT+2wFTtZ2DMfIm+ngQF3LbX/5aicke/CwyfvRggPn9sC9akbuWoacmsjuaIqjDItzJIit12QJasWRhfo64jTQbrrVsgC1tdjRgN51MU8Lg5tupF+DwJDkugzzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670410; c=relaxed/simple;
	bh=78GW7mMadIJE3i0wwAJqmhw5mOAPyaGM1oxM/4v8FgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2f7ZT5VBXOE/9inuziYTpYfVNtL1UqAZfzS7kQG5VogPI4EHoKKOnwq563qgEvlHqVt9FOpN/XAKbue4XHtyvbQOTC36V45lljXZpJQiJ512x84cvlO5tDeTTWG/Cf5jAz8Q6rkkySDSSxRgjyoFv44XszIB1VyjBTH5+gSHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E18D168AA6; Thu, 11 Jul 2024 05:59:56 +0200 (CEST)
Date: Thu, 11 Jul 2024 05:59:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
Message-ID: <20240711035956.GA2556@lst.de>
References: <20240705162450.3481169-1-john.g.garry@oracle.com> <20240705162450.3481169-8-john.g.garry@oracle.com> <20240711025958.GJ612460@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711025958.GJ612460@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 10, 2024 at 07:59:58PM -0700, Darrick J. Wong wrote:
> Hmm.  If we don't support reflink + forcealign ATM, then shouldn't the
> superblock verifier or xfs_fs_fill_super fail the mount so that old
> kernels won't abruptly emit EFSCORRUPTED errors if a future kernel adds
> support for forcealign'd cow and starts writing out files with both
> iflags set?

Yes.

> That said, if the bs>ps patchset lands, then I think forcealign cow is
> a simple matter of setting the min folio order to the forcealign size
> and making sure that we always write out entire folios if any of the
> blocks cached by the folio is shared.  Direct writes to forcealigned
> shared files probably has to be aligned to the forcealign size or fall
> back to buffered writes for cow.

It has all the same problems as rtexsize > 1 + reflink, and suppoting
it will require raiding your patch stack.  Or better just wait until
we've got all that in now that we're actively working on it.

