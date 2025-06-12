Return-Path: <linux-fsdevel+bounces-51397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDEDAD66A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 06:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4AE164332
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 04:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733A91D90C8;
	Thu, 12 Jun 2025 04:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/fbMnh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15EE19F137;
	Thu, 12 Jun 2025 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749701200; cv=none; b=EgL7lqD3VkuMgzpL8AX8swG5V7a15ROp2ukssulfhRBH6rbWYtNp98HLlad4YqDJ+IANO/zled3pPKTZ5Q1uD9/uj46mO1P8xhBRObI6vqprkwhgDiFEO28LryUuUgGqCyUqx1A/pUMlOcXRm1SixH22bwLgVRkVjXORxtbAtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749701200; c=relaxed/simple;
	bh=Q4ZfThogLrjrzXMAxDJlRiD7rOypQqZu6v0KUZrg3KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsCDlq/i4fOe7ul+e9FSLXoeSEmPWC4G7tgDkBe9Cmr0gqqOo+A5NnIshqFMveOVvEanfDh0rHqy7Jm1VCv0JSCSlpacixkS2C5oRDtLT+LXbpqkORTBFpYxDSgKcmk/VNATiNGVy909KVDIE9GbF9rSDv4HXUEPYbUTc1lq+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/fbMnh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1A7C4CEEA;
	Thu, 12 Jun 2025 04:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749701200;
	bh=Q4ZfThogLrjrzXMAxDJlRiD7rOypQqZu6v0KUZrg3KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/fbMnh6A/cjTgo7lUITahboGp1sZvt+yqQ9+dzfJ1x2SVGCkshiUIUJhObb9W2HC
	 iIwbKpuYLlrFtKoLBTyc0SYLoMmmafoJO3CtnT3oLaa5WBmnoJjz8ljuNPlsJ8tH22
	 Xb9gAO3UPl938q8TSlHmgV7h/STg+DViIZ0EDeCmE/obMMnxC7wej3kZZ29N8kJU5K
	 JhhkuOoxr2VLkHuTyb3gdjniPi5JGAW893QI0S7+tHTg0dz4W9udr69W3Hv+/B4J0m
	 HknQd6s7PeCg1lrlpK8ruUVjVFVdzOJe2xYiZdIOSrUIxJLfMtCQe3tVxsIMILghNV
	 hNH/9z2L7VF/Q==
Date: Wed, 11 Jun 2025 21:06:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/7] iomap: optional zero range dirty folio processing
Message-ID: <20250612040639.GO6156@frogsfrogsfrogs>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-4-bfoster@redhat.com>
 <20250609160420.GC6156@frogsfrogsfrogs>
 <aEgjMtAONSHz6yJT@bfoster>
 <20250610145552.GM6156@frogsfrogsfrogs>
 <aEj-HgO5BcVwb6Qc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEj-HgO5BcVwb6Qc@infradead.org>

On Tue, Jun 10, 2025 at 08:55:10PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 07:55:52AM -0700, Darrick J. Wong wrote:
> > Hrmm.  On closer examination, at least for xfs we've taken i_rwsem and
> > the invalidate_lock so I think it should be the case that you don't need
> > to revalidate.  I think the same locks are held for iomap_unshare_range
> > (mentioned elsewhere in this thread) though it doesn't apply to regular
> > pagecache writes.
> 
> We should document these assumptions, preferable using (lockdep)
> asserts.

Agreed.  I think most of iomap/buffered-io.c wants the caller to hold
i_rwsem in shared mode for reads; i_rwsem in exclusive mode for writes;
and the invalidate lock for page faults.

The big exception iirc is iomap_zero_range where you need to hold
i_rwsem and the mapping invalidate lock, right?

--D

