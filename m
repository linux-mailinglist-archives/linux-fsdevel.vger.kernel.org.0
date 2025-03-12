Return-Path: <linux-fsdevel+bounces-43801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6335A5DE4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61BB3B887A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DC924A052;
	Wed, 12 Mar 2025 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SEiQqttB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49A42A82;
	Wed, 12 Mar 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787152; cv=none; b=q2egaReSTyQROx1R/mXPaCPr/dyFBGKCHesrGAQeJ7720AIozmxpE8ayB4WKJ2YjzZaa/fTgOmdVOsfBaGOewNcZCO6g1NJ2GHOB6VwDhTVvyN6bm1h5paOyFmMnulH+LFAU1W5IUl/XASMOS+L7FIj7uJzU6JI8JkeqNZpPWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787152; c=relaxed/simple;
	bh=SXBBwLCdEekPpY3LbUOfpucKTNYYZoZVYFcr/Y5RhAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJyX5lX+BLR5ZQpnl4TuAo6R2RYTAmO7xS3WjnPD6YPbhF2yTJaB3ycKVWfl2X4iVYIZMPLX2LrR4G8XP0lMkDxoEMvp3x+35FCfuwPNgAvZGOhAc8BBs1CD69BHZzVg3ztzm18Sy1CkSfzvfboHZuMXN750o3pVKhoDMNfR/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SEiQqttB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=heOxSdjifVC4fQFHjBuUsKHkLMZESVzEVVrY7e7/bgk=; b=SEiQqttB67WyH7f7KTD/9fusKj
	Z3eLlccbVuO6rr1tSvQvElYHryeSdLwNzJs5EfgonWu328yA+xwHX/6vwe06G+GM0p4snka67Q62A
	RocnhEmVd+qd1rezcXC9C5DfwqBnHXPLT+ZSAI9bwyTBgiV5bs4u3DmNsynLZWAaIHkA7NW8lpQwQ
	+OMptCGNV2rVoObMrf3iTN4z1hsLopgDJgeMlhApM1d2aIgfoZm3O13vWjzimVGTG6It90ERsYoQU
	J961uA3BTxOYQqXE1WiLmfU3E68aYz6c/ScKuoiIciLRPm60U4xR4XqlYMl5Wem1B1VNW0Tekx7kf
	lDKpzDNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsMP8-00000008c27-1XG1;
	Wed, 12 Mar 2025 13:45:50 +0000
Date: Wed, 12 Mar 2025 06:45:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 04/10] xfs: Reflink CoW-based atomic write support
Message-ID: <Z9GQDhRn3klzmDpo@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-5-john.g.garry@oracle.com>
 <Z9E3Sbh4AWm1C1IQ@infradead.org>
 <81247acc-f0fe-4d10-a0cd-bbd5b792267f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81247acc-f0fe-4d10-a0cd-bbd5b792267f@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 09:13:45AM +0000, John Garry wrote:
> > > +	if (error || (!*shared && !atomic_sw))
> > 
> > And it's pnly used once.  Basically is is used to force COW, right?
> 
> Yes, we force it. Indeed, I think that is term you used a long time ago in
> your RFC for atomic file updates.
> 
> But that flag is being used to set XFS_BMAPI_EXTSZALIGN, so feels like a bit
> of a disconnect as why we would set XFS_BMAPI_EXTSZALIGN for "forced cow". I
> would need to spell that out.

Maybe use two flags for that even if they currently are set together?
Note that this would go away if we'd always align extsize hinted
allocations, which I suspect is a good idea (even if I'm not 100% sure
about it).


