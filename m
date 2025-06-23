Return-Path: <linux-fsdevel+bounces-52491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 857BDAE372A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E53A1893A82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 07:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFE71F7092;
	Mon, 23 Jun 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hEBB7216"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A991B4240;
	Mon, 23 Jun 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664548; cv=none; b=j8X60R87arfZob67fFO14jOrOgim4vDhMy04cYDxKFxx04Jgt4tpDMvJwxLTpuirBh5KqDTaKpMr2ic6+cWAhPaBVUhtTo+jsrjUNdXewJpvQhLYtYPkUPRqUHBOMCvrw+xdW25qaRO35r0OMaLKoHBz9oJOAYmKIcWbLkladJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664548; c=relaxed/simple;
	bh=Igc0gb/4fqGaP7PxgbaNOPDn2jKSvvZ/FT582jiBRuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuR/CI/Q9Ea3Z8YGAe6DXMSn7YKVDo3SWY8P3IVg3wBve7psfc5EI2rdFo60u2aN+w+DfsuyG5Cp8WUHKbFVKkGvV2l2vjeViLb27BwXnEjnEu5x/sdeq9sD+kgzQ5CnGtSPmTbvTPl5juxjf5qHF24/bK0ukIbVyOApHQDGt2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hEBB7216; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gO6BgaOURwVvfKJZL4NV0+ycIT42XYR9tx/8Rf/n8Y8=; b=hEBB7216jZyDUq0t35LTpI2Mdh
	Zim3MfJyDOpirhznfv4bpqhDbnn1P10fI/ZVT7eRo76+qbagr2pLY4pNTo1GSuFRKwP1okdLCZxF2
	VOispB5mBgW53eh7AzdciuKpgb66wrW2ubGsearpzcZ+dgreiXc5/PjuTeDFbkvCA/btF4UGn45Q4
	3nmXiw++HduhE3D9Ssg6ADye1GsbVRO0vZ2noQEy+z/j5Teb1HQbd+65zWE/my9wBOQl4DG7fZqZ/
	y8OLoqhL1uvIi5UqEZJDZsQ/6/X+5BODaPaAW7w/s9bzTzk/ML5fwpIBXqM751lH9q3XwfkV30cYO
	ptZWuL+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTbow-00000001tk8-0wHD;
	Mon, 23 Jun 2025 07:42:26 +0000
Date: Mon, 23 Jun 2025 00:42:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, anuj1072538@gmail.com, miklos@szeredi.hu,
	brauner@kernel.org, linux-xfs@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 04/16] iomap: add wrapper function iomap_bio_readpage()
Message-ID: <aFkFYkleaEc9HxSr@infradead.org>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-5-joannelkoong@gmail.com>
 <aFAS9SMi1GkqFVg2@infradead.org>
 <CAJnrk1ZCeeVumEaMy+kxqqwn3n1gtSBjtCGUrT1nctjnJaKkZA@mail.gmail.com>
 <aFDxNWQtInriqLU8@infradead.org>
 <CAJnrk1ZrgXL2=7t2rCdAmBz0nNcRT0q7nBUtOUDfz2+CwCWb-A@mail.gmail.com>
 <aFJEXZgiGuszZfh6@infradead.org>
 <CAJnrk1aCo308fxgzYRnei1A29qskvMtiWNS50BJNwiyrQ2A_oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1aCo308fxgzYRnei1A29qskvMtiWNS50BJNwiyrQ2A_oA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 18, 2025 at 12:17:14PM -0700, Joanne Koong wrote:
> > Sure.  What I mean is that I want to do this last before getting the
> > series ready to merge.  I.e. don't bother with until we have something
> > we're all fine with on a conceptual level.
> 
> I'm pausing this patchset until yours lands and then I was planning to
> rebase this (the CONFIG_BLOCK and fuse specifics) on top of yours. Not
> sure if that's what you mean or not, but yes, happy to go with
> whatever you think works best.

It's not going to land without a user..

At some point we'll need to fuse side of this to go ahead.  I'm happy
to either hand control of the series to you, or work with you on a
common tree to make that happen.

