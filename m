Return-Path: <linux-fsdevel+bounces-53295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4806CAED3F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C681895EF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 05:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4BE1C84DD;
	Mon, 30 Jun 2025 05:42:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B8D5227;
	Mon, 30 Jun 2025 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262162; cv=none; b=LiYDvvR6qssdbjBMRicNhCT5je0KXecVcwVlpsmhHUneh5Mpr86z/U4KzVIpu5rjVAnjCsO/MEtZh7pPYgzl2z1TCR3UWEGzzshXcuF+NZfst0mTBjp/TcHtkXXW3M03nUjfncsMB1NozzyH8dtlsYQ44pHM5/gcLl2o10wXkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262162; c=relaxed/simple;
	bh=GIWsfrtYwse+E8YsX2pJzplYbDDPWA/UFNRpnR2b96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPvaCkrrqlOKkAo1M6FOaKcvfsoBA0BM5JDOiipEKHlUrc06rcCFpNNMpJ6fZaOaVqz+ePTtnrjqOdLtJhWth2x2355kayB/zXAAID54brJr98WKN/HTaYZj7ffa+SHpMGNL1/9aFBpRlatjDe+XLkGtzzDQlFa61CzDRiyFX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C87468AA6; Mon, 30 Jun 2025 07:42:33 +0200 (CEST)
Date: Mon, 30 Jun 2025 07:42:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 03/12] iomap: refactor the writeback interface
Message-ID: <20250630054233.GA28532@lst.de>
References: <20250627070328.975394-1-hch@lst.de> <20250627070328.975394-4-hch@lst.de> <aF61PZEb5ndROI6z@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF61PZEb5ndROI6z@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 27, 2025 at 11:14:05AM -0400, Brian Foster wrote:
> >   struct iomap_writeback_ops {
> > -     int (*map_blocks)(struct iomap_writeback_ctx *wpc, struct inode *inode,
> > -                       loff_t offset, unsigned len);
> > -     int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
> > -     void (*discard_folio)(struct folio *folio, loff_t pos);
> > +    int (*writeback_range)(struct iomap_writeback_ctx *wpc,
> > +    		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
> 
> Whitespace damage on the above line.

Without this the vim syntax highlighting is confused for the rest of the
file unfortunately.  Not sure how to deal with it, the RST formatting
keeps driving me crazy.  As does this document, which really should
not duplicate the type information, but folks really wanted this
annoyingly redundant information that is a huge pain to maintain for no
gain at all :(


