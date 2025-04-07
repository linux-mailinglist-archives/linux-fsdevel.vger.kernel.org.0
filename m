Return-Path: <linux-fsdevel+bounces-45840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89469A7D878
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 10:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA513B14B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723C8211460;
	Mon,  7 Apr 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olIPwW5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D431494CF;
	Mon,  7 Apr 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015802; cv=none; b=UqhZ/S7K7ClgXa0vxm2N1zMxl4cLItsNfFMwVqr6Q/Tn7MZNSvFbibdQ3Je8qYXXULOgW3DQQ8J9JxUA1zsBAbih4wIxb4BMvEnrZvq2AwW2g51krClRy4jUsQz0Hy5gT7L4nNaX27E2GranOAhvQnlexYsf9+tpdf7gWD7FOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015802; c=relaxed/simple;
	bh=Uyrr8zYuPQkJaJbPKpCv0EmhU3pSrLmJrMOBSFZCoj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bALteksAGqY+eCDh5MTWq+KeTUTwRjDS6F4FSMD3mzAvTf/gOdN5lni9qffQS1OyRWVLJwycqxXWXwP1RetnYsgSjwSkmTj+QjkVEyG7KIcC0wXBohJjdZnQo2eA1/4SXxPSG+MWoboIhUDWD/EdtYJn+75snx+5emOWQP4INgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=olIPwW5A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dCalhDEuS5aSz6JxLgjugXvo48qDq+7TQIecVQCXiLI=; b=olIPwW5A9QVy5ZxragfAYlfoN/
	YW2Jc/nUPItzcwqQqshzLQFeXwMhfkL43UwJZra3d2uE2i4fJKD8PPJgH6cH9WATWC559P60SIkVZ
	wP1p9DCbS0//3GlhrFv4txAyzxJpRoetWEtkTDSftbVvQ/Qsm/s6JSqDHeoJicO7p8qTiYZo6f1b9
	ajdrwsYK2CUAdUHguz3YASC5BHBEcJ82TKsGXSTEwGR5a2e1f4a+snkPDM27V1uNvDDKcqWwpqfxc
	2Y5Y8Gx1NbJeRanxcrTrFLoxMpWBrh4AcgimJ4Nil4rhZgdp5caA7hsYr4K2WogYfMPtzT1Im45g4
	qPBXj6wA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1iB6-0000000H4au-2vrb;
	Mon, 07 Apr 2025 08:50:00 +0000
Date: Mon, 7 Apr 2025 01:50:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org, djwong@kernel.org, ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: iomap: Add missing flags description
Message-ID: <Z_ORuFqb-KErLgEG@infradead.org>
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
 <cfd156b3-e166-4f2c-9cb2-c3dfd29c7f5b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd156b3-e166-4f2c-9cb2-c3dfd29c7f5b@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 04, 2025 at 10:36:32AM +0100, John Garry wrote:
> > @@ -243,6 +243,11 @@ The fields are as follows:
> >        regular file data.
> >        This is only useful for FIEMAP.
> > +   * **IOMAP_F_BOUNDARY**: This indicates that I/O and I/O completions
> > +     for this iomap must never be merged with the mapping before it.
> 
> This is just effectively the same comment as in the code - what's the use in
> this?

Darrick asked for this file to have full comments.  I'm more on your
side here as a lot of this seem redundant.

> 
> > +     Currently XFS uses this to prevent merging of ioends across RTG
> > +     (realtime group) boundaries.
> > +
> >      * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
> >        be set by the filesystem for its own purposes.
> 
> Is this comment now out of date according to your change in 923936efeb74?

Also we probably should not detail file system behavior here, but a
high level description of what it is useful.


