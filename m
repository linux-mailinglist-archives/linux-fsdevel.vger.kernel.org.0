Return-Path: <linux-fsdevel+bounces-68529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C7BC5E096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 16:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158ED4A01FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8968E344030;
	Fri, 14 Nov 2025 15:36:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91A32573E;
	Fri, 14 Nov 2025 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134611; cv=none; b=Y1r3nHLouYxc7T9Vud0vfpQ44jCFkdGnIYxVWTIOFnoTw8az1DPs4N664UWIoeKCVkW08wCYCrT0IISTTmioUaHamrtdVLBUiXxotKTCIalDf3DFkBqyXwTsyEIwIdJ3p3u04Fs5SopxJYkCChnfGrp5jg2SqhZK5s8WWAG4Kxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134611; c=relaxed/simple;
	bh=puvLXh5u8I8NJkQFC3SxNEhEGzv/w9+sDClfLtptJ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHViGaRnD8sByu8F7YijPjFYy6xUYpS2USDCbt/+rFlnSGxDAxzA8We1IfF0Xo8YWe8A8ewEMWPk4qeQJnfqTaX9QqHoCE/r9R2kPh6ywPD0EHnfiAnn43/GKf67T1V/S63eSjClZnTjDNKlvKWLwt8703pBzi/Jw4zaKa5ANNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A84A4227A88; Fri, 14 Nov 2025 16:36:44 +0100 (CET)
Date: Fri, 14 Nov 2025 16:36:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Keith Busch <kbusch@kernel.org>, Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251114153644.GA31395@lst.de>
References: <20251031130050.GA15719@lst.de> <aQTcb-0VtWLx6ghD@kbusch-mbp> <20251031164701.GA27481@lst.de> <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj> <20251103122111.GA17600@lst.de> <aRYXuwtSQUz6buBs@redhat.com> <20251114053943.GA26898@lst.de> <aRb2g3VLjz1Q_rLa@redhat.com> <20251114120152.GA13689@lst.de> <aRchGBJA1ExoGi8W@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRchGBJA1ExoGi8W@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 14, 2025 at 01:31:20PM +0100, Kevin Wolf wrote:
> My main point above was that RAID and (potentially passed through) PI
> are independent of each other and I think that's still true with or
> without multiple stability levels.
> 
> If you don't have these levels, you just have to treat level 1 and 2 the
> same, i.e. bounce all the time if the kernel needs the guarantee (which
> is not for userspace PI, unless the same request needs the bounce buffer
> for another reason in a different place like RAID). That might be less
> optimal, but still correct and better than what happens today because at
> least you don't bounce for level 0 any more.

Agreed.

> If there is something you can optimise by delegating the responsibility
> to userspace in some cases - like you can prove that only the
> application itself would be harmed by doing things wrong - then having
> level 1 separate could certainly be interesting. In this case, I'd
> consider adding an RWF_* flag for userspace to make the promise even
> outside PI passthrough. But while potentially worthwhile, it feels like
> this is a separate optimisation from what you tried to address here.

Agreed as well.

In fact I'm kinda lost what we're even arguing about :)


