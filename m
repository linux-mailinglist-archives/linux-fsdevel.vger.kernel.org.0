Return-Path: <linux-fsdevel+bounces-52764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288DAE6515
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C82E7A4DB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1524F291C0F;
	Tue, 24 Jun 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RSNMSOOo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768A280CC8;
	Tue, 24 Jun 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768448; cv=none; b=FsxOzxfXtJkCZQh6/L0QKiiaE/LA7RdPol79mlDtpLO2w3pOrbKPeZgURClVBZiGSWzLeGi9nJQXTnoLPqWMd/Pay/3074dCGquvYv61sHraxti2DUppSkMP5gKjebF6mS6Ofkgcr2G3kCRwLI3P5Z3IFJWCjGYqSvjhVbAqY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768448; c=relaxed/simple;
	bh=J24vTlX437+hChkV2ad5kSAeXTAcjqgp9PNzVglucRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCwJFxAInHTpMX4talxBnaq/rVj+n8PDNpQoC9nfP05Qrx2cHtoLMNudrL82w0HsIUtAkgw07upgQ5ba/EWf35bTtRQ9n/PRgF4UkZoHj15sK6gjsLh6FKIqI8EKtloYy5g4TiS1NFOEeJSrcgcpsjYJp0uxIxpKAQcQRhfpNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RSNMSOOo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J24vTlX437+hChkV2ad5kSAeXTAcjqgp9PNzVglucRc=; b=RSNMSOOo5wRyUf8j5Hl2/GcLV9
	u08zA5Ey/ntiLlDL6za+d7NRhOvyFWs+R7j9wVOy5sZwQ6W5TS51Up8iy3OqlQEoNHkEZkWq1/9aQ
	EFJjtVfF2zu8q1Ee6HWqT+okS8DhhSI9P3ImG16xLPv8TmcZIGyiXhm9irFWRBcuzf615GsiYQYBD
	HK6p/r4GnXi18od3WXxhJ0ehvkrIuLtvaJvLkfJhCENTS+PMHBe0MdmIPthQ99n+jtRYQcqyXk2P3
	pNJw9uCCpz5yboh0aacfZpIlyyVSQc0tS3sUjGpEs4yob93rO9gBMjQOh9MWuJJJWCwflwx9p3LoJ
	NzjX3Qcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU2qk-00000005b7t-3rZx;
	Tue, 24 Jun 2025 12:34:06 +0000
Date: Tue, 24 Jun 2025 05:34:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <aFqbPj7EXJdKKkns@infradead.org>
References: <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
 <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
 <20250624-geerntet-haare-2ce4cc42b026@brauner>
 <8db82a80-242f-41ff-84b8-601d6dcd9b9d@suse.com>
 <20250624-briefe-hassen-f693b4fe3501@brauner>
 <abe98c94-b4e0-446b-90e7-c9cdb1c9d197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe98c94-b4e0-446b-90e7-c9cdb1c9d197@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 24, 2025 at 07:21:50PM +0930, Qu Wenruo wrote:
> Thus the new callback may be a good chance for those mature fses to explore
> some corner case availability improvement, e.g. the loss of the external
> journal device while there is no live journal on it.
> (I have to admin it's super niche, and live-migration to internal journal
> may be way more complex than my uneducated guess)

I don't know know of a file system that has a log/journal where is isn't
integral part of the metadata write architecture.


