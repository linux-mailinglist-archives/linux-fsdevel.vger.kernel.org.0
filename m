Return-Path: <linux-fsdevel+bounces-29743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0C97D4DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 13:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77BA285D89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B214A143878;
	Fri, 20 Sep 2024 11:31:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECFB24B4A;
	Fri, 20 Sep 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831870; cv=none; b=O/quJsp0oSBuYT7wWwO1fMGAf6lChZElr1Kz8fKlF/Qhhcl/xmCmhz07k/jw4cYhDCyrMDVu2zqUHfYziPqO7WdUYPiB1Fh7B9MYtQGq1Frst5tTMm4f5MMLItpGdUOClyQDH572xTnpW8m3LKMXZKB1eqm68QYo/U6dAHafUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831870; c=relaxed/simple;
	bh=00rQ0XCE3Dhcpny0JBLhhPgjHQyuunnfQ+U2ui6jIzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKxBXD0z+wKMVzP0N/rhsD/QarZUYZQA6gxdyEFTmulxuCJ2K5OBJySB91WjZZAJkt2b+3c0e8UWhTJkDD/GrE/souWb1eWeD91NHfx6/Z2mXOZ8EBZwPKUsfu4RwKem8ra/Rh7FcH46rj/vTI6ng7siJf6goxz2eWOFlUohTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 195B9227AA8; Fri, 20 Sep 2024 13:31:04 +0200 (CEST)
Date: Fri, 20 Sep 2024 13:31:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs: factor out a xfs_file_write_zero_eof helper
Message-ID: <20240920113103.GA24285@lst.de>
References: <20240910043949.3481298-1-hch@lst.de> <20240910043949.3481298-7-hch@lst.de> <20240917211419.GC182177@frogsfrogsfrogs> <20240918050936.GA31238@lst.de> <ZuzBElgA34H7FAEl@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuzBElgA34H7FAEl@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Sep 20, 2024 at 10:25:54AM +1000, Dave Chinner wrote:
> > Sure.  If you have a better idea I'm all ears, too.
> 
> I would have thought a -EBUSY error would have been appropriate.
> i.e. there was an extending write in progress (busy doing IO) so we
> couldn't perform the zeroing operation and hence the write needs to
> be restarted now the IO has been drained...

I can't say that I'm a huge fan of overloading errno values when there
is quite a few call that could return basically arbitrary errors in
the chain.  See the "fix a DEBUG-only assert failure in xfs/538"
series for when this kind of errno overloading causes problems later
on in unexpected ways.

