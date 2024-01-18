Return-Path: <linux-fsdevel+bounces-8269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE6A831E94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 18:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0118B24EA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358E2D056;
	Thu, 18 Jan 2024 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/OfCOSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4002C68C;
	Thu, 18 Jan 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599666; cv=none; b=up0K+WYR7eMRSsgcP/jKPVkOGlnkc37sBL+MsZZ/hgByttf+05ZZwM6bMownNjnfhohKzrMVuSQZ4SeXhnDZBKYl6mJ/cYdyyI0aAUtgVzmyjrivIQ+U5uVcCrtmCtnQPo/bKuvwk+nsYF3Ibno+2bl25zam5NNTQM9fb/yOcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599666; c=relaxed/simple;
	bh=AgYJhYaWCtIL15p5uDR2tgMOlRRXTsWC14GVmp55svg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zfy1hRBjaaRQsHBVcnPhXON6jiAr6DV5nJ4DiMx853filHaNtnxmTQUQgn5PwzkwHpalfX+xNbORFqX9P6NHv6A9fTUaqGFxIN65hZmBSP+9q3ELHQ+Df4iKU1+fyxSbPdircWsS4H2xo5wA75YC4d7sJUHooq3kLULPnHJCYWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/OfCOSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D33C433F1;
	Thu, 18 Jan 2024 17:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705599665;
	bh=AgYJhYaWCtIL15p5uDR2tgMOlRRXTsWC14GVmp55svg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/OfCOSBrO4roL7YHt1XmgOcSabEJdX0Vb9v0O4QW4Htj1VAY0NyQ9aexqLUNVMCS
	 4fkoi1m0wxpEpA49O08mgo+Z0VukvwyARPrei9+o+b/1466dj5gXkk5K+SiyE6olsr
	 tM0L0YVtsKm/N0mlgSfMCd04NLxAop0lJoa2XXOdmLExbYAZswrW3WgIy9tX/qLtbp
	 dZZvl5YVrpqUmefmg/xOIjqI1s5wB5/XNCz1yVqIWkF/8eqRbRMgI+BrZN2ao2fRFV
	 M5N2VWFLix69EUukbJ52bCbunK1i4A0bpn5Pku7NY4Mxg5LzIJgF0yunU9KVgl1/RR
	 eJyfVzyD378xA==
Date: Thu, 18 Jan 2024 18:41:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH DRAFT RFC 34/34] buffer: port block device access to
 files and get rid of bd_inode access
Message-ID: <20240118-imponieren-alzheimer-57894968e4de@brauner>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-34-6c8ee55fb6ef@kernel.org>
 <20240117163254.xfcqpkpy3ok5blui@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117163254.xfcqpkpy3ok5blui@quack3>

On Wed, Jan 17, 2024 at 05:32:54PM +0100, Jan Kara wrote:
> > @@ -68,6 +69,7 @@ struct buffer_head {
> >  	size_t b_size;			/* size of mapping */
> >  	char *b_data;			/* pointer to data within the page */
> >  
> > +	struct file *f_b_bdev;
> >  	struct block_device *b_bdev;
> >  	bh_end_io_t *b_end_io;		/* I/O completion */
> >   	void *b_private;		/* reserved for b_end_io */
> 
> It is kind of annoying to have bdev duplicated in every buffer_head.
> Perhaps we can get rid of b_bdev?

Yes, that's ultimately the goal similar for struct super_block, I think
and struct iomap. But please see:
https://lore.kernel.org/r/20240118-gemustert-aalen-ee71d0c69826@brauner
as I'm still not yet clear on some details there.

