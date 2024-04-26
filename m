Return-Path: <linux-fsdevel+bounces-17887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DAA8B36A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54B01C21EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145B9145343;
	Fri, 26 Apr 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="aQ34CJ9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D473A1B7;
	Fri, 26 Apr 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131797; cv=none; b=KO6P4qfN4cqfn3oc0Ewiwx2NrC8kJ/E7YXKJkFVAnUXSnLsqxh7Uw+WHsg45A9nc3PCwUc9Cq2TPgtNZPbCrbZY9U1IG8IA+AdrkF9xL99oyeMAl+4Qly1Dh8J/cZtpOZ6fsJ29zuF8dZ4x7hq0DDVHmq7acw9xzxR+6KjHyUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131797; c=relaxed/simple;
	bh=BcEjWt3YbmNIE7LVBFxvxMgZ2KaV3f86h2IsdGvrfSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYVd2y3Ngvr2QWW/iD0jVS5dhC1WFjylcuF5pEdDacNMWiGDAIotYGJEGk/dy4nF65Q0A1oEzabMHjHqmW+usxoPlq2Lmbusm/L530+oDKN3No6qj8ueaFM2quUM2Y/QRKli+3LmEqJwduqmh9/kVtUHR2T/RtZNkLvLWAJBo+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=aQ34CJ9E; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VQrSn4Vb2z9smT;
	Fri, 26 Apr 2024 13:43:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714131785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cltDh65KDZw+OJ1Jx8uFob9VDGIFeVIuEhOR2xoeV7w=;
	b=aQ34CJ9EipShkD28LV1bat6g3mnpc2GYmdBbBDCxEOoKx1zuh67XteNQm//lttTjtJ0edL
	6LHYT43I/gKfoQuSGCtBrXqszUCosiV79JLe/IpGS2LxZSkhUI7OvKsJYEDjwHNBKu8mdo
	UlDUKmUFUqBoNudAiYdIi/bpWmjmwDddMKFafy8oYEyhkldv+0DZxVEi8SZ1hUtGFCQf/B
	rdfj2D7v9znaP2RGoKhZD/BYFOGRi82ix5kxdxKbu4K5kZkVUmO3U2/QhsErvykWztTiKe
	7h0LLoaQJb+HZoz5OX0ZqX+BGUNHfMp8oEV433VEKJDCmdeFCDClI1k7vcvcPQ==
Date: Fri, 26 Apr 2024 11:43:01 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: willy@infradead.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240426114301.rtrqsv653a6vkbh6@quentin>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-8-kernel@pankajraghav.com>
 <ZitIK5OnR7ZNY0IG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZitIK5OnR7ZNY0IG@infradead.org>
X-Rspamd-Queue-Id: 4VQrSn4Vb2z9smT

On Thu, Apr 25, 2024 at 11:22:35PM -0700, Christoph Hellwig wrote:
> On Thu, Apr 25, 2024 at 01:37:42PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> > < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> > size < page_size. This is true for most filesystems at the moment.
> > 
> > If the block size > page size, this will send the contents of the page
> > next to zero page(as len > PAGE_SIZE) to the underlying block device,
> > causing FS corruption.
> > 
> > iomap is a generic infrastructure and it should not make any assumptions
> > about the fs block size and the page size of the system.
> 
> So what happened to the plan to making huge_zero_page a folio and have
> it available for non-hugetlb setups?  Not only would this be cleaner
> and more efficient, but it would actually work for the case where you'd
> have to zero more than 1MB on a 4k PAGE_SIZE system, which doesn't
> seem impossible with 2MB folios.

I mentioned this Darrick in one of the older series[1] that it was
proving to be a bit complicated (at least for me) to add that support.

Currently, we reserve the ZERO_PAGE during kernel startup (arch/x86/kernel/head_64.S).

Do we go about doing the same by reserving 1 PMD (512 PTEs with base page size)
at kernel startup if we want to have zeroed 2MB (for x86) always at
our disposal to use for zeroing out?
Because allocating it during runtime will defeat the purpose.

Let me know what you think.

In anycase, I would like to pursue huge_zero_page folio separately
from this series. Also iomap_dio_zero() only pads a fs block with
zeroes, which should never be > 64k for XFS.

[1] https://lore.kernel.org/linux-fsdevel/5kodxnrvjq5dsjgjfeps6wte774c2sl75bn3fg3hh46q3wkwk5@2tru4htvqmrq/

