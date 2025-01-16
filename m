Return-Path: <linux-fsdevel+bounces-39352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2915DA131FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C57A18877D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 04:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DB313C9B3;
	Thu, 16 Jan 2025 04:32:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE3C17C8B;
	Thu, 16 Jan 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737001955; cv=none; b=QtaLdBjjJYYy7Ns2ZZ+OO1L3HySjYmsiJ2RUuwa/yyN6lPRk5xMH3vgdvNiNWk7AJAvMv3oTJy+dXVbO2NkOSFXi/X5l73xhGYXepydzydvxwZhi64FaUiQb6xgA8GrvggnlmPCpytt2CZ9TAQx414fVipVyre7tbOT/LzZ8sbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737001955; c=relaxed/simple;
	bh=QU+sI6fZ3PI0hcZl3OWlnHw+SfJVqZnNQDuQYSGwWac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NavYB3iwltvrPiVyGAbnzh8/lYC/6zb5yMld+UqGPSuk+QSsuzkxp1hBb+a7yUHwAp86s6AP8h3YqJq2fFyZaVHXbSz7Xwm60bQlMhiN7uVjUaBairVT8diXfDAWQS9GPY1ooKOF9KOlkCEpRlLMiXpa12sOm7oAZ9tHuzzja5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 050CA68BEB; Thu, 16 Jan 2025 05:32:27 +0100 (CET)
Date: Thu, 16 Jan 2025 05:32:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
Message-ID: <20250116043226.GA23137@lst.de>
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-9-hch@lst.de> <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 15, 2025 at 02:35:03PM +0100, Andreas Gruenbacher wrote:
> > +++ b/fs/gfs2/quota.c
> > @@ -236,8 +236,7 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, str
> >                 return NULL;
> >
> >         qd->qd_sbd = sdp;
> > -       qd->qd_lockref.count = 0;
> > -       spin_lock_init(&qd->qd_lockref.lock);
> > +       lockref_init(&qd->qd_lockref, 0);
> 
> Hmm, initializing count to 0 seems to be the odd case and it's fairly
> simple to change gfs2 to work with an initial value of 1. I wonder if
> lockref_init() should really have a count argument.

Well, if you can fix it to start with 1 we could start out with 1
as the default.  FYI, I also didn't touch the other gfs2 lockref
because it initialize the lock in the slab init_once callback and
the count on every initialization.


