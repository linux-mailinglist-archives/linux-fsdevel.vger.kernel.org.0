Return-Path: <linux-fsdevel+bounces-73701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61112D1EF34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A28F53075CB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA10F39447C;
	Wed, 14 Jan 2026 13:01:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050D286A9;
	Wed, 14 Jan 2026 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768395676; cv=none; b=jsEnX+qnjInVbiw5aC8jCAIxlGN3ggmmqUciab7Oe5HJXKqlleygOaCNigFaOtMv/jBzlmyRgccb9frbcPRlOqoct5K96T135/XzNA7xQL28kLOxpI9Jxm+VKNn+ooFBPUKSIuxNrthPhuoH/O6/HpiQxVmmuwQyrZ047Go/7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768395676; c=relaxed/simple;
	bh=pqnPdtGOmy4dMCy+5meBWTXgr3Lr9Iqe3Z2a5rpOcog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJlcsTrH7PGycMIUfMctqOx9RvnbqpUK7naW1LyPrBT1VrjmyepiiOcoO4/pfuSKjG4s3lILD8kkX2IGj8uX/t1gCQV5tAxfh2wHtDIU3BavQhrmQLrkCJTiBzxtfesG0ungd/kDN+YlVXyuPp2ptK9r//K2tfQQ7M3imELvz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CC26227AA8; Wed, 14 Jan 2026 14:01:10 +0100 (CET)
Date: Wed, 14 Jan 2026 14:01:09 +0100
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, WenRuo Qu <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 02/14] block: open code bio_add_page and fix handling
 of mismatching P2P ranges
Message-ID: <20260114130109.GA6321@lst.de>
References: <20260114074145.3396036-1-hch@lst.de> <20260114074145.3396036-3-hch@lst.de> <e9ac4917-ed9b-43ec-8628-bd664c9b7e13@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9ac4917-ed9b-43ec-8628-bd664c9b7e13@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 12:46:06PM +0000, Johannes Thumshirn wrote:
> > +		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
> > +		__bio_add_page(bio, pages[i], len, offset);
> 
> Can you add a comment here, that this is a deliberately nearly a 
> duplication of bio_add_page()? Otherwise someone thinking he/she is 
> smart will de-duplicate it later again.

This gets morphed into a function not taking a bio in lib/ right after
this, at which point that should be obvious :)


