Return-Path: <linux-fsdevel+bounces-51222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D382AD49C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 05:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972FD3A6018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 03:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A920766C;
	Wed, 11 Jun 2025 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dtSQsPco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70315574E;
	Wed, 11 Jun 2025 03:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614053; cv=none; b=MLcKNBb2Bksd9tJlanhFv8GI1mhoNGTY3s1aqUOwb86oiDdZODJjj+KWMT6i/H/UQtz3tjLeS4PqDe2Tr70Pee/sO1ORDk3trN8Lc+DJDR6YM9Y//Gl0Aoqerm9jz8tCrtAfp+ogg36wpYuUHCao8etaAppLhTrdv2Vsn6ZS5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614053; c=relaxed/simple;
	bh=7tFQgS7Ma9dG43uguRPEKDy9D2/IM3aDHYf9xCGr8qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UENhC9CDmfWJWSrgkni3jUoPusCE0EWzj2z/h/O0Xiu5qxHgXfqPACI8YMrK0DT624Gr9fGXduxDqYCksMGBvHy93yZ6Fuea8ADl8GS7v7EJu0SEDxvVWCfS1O3AJ8YKtsMZBD2DgA621vhpKs3kceKrYgX19EzKZcmfN5FeOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dtSQsPco; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MprDUbh+gGPhemE6iohYc3WODyPSYTtQz588hZeuMn4=; b=dtSQsPcojptqxJG/Gwd89Rtc8G
	D8nGFwBKrCEyWneenM2ZTgRL6+Q44f53zDo2Yt5pKgI/jt99Xma+tgZHyemBAMO728PkTseH3cHlk
	wRV1UwegwyHyfiuCU64NNLpUtnaFQFHYHEFJhBFRjeogCh1w0VxD5SUFFyHHylLtRNg6Ac0y2lcJY
	bMT9YhCvJfpmpWauQPekyhAwnl6Xcr9Kqu+uU3qTSnNUKveCkul3ykvQugyv+8rC8X2dqvIb+rJm3
	vhu4z+xnZIGZbd2y4kFd+YR5+U+JFx1JSh/Sho2moyV/jEEqbm0F36JBtapmRygvadOd2Na+7rSN2
	+cuj2/WQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCXT-00000008maB-2bqn;
	Wed, 11 Jun 2025 03:54:11 +0000
Date: Tue, 10 Jun 2025 20:54:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/7] iomap: optional zero range dirty folio processing
Message-ID: <aEj947cy2re9cqZN@infradead.org>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-4-bfoster@redhat.com>
 <20250609160420.GC6156@frogsfrogsfrogs>
 <aEgjMtAONSHz6yJT@bfoster>
 <aEgzJgwRDsvlfhA1@infradead.org>
 <aEg-9ygiDrIATmx3@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEg-9ygiDrIATmx3@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 10:19:35AM -0400, Brian Foster wrote:
> > On thing that the batch would be extremely useful for is making
> > iomap_file_unshare not totally suck by reading in all folios for a
> > range (not just the dirty ones) similar to the filemap_read path
> > instead of synchronously reading one block at a time.
> > 
> 
> I can add it to the list to look into. On a quick look though any reason
> we wouldn't want to just invoke readahead or something somewhere in that
> loop, particularly if that is mainly a performance issue..?

I was planning to look into it once your series lands.

Yes, doing readahead is the main thing.  But once we start doing
that we might as well try to reuse the entire folio_batch optimization
done in the file read path, which has shown to be pretty effective.


