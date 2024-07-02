Return-Path: <linux-fsdevel+bounces-22936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35455923D1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 14:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673BB1C22AE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6A15D5B6;
	Tue,  2 Jul 2024 12:02:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C371C686;
	Tue,  2 Jul 2024 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921779; cv=none; b=ACRw50Iij5Fl9Wsp+Z2TRldEjI7QJliJJoHvO9nN1Ts48LxC01ftaGLgtPmBspOvCE4A2CU2tPLwfUxXClIGWxC03PB6+pMMi06mDcJPOwiDlHVL4REj4uhLwyZOrn3JHm0N7LKP7mkCyA9k3Wx1mhghI+VQtxXjjsCpOsn/KwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921779; c=relaxed/simple;
	bh=0iI8lxDGNyMCXms2D+NpXyjFS1o8mMf1bWr0prHRedA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL9Azb3ee7zDmufskIAv/jS3WGAtY0I20mJfYO1PwVT15ZkI0cfODe02D9RtTSsDquJTUjw0lJoUe57L3SVzpFuFcSuQ01ZPsgAeTimH1C+4ZsJp2FXGMHlHXufEQvul2+L9juLhNWyqs1tYRlhdXaK3naUFsqPwHv/elFXvJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1ABC168AA6; Tue,  2 Jul 2024 14:02:51 +0200 (CEST)
Date: Tue, 2 Jul 2024 14:02:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christoph Hellwig <hch@lst.de>, david@fromorbit.com,
	willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs >
 system page size
Message-ID: <20240702120250.GA17373@lst.de>
References: <20240625114420.719014-1-kernel@pankajraghav.com> <20240625114420.719014-7-kernel@pankajraghav.com> <20240702074203.GA29410@lst.de> <20240702101556.jdi5anyr3v5zngnv@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702101556.jdi5anyr3v5zngnv@quentin>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 02, 2024 at 10:15:56AM +0000, Pankaj Raghav (Samsung) wrote:
> Willy suggested we could use raw pages as we don't need the metadata
> from using a folio. [0]

Ok, that feels weird but I'll defer to his opinion in that case.

> > > +	/*
> > > +	 * Max block size supported is 64k
> > > +	 */
> > > +	WARN_ON_ONCE(len > ZERO_PAGE_64K_SIZE);
> > 
> > 
> > A WARN_ON without actually erroring out here is highly dangerous. 
> 
> I agree but I think we decided that we are safe with 64k for now as fs 
> that uses iomap will not have a block size > 64k. 
> 
> But this function needs some changes when we decide to go beyond 64k
> by returning error instead of not returning anything. 
> Until then WARN_ON_ONCE would be a good stop gap for people developing
> the feature to go beyond 64k block size[1]. 

Sure, but please make it return an error and return that instead of
just warning and going beyond the allocated page.


