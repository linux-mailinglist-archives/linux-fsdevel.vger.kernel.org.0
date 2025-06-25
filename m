Return-Path: <linux-fsdevel+bounces-52855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A5BAE796B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6525B16F56A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5826D20DD42;
	Wed, 25 Jun 2025 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH1n489F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF917A2F8;
	Wed, 25 Jun 2025 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838669; cv=none; b=Rj0+ia9byQxn2z5D8H3PbMEpueiECNGUrtFklZeksxGTEdW0GZkJeiGpWr+RxZ30sjMp6HPvM0lyh4IVybmbk8p4M5Agmo5bHvtChN2TA++j3uA0RnVTCvOv5FXJ9dLIC0Qw4sbZtOw7PKlE3TjGAOW/wXBaJPZvp03403ZAUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838669; c=relaxed/simple;
	bh=33Db58Zgs1Us82FoEGQ+AOZm9l1WltZ90kNW2vjvy6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS5WfnInt9dke/uC59OgncX13QYCuAVzQ2qrLyS9c6mgrwxQ6mNZmkW9dbox6UtaJZjGObSL5lNcwYaIQn5cQAycRPsZB4gZWOo1+CWF7KQaXqc9q4trWPdOZJIFvzRtwgKx/gKlLVqkq/Bzv8dsKomT73Q6I68fSHucxFCK1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH1n489F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A09C4CEEA;
	Wed, 25 Jun 2025 08:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750838669;
	bh=33Db58Zgs1Us82FoEGQ+AOZm9l1WltZ90kNW2vjvy6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iH1n489FRT/VUDCzbZstkBsRFo5c8F/QxvDELXrmnB0il6WHte0vIcyu5rPE+DJtw
	 Cxj+2D7s/QNd1hV2OSvnvUCYXs9f+HD2SqK0g+PiI1SvSgeqDm9nok2idfvm+VXf06
	 4OdwhvFB5kpZfqgJ+GdVYC2Ml0cj3Q56rUKQw4+RYwzv1PVFnVnNCqPmZRn6zEJ4My
	 P7N7u+Xh82fg35P2Nz7WEIWKCtFSLfnHs513dkhYS7po6+vuc+GxIDdMOYuSQg1QQL
	 OCxmz9soe8yvYONFgmprZloT7OqCjIdaLjJriPpYTxtdDX02YuE5PBV9CLKzDU5KrF
	 x8SDdin5EAkhg==
Date: Wed, 25 Jun 2025 10:04:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>, 
	"tytso@mit.edu" <tytso@mit.edu>, "hch@infradead.org" <hch@infradead.org>, 
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, 
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net" <tursulin@ursulin.net>, 
	"airlied@gmail.com" <airlied@gmail.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"chentao325@qq.com" <chentao325@qq.com>
Subject: Re: [PATCH v2 3/5] fs: change write_begin/write_end interface to
 take struct kiocb *
Message-ID: <20250625-erstklassig-stilvoll-273282f0dd1b@brauner>
References: <20250624121149.2927-1-chentaotao@didiglobal.com>
 <20250624121149.2927-4-chentaotao@didiglobal.com>
 <aFqfZ9hiiW4qnYtO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFqfZ9hiiW4qnYtO@casper.infradead.org>

On Tue, Jun 24, 2025 at 01:51:51PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 24, 2025 at 12:12:08PM +0000, 陈涛涛 Taotao Chen wrote:
> > -static int blkdev_write_end(struct file *file, struct address_space *mapping,
> > +static int blkdev_write_end(struct kiocb *iocb, struct address_space *mapping,
> >  		loff_t pos, unsigned len, unsigned copied, struct folio *folio,
> >  		void *fsdata)
> >  {
> >  	int ret;
> > -	ret = block_write_end(file, mapping, pos, len, copied, folio, fsdata);
> > +	ret = block_write_end(iocb->ki_filp, mapping, pos, len, copied, folio, fsdata);
> 
> ... huh.  I thought block_write_end() had to have the same prototype as
> ->write_end because it was used by some filesystems as the ->write_end.
> I see that's not true (any more?).  Maybe I was confused with
> generic_write_end().  Anyway, block_write_end() doesn't use it's file
> argument, and never will, so we can just remove it.
> 
> > +++ b/include/linux/fs.h
> > @@ -446,10 +446,10 @@ struct address_space_operations {
> >  
> >  	void (*readahead)(struct readahead_control *);
> >  
> > -	int (*write_begin)(struct file *, struct address_space *mapping,
> > +	int (*write_begin)(struct kiocb *, struct address_space *mapping,
> >  				loff_t pos, unsigned len,
> >  				struct folio **foliop, void **fsdata);
> > -	int (*write_end)(struct file *, struct address_space *mapping,
> > +	int (*write_end)(struct kiocb *, struct address_space *mapping,
> >  				loff_t pos, unsigned len, unsigned copied,
> >  				struct folio *folio, void *fsdata);
> 
> Should we make this a 'const struct kiocb *'?  I don't see a need for
> filesystems to be allowed to modify the kiocb in future, but perhaps
> other people have different opinions.

Given I picked up Willy's change I'll wait for a resubmit of this series
on top of vfs-6.17.misc unless I hear otherwise?

