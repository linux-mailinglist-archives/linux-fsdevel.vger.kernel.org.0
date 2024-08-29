Return-Path: <linux-fsdevel+bounces-27756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B12B96390A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8481F2595F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23E013634C;
	Thu, 29 Aug 2024 03:52:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA0D4CB36;
	Thu, 29 Aug 2024 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903568; cv=none; b=KV8EiEdqqOvk46+eCKhyJr7H78fS8fqP4wAw0bz51Ta+0BBO3Uxy9VaamJ5/PlOxY7PL8HatnxqJDygapv0kDcwAbdM3jF/W7aQvpzvm8vu256fwKsgRuAQILDp0mC72FjNcm5umuxoAAiJgcTZV0/TUuwfTS+Hll7rDCpDXdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903568; c=relaxed/simple;
	bh=ajsYe1bvalPfkROPql2EFfKGi+n1wIpOjIa06f29fEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRKwT+EMvfTA+DatR3RA3BwOSHNMbI2Vg2ng0R94bhvHrXOSU0S1wpYiBPNjy+jZcrF6FhdyAoj/5hn2ag9ecL4XSd+wPZpqB0NJHzZ8zJBdJ07nSK4AkP5X5uAb+CBsv3lLaNKgxOfXVF4DFWKlcvqZl3ojIdZmQmMfXW267nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C076568AA6; Thu, 29 Aug 2024 05:44:26 +0200 (CEST)
Date: Thu, 29 Aug 2024 05:44:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: add STATX_DIO_READ_ALIGN
Message-ID: <20240829034426.GA3854@lst.de>
References: <20240828051149.1897291-1-hch@lst.de> <20240828051149.1897291-3-hch@lst.de> <20240828235227.GB558903@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828235227.GB558903@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 28, 2024 at 11:52:27PM +0000, Eric Biggers wrote:
> Thanks.  We maybe should have included read/write separation in STATX_DIOALIGN,
> but at the time the only case that was brought up was "DIO reads are supported
> but DIO writes are not" which people had argued was not useful.
> 
> Is this patch meant to support that case,

Why would anyone support direct I/O reads but not writes?  That seems
really weird, but maybe I'm missing something important.

> or just the case where DIO in both
> directions is supported but with different alignments?  Is that different file
> offset alignments, different memory alignments, or both?  This patch doesn't add
> a stx_dio_read_mem_align field, so it's still assumed that both directions share
> the existing stx_dio_mem_align property, including whether DIO is supported at
> all (0 vs. nonzero).

Yes.  The memory alignment really is dependent on the underlying storage
hardware DMA engine, which doesn't distinguish between reads and writes.

> So as proposed, the only case it helps with is where DIO
> in both directions is supported with the same memory alignment but different
> file offset alignments.

Yes.

> Maybe that is intended, but it's not clear to me.

Well, that's good feedback to make it more clear.

> Are there specific userspace applications that would like to take advantage of a
> smaller value of stx_dio_read_offset_align compared to the existing
> stx_dio_offset_align?

There are a lot of read-heavy workloads where smaller reads do make
a difference.


