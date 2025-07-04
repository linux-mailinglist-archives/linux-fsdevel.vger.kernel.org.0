Return-Path: <linux-fsdevel+bounces-53980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1AEAF9AF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 20:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A411C81D2F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 18:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B7217F56;
	Fri,  4 Jul 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nkkLNYgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F41DE3B5;
	Fri,  4 Jul 2025 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751655537; cv=none; b=QLJp2wy4D/EePYYDKwqVxJNnV+yqkeip/dVtQOiyiotDupUjke4q5+Wmr2yrZXc14znAycF34yFKj+pQ++tr/KmlWOcXHECXpYJ/OlB3EIhf+dXm9D95oesQ1uUioCNI2aVa/Md8NrhGloQW8ADdUhIhDW8Yw5xDjvlH1TvecdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751655537; c=relaxed/simple;
	bh=g/rKyV7VLe4C2HnR5afRx/OqcQOwCYib/qRjPEkH9es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jhe2MiIwlT+EEIajFjrXYeZnFh+Fx/CRsPIvqcSLAtrlwa2HoZg+ey4dMyS/I02zuAPNjjBkM9EVBNAyDo9QmbHv1+sDxUnNaa6ecDS273brODPa1m0k8JZVvXaaS9nzQGzNcT1IbgsbK88erJGqcXPfnFAnn7xsoQGMjmyAunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nkkLNYgu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7bVe6j5MuC+VkuFyICwiR2qNPRIfLIced8O4pJKdKJM=; b=nkkLNYgupLUB0HceleDG4+xZ8K
	8+rCVo+Wnv1djgMWa/6V0IIKMt61rZR57bumIJwXVxyTvzBmRpWqENoLf9A4rsgK9G8QaCowiYEnX
	O24sSvtcYTqooU30yfDhfbgQVHJ+sq6gM44CNK2i6w5caEXljf3eOCNknwWrWKAsufevfDcebvsw+
	ACaIHJEIO3H1mo90JKdImUkUjecb2aYbrBJnQkGA0dMa8oD/aL9DSdy7P14jVtVk+SOpTE7x8j5Hg
	Bm7puEHd08gAlXZdQ+21n0EwF/CHmzy1G54pkDJctj3LMXIa9LabTK6XGlrLKm/cqHmFgztnpSNsL
	JbihNqAA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXlcC-00000000PPj-2Fpn;
	Fri, 04 Jul 2025 18:58:28 +0000
Date: Fri, 4 Jul 2025 19:58:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Groves <John@groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 18/18] famfs_fuse: Add documentation
Message-ID: <aGgkVA81Zms8Xgel@casper.infradead.org>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-19-john@groves.net>
 <aGcf4AhEZTJXbEg3@archie.me>
 <87ecuwk83h.fsf@trenco.lwn.net>
 <aGdQM-lcBo6T5Hog@archie.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGdQM-lcBo6T5Hog@archie.me>

On Fri, Jul 04, 2025 at 10:53:23AM +0700, Bagas Sanjaya wrote:
> On Thu, Jul 03, 2025 at 08:22:58PM -0600, Jonathan Corbet wrote:
> > Bagas.  Stop.
> > 
> > John has written documentation, that is great.  Do not add needless
> > friction to this process.  Seriously.
> > 
> > Why do I have to keep telling you this?
> 
> Cause I'm more of perfectionist (detail-oriented)...

Reviews aren't about you.  They're about producing a better patch.
Do your reviews produce better patches or do they make the perfect the
enemy of the good?

