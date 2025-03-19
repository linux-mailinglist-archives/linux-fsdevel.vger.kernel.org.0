Return-Path: <linux-fsdevel+bounces-44419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24CCA686AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F4A17AC56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C0B2512D3;
	Wed, 19 Mar 2025 08:23:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E39250BE5;
	Wed, 19 Mar 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372611; cv=none; b=CXjPFdZHxjO46CguRLjmROxsb0aywpDY4xT/Pw4nPIz4mqOL3JTgk1LM4sVuAuGpc0T5yAMkg+09MdTaep3y6WhU67XEYzZ41buh5WEQ5QZ9GSXqVTtF1j5CVFalmnKM2X3bbSHBEygp8JK09GVZwmM6GKbw8jYOOpfw0RwYl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372611; c=relaxed/simple;
	bh=nCRr4ut1ts2fNSVp6rd7MF4epq+X7cTGVPcYpEVeW9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6XZ/hrlvs1ffiLBCDsK7VR8Mlc3uyJoe/9xVGv7QaxsaBeGPpepuJEskLneMqE/xVjUUCdzzPx9TL3Bow/1R05NSOUcbvToGmPaIUJ3Z+WXaECiodfTyurP3D635gAeGqIuC1kSK8A6rLqGVDijeSWqr2Z/Oq7huvuvbttH0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FA4A67373; Wed, 19 Mar 2025 09:23:24 +0100 (CET)
Date: Wed, 19 Mar 2025 09:23:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Brian Foster <bfoster@redhat.com>, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH -next] iomap: fix inline data on buffered read
Message-ID: <20250319082323.GA26665@lst.de>
References: <20250319025953.3559299-1-hsiangkao@linux.alibaba.com> <20250319081730.GB26281@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319081730.GB26281@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 19, 2025 at 09:17:30AM +0100, Christoph Hellwig wrote:
> I'd move the iomap_iter_advance into iomap_read_inline_data, just like
> we've pushed it down as far as possible elsewhere, e.g. something like
> the patch below.  Although with that having size and length puzzles
> me a bit, so maybe someone more familar with the code could figure
> out why we need both, how they can be different and either document
> or eliminate that.

... and this doesn't even compile because it breaks write_begin.
So we'll need to keep it in the caller, but maybe without the
goto and just do the plain advance on length?


