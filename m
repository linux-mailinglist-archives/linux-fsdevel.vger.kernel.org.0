Return-Path: <linux-fsdevel+bounces-40471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F455A23A26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA50E7A2AF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 07:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C022F14F9F4;
	Fri, 31 Jan 2025 07:30:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19342146A72;
	Fri, 31 Jan 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308629; cv=none; b=R7kqDrKiAM6CsmsspwJnV4SULWyqhUhjKFS+Xce/NPa2yqkkuX5jmGMDxzLCcaPu8Y8gky4cXb4VtkH6235rnjvW0CGal3nqfdeLZOLXHO3dbpRklTCdJkq4Y9RsgdEBtJm8Pt0AOF7XPbw+pTQSnI2mc/Bh5DmfvpgH7kv3kw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308629; c=relaxed/simple;
	bh=qNuDO0SHM2AgU5bKZ20/13qIKAE79jtfoLUxSzMM8Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx/ph8fNyjIANXmkZf1HgedFz7mBFAZ7Xb28yJCzT53rRJJ/AEefpvlO26zjrQ0E5TptTVD9qpdyrk/81bMSE/gwRnG+imS4BMRDq6Wq+kBXzg2fzhd6Us7p1blc1CRBixwv0sqoo171TCmAABOwsJ5wsLJljR1lxpB64EqU3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55D8468C4E; Fri, 31 Jan 2025 08:30:24 +0100 (CET)
Date: Fri, 31 Jan 2025 08:30:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] lockref: remove count argument of lockref_init
Message-ID: <20250131073023.GC16012@lst.de>
References: <20250129143353.1892423-1-agruenba@redhat.com> <20250129143353.1892423-4-agruenba@redhat.com> <20250129154413.GD7369@lst.de> <CAHc6FU47ToGhxxO1MzcdyL=Mcqrf-E+Wh3dwMiuL365pXSfKsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU47ToGhxxO1MzcdyL=Mcqrf-E+Wh3dwMiuL365pXSfKsg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 06:19:39PM +0100, Andreas Gruenbacher wrote:
> On Wed, Jan 29, 2025 at 4:44 PM Christoph Hellwig <hch@lst.de> wrote:
> > Maybe the lockref_init kerneldoc now needs to say that it's initialized
> > to a hold count of 1?
> 
> I always feel a bit guilty when adding a comment like "Initializes
> @lockref->count to 1" and five lines further down in the code, it says
> 'lockref->count = 1'. But okay.

It reads a bit odd, but kerneldoc comments aren't just for the reader
of the code - they also get extraced into rendered documentation.

