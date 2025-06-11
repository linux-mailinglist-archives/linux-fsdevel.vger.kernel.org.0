Return-Path: <linux-fsdevel+bounces-51223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB5AD49C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 05:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B19517B2EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 03:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93C920766C;
	Wed, 11 Jun 2025 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifP/tEIL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7AD15574E;
	Wed, 11 Jun 2025 03:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614113; cv=none; b=R/OyoLgeVsZafJOMJhJKtre3vGxe6oTuIvflvT+/GpmlZ61lvn7WLwMAmH+mjOjWw84uUHSJrOQdV49I+AWlhPcaCJbnYsrvj906fZgYv26LJnE8ibul2+rdQGee/DgNCQNc6g39kH1WnGbrFPskA1YhxdP+6FO4Q0jrUQYx1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614113; c=relaxed/simple;
	bh=LFHsNLocIYYY1fg2AE/dMM5jOCNenWZF75t9qNwyUZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwXdSKR/35QPmhiDh9f+T2VFe2peF7H8Y8NooF4Z/a0HR/HDDtqC/VVZG6KMA0Tl/YtH2uKs0FDp6Z9uUlgxm0wSS1M3fqyqtz3PmzvkdhW2hld52EVPBP2dkeWeuEciWCS5XKVl8RVmrh233bQYfwWZvcAWf0NcqEauIO6luJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ifP/tEIL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xQRZH3iFrE2LE+t6ZGsdx1okE6DXb7IDqLisMb96/sQ=; b=ifP/tEILXZu3HzF6rA7EBJjZKp
	G6Li6yP4WOR/l8MATctF/95nyZlMFaOTE5DUpBedrCkSJvDOjlkvZX1pFE9fWwVMZqSt9ORcJSI+4
	xR1ih03zttjqhZ7pfnzXVx6Qu+lCJuymnNakr9Cv2/TBabUFqGnprSXZlwtviL8io95nVIOBK4n6V
	AYMkliu59MZQ/WO1soVCRfAla6jr1CaDqZipcmYxirkZVyynaXVtEl2dm0Blj2WrOhxixf2MXa52I
	rlxTICUsNp9rQ5Bqnr35r2BED7ir7A89yXzpC9GF/hwR5zOighRz8wo4gtmwmOgTaIG9fCCBjke29
	o5+10JaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCYQ-00000008myP-2PWG;
	Wed, 11 Jun 2025 03:55:10 +0000
Date: Tue, 10 Jun 2025 20:55:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/7] iomap: optional zero range dirty folio processing
Message-ID: <aEj-HgO5BcVwb6Qc@infradead.org>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-4-bfoster@redhat.com>
 <20250609160420.GC6156@frogsfrogsfrogs>
 <aEgjMtAONSHz6yJT@bfoster>
 <20250610145552.GM6156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610145552.GM6156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 07:55:52AM -0700, Darrick J. Wong wrote:
> Hrmm.  On closer examination, at least for xfs we've taken i_rwsem and
> the invalidate_lock so I think it should be the case that you don't need
> to revalidate.  I think the same locks are held for iomap_unshare_range
> (mentioned elsewhere in this thread) though it doesn't apply to regular
> pagecache writes.

We should document these assumptions, preferable using (lockdep)
asserts.


